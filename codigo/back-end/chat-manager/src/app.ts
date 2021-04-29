import { Server as SocketIOServer } from "socket.io";
import { createServer } from "http";
import express from "express";

const app = express();

app.use("/", (req, res) => {
	res.send("Hello World");
});

const httpServer = createServer(app);
const io = new SocketIOServer(httpServer, {
	cors: {
		origin: "*",
		methods: ["GET", "POST"],
	},
});

const usersQueue: any[] = [];

io.on("connection", (socket) => {
	socket.on("join-all-tags", (data) => {
		usersQueue.push({ tags: data.tags, socketID: socket.id });
		console.log(data);
	});
});

// setInterval(() => {
// 	usersQueue.forEach((user) => {
// 		const scores = usersQueue
// 			.filter((caller) => caller.socketID !== user.socketID)
// 			.map((caller) => compareUserTags(user.tags, caller.tags));
// 		console.log(scores);
// 	});
// }, 30_000);

httpServer.listen(5001);
