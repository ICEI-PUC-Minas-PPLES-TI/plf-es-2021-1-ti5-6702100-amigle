<script lang="ts">
	import Dialog, { Title, Content } from "@smui/dialog";
	import { onMount } from "svelte";
	import Line from "svelte-chartjs/src/Line.svelte";
	import { getChats } from "../../../api/chat";
	import type { ChatType } from "../../../types/chatType";

	export let dialog: any;
	export let chats: ChatType[] = [];

	let data = {};

	const generateChartLabels = () => {
		const arr: Date[] = [];
		const start = new Date(new Date().setDate(new Date().getDate() - 30));
		const end = new Date();

		for (let dt = new Date(start); dt <= end; dt.setDate(dt.getDate() + 1)) {
			arr.push(new Date(dt));
		}

		const strArr = arr.map((d) => d.toISOString().split("T")[0]);

		return strArr;
	};

	const generateChartValues = () => {
		const labels = generateChartLabels();
		const values = [];
		const valuesObj = {};

		for (const label of labels) {
			valuesObj[label] = 0;
		}

		chats.forEach((chat) => {
			const date = chat.startDate.split(" ")[0];

			if (valuesObj[date] !== undefined) {
				valuesObj[date]++;
			}
		});

		for (const value of Object.values(valuesObj)) {
			values.push(value);
		}

		return values;
	};

	onMount(async () => {
		chats = await getChats();
		data = {
			labels: generateChartLabels(),
			datasets: [
				{
					label: "Conversas",
					data: generateChartValues(),
					fill: false,
					borderColor: "#6200ee",
					tension: 0.1,
				},
			],
		};
	});
</script>

<Dialog bind:this={dialog}>
	<Title>Chats nos últimos 30 dias</Title>
	<Content style="width: 800px">
		<Line {data} />
	</Content>
</Dialog>
