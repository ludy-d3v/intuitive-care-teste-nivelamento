# teste 1 - web scraping

## descrição

este script realiza o download automático dos anexos I e II (em formato PDF) da página oficial da ANS sobre o rol de procedimentos e eventos em saúde, e em seguida compacta os arquivos em um único `.zip`.

> página de origem:  
https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos

---

## tecnologias utilizadas

- python 3
- bibliotecas:
  - `requests`
  - `beautifulsoup4`
  - `zipfile`
  - `os`

---

## como executar

1. instale os pacotes necessários (se ainda não tiver):

```bash
pip install requests beautifulsoup4

## resultado

o script automatiza o processo de coleta de arquivos da ANS, garantindo agilidade e reprodutibilidade no ambiente de testes.
(-se for abrir no excel: clique em "dados" > "obter dados" > "de um arquivo CSV"
-escolha "separador: ponto e vírgula (;)"
-clique em "carregar")