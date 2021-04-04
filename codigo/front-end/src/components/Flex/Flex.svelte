<script lang="ts">
	export let direction: "row" | "column" = "row";
	export let align: "flex-start" | "center" | "flex-end" | "stretch" = "center";
	export let justify: "flex-start" | "center" | "flex-end" | "space-between" =
		"center";
	export let height: number;
</script>

<div
	style={`display: flex; width:100%; height:${
		height ? `${height}px` : "100%"
	}; flex-direction: ${direction}; align-items: ${align}; justify-content: ${justify}`}
>
	<slot />
</div>
