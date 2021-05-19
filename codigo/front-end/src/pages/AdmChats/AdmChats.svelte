<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import { onMount } from "svelte";
	import { getChats } from "../../api/chat";
	import Flex from "../../components/Flex/Flex.svelte";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import Chat from "../../dialogs/Adm/Chat/Chat.svelte";
	import ChatStats from "../../dialogs/Adm/ChatStats/ChatStats.svelte";
	import type { ChatType } from "../../types/chatType";

	let statsDialog;
	let chatDialog;

	let chats: ChatType[] = [];

	const showStatsDialog = () => {
		statsDialog.open();
	};

	const showChatDialog = () => {
		chatDialog.open();
	};

	const formatDate = (date: string) => {
		const dateObj = new Date(date);

		if (isNaN(dateObj.getTime())) {
			return "";
		}

		const dateString = new Intl.DateTimeFormat("pt-BR", {
			dateStyle: "long",
			timeStyle: "short",
		}).format(dateObj);

		return dateString;
	};

	onMount(async () => {
		chats = await getChats();
	});
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
			</Row>
		</Head>
		<Body>
			{#each chats as chat}
				<Row>
					<Cell>{chat.id}</Cell>
					<Cell>{formatDate(chat.startDate)}</Cell>
					<Cell>{formatDate(chat.endDate)}</Cell>
					<Cell>{chat.users.firstUser.name} e {chat.users.secondUser.name}</Cell
					>
				</Row>
			{/each}
		</Body>
	</DataTable>
</div>
<ChatStats bind:dialog={statsDialog} />
<Chat bind:dialog={chatDialog} />
