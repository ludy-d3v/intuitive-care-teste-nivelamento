import pandas as pd
import glob

# Diretório onde estão as planilhas
diretorio = 'C:/Users/Ludy7/OneDrive/Documents/adt/cursos/testes-processo-seletivo/teste-3/automocao/'

# Lista todas as planilhas no diretório
arquivos_csv = glob.glob(diretorio + "*.csv")

# Combina todas as planilhas
df_combined = pd.concat([pd.read_csv(arquivo, delimiter=';', encoding='utf-8') for arquivo in arquivos_csv])

# Novo local de salvamento do arquivo unificado
caminho_unificado = 'C:/Users/ludy7/OneDrive/Documents/adt/cursos/testes-processo-seletivo/teste-3/combinado_unificado.csv'

# Salva a planilha unificada
df_combined.to_csv(caminho_unificado, index=False, sep=';', encoding='utf-8')

print(f"Arquivo unificado salvo em: {caminho_unificado}")