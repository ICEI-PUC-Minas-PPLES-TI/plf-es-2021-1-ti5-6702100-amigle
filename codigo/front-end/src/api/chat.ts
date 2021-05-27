import type { ChatType, ChatHistoryType } from "../types/chatType";

import { getReq } from "./api";

export const getChats = (): Promise<ChatType[]> => {
	return getReq("chat");
};

export const getChatHistory = (uid: string): Promise<ChatHistoryType[]> => {
	return getReq(`chat/${uid}`);
};
