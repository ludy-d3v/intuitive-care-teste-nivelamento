# teste 2 - transformação de dados

## descrição

este script realiza a extração de dados do PDF do Anexo I (obtido no Teste 1), transforma a tabela de procedimentos em um CSV estruturado e aplica tratamentos de dados, como substituição de siglas e remoção de colunas vazias. compacta o resultado em um arquivo `.zip`.

---

## tecnologias utilizadas

- python 3
- bibliotecas:
  - `pdfplumber`
  - `pandas`
  - `zipfile`
  - `os`

---

## como executar

1. instale os pacotes necessários:

```bash
pip install pdfplumber pandas
```

2. coloque o arquivo `anexo_I.pdf` (baixado no teste 1) na mesma pasta do script.

3. execute o script:

```bash
python transformacao.py
```

4. O script irá:

- extrair todas as tabelas do PDF
- salvar os dados em um CSV formatado
- substituir `OD` por "Seg. Odontológica" e `AMB` por "Seg. Ambulatorial"
- compactar o CSV em um arquivo `.zip`

---

## saídas esperadas

- `teste_rol_planilha.zip` contendo:
  - `Rol_Procedimentos.csv`

---

## resultado

o script entrega um CSV limpo, padronizado e pronto para análise ou uso em banco de dados.
