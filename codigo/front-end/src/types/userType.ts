import type { TagType } from "./tagType";

export type UserType = {
	id: string;
	isAdmin: boolean;
	name: string;
	birthDate: string;
	profilePic: string;
	tags: TagType[];
};
