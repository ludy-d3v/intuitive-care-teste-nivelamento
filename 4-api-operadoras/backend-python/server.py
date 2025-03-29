from flask import Flask, request, jsonify
import pandas as pd
from flask_cors import CORS
import numpy as np

# instanciando o flask e configurando o CORS
app = Flask(__name__)
CORS(app) 

# carregar os dados do CSV com validações
try:
    # leitura inicial do CSV
    operadoras = pd.read_csv('operadoras.csv', encoding='utf-8')
    print("CSV carregado com sucesso. Visualização inicial:")
    print(operadoras.head())

    # definição de colunas esperadas para evitar erro de chave inexistente
    colunas_esperadas = [
        'Bairro', 'CEP', 'CNPJ', 'Cargo_Representante', 'Cidade', 'Complemento',
        'DDD', 'Data_Registro_ANS', 'Endereco_eletronico', 'Fax', 'Logradouro',
        'Modalidade', 'Nome_Fantasia', 'Numero', 'Razao_Social',
        'Regiao_de_Comercializacao', 'Registro_ANS', 'Representante', 'Telefone', 'UF'
    ]
    operadoras = operadoras.reindex(columns=colunas_esperadas, fill_value='Não informado')

    # limpeza e tratamento dos dados
    operadoras['Razao_Social'] = operadoras['Razao_Social'].fillna('Desconhecido').str.strip()
    operadoras['Nome_Fantasia'] = operadoras['Nome_Fantasia'].fillna('Não informado').str.strip()
    operadoras['Registro_ANS'] = pd.to_numeric(operadoras['Registro_ANS'], errors='coerce').fillna(-1).astype(int)
    operadoras['DDD'] = pd.to_numeric(operadoras['DDD'], errors='coerce').fillna(-1).astype(int)
    operadoras['Telefone'] = pd.to_numeric(operadoras['Telefone'], errors='coerce').fillna(-1).astype(int)
    operadoras['UF'] = operadoras['UF'].fillna('Não especificado').str.strip()

except FileNotFoundError:
    print("Erro: O arquivo 'operadoras.csv' não foi encontrado. Certifique-se de que está na pasta correta.")
    operadoras = pd.DataFrame()
except Exception as e:
    print(f"Erro ao carregar o arquivo CSV: {e}")
    operadoras = pd.DataFrame()

# verificar se as colunas essenciais estão presentes
colunas_necessarias = {'Razao_Social', 'Nome_Fantasia', 'Registro_ANS'}
if not colunas_necessarias.issubset(operadoras.columns):
    print("Erro: As colunas esperadas não estão presentes no arquivo CSV.")
    operadoras = pd.DataFrame()

# adicionar cabeçalhos de resposta para CORS
@app.after_request
def after_request(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'GET, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Content-Type, Authorization'
    return response

# rota de busca de operadoras
@app.route('/search', methods=['GET'])
def search_operadoras():
    query = request.args.get('query', '').strip()
    print(f"Query recebida: {query}")

    try:
        if operadoras.empty:
            print("Erro: A base de dados está vazia ou não foi carregada.")
            return jsonify([])

        if not query:
            retorno = operadoras.head(10).replace({np.nan: "Não informado"}).to_dict(orient='records')
            print("Dados retornados sem busca:", retorno)
            return jsonify(retorno)

        # filtrando os dados
        resultados = operadoras[
            operadoras['Razao_Social'].str.contains(query, case=False, na=False) |
            operadoras['Nome_Fantasia'].str.contains(query, case=False, na=False)
        ]

        if resultados.empty:
            print(f"Nenhum registro encontrado para a consulta: {query}")
            return jsonify([])

        # convertendo os dados corretamente
        retorno = resultados.replace({np.nan: "Não informado"}).to_dict(orient='records')

        # normalizando os tipos de dados para evitar problemas no front-end
        for item in retorno:
            item["Registro_ANS"] = str(item.get("Registro_ANS", "Não informado"))
            item["Telefone"] = str(item.get("Telefone", "Não informado"))
            item["DDD"] = str(item.get("DDD", "Não informado"))
            item["CEP"] = str(item.get("CEP", "Não informado"))
            item["CNPJ"] = str(item.get("CNPJ", "Não informado"))

        print("Resultados encontrados:", retorno)
        return jsonify(retorno)

    except Exception as e:
        print(f"Erro interno no servidor: {e}")
        return jsonify({'error': 'Erro interno no servidor.'}), 500

# teste direto no terminal
if __name__ == '__main__':
    print("Testando carregamento do CSV...")
    print(operadoras.head(10))
    app.run(host='0.0.0.0', port=5000, debug=True)