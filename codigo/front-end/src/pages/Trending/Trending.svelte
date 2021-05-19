<script lang="ts">
	import List, { Item } from "@smui/list";
	import Chip, { Set } from "@smui/chips";
	import { onDestroy, onMount } from "svelte";
	import io from "socket.io-client";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	let socket: any;

	const allTagsCategory = {
		id: 0,
		name: "Todas",
	};

	let categories = [];
	let allTags = [];

	onMount(() => {
		const baseAddress = window.location.href.includes("localhost")
			? "http://localhost:5001"
			: "https://amigle-chat-manager.herokuapp.com";

		socket = io(baseAddress, {
			secure: true,
		});

		socket.emit("get-trending");

		socket.on("trending-update", (data: any) => {
			categories = data.categories;
			categories.unshift(allTagsCategory);
			allTags = data.tags;
		});
	});

	onDestroy(() => {
		socket.disconnect();
	});
</script>

<div>
	<h1 class="mdc-typography--headline4">Tags em Alta</h1>
	<Spacer vertical={32} />
	<Set chips={categories} let:chip>
		<Chip>{chip.name}</Chip>
	</Set>
	<List nonInteractive>
		{#each allTags as tag}
			<Item>
				<Flex justify="space-between">
					<Flex direction="column" align="flex-start" width={200}>
						<span class="mdc-typography--caption" style="color:#666"
							>{tag.count} pessoas falando sobre</span
						>
						<span>{tag.name}</span>
					</Flex>
				</Flex>
			</Item>
		{/each}
	</List>
</div>
