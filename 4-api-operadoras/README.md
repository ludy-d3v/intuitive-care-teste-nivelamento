# teste 4

esse projeto foi desenvolvido como parte de um teste de nivelamento para a Intuitive Care.

---

## o que foi utilizado

- frontend: vue.js
- backend: flask (python)
- API de comunicação: axios
- testes de API: postman
- estilização: CSS customizado

---

## execução

## backend (Flask)

- certifique-se de ter Python instalado.
- instale as dependências com:
   ```
   pip install flask flask-cors pandas
   ```
- coloque o arquivo `operadoras.csv` na raiz do projeto.
- execute o backend com:
   ```
   python app.py
   ```
   O backend estará disponível em: `http://192.168.0.5:5000`

## frontend (Vue.js)

- certifique-se de ter Node.js e Vue CLI instalados.
- no diretório do frontend:
   ```
   npm install
   npm run serve
   ```
   o frontend estará disponível em: `http://192.168.0.5:8080`

---

## postman

incluí uma coleção Postman neste repositório:

- `IntuitiveCare_Postman_Collection.json`

## como usar:

- abra o Postman
- clique em **Import**
- selecione o arquivo `.json`
- teste os endpoints:
   - `GET /search` — retorna os primeiros 10 registros
   - `GET /search?query=bradesco` — busca por operadoras com filtro

---

## interface

a interface foi customizada com a paleta da Intuitive Care. inclui:
- logo da empresa
- cores em tons de roxo
- layout responsivo com destaque para usabilidade

---

## prints

> para visualizar corretamente, mantenha este arquivo junto à pasta `prints/`

### tela inicial
(prints/tela-inicial.png)

---

### busca com resultados

(prints/busca-com-resultados.png)

(prints/busca-com-resultados2.png)

(prints/busca-com-resultados3.png)

---

### busca sem resultado

(prints/busca-sem-resultados.png)

---

### testes via postman

(prints/postman-busca.png)

---

## estrutura

```
/frontend       --> projeto Vue.js
/backend        --> app.py (Flask backend)
/operadoras.csv --> base de dados da API
/postman        --> coleção de testes
```

---

## autoria 👩‍💻

desenvolvido com dedicação por Ludmilla Oliveira. :)