
-- Ativar extensão para gerar UUIDs
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- Tabela: Usuarios
CREATE TABLE Usuarios (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE NOT NULL,
    nome VARCHAR(255) NOT NULL,
    sobrenome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    Perfil VARCHAR(50) DEFAULT 'usuário comum',
    suspenso BOOLEAN DEFAULT FALSE,
    qnt_seguidores INT DEFAULT 0
);

-- Tabela: Publicacoes
CREATE TABLE Publicacoes (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE,
    titulo VARCHAR(255) NOT NULL,
    descricao TEXT NOT NULL,
    url_imagem TEXT,
    curtidas INT,
    denuncias INT
);

-- Tabela: Comentarios
CREATE TABLE Comentarios (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE,
    mensagem TEXT,
    publicacao_uuid VARCHAR(255),
    usuario_uuid VARCHAR(255),
    FOREIGN KEY (publicacao_uuid) REFERENCES Publicacoes(uuid),
    FOREIGN KEY (usuario_uuid) REFERENCES Usuarios(uuid)
);

-- Tabela: Seguidores
CREATE TABLE Seguidores (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE,
    seguidor_uuid VARCHAR(255),
    seguindo_uuid VARCHAR(255),
    FOREIGN KEY (seguidor_uuid) REFERENCES Usuarios(uuid),
    FOREIGN KEY (seguindo_uuid) REFERENCES Usuarios(uuid)
);

-- Tabela: acoes_moderadores
CREATE TABLE acoes_moderadores (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE,
    uuid_usuario VARCHAR(255),
    acao VARCHAR(255),
    FOREIGN KEY (uuid_usuario) REFERENCES Usuarios(uuid)
);

-- Tabela: palavras_proibidas
CREATE TABLE palavras_proibidas (
    ID SERIAL PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE,
    palavra VARCHAR(255)
);

-- Inserções de dados
-- 10 Usuários comuns
INSERT INTO Usuarios (uuid, nome, sobrenome, email, password)
VALUES 
(gen_random_uuid()::text, 'João', 'Silva', 'joao@example.com', 'senha123'),
(gen_random_uuid()::text, 'Maria', 'Oliveira', 'maria@example.com', 'senha123'),
(gen_random_uuid()::text, 'Carlos', 'Santos', 'carlos@example.com', 'senha123'),
(gen_random_uuid()::text, 'Ana', 'Souza', 'ana@example.com', 'senha123'),
(gen_random_uuid()::text, 'Pedro', 'Ferreira', 'pedro@example.com', 'senha123'),
(gen_random_uuid()::text, 'Mariana', 'Costa', 'mariana@example.com', 'senha123'),
(gen_random_uuid()::text, 'Lucas', 'Pereira', 'lucas@example.com', 'senha123'),
(gen_random_uuid()::text, 'Juliana', 'Almeida', 'juliana@example.com', 'senha123'),
(gen_random_uuid()::text, 'Fernando', 'Gomes', 'fernando@example.com', 'senha123'),
(gen_random_uuid()::text, 'Larissa', 'Ribeiro', 'larissa@example.com', 'senha123');

-- 1 Usuário Admin
INSERT INTO Usuarios (uuid, nome, sobrenome, email, password, Perfil)
VALUES (gen_random_uuid()::text, 'Admin', 'Master', 'admin@example.com', 'admin123', 'admin');

-- 1 Usuário Moderador
INSERT INTO Usuarios (uuid, nome, sobrenome, email, password, Perfil)
VALUES (gen_random_uuid()::text, 'Moderador', 'Oficial', 'mod@example.com', 'mod123', 'moderador');
