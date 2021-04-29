const baseAddress = "http://localhost:3000";

export const getReq = async (path: string) => {
	try {
		const data = await fetch(`${baseAddress}/${path}`, {
			method: "GET",
		});

		const json = await data.json();

		return json;
	} catch (error) {
		throw error;
	}
};

export const postReq = async (path: string, body?: any, noJson = false) => {
	try {
		const data = await fetch(`${baseAddress}/${path}`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
			},
			body: body ? JSON.stringify(body) : undefined,
		});

		if (noJson) {
			return data;
		}

		const json = await data.json();

		return json;
	} catch (error) {
		throw error;
	}
};

export const postReqWithFormData = async (path: string, body: FormData) => {
	try {
		const data = await fetch(`${baseAddress}/${path}`, {
			method: "POST",
			body,
		});

		const json = await data.json();

		return json;
	} catch (error) {
		throw error;
	}
};

export const putReq = async (path: string, body: any) => {
	try {
		const data = await fetch(`${baseAddress}/${path}`, {
			method: "PUT",
			headers: {
				"Content-Type": "application/json",
			},
			body: JSON.stringify(body),
		});

		return data;
	} catch (error) {
		throw error;
	}
};

export const deleteReq = async (path: string) => {
	try {
		const data = await fetch(`${baseAddress}/${path}`, {
			method: "DELETE",
		});

		return data;
	} catch (error) {
		throw error;
	}
};
