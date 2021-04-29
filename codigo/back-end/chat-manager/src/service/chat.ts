import { Server as SocketIOServer, Socket } from "socket.io";
import { User } from "../types/user";
import { getTagScoreArray } from "../utils/matchUsers";
class ChatService {
	#io: SocketIOServer;
	#allTagsQueue: User[];
	#specificTagMap: Map<number, User[]>;

	constructor(io: SocketIOServer) {
		this.#io = io;
		this.#allTagsQueue = [];
		this.#specificTagMap = new Map();

		this.listenToSocketConnections();
	}

	listenToSocketConnections() {
		this.#io.on("connection", (socket) => {
			socket.on("join-all-tags", (user: User) => {
				this.#allTagsQueue.push({ ...user, socketId: socket.id });
			});

			socket.on(
				"join-specific-tag",
				({ user, tagId }: { user: User; tagId: number }) => {
					const currentTagQueue = this.#specificTagMap.get(tagId);

					if (currentTagQueue) {
						currentTagQueue.push({ ...user, socketId: socket.id });
					} else {
						this.#specificTagMap.set(tagId, []);
						this.#specificTagMap
							.get(tagId)
							.push({ ...user, socketId: socket.id });
					}
				}
			);

			this.handleUserMatches(socket);
		});
	}

	handleUserMatches(socket: Socket) {
		setInterval(() => {
			this.handleAllTagsMatch(socket);
		}, 10_000);
	}

	handleAllTagsMatch(socket: Socket) {
		if (this.#allTagsQueue.length <= 1) {
			return;
		}

		this.#allTagsQueue.forEach((user) => {
			const scores = getTagScoreArray(user, this.#allTagsQueue);

			if (scores.length === 0) {
				return;
			}

			socket.to(scores[0].socketId).emit("match-made", {
				sockerId: socket.id,
			});

			this.#allTagsQueue.shift();
		});
	}

	handleSpecificTagsMatch(socket: Socket) {}
}
