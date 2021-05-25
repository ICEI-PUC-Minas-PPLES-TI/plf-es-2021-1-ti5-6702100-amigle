import fetch from "node-fetch";
import { Server as SocketIOServer, Socket } from "socket.io";
import Call from "../model/Call";
import UserConnection from "../model/UserConnection";
import { getTagScoreArray } from "../utils/matchUsers";
class ChatService {
	historyURL = "http://localhost:3000/chat";

	#io: SocketIOServer;
	#allTagsQueue: UserConnection[];
	#specificTagMap: Map<number, UserConnection[]>;

	#activeCalls: Call[];

	static activeCallUpdateListener = (calls: Call[]) => {};

	constructor(io: SocketIOServer) {
		this.#io = io;
		this.#allTagsQueue = [];
		this.#specificTagMap = new Map();

		this.#activeCalls = [];

		this.listenToSocketConnections();
		this.handleUserMatches();
	}

	saveToHistory(call: Call) {
		const users = [call.firstUser.user.id, call.secondUser.user.id].sort();

		const body = {
			firstUserId: users[0],
			secondUserId: users[1],
		};

		fetch(this.historyURL, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(body),
		})
			.then((res) => res.json())
			.then((res) => {
				call.id = res.chatId;
			})
			.catch((error) => {
				console.log(error);
			});
	}

	updateHistory(call: Call) {
		fetch(this.historyURL + `/${call.id}`, {
			method: "PUT",
		})
			.then((res) => {
				// do nothing
			})
			.catch((error) => {
				console.log(error);
			});
	}

	listenToSocketConnections() {
		this.#io.on("connection", (socket) => {
			console.log("Connected socket:  " + socket.id);

			socket.on("join-all-tags", (user) => {
				if (user) {
					this.#allTagsQueue.push(new UserConnection(user, socket));
				}
			});

			socket.on("join-specific-tag", (data) => {
				if (data) {
					const tagQueue = this.#specificTagMap.get(data.tagId);

					if (tagQueue) {
						tagQueue.push(new UserConnection(data.user, socket));
					} else {
						this.#specificTagMap.set(data.tagId, [
							new UserConnection(data.user, socket),
						]);
					}
				}
			});

			socket.on("send-message", (payload) => {
				socket.to(payload.target).emit("message-received", {
					received: true,
					text: payload.text,
				});
			});

			socket.on("offer", (payload) => {
				socket.to(payload.target).emit("offer", payload);
			});

			socket.on("answer", (payload) => {
				socket.to(payload.target).emit("answer", payload);
			});

			socket.on("ice-candidate", (incoming) => {
				socket.to(incoming.target).emit("ice-candidate", incoming.candidate);
			});

			socket.on("disconnect", () => {
				this.#allTagsQueue = this.#allTagsQueue.filter(
					(uc) => uc.socket.id !== socket.id
				);

				const call = this.#activeCalls.find(
					(call) =>
						call.firstUser.socket.id === socket.id ||
						call.secondUser.socket.id === socket.id
				);

				if (!call) {
					return;
				}

				call.hangUp(socket.id);
				this.updateHistory(call);

				this.#activeCalls = this.#activeCalls.filter((c) => {
					c.firstUser.socket.id !== call.firstUser.socket.id &&
						c.secondUser.socket.id !== call.secondUser.socket.id;
				});

				ChatService.activeCallUpdateListener(this.#activeCalls);
			});
		});
	}

	handleUserMatches() {
		setInterval(() => {
			this.handleAllTagsMatch();
			this.handleSpecificTagsMatch();
		}, 3_000);
	}

	handleAllTagsMatch() {
		let finished = false;

		while (!finished) {
			if (this.#allTagsQueue.length <= 1) {
				finished = true;
				return;
			}

			const firstUser = this.#allTagsQueue.shift();
			const scoreArray = getTagScoreArray(firstUser, this.#allTagsQueue);
			const secondUser = scoreArray[0].uc;

			firstUser.onMatch(secondUser);

			const call = new Call(firstUser, secondUser);

			this.saveToHistory(call);

			this.#activeCalls.push(call);
			ChatService.activeCallUpdateListener(this.#activeCalls);

			this.#allTagsQueue = this.#allTagsQueue.filter(
				(uc) =>
					uc.user.id !== firstUser.user.id &&
					uc.user.id !== scoreArray[0].uc.user.id
			);
		}
	}

	handleSpecificTagsMatch() {
		let finished = false;

		while (!finished) {
			finished = true;

			for (const [_, value] of this.#specificTagMap.entries()) {
				if (value.length > 1) {
					finished = false;

					const firstUser = value.shift();
					const secondUser = value.shift();

					firstUser.onMatch(secondUser);

					const call = new Call(firstUser, secondUser);

					this.saveToHistory(call);

					this.#activeCalls.push(call);
					ChatService.activeCallUpdateListener(this.#activeCalls);
				}
			}

			if (finished) {
				return;
			}
		}
	}
}

export default ChatService;
