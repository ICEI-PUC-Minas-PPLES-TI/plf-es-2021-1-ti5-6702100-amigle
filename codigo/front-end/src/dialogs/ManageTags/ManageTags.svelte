<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item } from "@smui/list";
	import Chip, { Set } from "@smui/chips";
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import { onMount } from "svelte";

	import { queryTags } from "../../api/tag";
	import { deleteUserTag, getUser, postUserTag } from "../../api/user";
	import { getTagCategories } from "../../api/tagCategory";
	import type { TagType } from "../../types/tagType";
	import type { TagCategoryType } from "../../types/tagCategoryType";
	import { getLocalUser } from "../../utils/authStorage";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import Flex from "../../components/Flex/Flex.svelte";

	export let dialog: any;

	let search = "";

	const allTags = {
		id: 0,
		name: "Todas",
	};

	let user = getLocalUser();
	let searching = false;
	let selectedCategory = allTags;
	let categories: TagCategoryType[] = [];
	let tags: TagType[] = [];

	const getUserTags = async () => {
		const userData = await getUser(user.id);
		user = userData;

		if (selectedCategory.id === 0) {
			tags = userData.tags;
			return;
		}

		tags = userData.tags.filter(
			(tag) => tag.category.id === selectedCategory.id
		);
	};

	const onChangeCategory = () => {
		getUserTags();
	};

	const onSearch = async () => {
		if (!search) {
			searching = false;

			await getUserTags();
			return;
		}

		searching = true;
		selectedCategory = allTags;

		const results = await queryTags(search);
		const filteredResults = results.filter(
			(result) => !user.tags.find((tag) => tag.id === result.id)
		);
		tags = filteredResults;
	};

	const addTag = async (id: number) => {
		await postUserTag(user.id, id);

		await getUserTags();

		searching = false;
	};

	const removeTag = async (id: number) => {
		await deleteUserTag(user.id, id);

		await getUserTags();

		searching = false;
	};

	onMount(async () => {
		categories = await getTagCategories();
		categories.unshift(allTags);

		setTimeout(() => {
			selectedCategory = allTags;
		}, 100);

		await getUserTags();
	});
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
				on:keyup={onSearch}
			/>
		</Flex>
	</Content>
	<Set
		chips={categories}
		choice
		class={searching ? "disabled" : ""}
		bind:selected={selectedCategory}
		let:chip
	>
		<Chip on:click={onChangeCategory} {chip}>{chip.name}</Chip>
	</Set>
	<List nonInteractive>
		{#each tags as tag}
			<Item>
				<Flex direction="column" align="flex-start">
					<span class="mdc-typography--caption" style="color:#666"
						>{tag.category.name}</span
					>
					<span>{tag.name}</span>
				</Flex>
				{#if searching}
					<Button on:click={() => addTag(tag.id)}>Adicionar</Button>
				{:else}
					<Button on:click={() => removeTag(tag.id)} style="color:#E7432C"
						>Remover</Button
					>
				{/if}
			</Item>
		{/each}
	</List>
	<Actions>
		<Button on:click={dialog.close}>Fechar</Button>
	</Actions>
</Dialog>
