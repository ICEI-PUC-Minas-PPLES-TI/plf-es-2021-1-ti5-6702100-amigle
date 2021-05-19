export const mapToObj = (map: Map<number, number>) => {
	return Array.from(map).reduce((obj: any, [key, value]) => {
		obj[key] = value;
		return obj;
	}, {});
};
