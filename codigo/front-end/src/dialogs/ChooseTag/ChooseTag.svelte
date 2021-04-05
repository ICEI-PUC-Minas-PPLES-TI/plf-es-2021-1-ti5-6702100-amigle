<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Chip, { Set } from "@smui/chips";
	import Button from "@smui/button";

	import Flex from "../../components/Flex/Flex.svelte";

	export let dialog: any;

	const categories = [
		{
			id: 1,
			name: "Todas",
		},
		{
			id: 2,
			name: "Filmes",
		},
	];
	const tags = [
		{
			id: 1,
			name: "Ação",
			category: "Filmes",
		},
		{
			id: 2,
			name: "Aventura",
			category: "Filmes",
		},
	];
</script>

<Dialog bind:this={dialog}>
	<Title>Escolher a Tag</Title>
	<Set chips={categories} let:chip>
		<Chip>{chip.name}</Chip>
	</Set>
	<List>
		{#each tags as tag}
			<Item>
				<Flex direction="column" align="flex-start">
					<span class="mdc-typography--caption" style="color:#666"
						>{tag.category}</span
					>
					<span>{tag.name}</span>
				</Flex>
			</Item>
		{/each}
	</List>
	<Actions>
		<Button on:click={dialog.close}>Fechar</Button>
	</Actions>
</Dialog>
