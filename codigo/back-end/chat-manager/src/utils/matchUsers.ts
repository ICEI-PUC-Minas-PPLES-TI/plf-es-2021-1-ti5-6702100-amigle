import { Tag } from "../types/tag";
import { User } from "../types/user";

function compareUserTags(t1: Tag[], t2: Tag[]) {
	let score = 0;

	const tagIds1 = t1.map((t) => t.id);
	const tagIds2 = t2.map((t) => t.id);

	tagIds1.forEach((tag) => {
		if (tagIds2.includes(tag)) {
			score++;
		}
	});

	return score;
}

export function getTagScoreArray(user: User, users: User[]) {
	const otherUsers = users.filter((u) => u.id !== user.id);
	const scores: { userId: string; socketId: string; score: number }[] = [];

	otherUsers.forEach((u) => {
		scores.push({
			userId: u.id,
			socketId: u.socketId,
			score: compareUserTags(user.tags, u.tags),
		});
	});

	scores.sort((u1, u2) => u2.score - u1.score);

	return scores;
}
