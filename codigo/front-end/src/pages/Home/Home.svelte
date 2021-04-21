<script lang="ts">
	import Textfield from "@smui/textfield";
	import Button from "@smui/button";

	import Flex from "../../components/Flex/Flex.svelte";
	import ChooseTag from "../../dialogs/ChooseTag/ChooseTag.svelte";
	import { onMount } from "svelte";
	import StartConversation from "../../dialogs/StartConversation/StartConversation.svelte";
	import Loading from "../../dialogs/Loading/Loading.svelte";

	let message = "";

	let initialDialog;
	let chooseTagDialog;
	let loadingDialog;

	let isChatHidden = false;

	onMount(() => {
		// loadingDialog.open();
	});

	const touchStart = () => {};

	const touchMove = () => {};

	const touchEnd = () => {};

	const toggleChat = () => {
		isChatHidden = !isChatHidden;
	};
</script>

<div>
	<Flex justify="space-between">
		<div class="home-videoContainer">
			<!-- svelte-ignore a11y-media-has-caption -->
			<video class="home-videoContainer-video" autoplay>
				<source type="video/mp4" />
			</video>
		</div>
		<div class="home-chat" class:-hidden={isChatHidden}>
			<div
				class="home-chat-grabber"
				on:touchstart={touchStart}
				on:touchmove={touchMove}
				on:touchend={touchEnd}
				on:click={toggleChat}
			>
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
					<div class="mdc-typography--body1 home-chat-message -mine">Olá</div>
					<div class="mdc-typography--body1 home-chat-message -yours">Oi</div>
				</Flex>
				<Flex height={56}>
					<Textfield
						variant="outlined"
						style="display:flex; width:100%"
						label="Mensagem"
						bind:value={message}
					/>
					<Button>Enviar</Button>
				</Flex>
			</Flex>
		</div>
	</Flex>
</div>
<StartConversation bind:dialog={initialDialog} />
<ChooseTag bind:dialog={chooseTagDialog} />
<Loading bind:dialog={loadingDialog} />

<style>
	.home-videoContainer {
		position: relative;
		width: 78%;
		height: calc(100vh - 186px);
	}
	.home-videoContainer-video {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		background-color: #000;
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
