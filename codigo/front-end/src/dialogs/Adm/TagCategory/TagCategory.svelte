<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import Spacer from "../../../components/Spacer/Spacer.svelte";
	import Flex from "../../../components/Flex/Flex.svelte";

	export let dialog: any;

	let categoryName = "";
	const tags = [
		{
			id: 1,
			name: "Filmes",
			count: "10 tags",
		},
		{
			id: 2,
			name: "Games",
			count: "20 tags",
		},
	];
</script>

<Dialog bind:this={dialog}>
	<Title>Gerenciar Categorias</Title>
	<Content>
		<Spacer vertical={16} />
		<Flex width={500}>
			<Textfield
				variant="outlined"
				style="display:flex; width:100%"
				label="Nome da Categoria"
				bind:value={categoryName}
			/>
			<Spacer horizontal={30} />
			<Button>Adicionar</Button>
		</Flex>
	</Content>
	<List>
		{#each tags as tag}
			<Item>
				<Flex justify="space-between">
					<Flex direction="column" align="flex-start">
						<span class="mdc-typography--caption" style="color:#666"
							>{tag.count}</span
						>
						<span>{tag.name}</span>
					</Flex>
					<Button style="color:#E7432C">Remover</Button>
				</Flex>
			</Item>
		{/each}
	</List>
	<Actions>
		<Button on:click={dialog.close}>Fechar</Button>
	</Actions>
</Dialog>
