<!-- svelte-ignore a11y-media-has-caption -->
<script lang="ts">
	import Textfield from "@smui/textfield";
	import Button from "@smui/button";

	import Flex from "../../components/Flex/Flex.svelte";
	import ChooseTag from "../../dialogs/ChooseTag/ChooseTag.svelte";
	import StartConversation from "../../dialogs/StartConversation/StartConversation.svelte";
	import Loading from "../../dialogs/Loading/Loading.svelte";
	import { getLocalUser } from "../../utils/authStorage";
	import { onDestroy, onMount } from "svelte";
	import type { UserType } from "../../types/userType";
	import { getUser } from "../../api/user";
	import io from "socket.io-client";

	const userId = getLocalUser().id;
	const tagId = 2;
	let user: UserType = null;

	let localVideo: HTMLVideoElement;
	let remoteVideo: HTMLVideoElement;

	let userStream: MediaStream = null;

	let otherUserSocketId: string;

	let socket: any = null;
	let peer: RTCPeerConnection;

	let cameraActive = true;
	let micActive = true;

	let messages: { received: boolean; text: string }[] = [];
	let message = "";

	let initialDialog: any;
	let chooseTagDialog: any;
	let loadingDialog: any;

	let isChatHidden = false;

	const toggleChat = () => {
		isChatHidden = !isChatHidden;
	};

	const openChatModal = () => {
		const baseAddress = window.location.href.includes("localhost")
			? "http://localhost:5001"
			: "https://amigle-chat-manager.herokuapp.com";

		socket = io(baseAddress, {
			secure: true,
		});
		initialDialog.open();
	};

	const handleTrackEvent = (e) => {
		remoteVideo.srcObject = e.streams[0];
	};

	const handleNewICECandidateMsg = (incoming: any) => {
		const candidate = new RTCIceCandidate(incoming);

		peer.addIceCandidate(candidate);
	};

	const handleICECandidateEvent = (e: RTCPeerConnectionIceEvent) => {
		if (e.candidate) {
			const payload = {
				target: otherUserSocketId,
				candidate: e.candidate,
			};

			socket.emit("ice-candidate", payload);
		}
	};

	const handleAnswer = (message: any) => {
		const desc = new RTCSessionDescription(message.sdp);
		peer.setRemoteDescription(desc);
		loadingDialog.close();
	};

	const handleReceiveCall = (incoming: any) => {
		peer = createPeer();
		const desc = new RTCSessionDescription(incoming.sdp);

		peer
			.setRemoteDescription(desc)
			.then(() => {
				userStream.getTracks().forEach((track) => {
					peer.addTrack(track, userStream);
				});
			})
			.then(() => peer.createAnswer())
			.then((answer) => peer.setLocalDescription(answer))
			.then(() => {
				const payload = {
					target: incoming.caller,
					caller: socket.id,
					sdp: peer.localDescription,
				};

				otherUserSocketId = incoming.caller;
				socket.emit("answer", payload);
				loadingDialog.close();
			});
	};

	const handleNegotiationNeededEvent = (socketId: string) => {
		peer
			.createOffer()
			.then((offer) => peer.setLocalDescription(offer))
			.then(() => {
				const payload = {
					target: socketId,
					caller: socket.id,
					sdp: peer.localDescription,
				};

				socket.emit("offer", payload);
			});
	};

	const createPeer = (socketId?: string) => {
		const peer = new RTCPeerConnection({
			iceServers: [
				{
					urls: "stun:stun.stunprotocol.org",
				},
				{
					urls: "turn:numb.viagenie.ca",
					credential: "muazkh",
					username: "webrtc@live.com",
				},
			],
		});

		peer.onicecandidate = handleICECandidateEvent;
		peer.ontrack = handleTrackEvent;
		peer.onnegotiationneeded = () => handleNegotiationNeededEvent(socketId);

		return peer;
	};

	const callUser = (socketId: string) => {
		peer = createPeer(socketId);
		userStream.getTracks().forEach((track) => {
			console.log(track);
			return peer.addTrack(track, userStream);
		});
	};

	const onSelectChatOption = (option: "allTags" | "specificTag") => {
		if (option === "allTags") {
			socket.emit("join-all-tags", user);
		} else {
			socket.emit("join-specific-tag", { user, tagId });
		}

		loadingDialog.open();

		socket.on("match-made", (data: { socketId: string }) => {
			callUser(data.socketId);
			otherUserSocketId = data.socketId;
			console.log(otherUserSocketId);
		});

		socket.on("offer", handleReceiveCall);

		socket.on("answer", handleAnswer);

		socket.on("ice-candidate", handleNewICECandidateMsg);

		socket.on(
			"message-received",
			(message: { received: boolean; text: string }) => {
				messages = [...messages, message];
			}
		);

		socket.on("disconnect", () => {
			remoteVideo.srcObject = null;
		});
	};

	const sendTextMessage = () => {
		messages = [
			...messages,
			{
				received: false,
				text: message,
			},
		];

		const payload = {
			target: otherUserSocketId,
			text: message,
		};
		socket.emit("send-message", payload);

		message = "";
	};

	const toggleAudio = () => {
		userStream.getTracks().forEach((track) => {
			if (track.readyState == "live" && track.kind === "audio") {
				track.enabled = micActive;
			}
		});
	};

	const toggleVideo = () => {
		userStream.getTracks().forEach((track) => {
			if (track.readyState == "live" && track.kind === "video") {
				track.enabled = cameraActive;
			}
		});
	};

	const disconnectCall = () => {
		socket.disconnect();
	};

	onMount(async () => {
		user = await getUser(userId);

		openChatModal();
		navigator.mediaDevices
			.getUserMedia({
				video: {
					facingMode: "user",
				},
				audio: true,
			})
			.then((stream) => {
				localVideo.srcObject = stream;
				userStream = stream;
			});
	});

	onDestroy(() => {
		socket.disconnect();
	});
</script>

<div>
	<Flex justify="center">
		<Button on:click={openChatModal}>Conversar</Button>
	</Flex>
	<Flex justify="space-between">
		<div class="home-videoContainer">
			<video
				bind:this={remoteVideo}
				class="home-videoContainer-remoteVideo"
				autoplay
			>
				<source type="video/mp4" />
			</video>
			<video
				bind:this={localVideo}
				class="home-videoContainer-localVideo"
				autoplay
				muted
			>
				<source type="video/mp4" />
			</video>
			<div class="home-videoContainer-buttons">
				<div>
					<button class="home-videoContainer-profileButton"
						>Ver Perfil do Usuário</button
					>
				</div>
				<div>
					<button class="home-videoContainer-microphoneButton">Microfone</button
					>
					<button class="home-videoContainer-cameraButton">Camera</button>
				</div>

				<div class="home-controls">
					<Flex justify="space-between">
						<div class="home-controls-container">
							<div class="home-microphone">
								<input
									bind:checked={micActive}
									on:change={toggleAudio}
									type="checkbox"
									id="toggle-microphone"
								/>
								<label for="toggle-microphone">
									{#if micActive}
										<img src="img/mic_on.svg" alt="" />
									{:else}
										<img src="img/mic_off.svg" alt="" />
									{/if}
								</label>
							</div>
							<div class="home-camera">
								<input
									bind:checked={cameraActive}
									on:change={toggleVideo}
									type="checkbox"
									id="toggle-camera"
								/>
								<label for="toggle-camera">
									{#if cameraActive}
										<img src="img/cam_on.svg" alt="" />
									{:else}
										<img src="img/cam_off.svg" alt="" />
									{/if}
								</label>
							</div>
						</div>
						<Button
							on:click={disconnectCall}
							variant="raised"
							type="button"
							style="background-color:#E7432C">Encerrar Chat</Button
						>
					</Flex>
				</div>
			</div>
		</div>
		<div class="home-chat" class:-hidden={isChatHidden}>
			<div class="home-chat-grabber" on:click={toggleChat}>
				<svg
					width="14"
					height="9"
					viewBox="0 0 14 9"
					fill="none"
					xmlns="http://www.w3.org/2000/svg"
				>
					<path
						d="M1.41 8.41L0 7L7 0L14 7L12.59 8.41L7 2.82L1.41 8.41Z"
						fill="black"
						fill-opacity="0.6"
					/>
				</svg>
			</div>
			<Flex direction="column" justify="space-between">
				<Flex direction="column" justify="flex-start">
					{#each messages as message}
						<div
							class:-mine={!message.received}
							class:-yours={message.received}
							class="mdc-typography--body1 home-chat-message"
						>
							{message.text}
						</div>
					{/each}
				</Flex>
				<Flex height={56}>
					<Textfield
						variant="outlined"
						style="display:flex; width:100%"
						label="Mensagem"
						bind:value={message}
					/>
					<Button on:click={sendTextMessage}>Enviar</Button>
				</Flex>
			</Flex>
		</div>
	</Flex>
</div>
<StartConversation
	bind:dialog={initialDialog}
	onSelectOption={onSelectChatOption}
/>
<ChooseTag bind:dialog={chooseTagDialog} />
<Loading bind:dialog={loadingDialog} />

<style>
	.home-videoContainer {
		position: relative;
		width: 78%;
		height: calc(100vh - 186px);
	}
	.home-videoContainer-localVideo {
		position: absolute;
		top: 20px;
		right: 20px;
		width: 20%;
		height: 20%;
		object-fit: cover;
		transform: rotateY(180deg);
	}
	.home-videoContainer-remoteVideo {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #000;
		object-fit: cover;
	}
	.home-controls {
		position: absolute;
		bottom: 0;
		left: 0;
		width: 100%;
		padding: 20px;
		box-sizing: border-box;
	}
	.home-controls-container {
		display: flex;
	}
	.home-microphone input,
	.home-camera input {
		display: none;
	}
	.home-microphone {
		margin-right: 16px;
	}
	.home-microphone input:checked + label,
	.home-camera input:checked + label {
		background-color: #fff;
	}
	.home-microphone label,
	.home-camera label {
		position: relative;
		display: flex;
		justify-content: center;
		align-items: center;
		width: 60px;
		height: 60px;
		background-color: rgb(231, 67, 44);
		border-radius: 50%;
		font-size: 0;
		cursor: pointer;
	}
	.home-chat {
		position: relative;
		height: calc(100vh - 186px);
		width: 20%;
	}
	.home-chat-grabber {
		display: none;
	}
	.home-chat-message {
		padding: 16px;
		border-radius: 4px;
		width: 66%;
		margin-bottom: 16px;
	}
	.home-chat-message.-mine {
		background-color: #6200ee;
		color: #fff;
		align-self: flex-end;
	}
	.home-chat-message.-yours {
		background-color: rgb(33, 33, 33, 0.08);
		align-self: flex-start;
	}

	@media screen and (max-width: 1000px) {
		.home-videoContainer {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100vh;
		}

		.home-chat {
			background-color: #fff;
			position: fixed;
			bottom: 0;
			left: 0;
			width: 100%;
			padding: 24px;
			padding-top: 44px;
		}

		.home-chat.-hidden {
			transform: translateY(calc(100% - 44px));
		}
		.home-chat.-hidden .home-chat-grabber {
			transform: rotate(0deg);
		}

		.home-chat-grabber {
			display: flex;
			position: absolute;
			justify-content: center;
			align-items: center;
			height: 44px;
			width: 100vw;
			top: 0;
			left: 0;
			transform: rotate(180deg);
		}
	}
</style>
