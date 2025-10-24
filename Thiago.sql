CREATE DATABASE loja_pascotto_prova;

USE loja_pascotto_prova;

CREATE TABLE fornecedores(
	idFornecedor VARCHAR (10) PRIMARY KEY,
    nome VARCHAR (50) NOT NULL,
    cnpj INT(15) NOT NULL,
    telefone INT(15),
    cpf INT(11)
);

CREATE TABLE colaborador(
	idColaborador VARCHAR(100) PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    cargo VARCHAR(50),
    salario FLOAT(10.2)
);

CREATE TABLE produtos(
	idProduto VARCHAR(100) PRIMARY KEY,
	idFornecedor VARCHAR (10),
	nome VARCHAR(50) NOT NULL,
    preco FLOAT(10.5),
	quantdade_estoque INT,
    CONSTRAINT fk_idFornecedor_produtos FOREIGN KEY(idFornecedor) REFERENCES fornecedores(idFornecedor)
);

CREATE TABLE pedidos(
	idPedido VARCHAR(50) PRIMARY KEY,
	idColaborador VARCHAR(100),
    idProduto VARCHAR(100),
    quantidade INT(100),
    CONSTRAINT fk_idColaborador_pedidos FOREIGN KEY(idColaborador) REFERENCES colaboradores(idColaborador),
    CONSTRAINT fk_idProduto_pedidos FOREIGN KEY(idProduto) REFERENCES produtos(idProduto)
);

ALTER TABLE fornecedores ADD COLUMN email VARCHAR(50);

select * from fornecedores;

CREATE TABLE categorias(
	idCategoria VARCHAR(100) PRIMARY KEY,
    nmeCategoria VARCHAR(50) NOT NULL
);

ALTER TABLE pedidos ADD COLUMN idCategorias VARCHAR(100);
