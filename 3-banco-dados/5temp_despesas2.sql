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