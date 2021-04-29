import type { TagType } from "../types/tagType";
import { deleteReq, getReq, postReq, putReq } from "./api";

export const getTags = (): Promise<TagType[]> => {
	return getReq("tag");
};

export const getTag = (id: number): Promise<TagType> => {
	return getReq(`tag/${id}`);
};

export const queryTags = (name: string): Promise<TagType[]> => {
	return getReq(`tag?name=${name}`);
};

export const getTagsByCategoryId = (categoryId: number): Promise<TagType[]> => {
	return getReq(`tag?categoryId=${categoryId}`);
};

export const postTag = (userId: string, tag: any) => {
	return postReq(`tag/${userId}`, tag, true);
};

export const putTag = (tag: any) => {
	return putReq(`tag/${tag.id}`, tag);
};

export const deleteTag = (id: number) => {
	return deleteReq(`tag/${id}`);
};
