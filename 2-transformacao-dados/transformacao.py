import pdfplumber
import pandas as pd
import zipfile
import os

PDF_FILE = "anexo_I.pdf"

CSV_FILE = "Rol_Procedimentos.csv"

ZIP_FILE = "teste_rol_planilha.zip"

data = []

with pdfplumber.open(PDF_FILE) as pdf:
    for page in pdf.pages:
        tables = page.extract_table()
        if tables:
            for row in tables:
                row = [str(cell).strip().replace("\n", " ") if cell else "" for cell in row]
                data.append(row)

df = pd.DataFrame(data)

# define a primeira linha como cabeçalho
df.columns = df.iloc[0]
df = df[1:]

# remove colunas vazias
df.dropna(axis=1, how="all", inplace=True)

# substitui abreviações OD e AMB
df.replace({"OD": "Seg. Odontológica", "AMB": "Seg. Ambulatorial"}, inplace=True)

df.to_csv(CSV_FILE, index=False, encoding="utf-8-sig", sep=";")

with zipfile.ZipFile(ZIP_FILE, "w") as zipf:
    zipf.write(CSV_FILE, os.path.basename(CSV_FILE))

os.remove(CSV_FILE)

print(f"Arquivo ZIP '{ZIP_FILE}' criado com sucesso!")
