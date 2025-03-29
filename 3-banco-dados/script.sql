-- ----------------------------------------
-- script SQL - teste de nivelamento 3
-- candidata: [Ludmilla Oliveira]
-- banco: PostgreSQL 10+
-- ----------------------------------------

-- este script cria e popula as tabelas com dados reais, realizando tratamento de dados,
-- integridade referencial e queries analíticas para avaliação de despesas.
-- utilize psql + \copy para importar os arquivos corretamente do lado cliente.

-- -------------------------------
-- 0. limpeza (para retestes)
-- -------------------------------
DROP TABLE IF EXISTS despesas;
DROP TABLE IF EXISTS operadoras;
DROP TABLE IF EXISTS temp_despesas;

-- -------------------------------
-- 1. criação da tabela: operadoras
-- -------------------------------
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

-- -------------------------------
-- 2. importação da tabela operadoras via terminal (psql)
-- -------------------------------
-- \copy operadoras FROM 'CAMINHO/para/operadoras.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

-- -------------------------------
-- 3. criação da tabela: despesas
-- -------------------------------
CREATE TABLE despesas (
    id_despesa SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    reg_ans INTEGER NOT NULL REFERENCES operadoras(registro_ans),
    cd_conta_contabil VARCHAR(20) NOT NULL,
    descricao TEXT,
    vl_saldo_inicial NUMERIC(18,2),
    vl_saldo_final NUMERIC(18,2)
);

-- -------------------------------
-- 4. tabela temporária para importação e tratamento
-- -------------------------------
CREATE TEMP TABLE temp_despesas (
    data TEXT,
    reg_ans TEXT,
    cd_conta_contabil TEXT,
    descricao TEXT,
    vl_saldo_inicial TEXT,
    vl_saldo_final TEXT
);

-- -------------------------------
-- 5. importação via terminal (psql):
-- \copy temp_despesas FROM 'CAMINHO/para/despesas.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';

-- -------------------------------
-- 6. inserção de operadoras faltantes com dados fictícios
-- -------------------------------
-- apenas para registros que estejam em despesas.csv mas não existam no CSV de operadoras

INSERT INTO operadoras (registro_ans, cnpj, razao_social) 
VALUES
(422118, '00000000000000', 'Placeholder'),
(413194, '00000000000000', 'Placeholder'),
(421880, '00000000000000', 'Placeholder'),
(352861, '00000000000000', 'Placeholder'),
(406708, '00000000000000', 'Placeholder'),
(369233, '00000000000000', 'Placeholder'),
(363766, '00000000000000', 'Placeholder'),
(423769, '00000000000000', 'Placeholder'),
(358509, '00000000000000', 'Placeholder'),
(422282, '00000000000000', 'Placeholder'),
(422819, '00000000000000', 'Placeholder'),
(421898, '00000000000000', 'Placeholder'),
(422843, '00000000000000', 'Placeholder'),
(350729, '00000000000000', 'Placeholder'),
(414131, '00000000000000', 'Placeholder'),
(417416, '00000000000000', 'Placeholder'),
(421600, '00000000000000', 'Placeholder'),
(418838, '00000000000000', 'Placeholder'),
(419168, '00000000000000', 'Placeholder'),
(337510, '00000000000000', 'Placeholder'),
(417556, '00000000000000', 'Placeholder'),
(420263, '00000000000000', 'Placeholder'),
(420034, '00000000000000', 'Placeholder'),
(422665, '00000000000000', 'Placeholder'),
(422550, '00000000000000', 'Placeholder'),
(422142, '00000000000000', 'Placeholder'),
(420115, '00000000000000', 'Placeholder'),
(357910, '00000000000000', 'Placeholder'),
(423246, '00000000000000', 'Placeholder'),
(411701, '00000000000000', 'Placeholder'),
(422614, '00000000000000', 'Placeholder'),
(392391, '00000000000000', 'Placeholder'),
(417645, '00000000000000', 'Placeholder'),
(340146, '00000000000000', 'Placeholder'),
(310131, '00000000000000', 'Placeholder'),
(421669, '00000000000000', 'Placeholder'),
(420662, '00000000000000', 'Placeholder'),
(412228, '00000000000000', 'Placeholder'),
(421251, '00000000000000', 'Placeholder'),
(361038, '00000000000000', 'Placeholder'),
(419842, '00000000000000', 'Placeholder'),
(349194, '00000000000000', 'Placeholder'),
(420824, '00000000000000', 'Placeholder'),
(373010, '00000000000000', 'Placeholder'),
(421227, '00000000000000', 'Placeholder'),
(422606, '00000000000000', 'Placeholder'),
(416177, '00000000000000', 'Placeholder'),
(420913, '00000000000000', 'Placeholder'),
(412830, '00000000000000', 'Placeholder'),
(410179, '00000000000000', 'Placeholder'),
(422096, '00000000000000', 'Placeholder'),
(418951, '00000000000000', 'Placeholder'),
(309362, '00000000000000', 'Placeholder'),
(344583, '00000000000000', 'Placeholder'),
(421138, '00000000000000', 'Placeholder'),
(402834, '00000000000000', 'Placeholder'),
(416665, '00000000000000', 'Placeholder'),
(418480, '00000000000000', 'Placeholder'),
(420689, '00000000000000', 'Placeholder'),
(419915, '00000000000000', 'Placeholder'),
(421987, '00000000000000', 'Placeholder'),
(417807, '00000000000000', 'Placeholder'),
(321869, '00000000000000', 'Placeholder'),
(413291, '00000000000000', 'Placeholder'),
(305995, '00000000000000', 'Placeholder'),
(421219, '00000000000000', 'Placeholder'),
(423157, '00000000000000', 'Placeholder'),
(417262, '00000000000000', 'Placeholder'),
(419834, '00000000000000', 'Placeholder'),
(423459, '00000000000000', 'Placeholder');

-- -------------------------------
-- 7. inserção dos dados tratados na tabela final
-- -------------------------------
INSERT INTO despesas (data, reg_ans, cd_conta_contabil, descricao, vl_saldo_inicial, vl_saldo_final)
SELECT 
    CASE
        WHEN data LIKE '__/__/____' THEN TO_DATE(data, 'DD/MM/YYYY')
        WHEN data LIKE '____-__-__' THEN TO_DATE(data, 'YYYY-MM-DD')
        ELSE NULL
    END AS data,
    reg_ans::INTEGER,
    cd_conta_contabil,
    descricao,
    REPLACE(vl_saldo_inicial, ',', '.')::NUMERIC,
    REPLACE(vl_saldo_final, ',', '.')::NUMERIC
FROM temp_despesas;

-- -------------------------------
-- 8. query analítica - top 10 operadoras com maiores despesas (último ano)
-- -------------------------------
SELECT 
    COALESCE(NULLIF(TRIM(o.nome_fantasia), ''), 'NÃO IDENTIFICADA') AS operadora,
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    despesas d
INNER JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
WHERE 
    d.descricao ILIKE '%eventos/ sinistros conhecidos ou avisados  de assist╩ncia a sa┌de medico hospitalar%'
    AND d.vl_saldo_final > 0
    AND d.data >= (CURRENT_DATE - INTERVAL '1 year')
GROUP BY 
    operadora
ORDER BY 
    total_despesas DESC
LIMIT 10;

-- -------------------------------
-- 9. query analítica - top 10 operadoras com maiores despesas no 4º trimestre de 2024
-- -------------------------------
SELECT 
    EXTRACT(QUARTER FROM d.data) AS trimestre,
    COALESCE(NULLIF(TRIM(o.nome_fantasia), ''), 'NÃO IDENTIFICADA') AS operadora,
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    despesas d
INNER JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
WHERE 
    d.descricao ILIKE '%eventos/ sinistros conhecidos ou avisados  de assist╩ncia a sa┌de medico hospitalar%'
    AND d.vl_saldo_final > 0
    AND d.data >= '2024-10-01' AND d.data <= '2024-12-31'
GROUP BY 
    trimestre, operadora
ORDER BY 
    total_despesas DESC
LIMIT 10;
