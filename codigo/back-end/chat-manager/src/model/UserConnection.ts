import { Socket } from "socket.io";
import { User } from "../types/user";

class UserConnection {
	user: User;
	socket: Socket;

	constructor(user: User, socket: Socket) {
		this.user = user;
		this.socket = socket;
	}

	onMatch(user: UserConnection) {
		this.socket.to(user.socket.id).emit("match-made", {
			socketId: this.socket.id,
		});
	}
}

export default UserConnection;
