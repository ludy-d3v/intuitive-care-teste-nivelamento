CREATE TABLE despesas (
    id_despesa SERIAL PRIMARY KEY,
    data DATE NOT NULL,
    reg_ans INTEGER NOT NULL REFERENCES operadoras(registro_ans),
    cd_conta_contabil VARCHAR(20) NOT NULL,
    descricao TEXT,
    vl_saldo_inicial NUMERIC(18,2),
    vl_saldo_final NUMERIC(18,2)
);