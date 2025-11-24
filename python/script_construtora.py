import psycopg2

# Conexão com o banco
conn = psycopg2.connect(
    host="localhost",
    database="construtora",
    user="postgres",
    password="123"
)
cur = conn.cursor()

# Consulta 1: INNER JOIN
print("=== CLIENTES E SEUS PROJETOS ===")
cur.execute("""
    SELECT p.Nome AS cliente, pr.ID AS projeto, pr.Orcamento
    FROM PESSOA p
    JOIN CLIENTE c ON p.CPF = c.Pessoa_CPF
    JOIN CONTRATO co ON c.Pessoa_CPF = co.Cliente_CPF
    JOIN PROJETO pr ON co.Projeto_ID = pr.ID;
""")
for row in cur.fetchall():
    print(f"Cliente: {row[0]} | Projeto: {row[1]} | Orçamento: R${row[2]:,.2f}")

print("\n=== PROJETOS E ARQUITETOS (LEFT JOIN) ===")
cur.execute("""
    SELECT pr.ID, COALESCE(a.Nome, 'Sem arquiteto') AS arquiteto
    FROM PROJETO pr
    LEFT JOIN ARQUITETO_PROJETA_PROJETO ap ON pr.ID = ap.Projeto_ID
    LEFT JOIN PESSOA a ON ap.Arquiteto_CPF = a.CPF;
""")
for row in cur.fetchall():
    print(f"Projeto: {row[0]} | Arquiteto: {row[1]}")

print("\n=== VISÃO UNIFICADA DE PESSOAS ===")
cur.execute("SELECT Nome, CPF, Funcao FROM VW_PESSOAS_FUNCOES ORDER BY Funcao;")
for row in cur.fetchall():
    print(f"{row[0]} ({row[2]}) - CPF: {row[1]}")

cur.close()
conn.close()