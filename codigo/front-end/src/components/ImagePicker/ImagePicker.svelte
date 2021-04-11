<script lang="ts">
	import Button from "@smui/button";
	import { onMount } from "svelte";

	export let image = null;

	let input = null;

	onMount(() => {
		input = document.getElementById("imagePicker-input");

		input.addEventListener("change", (event) => {
			const file = event.target.files[0];

			image = file;
		});
	});

	const selectImage = () => {
		input?.click();
	};
</script>

<div class="imagePicker">
	<Button type="button" on:click={selectImage}
		>+ Escolher Imagem de Perfil</Button
	>
	<input
		id="imagePicker-input"
		class="imagePicker-input"
		type="file"
		accept="image/x-png,image/gif,image/jpeg"
	/>
	<img
		class="imagePicker-image"
		src={image ? URL.createObjectURL(image) : "img/empty.webp"}
		alt=""
	/>
</div>

<style>
	.imagePicker {
		display: flex;
		align-items: center;
		justify-content: space-between;
	}
	.imagePicker-image {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		object-fit: cover;
	}
	.imagePicker-input {
		display: none;
	}
</style>
