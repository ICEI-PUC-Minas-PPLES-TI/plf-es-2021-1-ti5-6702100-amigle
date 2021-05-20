<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import Spacer from "../../../components/Spacer/Spacer.svelte";
	import Flex from "../../../components/Flex/Flex.svelte";
	import { onMount } from "svelte";
	import {
		deleteTagCategory,
		getTagCategories,
		postTagCategory,
	} from "../../../api/tagCategory";
	import type { TagCategoryType } from "../../../types/tagCategoryType";

	export let dialog: any;

	let categoryName = "";
	let tagCategories: TagCategoryType[] = [];

	const addCategory = async () => {
		if (!categoryName) {
			alert("O nome da tag não pode ser vazio.");
			return;
		}
		try {
			await postTagCategory({
				name: categoryName,
			});

			await getData();
			alert("Tag adicionada com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao adicionar a tag.");
		}
	};

	const removeCategory = async (id: number) => {
		try {
			await deleteTagCategory(id);
			await getData();
			alert("Tag removida com sucesso!");
		} catch (error) {
			alert("Erro ao remover a tag.");
		}
	};

	const getData = async () => {
		tagCategories = await getTagCategories();
	};

	onMount(async () => {
		getData();
	});
</script>

<Dialog bind:this={dialog}>
	<Title>Gerenciar Categorias</Title>
	<Content>
		<Spacer vertical={16} />
		<Flex width={500}>
			<Textfield
				id="tagCategoryName"
				variant="outlined"
				style="display:flex; width:100%"
				label="Nome da Categoria"
				bind:value={categoryName}
			/>
			<Spacer horizontal={30} />
			<Button on:click={addCategory}>Adicionar</Button>
		</Flex>
	</Content>
	<List>
		{#each tagCategories as tagCategory}
			<Item>
				<Flex justify="space-between">
					<Flex direction="column" align="flex-start">
						<span>{tagCategory.name}</span>
					</Flex>
					<Button
						on:click={() => removeCategory(tagCategory.id)}
						style="color:#E7432C">Remover</Button
					>
				</Flex>
			</Item>
		{/each}
	</List>
	<Actions>
		<Button on:click={dialog.close}>Fechar</Button>
	</Actions>
</Dialog>
