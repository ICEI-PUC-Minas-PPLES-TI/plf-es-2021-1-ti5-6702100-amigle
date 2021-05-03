import type { TagCategoryType } from "../types/tagCategoryType";
import { deleteReq, getReq, postReq, putReq } from "./api";

export const getTagCategories = (): Promise<TagCategoryType[]> => {
	return getReq("tag_category");
};

export const getTagCategory = (id: number): Promise<TagCategoryType> => {
	return getReq(`tag_category/${id}`);
};

export const postTagCategory = (tagCategory: any) => {
	return postReq("tag_category", tagCategory, true);
};

export const putTagCategory = (tagCategory: any) => {
	return putReq(`tag_category/${tagCategory.id}`, tagCategory);
};

export const deleteTagCategory = (id: number) => {
	return deleteReq(`tag_category/${id}`);
};
