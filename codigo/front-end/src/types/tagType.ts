import type { TagCategoryType } from "./tagCategoryType";

export type TagType = {
	id: number;
	isApproved: boolean;
	name: string;
	category: TagCategoryType;
};
