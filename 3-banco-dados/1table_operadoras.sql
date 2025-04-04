CREATE TABLE operadoras (
    registro_ans INTEGER PRIMARY KEY,
    cnpj VARCHAR(20) NOT NULL,
    razao_social VARCHAR(255) NOT NULL,
    nome_fantasia VARCHAR(255),
    modalidade VARCHAR(100),
    logradouro VARCHAR(255),
    numero VARCHAR(20),
    complemento VARCHAR(255),
    bairro VARCHAR(100),
    cidade VARCHAR(100),
    uf CHAR(2) CHECK (uf ~ '^[A-Z]{2}$'),
    cep VARCHAR(20),
    ddd VARCHAR(3),
    telefone VARCHAR(20),
    fax VARCHAR(20),
    endereco_eletronico VARCHAR(255),
    representante VARCHAR(100),
    cargo_representante VARCHAR(100),
    regiao_de_comercializacao INTEGER,
    data_registro_ans DATE
);