-- 1. INNER JOIN: Projetos e seus clientes
SELECT p.Nome AS cliente, pr.ID AS projeto, pr.Orcamento
FROM PESSOA p
JOIN CLIENTE c ON p.CPF = c.Pessoa_CPF
JOIN CONTRATO co ON c.Pessoa_CPF = co.Cliente_CPF
JOIN PROJETO pr ON co.Projeto_ID = pr.ID;

-- 2. LEFT JOIN: Todos os projetos e seus arquitetos (mesmo sem arquiteto)
SELECT pr.ID, pr.Orcamento, COALESCE(a.Nome, 'Sem arquiteto') AS arquiteto
FROM PROJETO pr
LEFT JOIN ARQUITETO_PROJETA_PROJETO ap ON pr.ID = ap.Projeto_ID
LEFT JOIN PESSOA a ON ap.Arquiteto_CPF = a.CPF;

-- 3. WHERE + BETWEEN: Projetos com orçamento entre 700k e 1M
SELECT ID, Orcamento, Cidade
FROM PROJETO
WHERE Orcamento BETWEEN 700000 AND 1000000;

-- 4. LIKE: Clientes com email @gmail.com
SELECT p.Nome, c.Email
FROM PESSOA p
JOIN CLIENTE c ON p.CPF = c.Pessoa_CPF
WHERE c.Email LIKE '%@gmail.com';

-- 5. IS NULL: Engenheiros sem supervisor
SELECT p.Nome, e.CREA
FROM PESSOA p
JOIN ENGENHEIRO e ON p.CPF = e.Pessoa_CPF
WHERE e.Supervisor_CPF IS NULL;

-- 6. IN: Pessoas que são operários ou arquitetos
SELECT CPF, Nome
FROM PESSOA
WHERE CPF IN (SELECT Pessoa_CPF FROM OPERARIO)
   OR CPF IN (SELECT Pessoa_CPF FROM ARQUITETO);

-- 7. Funções de agregação + GROUP BY + HAVING
SELECT o.Cargo, COUNT(*) AS total, AVG(o.Salario) AS media_salario
FROM OPERARIO o
GROUP BY o.Cargo
HAVING AVG(o.Salario) > 2600;

-- 8. Subconsulta com IN: Materiais usados no PROJ000001
SELECT m.Nome
FROM MATERIAL m
WHERE m.Cod_material IN (
    SELECT fp.Material_Cod
    FROM FORNECIMENTO_PROJETO fp
    WHERE fp.Projeto_ID = 'PROJ000001'
);

-- 9. Subconsulta com ALL: Operários com salário menor que todos os engenheiros
SELECT p.Nome, o.Salario
FROM PESSOA p
JOIN OPERARIO o ON p.CPF = o.Pessoa_CPF
WHERE o.Salario < ALL (SELECT Salario FROM ENGENHEIRO);

-- 10. UNION: CPFs de clientes e operários
SELECT Pessoa_CPF FROM CLIENTE
UNION
SELECT Pessoa_CPF FROM OPERARIO;

-- 11. VIEW: Visão unificada de pessoas e funções
CREATE VIEW VW_PESSOAS_FUNCOES AS
SELECT
    p.Nome,
    p.CPF,
    CASE
        WHEN c.Pessoa_CPF IS NOT NULL THEN 'Cliente'
        WHEN e.Pessoa_CPF IS NOT NULL THEN 'Engenheiro (' || e.Cargo || ')'
        WHEN a.Pessoa_CPF IS NOT NULL THEN 'Arquiteto'
        WHEN o.Pessoa_CPF IS NOT NULL THEN 'Operário (' || o.Cargo || ')'
        ELSE 'Desconhecido'
    END AS Funcao
FROM PESSOA p
LEFT JOIN CLIENTE c ON p.CPF = c.Pessoa_CPF
LEFT JOIN ENGENHEIRO e ON p.CPF = e.Pessoa_CPF
LEFT JOIN ARQUITETO a ON p.CPF = a.Pessoa_CPF
LEFT JOIN OPERARIO o ON p.CPF = o.Pessoa_CPF;