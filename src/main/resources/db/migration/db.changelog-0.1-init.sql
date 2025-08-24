--liquibase formatted sql

--changeset alex:1
CREATE TABLE IF NOT EXISTS account(
                                    id BIGSERIAL PRIMARY KEY,
                                    firstname VARCHAR(64) NOT NULL,
                                    lastname VARCHAR(64) NOT NULL,
                                    email VARCHAR(64) UNIQUE NOT NULL,
                                    password VARCHAR(128) NOT NULL,
                                    role VARCHAR(64) NOT NULL,
                                    enabled boolean DEFAULT TRUE
);
--rollback DROP TABLE users


--changeset alex:2
CREATE TABLE IF NOT EXISTS card(
    id BIGSERIAL PRIMARY KEY ,
    account_id BIGINT REFERENCES account(id) ON DELETE CASCADE NOT NULL,
    holder VARCHAR(128) NOT NULL,
    number_hash VARCHAR(255) UNIQUE NOT NULL,
    last_four_digits CHAR(4) NOT NULL ,
    exp_date DATE NOT NULL,
    status VARCHAR(32) CHECK ( status IN('ACTIVE','BLOCKED','EXPIRED') ) NOT NULL,
    balance DECIMAL(19,2) NOT NULL DEFAULT 0

);
--rollback DROP TABLE card

--changeset alex:3
CREATE TABLE IF NOT EXISTS Transaction(
   id BIGSERIAL PRIMARY KEY,
    from_card_id BIGINT REFERENCES card(id) ON DELETE CASCADE,
    to_card_id BIGINT REFERENCES card(id) ON DELETE CASCADE,
    amount DECIMAL(19,2) NOT NULL CHECK ( amount > 0 ),
    description VARCHAR(255),
    status VARCHAR(32) NOT NULL CHECK (status IN('SUCCESS','FAILED')),
    timestamp TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);