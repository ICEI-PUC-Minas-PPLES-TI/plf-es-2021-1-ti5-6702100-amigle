<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import Button from "@smui/button";

	export let dialog: any;
</script>

<Dialog bind:this={dialog}>
	<Title id="searchingText">Procurando...</Title>
	<Content>
		<div class="loader" />
	</Content>
</Dialog>

<style>
	.loader,
	.loader:after {
		border-radius: 50%;
		width: 88px;
		height: 88px;
	}
	.loader {
		margin: 20px auto;
		font-size: 10px;
		position: relative;
		text-indent: -9999em;
		border-top: 1.1em solid rgba(110, 0, 248, 0.2);
		border-right: 1.1em solid rgba(110, 0, 248, 0.2);
		border-bottom: 1.1em solid rgba(110, 0, 248, 0.2);
		border-left: 1.1em solid #6e00f8;
		-webkit-transform: translateZ(0);
		-ms-transform: translateZ(0);
		transform: translateZ(0);
		-webkit-animation: load8 1.1s infinite linear;
		animation: load8 2s infinite linear;
	}
	@-webkit-keyframes load8 {
		0% {
			-webkit-transform: rotate(0deg);
			transform: rotate(0deg);
		}
		100% {
			-webkit-transform: rotate(360deg);
			transform: rotate(360deg);
		}
	}
	@keyframes load8 {
		0% {
			-webkit-transform: rotate(0deg);
			transform: rotate(0deg);
		}
		100% {
			-webkit-transform: rotate(360deg);
			transform: rotate(360deg);
		}
	}
</style>
