<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import Flex from "../../components/Flex/Flex.svelte";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import Chat from "../../dialogs/Adm/Chat/Chat.svelte";
	import ChatStats from "../../dialogs/Adm/ChatStats/ChatStats.svelte";

	let statsDialog;
	let chatDialog;

	const showStatsDialog = () => {
		statsDialog.open();
	};

	const showChatDialog = () => {
		chatDialog.open();
	};
</script>

<div>
	<Flex justify="space-between">
		<h1 class="mdc-typography--headline4">Conversas</h1>
		<Button on:click={showStatsDialog}>Visualizar Estatísticas</Button>
	</Flex>
	<Spacer vertical={32} />

	<DataTable style="width:100%">
		<Head>
			<Row>
				<Cell>ID</Cell>
				<Cell>Início</Cell>
				<Cell>Fim</Cell>
				<Cell>Usuários</Cell>
				<Cell>-</Cell>
			</Row>
		</Head>
		<Body>
			<Row>
				<Cell>1</Cell>
				<Cell>20/01/2021 às 10:52</Cell>
				<Cell>20/01/2021 às 11:01</Cell>
				<Cell>Lucas e Arthur</Cell>
				<Cell>
					<Button on:click={showChatDialog}>Visualizar</Button>
				</Cell>
			</Row>
		</Body>
	</DataTable>
</div>
<ChatStats bind:dialog={statsDialog} />
<Chat bind:dialog={chatDialog} />
