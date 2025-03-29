# teste 3 – banco de dados

este desafio propõe a criação de um banco de dados relacional com dados públicos da ANS, estruturação de tabelas, importação de dados tratados e realização de queries analíticas.

---

## tecnologias

- PostgreSQL 10+
- SQL (DDL, DML e queries analíticas)
- `psql` (para importação via terminal)

---

## estrutura dos dados

- `operadoras.csv`: dados cadastrais das operadoras ativas na ANS
- `despesas.csv`: despesas extraídas dos demonstrativos contábeis dos últimos 2 anos

CSVs tratados e prontos para importação:
[🔗 Acesse os arquivos no Google Drive](https://drive.google.com/drive/folders/1WTADurGc-c1sSBDBU6rcQeFEgwHrJbnS?usp=sharing)

---

## o que o script SQL realiza

- criação das tabelas: `operadoras`, `despesas`, `temp_despesas`
- importação dos dados tratados via `\copy`
- inserção de operadoras faltantes (placeholders)
- conversão de formatos de data e valores numéricos
- duas queries analíticas:
  - Top 10 operadoras com maiores despesas no **último ano**
  - Top 10 operadoras com maiores despesas no **4º trimestre de 2024**

---

## ▶️ execução (psql)

1. acesse o banco:
```bash
psql -U postgres -d teste_nivelamento
```

2. execute o script SQL:
```sql
\i caminho/para/script.sql
```

3. importe os dados:
```sql
\copy operadoras FROM 'CAMINHO/operadoras.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
\copy temp_despesas FROM 'CAMINHO/despesas.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
```

---

## resultado esperado

- banco de dados funcional com integridade referencial
- tabelas populadas corretamente
- queries analíticas com retorno válido

---

**desenvolvido por Ludmilla Oliveira ✨**

## sistema automoção Python
#foi criado somente para juntar os arquivos divergentes dos últimos 2 anos do repositório em um único CSV