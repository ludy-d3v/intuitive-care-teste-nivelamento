# teste adicional - análises complementares

## objetivo

este conjunto de queries SQL complementa os testes anteriores com análises exploratórias adicionais, demonstrando domínio sobre os dados fornecidos pela ANS.

---

## consultas disponíveis

### 1. despesas totais por UF
mostra quais estados possuem o maior volume de despesas com operadoras de saúde.

### 2. evolução mensal de despesas (UNIMED NACIONAL)
exibe o histórico mês a mês de despesas de uma operadora específica (pode ser alterada).

### 3. participação percentual das operadoras
mostra as operadoras que mais contribuem para o total de despesas no dataset, em percentual.

---

## como executar

execute o arquivo `queries_adicionais.sql` no PostgreSQL conectado ao banco `teste_nivelamento`:

```sql
\i caminho/para/queries_adicionais.sql
```

as queries utilizam as tabelas `despesas` e `operadoras` já criadas no teste 3.
