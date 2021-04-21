<script lang="ts">
	import Dialog, { Title, Content } from "@smui/dialog";
	import Line from "svelte-chartjs/src/Line.svelte";

	export let dialog: any;

	const data = {
		labels: ["1", "2"],
		datasets: [
			{
				label: "Conversas",
				data: [1, 2],
				fill: false,
				borderColor: "#6200ee",
				tension: 0.1,
			},
		],
	};
</script>

<Dialog bind:this={dialog}>
	<Title>Chats nos últimos 30 dias</Title>
	<Content>
		<Line {data} />
	</Content>
</Dialog>
