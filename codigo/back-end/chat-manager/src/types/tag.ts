export type TagCategory = {
	id: number;
	name: string;
};

export type Tag = {
	category: TagCategory;
	id: number;
	isApproved: boolean;
	name: string;
};
