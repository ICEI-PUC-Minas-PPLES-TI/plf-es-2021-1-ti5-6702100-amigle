<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";
	import { onMount } from "svelte";
	import { each } from "svelte/internal";

	import { getUsers } from "../../api/user";

	import Spacer from "../../components/Spacer/Spacer.svelte";
	import User from "../../dialogs/Adm/User/User.svelte";

	let userDialog;
	let users: any[] = [];

	onMount(async () => {
		try {
			users = await getUsers();
		} catch (error) {
			alert("Erro ao recuperar usuários.");
		}
	});

	const showUserDialog = () => {
		userDialog.open();
	};
</script>

<div>
	<h1 class="mdc-typography--headline4">Usuários</h1>
	<Spacer vertical={32} />

	<DataTable style="width:100%">
		<Head>
			<Row>
				<Cell>UID</Cell>
				<Cell>Nome</Cell>
				<Cell>Idade</Cell>
				<Cell>Admin</Cell>
				<Cell>-</Cell>
			</Row>
		</Head>
		<Body>
			{#each users as user}
				<Row>
					<Cell>{user.id}</Cell>
					<Cell>{user.name}</Cell>
					<Cell>{user.age} anos</Cell>
					<Cell>{user.isAdmin ? "Sim" : "Não"}</Cell>
					<Cell>
						<Button on:click={showUserDialog}>Visualizar</Button>
					</Cell>
				</Row>
			{/each}
		</Body>
	</DataTable>
</div>
<User bind:dialog={userDialog} />
