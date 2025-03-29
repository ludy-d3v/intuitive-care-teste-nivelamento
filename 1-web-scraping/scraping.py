import requests
from bs4 import BeautifulSoup
import os
import zipfile

# URL da página onde os PDFs estão localizados
URL = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos"

# pasta para armazenar os PDFs
PASTA_DOWNLOAD = "anexos_ans"
os.makedirs(PASTA_DOWNLOAD, exist_ok=True)

# realiza a requisição HTTP para obter o conteúdo da página
response = requests.get(URL)
response.raise_for_status()

# analisa o HTML da página
soup = BeautifulSoup(response.text, "html.parser")

# encontra os links para os arquivos PDF
pdf_links = []
for link in soup.find_all("a", href=True):
    if "Anexo I" in link.text or "Anexo II" in link.text:
        pdf_links.append(link["href"])

# baixa os arquivos PDF
arquivos_baixados = []
for pdf_link in pdf_links:
    if not pdf_link.startswith("http"):
        pdf_link = "https://www.gov.br" + pdf_link

    nome_arquivo = pdf_link.split("/")[-1]
    caminho_arquivo = os.path.join(PASTA_DOWNLOAD, nome_arquivo)

    print(f"Baixando {nome_arquivo}...")
    pdf_response = requests.get(pdf_link)
    pdf_response.raise_for_status()

    with open(caminho_arquivo, "wb") as f:
        f.write(pdf_response.content)

    arquivos_baixados.append(caminho_arquivo)

# compacta os arquivos em um ZIP
zip_path = "anexos_ans.zip"
with zipfile.ZipFile(zip_path, "w") as zipf:
    for arquivo in arquivos_baixados:
        zipf.write(arquivo, os.path.basename(arquivo))

print(f"Arquivos compactados em {zip_path}")
