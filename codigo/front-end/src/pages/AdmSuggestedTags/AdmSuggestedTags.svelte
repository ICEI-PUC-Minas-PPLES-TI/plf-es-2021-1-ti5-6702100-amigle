<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import { onMount } from "svelte";
	import { deleteTag, getTags, putTag } from "../../api/tag";
	import { getTagCategories } from "../../api/tagCategory";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";
	import TagCategory from "../../dialogs/Adm/TagCategory/TagCategory.svelte";
	import type { TagCategoryType } from "../../types/tagCategoryType";
	import type { TagType } from "../../types/tagType";

	let tagsCategoryDialog: any;

	let tags: TagType[] = [];
	let tagCategories: TagCategoryType[] = [];

	const showTagsCategoryDialog = () => {
		tagsCategoryDialog.open();
	};

	const approveTag = async (tag: TagType) => {
		try {
			await putTag({
				id: tag.id,
				isApproved: true,
			});

			await getData();
			alert("Tag atualizada com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao atualizar a tag.");
		}
	};

	const disapproveTag = async (id: number) => {
		try {
			await deleteTag(id);
			await getData();
			alert("Tag reprovada com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao reprovar a tag.");
		}
	};

	const getData = async () => {
		tags = await getTags();
		tags = tags.filter((tag) => !tag.isApproved);
		tagCategories = await getTagCategories();
	};

	onMount(async () => {
		getData();
	});
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
				<Cell>Nome da Tag</Cell>
				<Cell>Ações</Cell>
			</Row>
		</Head>
		<Body>
			{#each tags as tag}
				<Row>
					<Cell>{tag.id}</Cell>
					<Cell>{tag.name}</Cell>
					<Cell>
						<Button on:click={() => approveTag(tag)}>Aprovar</Button>
						<Button on:click={() => disapproveTag(tag.id)} style="color:#E7432C"
							>Reprovar</Button
						>
					</Cell>
				</Row>
			{/each}
		</Body>
	</DataTable>
</div>
