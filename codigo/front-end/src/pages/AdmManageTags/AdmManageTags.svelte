<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import { onMount } from "svelte";
	import { deleteTag, getTags, putTag } from "../../api/tag";
	import { getTagCategories } from "../../api/tagCategory";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";
	import Tag from "../../dialogs/Adm/Tag/Tag.svelte";
	import TagCategory from "../../dialogs/Adm/TagCategory/TagCategory.svelte";
	import type { TagCategoryType } from "../../types/tagCategoryType";
	import type { TagType } from "../../types/tagType";

	let tagsCategoryDialog: any;
	let addTagDialog: any;

	let tags: TagType[] = [];
	let tagCategories: TagCategoryType[] = [];

	const showTagsCategoryDialog = () => {
		tagsCategoryDialog.open();
	};

	const showAddTagDialog = () => {
		addTagDialog.open();
	};

	const changeTagCategory = async (tag: TagType) => {
		const newCategoryId = (
			document.querySelector(
				`#select-tag-category[data-tag-id='${tag.id}']`
			) as any
		).value;

		try {
			await putTag({
				id: tag.id,
				categoryId: +newCategoryId,
			});

			await getData();
			alert("Tag atualizada com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao atualizar a tag.");
		}
	};

	const removeTag = async (id: number) => {
		try {
			await deleteTag(id);
			await getData();
			alert("Tag removida com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao remover a tag.");
		}
	};

	const getData = async () => {
		tags = await getTags();
		tags = tags.filter((tag) => tag.isApproved);
		tagCategories = await getTagCategories();
	};

	onMount(async () => {
		getData();
	});
</script>

<div>
	<Flex justify="space-between">
		<h1 class="mdc-typography--headline4">Gerenciar Tags</h1>
		<div>
			<Button on:click={showAddTagDialog}>Adicionar Tag</Button>
			<Button on:click={showTagsCategoryDialog}>Alterar Categorias</Button>
		</div>
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
			{#each tags as tag}
				<Row>
					<Cell>{tag.id}</Cell>
					<Cell>{tag.name}</Cell>
					<Cell
						><select id="select-tag-category" data-tag-id={tag.id}>
							{#each tagCategories as tagCategory}
								<option
									selected={tag.category.id === tagCategory.id}
									value={tagCategory.id}>{tagCategory.name}</option
								>
							{/each}
						</select>
					</Cell>
					<Cell>
						<Button on:click={() => changeTagCategory(tag)}
							>Alterar Categoria</Button
						>
						<Button on:click={() => removeTag(tag.id)} style="color:#E7432C"
							>Remover</Button
						>
					</Cell>
				</Row>
			{/each}
		</Body>
	</DataTable>
</div>
<TagCategory bind:dialog={tagsCategoryDialog} />
<Tag onClose={getData} bind:dialog={addTagDialog} />
