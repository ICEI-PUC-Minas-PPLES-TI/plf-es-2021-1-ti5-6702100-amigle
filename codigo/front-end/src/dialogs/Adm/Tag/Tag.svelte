<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import Select, { Option } from "@smui/select";
	import Flex from "../../../components/Flex/Flex.svelte";
	import Spacer from "../../../components/Spacer/Spacer.svelte";
	import { onMount } from "svelte";
	import type { TagCategoryType } from "../../../types/tagCategoryType";
	import { getTagCategories } from "../../../api/tagCategory";
	import { postTag } from "../../../api/tag";
	import { getLocalUser } from "../../../utils/authStorage";

	export let dialog: any;
	export let onClose = () => {};
	let name = "";
	let categoryId = 0;
	let categories: TagCategoryType[] = [];
	const user = getLocalUser();

	const addTag = async () => {
		try {
			await postTag(user.id, {
				name,
				categoryId,
			});

			alert("Tag adicionada com sucesso!");
			dialog.close();
			onClose();
		} catch (error) {
			alert("Ocorreu um erro ao adicionar a tag.");
		}
	};

	onMount(async () => {
		categories = await getTagCategories();
	});
</script>

<Dialog bind:this={dialog}>
	<Title>Adicionar Tag</Title>
	<Content>
		<Flex direction="column" justify="center">
			<Spacer vertical={16} />
			<Textfield
				variant="outlined"
				style="display:flex; width:100%"
				label="Nome da Tag"
				bind:value={name}
			/>
			<Spacer vertical={20} />
			<div class="add-tag-select">
				<strong>Categoria</strong>
				<select bind:value={categoryId} label="Categoria">
					{#each categories as category}
						<option value={category.id}>{category.name}</option>
					{/each}
				</select>
			</div>
		</Flex>
	</Content>
	<Actions>
		<Button on:click={addTag}>Adicionar</Button>
		<Button on:click={dialog.close}>Fechar</Button>
	</Actions>
</Dialog>

<style>
	.add-tag-select {
		width: 100%;
	}
	.add-tag-select select {
		display: block;
		width: 100%;
		padding: 12px 16px 14px;
	}
</style>
