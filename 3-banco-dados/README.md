# teste 3 - banco de dados

## descrição

este teste estrutura um banco de dados relacional com os dados da ANS, trata encoding e integridade referencial, e gera insights via SQL.

---

## tecnologias utilizadas

- PostgreSQL 10+
- comandos SQL e `psql` para importação de arquivos

---

## dados utilizados

- `operadoras.csv`: dados cadastrais de operadoras ativas (ANS)
- `despesas.csv`: dados de demonstrações contábeis dos últimos 2 anos

fontes:
- https://dadosabertos.ans.gov.br/FTP/PDA/operadoras_de_plano_de_saude_ativas/
- https://dadosabertos.ans.gov.br/FTP/PDA/demonstracoes_contabeis/

---

## q que o script faz

1. cria as tabelas `operadoras`, `despesas` e `temp_despesas`
2. importa os dados CSV via terminal (`\copy`)
3. insere operadoras faltantes com dados fictícios (placeholders)
4. realiza tratamento de dados (formato de data, vírgula em valores)
5. executa queries analíticas:
   - top 10 operadoras com maiores despesas no último ano
   - top 10 operadoras com maiores despesas no 4º trimestre de 2024

---

## como executar

### 1. acesse o PostgreSQL
```bash
psql -U postgres -d teste_nivelamento
```

### 2. execute o script SQL:
```sql
\i caminho/para/script.sql
```

### 3. importe os dados com os comandos:
```sql
\copy operadoras FROM 'CAMINHO/operadoras.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
\copy temp_despesas FROM 'CAMINHO/despesas.csv' DELIMITER ';' CSV HEADER ENCODING 'UTF8';
```

---

## resultados esperados

- tabelas criadas corretamente
- dados tratados e normalizados
- duas queries analíticas funcionando com retorno válido

---

## DADOS TRATADOS (CSV)

para manter o repositório leve e respeitar o limite de arquivos do GitHub, os arquivos `.csv` tratados estão disponíveis no Google Drive:

acesse a pasta com os arquivos:
[Google Drive – CSVs tratados](https://drive.google.com/drive/folders/1WTADurGc-c1sSBDBU6rcQeFEgwHrJbnS?usp=sharing)

os arquivos estão no formato `.csv` com delimitador `;` e encoding `UTF-8`, prontos para uso com os comandos `\copy` descritos acima.


## SISTEMA AUTOMOCAO PYTHON
#foi criado somente para juntar os arquivos divergentes dos últimos 2 anos do repositório em um único CSV