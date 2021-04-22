<script lang="ts">
	import { Router } from "svelte-router-spa";
	import Drawer, {
		AppContent,
		Content,
		Header,
		Title as DrawerTitle,
		Scrim,
	} from "@smui/drawer";
	import List, { Item } from "@smui/list";
	import TopAppBar, {
		Row,
		Section,
		Title as TopAppBarTitle,
	} from "@smui/top-app-bar";
	import IconButton from "@smui/icon-button";

	import Home from "./pages/Home/Home.svelte";
	import Login from "./pages/Login/Login.svelte";
	import Profile from "./pages/Profile/Profile.svelte";
	import SignUp from "./pages/SignUp/SignUp.svelte";
	import Trending from "./pages/Trending/Trending.svelte";
	import History from "./pages/History/History.svelte";
	import AdmChats from "./pages/AdmChats/AdmChats.svelte";
	import AdmUsers from "./pages/AdmUsers/AdmUsers.svelte";
	import AdmManageTags from "./pages/AdmManageTags/AdmManageTags.svelte";
	import AdmSuggestedTags from "./pages/AdmSuggestedTags/AdmSuggestedTags.svelte";
	import { isAdmin, isAuthenticated } from "./utils/authStorage";

	let drawer: any;
	let drawerOpen = false;

	const toggleDrawer = () => {
		drawerOpen = !drawerOpen;
	};

	const routes = [
		{
			name: "/",
			component: Home,
			onlyIf: { guard: isAuthenticated, redirect: "/login" },
		},
		{
			name: "trending",
			component: Trending,
			onlyIf: { guard: isAuthenticated, redirect: "/login" },
		},
		{
			name: "history",
			component: History,
			onlyIf: { guard: isAuthenticated, redirect: "/login" },
		},
		{
			name: "profile",
			component: Profile,
			onlyIf: { guard: isAuthenticated, redirect: "/login" },
		},
		{ name: "login", component: Login },
		{ name: "signup", component: SignUp },
		{
			name: "adm/chats",
			component: AdmChats,
			onlyIf: { guard: isAdmin, redirect: "/" },
		},
		{
			name: "adm/users",
			component: AdmUsers,
			onlyIf: { guard: isAdmin, redirect: "/" },
		},
		{
			name: "adm/manage-tags",
			component: AdmManageTags,
			onlyIf: { guard: isAdmin, redirect: "/" },
		},
		{
			name: "adm/suggested-tags",
			component: AdmSuggestedTags,
			onlyIf: { guard: isAdmin, redirect: "/" },
		},
	];
</script>

<Drawer variant="modal" bind:this={drawer} bind:open={drawerOpen}>
	<Header>
		<DrawerTitle>Amigle</DrawerTitle>
	</Header>
	<Content>
		<List on:click={toggleDrawer}>
			<Item><a class="drawer-link" href="/">Início</a></Item>
			<Item><a class="drawer-link" href="/trending">Trending</a></Item>
			<Item><a class="drawer-link" href="/history">Histórico</a></Item>
			<Item><a class="drawer-link" href="/profile">Meu Perfil</a></Item>
			<Item><a class="drawer-link" href="/">Sair</a></Item>
			{#if isAdmin()}
				<Item
					><a class="drawer-link" href="/adm/chats"
						><strong>[ADM] Conversas</strong></a
					></Item
				>
				<Item
					><a class="drawer-link" href="/adm/users"
						><strong>[ADM] Usuários</strong></a
					></Item
				>
				<Item
					><a class="drawer-link" href="/adm/manage-tags"
						><strong>[ADM] Gerenciar Tags</strong></a
					></Item
				>
				<Item
					><a class="drawer-link" href="/adm/suggested-tags"
						><strong>[ADM] Tags Sugeridas</strong></a
					></Item
				>
			{/if}
		</List>
	</Content>
</Drawer>

<Scrim />

<AppContent>
	<main>
		<TopAppBar variant="fixed">
			<Row>
				<Section>
					<IconButton class="material-icons" on:click={toggleDrawer}
						>menu</IconButton
					>
					<TopAppBarTitle
						><a class="app-title" href="/">Amigle</a></TopAppBarTitle
					>
				</Section>
				<Section align="end" toolbar>
					<div class="app-profile">
						<span class="mdc-typography--subtitle1 app-profile-username"
							>Lucas</span
						>
						<img
							class="app-profile-avatar"
							src="https://placekitten.com/40/40"
							alt=""
						/>
					</div>
				</Section>
			</Row>
		</TopAppBar>
		<section class="app-section">
			<Router {routes} />
		</section>
	</main>
</AppContent>

<style>
	.app-profile {
		display: flex;
		align-items: center;
	}
	.app-profile-username {
		margin-right: 16px;
		font-weight: bold;
	}
	.app-profile-avatar {
		border-radius: 50%;
	}
	.app-title {
		color: #fff;
		text-decoration: none;
	}
	.app-section {
		padding: 0 40px;
		padding-top: 120px;
	}
	.drawer-link {
		color: #000;
		text-decoration: none;
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: flex-start;
		align-items: center;
	}
</style>
