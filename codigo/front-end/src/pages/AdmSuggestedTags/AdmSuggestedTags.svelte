<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";
	import TagCategory from "../../dialogs/Adm/TagCategory/TagCategory.svelte";

	let tagsCategoryDialog;

	const showTagsCategoryDialog = () => {
		tagsCategoryDialog.open();
	};
</script>

<div>
	<Flex justify="space-between">
		<h1 class="mdc-typography--headline4">Tags Sugeridas</h1>
		<Button on:click={showTagsCategoryDialog}>Alterar Categorias</Button>
	</Flex>
	<Spacer vertical={32} />

	<DataTable style="width:100%">
		<Head>
			<Row>
				<Cell>ID</Cell>
				<Cell>Tag</Cell>
				<Cell>Categoria</Cell>
				<Cell>Ações</Cell>
			</Row>
		</Head>
		<Body>
			<Row>
				<Cell>1</Cell>
				<Cell>Lucas</Cell>
				<Cell>19 anos</Cell>
				<Cell>
					<Button>Aprovar</Button>
					<Button style="color:#E7432C">Reprovar</Button>
				</Cell>
			</Row>
		</Body>
	</DataTable>
</div>
<TagCategory bind:dialog={tagsCategoryDialog} />
