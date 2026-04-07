CREATE DATABASE IF NOT EXISTS loja_pascotto_v2;
USE loja_pascotto_v2;

-- 1. TABELA DE FORNECEDORES
-- Documentos salvos como VARCHAR para preservar zeros à esquerda.
CREATE TABLE fornecedores (
    id_fornecedor INT AUTO_INCREMENT PRIMARY KEY,
    nome_fantasia VARCHAR(100) NOT NULL,
    razao_social VARCHAR(100),
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. TABELA DE CATEGORIAS
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- 3. TABELA DE COLABORADORES
CREATE TABLE colaboradores (
    id_colaborador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(50),
    salario DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    data_admissao DATE
) ENGINE=InnoDB;

-- 4. TABELA DE PRODUTOS
-- A categoria agora faz parte do produto.
CREATE TABLE produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    id_fornecedor INT,
    id_categoria INT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco_venda DECIMAL(10, 2) NOT NULL,
    estoque_atual INT DEFAULT 0,
    estoque_minimo INT DEFAULT 5,
    CONSTRAINT fk_prod_fornecedor FOREIGN KEY (id_fornecedor) 
        REFERENCES fornecedores(id_fornecedor) ON DELETE SET NULL,
    CONSTRAINT fk_prod_categoria FOREIGN KEY (id_categoria) 
        REFERENCES categorias(id_categoria) ON DELETE SET NULL
) ENGINE=InnoDB;

-- 5. TABELA DE PEDIDOS (Cabeçalho)
-- Armazena QUEM vendeu e QUANDO.
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_colaborador INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    valor_total_pedido DECIMAL(10, 2) DEFAULT 0.00,
    CONSTRAINT fk_pedido_colaborador FOREIGN KEY (id_colaborador) 
        REFERENCES colaboradores(id_colaborador)
) ENGINE=InnoDB;

-- 6. ITENS DO PEDIDO (Detalhamento)
-- Em sistemas profissionais, um pedido pode ter vários produtos. 
-- Criamos esta tabela para permitir múltiplos itens por pedido.
CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT,
    id_produto INT,
    quantidade INT NOT NULL,
    preco_unitario_no_ato DECIMAL(10, 2) NOT NULL, -- Salva o preço da época da venda
    CONSTRAINT fk_item_pedido FOREIGN KEY (id_pedido) 
        REFERENCES pedidos(id_pedido) ON DELETE CASCADE,
    CONSTRAINT fk_item_produto FOREIGN KEY (id_produto) 
        REFERENCES produtos(id_produto)
) ENGINE=InnoDB;

-- Índices para acelerar buscas comuns
CREATE INDEX idx_nome_produto ON produtos(nome);
CREATE INDEX idx_data_pedido ON pedidos(data_pedido);
