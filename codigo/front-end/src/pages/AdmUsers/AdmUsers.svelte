<script lang="ts">
	import Button from "@smui/button";
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";

	import Spacer from "../../components/Spacer/Spacer.svelte";
import User from "../../dialogs/Adm/User/User.svelte";

let userDialog;

const showUserDialog = () => {
	userDialog.open();
}
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
			<Row>
				<Cell>1</Cell>
				<Cell>Lucas</Cell>
				<Cell>19 anos</Cell>
				<Cell>Sim</Cell>
				<Cell>
					<Button on:click={showUserDialog}>Visualizar</Button>
				</Cell>
			</Row>
		</Body>
	</DataTable>
</div>
<User bind:dialog={userDialog} />
