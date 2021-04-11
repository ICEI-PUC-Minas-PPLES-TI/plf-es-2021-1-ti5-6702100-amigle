<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Chip, { Set } from "@smui/chips";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import Flex from "../../components/Flex/Flex.svelte";

	export let dialog: any;

	let search = "";
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
	<Title>Gerenciar Tags</Title>
	<Content>
		<Spacer vertical={16} />
		<Flex width={500}>
			<Textfield
				variant="outlined"
				style="display:flex; width:100%"
				label="Buscar Tags"
				bind:value={search}
			/>
		</Flex>
	</Content>
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
