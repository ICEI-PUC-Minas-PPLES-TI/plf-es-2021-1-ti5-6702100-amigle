<script lang="ts">
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import { onMount } from "svelte";
	import { getChatHistory } from "../../api/chat";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import type { ChatHistoryType } from "../../types/chatType";
	import { getLocalUser } from "../../utils/authStorage";

	const userId = getLocalUser().id;

	let chats: ChatHistoryType[] = [];

	const formatDate = (date: string) => {
		const dateObj = new Date(date);

		if (isNaN(dateObj.getTime())) {
			return "";
		}

		return Intl.DateTimeFormat("pt-BR").format(dateObj);
	};

	const getDateDelta = (firstDate: string, secondDate: string) => {
		const firstDateObj = new Date(firstDate);
		const secondDateObj = new Date(secondDate);

		if (isNaN(firstDateObj.getTime()) || isNaN(secondDateObj.getTime())) {
			return "";
		}

		const delta = firstDateObj.getTime() - secondDateObj.getTime();

		return `${delta / 1000 / 60} minutos`;
	};

	onMount(async () => {
		chats = await getChatHistory(userId);
	});
</script>

<div>
	<h1 class="mdc-typography--headline4">Histórico de Conversas</h1>
	<Spacer vertical={32} />

	<DataTable style="width:100%">
		<Head>
			<Row>
				<Cell>Nome</Cell>
				<Cell>Data</Cell>
				<Cell>Duração</Cell>
			</Row>
		</Head>
		<Body>
			{#each chats as chat}
				<Row>
					<Cell>{chat.guestUserName}</Cell>
					<Cell>{formatDate(chat.startDate)}</Cell>
					<Cell>{getDateDelta(chat.startDate, chat.endDate)}</Cell>
				</Row>
			{/each}
		</Body>
	</DataTable>
</div>
