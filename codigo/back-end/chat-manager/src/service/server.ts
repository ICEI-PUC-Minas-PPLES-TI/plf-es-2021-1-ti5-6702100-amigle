import { createServer, Server as HTTPServer } from "http";
import express from "express";
import { Application } from "express";
import socketIO, { Server as SocketIOServer } from "socket.io";

export default class Server {
	#app: Application;
	#httpServer: HTTPServer;
	#io: SocketIOServer;

	constructor() {
		this.#app = express();
		this.#httpServer = createServer(this.#app);
		this.#io = socketIO(this.#httpServer);

		this.#httpServer.listen(process.env.PORT || 5001);
	}

	get io() {
		return this.#io;
	}
}
