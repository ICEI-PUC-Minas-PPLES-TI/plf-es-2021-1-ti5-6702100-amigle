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
