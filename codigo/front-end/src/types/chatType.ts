export type ChatType = {
	endDate: string;
	id: number;
	startDate: string;
	users: {
		firstUser: {
			id: string;
			name: string;
		};
		secondUser: {
			id: string;
			name: string;
		};
	};
};

export type ChatHistoryType = {
	endDate: string;
	guestUserName: string;
	id: number;
	startDate: string;
};
