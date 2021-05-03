import UserConnection from "../model/UserConnection";
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

export function getTagScoreArray(
	userConnection: UserConnection,
	userConnections: UserConnection[]
) {
	const scores: { uc: UserConnection; score: number }[] = [];

	userConnections.forEach((uc) => {
		scores.push({
			uc: uc,
			score: compareUserTags(userConnection.user.tags, uc.user.tags),
		});
	});

	scores.sort((u1, u2) => u2.score - u1.score);

	return scores;
}
