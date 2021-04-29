import type { UserType } from "../types/userType";

export const getLocalUser = () => {
	const userJSON = localStorage.getItem("user");

	if (userJSON) {
		const user: UserType = JSON.parse(userJSON);
		return user;
	}
};

export const removeLocalUser = () => {
	localStorage.removeItem("user");
};

export const isAuthenticated = () => {
	const userJSON = localStorage.getItem("user");
	return userJSON !== null;
};

export const isAdmin = () => {
	const userJSON = localStorage.getItem("user");

	if (userJSON) {
		const user = JSON.parse(userJSON);
		return user.isAdmin;
	}

	return false;
};
