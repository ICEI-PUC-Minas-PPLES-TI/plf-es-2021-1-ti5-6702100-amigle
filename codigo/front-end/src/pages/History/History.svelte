<script lang="ts">
	import DataTable, { Head, Body, Row, Cell } from "@smui/data-table";

	import Spacer from "../../components/Spacer/Spacer.svelte";
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
			<Row>
				<Cell>Lucas</Cell>
				<Cell>01/01/2021</Cell>
				<Cell>15 minutos</Cell>
			</Row>
		</Body>
	</DataTable>
</div>
