import { createServer, Server as HTTPServer } from "http";
import express from "express";
import { Application } from "express";
import { Server as SocketIOServer } from "socket.io";

export default class Server {
	#app: Application;
	#httpServer: HTTPServer;
	#io: SocketIOServer;

	constructor() {
		this.#app = express();
		this.#httpServer = createServer(this.#app);
		this.#io = new SocketIOServer(this.#httpServer, {
			cors: {
				origin: "*",
				methods: ["GET", "POST"],
			},
		});
	}

	get io() {
		return this.#io;
	}
}
