<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import Container from "../../components/Container/Container.svelte";

	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	export let email = "";
	export let password = "";
</script>

<div>
	<h1 class="mdc-typography--headline4">Login</h1>
	<Spacer vertical={32} />
	<Container maxWidth={382}>
		<form>
			<Textfield
				variant="outlined"
				style="display:flex"
				label="E-mail"
				bind:value={email}
			/>

			<Spacer vertical={16} />

			<Textfield
				variant="outlined"
				style="display:flex"
				label="Senha"
				bind:value={password}
			/>

			<Spacer vertical={32} />

			<Flex justify="space-between">
				<Button variant="outlined">Cadastrar-se</Button>
				<Button variant="raised" type="submit">Login</Button>
			</Flex>
		</form>
	</Container>
</div>
