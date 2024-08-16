import express from "express";
import http from "http";
import { Server } from "socket.io";
import mongoose from "mongoose";

const app = express();
const PORT = 3000;

const DB =
  "mongodb+srv://puneeth:Test1234@cluster0.xwjne.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

app.use(express.json());

const server = http.createServer(app);

var io = new Server(server);

io.on("connection", (socket) => {
  console.log(`Connected to : ${socket.id}`);

  socket.on("event", ({ nickname }) => {
    console.log(nickname);
  });
});

mongoose
  .connect(DB)
  .then(() => {
    console.log(" database Connection successful!");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, () => {
  console.log(`server is listening at port ${PORT}`);
});

const auth = (req, res, next) => {
  req.user = "puneeth";
  next();
};

app.get("/:user", auth, (req, res) => {
  console.log(req.params.user);
  console.log(req.user);
  res.send("I am puneeth kumar ");
});
