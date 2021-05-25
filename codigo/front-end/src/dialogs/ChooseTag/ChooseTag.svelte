<script lang="ts">
	import Dialog, { Title, Content, Actions } from "@smui/dialog";
	import List, { Item, Text } from "@smui/list";
	import Chip, { Set } from "@smui/chips";
	import Button from "@smui/button";

	import Flex from "../../components/Flex/Flex.svelte";
	import { getLocalUser } from "../../utils/authStorage";
	import { onMount } from "svelte";
	import type { TagCategoryType } from "../../types/tagCategoryType";
	import type { TagType } from "../../types/tagType";

	export let dialog: any;
	export let onSelected: (tagId: number) => void;

	const allTagsOption = {
		id: 0,
		name: "Todas",
	};

	let categories: TagCategoryType[] = [allTagsOption];
	let allTags: TagType[] = [];
	let tags: TagType[] = [];

	const onSort = (categoryId: number) => {
		if (categoryId === 0) {
			tags = allTags;

			return;
		}

		tags = allTags.filter((tag) => tag.category.id === categoryId);
	};

	onMount(() => {
		const user = getLocalUser();
		allTags = user.tags;
		tags = user.tags;

		user.tags.forEach((tag) => {
			if (!categories.find((category) => category.id === tag.category.id)) {
				categories = [...categories, tag.category];
			}
		});
	});
</script>

<Dialog bind:this={dialog}>
	<Title>Escolher a Tag</Title>
	<Set chips={categories} let:chip>
		<Chip on:click={() => onSort(chip.id)}>{chip.name}</Chip>
	</Set>
	<List>
		{#each tags as tag}
			<Item on:click={() => onSelected(tag.id)}>
				<Flex direction="column" align="flex-start">
					<span class="mdc-typography--caption" style="color:#666"
						>{tag.category.name}</span
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
