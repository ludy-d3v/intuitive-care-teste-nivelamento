
-- 1. despesas totais por UF
SELECT 
    o.uf,
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    despesas d
JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
WHERE 
    d.vl_saldo_final > 0
GROUP BY 
    o.uf
ORDER BY 
    total_despesas DESC;

-- 2. evolução mensal de despesas de uma operadora específica (UNIMED NACIONAL)
SELECT 
    TO_CHAR(d.data, 'YYYY-MM') AS mes,
    o.nome_fantasia AS operadora,
    SUM(d.vl_saldo_final) AS total_despesas
FROM 
    despesas d
JOIN 
    operadoras o ON d.reg_ans = o.registro_ans
WHERE 
    o.nome_fantasia ILIKE '%UNIMED NACIONAL%'
    AND d.vl_saldo_final > 0
GROUP BY 
    mes, o.nome_fantasia
ORDER BY 
    mes;

-- 3. participação percentual das operadoras no total de despesas
WITH total AS (
    SELECT SUM(vl_saldo_final) AS total_geral FROM despesas WHERE vl_saldo_final > 0
)
SELECT 
    o.nome_fantasia AS operadora,
    SUM(d.vl_saldo_final) AS total_despesas,
    ROUND(SUM(d.vl_saldo_final) / t.total_geral * 100, 2) AS percentual_participacao
FROM 
    despesas d
JOIN 
    operadoras o ON d.reg_ans = o.registro_ans,
    total t
WHERE 
    d.vl_saldo_final > 0
GROUP BY 
    o.nome_fantasia, t.total_geral
ORDER BY 
    total_despesas DESC
LIMIT 10;
