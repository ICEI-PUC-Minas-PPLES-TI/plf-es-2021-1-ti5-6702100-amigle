<script lang="ts">
	import Dialog, { Title, Content } from "@smui/dialog";
	import Button from "@smui/button";
	import List, { Item } from "@smui/list";

	import Flex from "../../../components/Flex/Flex.svelte";
	import { afterUpdate, beforeUpdate, onMount } from "svelte";
	import type { TagType } from "../../../types/tagType";
	import type { UserType } from "../../../types/userType";
	import { deleteUser, getUser } from "../../../api/user";

	let user: UserType = null;
	let tags: TagType[] = [];

	export let userId: string;
	export let dialog: any;

	const removeUser = async () => {
		await deleteUser(userId);

		dialog.close();
	};

	afterUpdate(async () => {
		if (userId) {
			user = await getUser(userId);
			tags = user.tags;
		}
	});
</script>

<Dialog bind:this={dialog}>
	<Title>Usuário: {user?.name}</Title>
	<Content>
		<div class="mdc-typography--body1">UID: {user?.id}</div>
		<div class="mdc-typography--body1">
			Data de Nascimento: {user?.birthDate}
		</div>
		<div class="mdc-typography--body1">Tags do usuário:</div>
		<List>
			{#each tags as tag}
				<Item>
					<Flex justify="space-between">
						<Flex direction="column" align="flex-start">
							<span class="mdc-typography--caption" style="color:#666"
								>{tag.category.name}</span
							>
							<span>{tag.name}</span>
						</Flex>
					</Flex>
				</Item>
			{/each}
		</List>
		<Button on:click={removeUser} style="color:#E7432C">Remover Usuário</Button>
	</Content>
</Dialog>
