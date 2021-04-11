-- SCHEMA: amigle

-- DROP SCHEMA amigle ;

CREATE SCHEMA amigle
    AUTHORIZATION postgres;
	
CREATE TABLE amigle.USER (
	id VARCHAR[50] NOT NULL,
	name VARCHAR[50],
	age INTEGER,
	is_admin BOOLEAN,
	PRIMARY KEY (id)
);

CREATE TABLE amigle.TAG_CATEGORY (
	id SERIAL NOT NULL,
	name VARCHAR[50],
	PRIMARY KEY (id)
);

CREATE TABLE amigle.TAG (
	id SERIAL NOT NULL,
	name VARCHAR[50],
	is_approved BOOLEAN,
	tag_category_id INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (tag_category_id) REFERENCES amigle.TAG_CATEGORY (id)
);

CREATE TABLE amigle.USER_TAG (
	id SERIAL NOT NULL,
	user_id VARCHAR[50] NOT NULL,
	tag_id INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (user_id) REFERENCES amigle.USER (id),
	FOREIGN KEY (tag_id) REFERENCES amigle.TAG (id)
);

CREATE TABLE amigle.CHAT (
	id SERIAL NOT NULL,
	start_date TIMESTAMP,
	end_date TIMESTAMP,
	first_user_id VARCHAR[50] NOT NULL,
	second_user_id VARCHAR[50] NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (first_user_id) REFERENCES amigle.USER (id),
	FOREIGN KEY (second_user_id) REFERENCES amigle.USER (id)
);