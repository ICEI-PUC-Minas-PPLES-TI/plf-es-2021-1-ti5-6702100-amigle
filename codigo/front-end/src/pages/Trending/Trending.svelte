<script>
	import List, { Item } from "@smui/list";
	import Button from "@smui/button";
	import Chip, { Set } from "@smui/chips";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	const categories = [
		{
			id: 1,
			name: "Todas",
		},
		{
			id: 2,
			name: "Filmes",
		},
	];
</script>

<div>
	<h1 class="mdc-typography--headline4">Tags em Alta</h1>
	<Spacer vertical={32} />
	<Set chips={categories} let:chip>
		<Chip>{chip.name}</Chip>
	</Set>
	<List nonInteractive>
		<Item>
			<Flex justify="space-between">
				<Flex direction="column" align="flex-start" width={200}>
					<span class="mdc-typography--caption" style="color:#666"
						>10 pessoas falando sobre</span
					>
					<span>Ação</span>
				</Flex>
				<div>
					<Button>+ Adicionar</Button>
				</div>
			</Flex>
		</Item>
	</List>
</div>
