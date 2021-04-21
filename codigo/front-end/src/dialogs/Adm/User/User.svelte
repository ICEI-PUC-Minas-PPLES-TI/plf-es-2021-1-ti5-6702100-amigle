<script lang="ts">
	import Dialog, { Title, Content } from "@smui/dialog";
	import Button from "@smui/button";
	import List, { Item } from "@smui/list";

	import Flex from "../../../components/Flex/Flex.svelte";

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

	export let dialog: any;
</script>

<Dialog bind:this={dialog}>
	<Title>Usuário: Lucas</Title>
	<Content>
		<div class="mdc-typography--body1">UID: 1</div>
		<div class="mdc-typography--body1">Idade: 19</div>
		<div class="mdc-typography--body1">Tags do usuário:</div>
		<List>
			{#each tags as tag}
				<Item>
					<Flex justify="space-between">
						<Flex direction="column" align="flex-start">
							<span class="mdc-typography--caption" style="color:#666"
								>{tag.category}</span
							>
							<span>{tag.name}</span>
						</Flex>
					</Flex>
				</Item>
			{/each}
		</List>
		<Button style="color:#E7432C">Remover Usuário</Button>
	</Content>
</Dialog>
