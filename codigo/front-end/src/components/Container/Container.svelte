<script lang="ts">
	export let maxWidth = 0;
</script>

<div style={`max-width: ${maxWidth}px`}>
	<slot />
</div>
