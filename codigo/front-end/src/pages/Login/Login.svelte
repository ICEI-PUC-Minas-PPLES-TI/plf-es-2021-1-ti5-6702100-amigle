<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import { login } from "../../api/user";

	import Container from "../../components/Container/Container.svelte";
	import Flex from "../../components/Flex/Flex.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	export let email = "";
	export let password = "";

	const onSubmit = async (event: Event) => {
		event.preventDefault();

		try {
			const user = await login(email, password);
			localStorage.setItem("user", JSON.stringify(user));

			window.location.pathname = "/";
		} catch (error) {
			alert("Ocorreu um erro ao fazer o login.");
		}
	};
</script>

<div>
	<h1 class="mdc-typography--headline4">Login</h1>
	<Spacer vertical={32} />
	<Container maxWidth={382}>
		<form on:submit={onSubmit}>
			<Textfield
				id="email"
				variant="outlined"
				style="display:flex"
				label="E-mail"
				bind:value={email}
			/>

			<Spacer vertical={16} />

			<Textfield
				id="password"
				variant="outlined"
				style="display:flex"
				label="Senha"
				type="password"
				bind:value={password}
			/>

			<Spacer vertical={32} />

			<Flex justify="space-between">
				<a
					class=" mdc-button mdc-ripple-upgraded mdc-button--outlined"
					href="/signup"
					type="submit">Cadastre-se</a
				>
				<Button id="loginButton" variant="raised" type="submit">Login</Button>
			</Flex>
		</form>
	</Container>
</div>
