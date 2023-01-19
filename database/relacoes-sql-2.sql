-- Active: 1674041033440@@127.0.0.1@3306

----------------- Prática 1

-- CRIANDO A TABELA users
CREATE TABLE users (
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL,
    created_at TEXT DEFAULT(DATETIME('now', 'localtime')) NOT NULL
);

SELECT DATETIME("now", "localtime");
SELECT * FROM users; -- VISUALIZAR A TABELA
DROP TABLE users; -- EXCLUIR A TABELA

-- POPULANDO A TABELA COM 3 USUÁRIOS
INSERT INTO users (id, name, email, password)
VALUES
    ("u001", "Edipo", "teste1@teste.com", "123"),
    ("u002", "Pamela", "teste2@teste.com", "456"),
    ("u003", "Aurora", "teste3@teste.com", "789");


----------------- PRÁTICA 2

-- CRIANDO A TABELA DE RELAÇÕES
CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users (id),
	FOREIGN KEY (followed_id) REFERENCES users (id)
);

SELECT * FROM follows; -- VISUALIZAR TABELA
DROP TABLE follows; -- EXCLUIR TABELA

-- POPULANDO A TABELA COM 3 USUÁRIOS
INSERT INTO follows (follower_id, followed_id)
VALUES
    ("u001", "u002"),
    ("u001", "u003"),
    ("u002", "u001");


-- RELACIONANDO AS TABELAS follows.follower_id = users.id
SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

----------------- PRÁTICA 3

-- VISUALIZANDO TAMBÉM OS QUE NÃO SEGUEM NINGUÉM
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- RETORNANDO TAMBÉM O NOME DA PESSOA SEGUIDA
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id;

-- REMOVENDO AMBIGUIDADES UTILIZANDO AS
SELECT 
    users.id AS usersId,
    users.name,
    users.email,
    users.password,
    users.created_at AS createAt,
    follows.follower_id AS followerId,
    follows.followed_id AS follwedId,
    usersFollowed.name AS nameFollowed 
 FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id;

