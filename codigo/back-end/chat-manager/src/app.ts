import { Server as SocketIOServer } from "socket.io";
import express from "express";
import ChatService from "./service/chat";
import Server from "./service/server";

const app = express();

app.use("/", (req, res) => {
	res.send("Hello World");
});

const server = new Server();
new ChatService(server.io);
