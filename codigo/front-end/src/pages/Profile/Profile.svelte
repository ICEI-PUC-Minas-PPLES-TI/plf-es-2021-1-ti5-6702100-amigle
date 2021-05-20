<script lang="ts">
	import Button from "@smui/button";
	import Textfield from "@smui/textfield";
	import { onMount } from "svelte";

	import { addProfilePic, deleteUser, getUser, putUser } from "../../api/user";

	import { getLocalUser } from "../../utils/authStorage";

	import Container from "../../components/Container/Container.svelte";
	import Flex from "../../components/Flex/Flex.svelte";
	import ImagePicker from "../../components/ImagePicker/ImagePicker.svelte";
	import Spacer from "../../components/Spacer/Spacer.svelte";
	import ManageTags from "../../dialogs/ManageTags/ManageTags.svelte";

	let imageUrl = "";
	let image: File = null;
	let name = "";
	let birthDate = "";
	let profilePic = "";

	let manageTagsDialog: any;

	const onSubmit = async (event: Event) => {
		const user = getLocalUser();
		event.preventDefault();

		try {
			await putUser({
				id: user.id,
				name,
				birthDate,
			});

			if (image) {
				await addProfilePic(user.id, image);
			}

			alert("Usuário atualizado com sucesso!");
		} catch (error) {
			alert("Ocorreu um erro ao atualizar o usuário.");
		}
	};

	const onDelete = async (event: Event) => {
		const user = getLocalUser();
		event.preventDefault();

		const shouldDelete = confirm(
			"Você tem certeza que quer remover sua conta?"
		);

		if (shouldDelete) {
			await deleteUser(user.id);
		}
	};

	const toggleManageTags = () => {
		manageTagsDialog.open();
	};

	onMount(async () => {
		const user = getLocalUser();

		try {
			const data = await getUser(user.id);

			name = data.name;
			birthDate = data.birthDate;
			profilePic = data.profilePic;
		} catch (error) {
			alert("Ocorreu um erro ao recuperar o usuário.");
		}
	});
</script>

<div>
	<h1 class="mdc-typography--headline4">Editar Perfil</h1>
	<Spacer vertical={32} />
	<Container maxWidth={382}>
		<form on:submit={onSubmit}>
			<ImagePicker src={profilePic} bind:image />
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
			<Spacer vertical={32} />

			<Flex justify="space-between">
				<Button on:click={toggleManageTags} type="button" variant="outlined"
					>Gerenciar Tags</Button
				>
				<Button id="saveButton" variant="raised" type="submit">Salvar</Button>
			</Flex>
			<Spacer vertical={16} />
			<Flex justify="space-between">
				<Button
					on:click={onDelete}
					variant="raised"
					type="button"
					style="background-color:#E7432C">Remover Conta</Button
				>
			</Flex>
		</form>
	</Container>
</div>
<ManageTags bind:dialog={manageTagsDialog} />
