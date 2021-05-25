import UserConnection from "./UserConnection";

class Call {
	id: number;
	firstUser: UserConnection;
	secondUser: UserConnection;

	constructor(firstUser: UserConnection, secondUser: UserConnection) {
		this.firstUser = firstUser;
		this.secondUser = secondUser;
	}

	// socket id of the user who disconnected
	hangUp(hangupSocketId: string) {
		const user =
			this.firstUser.socket.id === hangupSocketId
				? this.secondUser
				: this.firstUser;

		user.socket.disconnect();
	}
}

export default Call;
