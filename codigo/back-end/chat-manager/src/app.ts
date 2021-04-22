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

function compareTags(t1: string[], t2: string[]) {
  let score = 0;

  t1.forEach((tag) => {
    if (t2.includes(tag)) {
      score++;
    }
  });

  return score;
}

setInterval(() => {
  usersQueue.forEach((user) => {
    const scores = usersQueue
      .filter((caller) => caller.socketID !== user.socketID)
      .map((caller) => compareTags(user.tags, caller.tags));
    console.log(scores);
  });
}, 30_000);

httpServer.listen(5001);
