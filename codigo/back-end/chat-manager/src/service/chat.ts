import { Server as SocketIOServer, Socket } from "socket.io";
import Call from "../model/Call";
import UserConnection from "../model/UserConnection";
import { getTagScoreArray } from "../utils/matchUsers";
class ChatService {
	#io: SocketIOServer;
	#allTagsQueue: UserConnection[];
	#specificTagMap: Map<number, UserConnection[]>;

	#activeCalls: Call[];

	constructor(io: SocketIOServer) {
		this.#io = io;
		this.#allTagsQueue = [];
		this.#specificTagMap = new Map();

		this.#activeCalls = [];

		this.listenToSocketConnections();
		this.handleUserMatches();
	}

	listenToSocketConnections() {
		this.#io.on("connection", (socket) => {
			socket.on("join-all-tags", (user) => {
				if (user) {
					this.#allTagsQueue.push(new UserConnection(user, socket));
				}
			});

			socket.on("join-specific-tag", (user) => {
				if (user) {
					this.#allTagsQueue.push(new UserConnection(user, socket));
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

				call.hangUp(socket.id);

				this.#activeCalls = this.#activeCalls.filter((c) => {
					c.firstUser.socket.id !== call.firstUser.socket.id &&
						c.secondUser.socket.id !== call.secondUser.socket.id;
				});
			});
		});
	}

	handleUserMatches() {
		setInterval(() => {
			this.handleAllTagsMatch();
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

			console.log(scoreArray);

			firstUser.onMatch(secondUser);

			this.#activeCalls.push(new Call(firstUser, secondUser));
			this.#allTagsQueue = this.#allTagsQueue.filter(
				(uc) =>
					uc.user.id !== firstUser.user.id &&
					uc.user.id !== scoreArray[0].uc.user.id
			);
		}
	}

	handleSpecificTagsMatch() {}
}

export default ChatService;
