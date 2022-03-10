-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE octobur_members (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    password_hash CHAR(98) NOT NULL
);

CREATE UNIQUE INDEX octobur_members_username_index ON octobur_members(username);

CREATE UNIQUE INDEX octobur_members_email_index ON octobur_members(email);

-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE IF EXISTS octobur_members;