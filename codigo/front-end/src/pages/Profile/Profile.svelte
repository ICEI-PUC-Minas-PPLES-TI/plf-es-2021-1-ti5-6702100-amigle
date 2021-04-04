<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import Container from "../../components/Container/Container.svelte";

	import Flex from "../../components/Flex/Flex.svelte";
	import ImagePicker from "../../components/ImagePicker/ImagePicker.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";
	import ManageTags from "../../dialogs/ManageTags/ManageTags.svelte";

	let image: File = null;
	let name = "";
	let age = "";
	let email = "";
	let password = "";
	let confirmPassword = "";

	let manageTagsDialog: any;

	const onSubmit = (event: Event) => {
		event.preventDefault();
	};

	const toggleManageTags = () => {
		manageTagsDialog.open();
	};
</script>

<div>
	<h1 class="mdc-typography--headline4">Editar Perfil</h1>
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

			<Flex justify="space-between">
				<Button on:click={toggleManageTags} variant="outlined"
					>Gerenciar Tags</Button
				>
				<Button variant="raised" type="submit">Salvar</Button>
			</Flex>
			<Spacer vertical={16} />
			<Flex justify="space-between">
				<Button variant="raised" type="submit" style="background-color:#E7432C"
					>Remover Conta</Button
				>
			</Flex>
		</form>
	</Container>
	<ManageTags bind:dialog={manageTagsDialog} />
</div>
