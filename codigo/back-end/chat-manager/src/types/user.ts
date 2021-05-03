import { Tag } from "./tag";

export type User = {
	id: string;
	socketId: string;
	tags: Tag[];
};
