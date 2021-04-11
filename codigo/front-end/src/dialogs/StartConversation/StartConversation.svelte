<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import Button from "@smui/button";

	export let dialog: any;
</script>

<Dialog bind:this={dialog}>
	<Title>Escolher a Tag</Title>
	<Content>
		Escolha entre iniciar uma conversa que encontrará alguem automaticamente com
		base em todas as suas tags, ou com base em uma tag específica
	</Content>
	<Actions>
		<Button>Todas as Tags</Button>
		<Button>Tag Específica</Button>
	</Actions>
</Dialog>
