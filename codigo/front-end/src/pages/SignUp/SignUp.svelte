<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import { login, postUser } from "../../api/user";

	import Container from "../../components/Container/Container.svelte";
	import Flex from "../../components/Flex/Flex.svelte";
	import ImagePicker from "../../components/ImagePicker/ImagePicker.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	let image: File = null;
	let name = "";
	let birthDate = "";
	let email = "";
	let password = "";
	let confirmPassword = "";

	const onSubmit = async (event: Event) => {
		event.preventDefault();

		if (password !== confirmPassword) {
			alert("As senhas não estão iguais");
			return;
		}

		try {
			await postUser({
				name,
				birthDate,
				email,
				password,
			});

			window.location.pathname = "/";
		} catch (error) {
			alert("Ocorreu um erro ao realizar o cadastro");
		}
	};
</script>

<div>
	<h1 class="mdc-typography--headline4">Cadastro</h1>
	<Spacer vertical={32} />
	<Container maxWidth={382}>
		<form on:submit={onSubmit}>
			<ImagePicker bind:image />
			<Spacer vertical={32} />

			<Textfield
				id="name"
				variant="outlined"
				style="display:flex"
				label="Nome"
				bind:value={name}
			/>
			<Spacer vertical={16} />

			<Textfield
				id="birthDate"
				variant="outlined"
				style="display:flex"
				label="Data de Nascimento"
				type="date"
				bind:value={birthDate}
			/>
			<Spacer vertical={16} />

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
			<Spacer vertical={16} />

			<Textfield
				id="confirmPassword"
				variant="outlined"
				style="display:flex"
				label="Confirmar Senha"
				type="password"
				bind:value={confirmPassword}
			/>
			<Spacer vertical={32} />

			<Flex justify="flex-end">
				<Button id="signupButton" variant="raised" type="submit"
					>Cadastrar</Button
				>
			</Flex>
		</form>
	</Container>
</div>
