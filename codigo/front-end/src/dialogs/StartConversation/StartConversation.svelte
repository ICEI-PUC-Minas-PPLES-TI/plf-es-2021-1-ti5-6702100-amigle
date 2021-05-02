<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import Button from "@smui/button";

	export let dialog: any;
	export let onSelectOption = (option: "allTags" | "specificTag") => {};
</script>

<Dialog bind:this={dialog}>
	<Title>Escolher a Tag</Title>
	<Content>
		Escolha entre iniciar uma conversa que encontrará alguem automaticamente com
		base em todas as suas tags, ou com base em uma tag específica
	</Content>
	<Actions>
		<Button on:click={() => onSelectOption("allTags")}>Todas as Tags</Button>
		<Button on:click={() => onSelectOption("specificTag")}
			>Tag Específica</Button
		>
	</Actions>
</Dialog>
