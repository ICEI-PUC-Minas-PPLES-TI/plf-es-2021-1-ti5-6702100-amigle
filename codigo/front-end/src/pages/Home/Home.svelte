<script>
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

	onMount(() => {
		loadingDialog.open();
	});
</script>

<div>
	<Flex justify="space-between">
		<div class="home-videoContainer">
			<!-- svelte-ignore a11y-media-has-caption -->
			<video class="home-videoContainer-video" autoplay>
				<source type="video/mp4" />
			</video>
		</div>
		<div class="home-chat">
			<Flex direction="column" justify="space-between">
				<Flex direction="column" justify="flex-start">
					<div class="mdc-typography--body1 home-chat-message -mine">Olá</div>
					<div class="mdc-typography--body1 home-chat-message -yours">Oi</div>
				</Flex>
				<Flex height={56}>
					<Textfield
						variant="outlined"
						style="display:flex"
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
		height: calc(100vh - 186px);
		width: 20%;
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
</style>
