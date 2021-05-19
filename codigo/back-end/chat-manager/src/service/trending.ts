import { Server as SocketIOServer, Socket } from "socket.io";
import Call from "../model/Call";
import { Tag, TagCategory } from "../types/tag";
import ChatService from "./chat";

class TrendingService {
	#io: SocketIOServer;

	#activeCalls: Call[];
	#trending: { categories: TagCategory[]; tags: Tag[] } = {
		categories: [],
		tags: [],
	};

	#trendingUpdateCallbacks: { socket: Socket; callback: () => void }[] = [];

	constructor(io: SocketIOServer) {
		this.#io = io;
		this.#activeCalls = [];

		this.listenToSocketConnections();
		ChatService.activeCallUpdateListener = (calls: Call[]) => {
			this.#activeCalls = calls;
			this.#trending = this.getTrendingTags();

			this.#trendingUpdateCallbacks.forEach((i) => {
				i.callback();
			});
		};
	}

	getTrendingTags() {
		const tagsMap: any = {};
		const categoriesMap: any = {};
		const trendingMap: any = {};

		this.#activeCalls.forEach((call) => {
			call.firstUser.user.tags.forEach((tag) => {
				const score = trendingMap[tag.id];

				if (score) {
					trendingMap[tag.id] = score + 1;
				} else {
					trendingMap[tag.id] = 1;
				}

				tagsMap[tag.id] = tag;
				categoriesMap[tag.category.id] = tag.category;
			});

			call.secondUser.user.tags.forEach((tag) => {
				const score = trendingMap[tag.id];

				if (score) {
					trendingMap[tag.id] = score + 1;
				} else {
					trendingMap[tag.id] = 1;
				}

				tagsMap[tag.id] = tag;
				categoriesMap[tag.category.id] = tag.category;
			});
		});

		for (const [key, value] of Object.entries(trendingMap)) {
			tagsMap[key].count = value;
		}

		const result: { categories: TagCategory[]; tags: Tag[] } = {
			categories: Object.values(categoriesMap),
			tags: Object.values(tagsMap),
		};

		return result;
	}

	listenToSocketConnections() {
		this.#io.on("connection", (socket) => {
			socket.on("get-trending", () => {
				socket.emit("trending-update", this.#trending);

				this.#trendingUpdateCallbacks.push({
					socket,
					callback: () => {
						socket.emit("trending-update", this.#trending);
					},
				});
			});

			socket.on("disconnect", () => {
				this.#trendingUpdateCallbacks = this.#trendingUpdateCallbacks.filter(
					(i) => {
						i.socket.id !== socket.id;
					}
				);
			});
		});
	}
}

export default TrendingService;
