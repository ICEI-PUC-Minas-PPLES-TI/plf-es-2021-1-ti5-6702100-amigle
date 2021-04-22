<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";

	import { postUser } from "../../api/user";

	import Container from "../../components/Container/Container.svelte";
	import Flex from "../../components/Flex/Flex.svelte";
	import ImagePicker from "../../components/ImagePicker/ImagePicker.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";

	let image: File = null;
	let name = "";
	let age = "";
	let email = "";
	let password = "";
	let confirmPassword = "";

	const onSubmit = async (event: Event) => {
		event.preventDefault();

		await postUser({
			name,
			age,
			email,
			password,
		});
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
				variant="outlined"
				style="display:flex"
				label="Nome"
				bind:value={name}
			/>
			<Spacer vertical={16} />

			<Textfield
				variant="outlined"
				style="display:flex"
				label="Idade"
				bind:value={age}
			/>
			<Spacer vertical={16} />

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
				type="password"
				bind:value={password}
			/>
			<Spacer vertical={16} />

			<Textfield
				variant="outlined"
				style="display:flex"
				label="Confirmar Senha"
				type="password"
				bind:value={confirmPassword}
			/>
			<Spacer vertical={32} />

			<Flex justify="flex-end">
				<Button variant="raised" type="submit">Cadastrar</Button>
			</Flex>
		</form>
	</Container>
</div>
