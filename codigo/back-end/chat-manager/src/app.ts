import express from "express";

import { mapToObj } from "./utils/mapToObject";

import ChatService from "./service/chat";
import TrendingService from "./service/trending";
import Server from "./service/server";

const app = express();

const server = new Server();
new ChatService(server.io);
new TrendingService(server.io);

app.use("/", (req, res) => {
	res.send("Chat Manager");
});

console.log("Server running!");
