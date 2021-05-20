import type { UserType } from "../types/userType";
import { deleteReq, getReq, postReq, postReqWithFormData, putReq } from "./api";

export const getUsers = (): Promise<UserType[]> => {
	return getReq("user");
};

export const getUser = (id: string): Promise<UserType> => {
	return getReq(`user/${id}`);
};

export const postUser = (user: any) => {
	return postReq("user", user, true);
};

export const postUserTag = (userId: string, tagId: number) => {
	return postReq(`user/${userId}/${tagId}`, null, true);
};

export const putUser = (user: any) => {
	return putReq(`user/${user.id}`, user, true);
};

export const deleteUser = (id: string) => {
	return deleteReq(`user/${id}`);
};

export const deleteUserTag = (userId: string, tagId: number) => {
	return deleteReq(`user/${userId}/${tagId}`);
};

export const login = (email: string, password: string) => {
	return postReq("user/login", { email, password });
};

export const addProfilePic = (id: string, image: File) => {
	const data = new FormData();
	data.set("profilePic", image);

	return postReqWithFormData(`user/${id}`, data);
};
