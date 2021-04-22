import { getReq, postReq, putReq } from "./api";

export const getUsers = () => {
	return getReq("user");
};

export const getUser = (id: string) => {
	return getReq(`user/${id}`);
};

export const postUser = (user: any) => {
	return postReq("user", user);
};

export const putUser = (user: any) => {
	return putReq(`user/${user.id}`, user);
};

export const deleteReq = (id: string) => {
	return deleteReq(`user/${id}`);
};

export const login = (email: string, password: string) => {
	return postReq("user/login", { email, password });
};
