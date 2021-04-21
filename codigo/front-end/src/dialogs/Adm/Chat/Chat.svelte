<script lang="ts">
	import Dialog, { Title, Content } from "@smui/dialog";

	export let dialog: any;
</script>

<Dialog bind:this={dialog}>
	<Title>Conversa</Title>
	<Content>
		<div>
			<strong class="mdc-typography--body1">Início: 20/01/2021 às 12:50</strong>
		</div>
		<div>
			<strong class="mdc-typography--body1">Fim: 20/01/2021 às 13:21</strong>
		</div>
		<div>
			<strong class="mdc-typography--body1">Usuário 1: Lucas</strong>
		</div>
		<div>
			<strong class="mdc-typography--body1">Usuário 2: Arthur</strong>
		</div>
	</Content>
</Dialog>
