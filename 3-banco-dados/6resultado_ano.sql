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
