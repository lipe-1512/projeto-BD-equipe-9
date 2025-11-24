-- PESSOA
INSERT INTO PESSOA (CPF, Nome) VALUES
('11111111111', 'Ana Silva'),
('22222222222', 'Carlos Mendes'),
('33333333333', 'Pedro Alves'),
('44444444444', 'Lucia Ferreira'),
('55555555555', 'Roberto Costa'),
('66666666666', 'Juliana Soares'),
('77777777777', 'Fernando Lima'),
('88888888888', 'Mariana Gomes'),
('99999999999', 'Ricardo Oliveira');

-- Telefones das pessoas
INSERT INTO PESSOA_TELEFONE VALUES
('11111111111', '81999991111'),
('22222222222', '81988882222'),
('88888888888', '81977773333'),
('99999999999', '81966664444');

-- CLIENTE
INSERT INTO CLIENTE (Pessoa_CPF, Email, Rua, Numero, Complemento, Bairro, Cidade, Estado, Pais, CEP) VALUES
('11111111111', 'ana.silva@gmail.com', 'Rua das Palmeiras', '100', 'Casa', 'Boa Vista', 'Recife', 'PE', 'Brasil', '50000000'),
('22222222222', 'carlos.mendes@outlook.com', 'Av. Boa Viagem', '200', 'Apto 101', 'Boa Viagem', 'Recife', 'PE', 'Brasil', '51000000'),
('33333333333', 'pedro.alves@email.com', 'Rua do Sol', '300', '', 'Centro', 'São Paulo', 'SP', 'Brasil', '01000000');

-- ENGENHEIRO
INSERT INTO ENGENHEIRO (Pessoa_CPF, CREA, Salario, Supervisor_CPF) VALUES
('88888888888', 'CREA-PE10000', 9000.00, NULL),
('99999999999', 'CREA-PE10001', 10500.00, '88888888888');

-- ARQUITETO
INSERT INTO ARQUITETO (Pessoa_CPF, CAU, Salario) VALUES
('66666666666', 'CAU-BR123456', 7500.00),
('77777777777', 'CAU-BR654321', 8000.00);

-- OPERARIO
INSERT INTO OPERARIO (Pessoa_CPF, Cargo, Salario) VALUES
('44444444444', 'Pedreiro', 2500.00),
('55555555555', 'Eletricista', 2800.00),
('66666666666', 'Encanador', 2600.00),
('77777777777', 'Carpinteiro', 2700.00);

-- FORNECEDOR
INSERT INTO FORNECEDOR (CNPJ, Nome, Rua, Numero, Complemento, Bairro, Cidade, Estado, Pais, CEP) VALUES
('12345678000199', 'Materiais Construção LTDA', 'Rua do Comércio', '150', 'Loja 1', 'Santo Amaro', 'Recife', 'PE', 'Brasil', '52000000'),
('98765432000188', 'Ferramentas Essenciais SA', 'Av. Industrial', '300', '', 'Barra', 'Salvador', 'BA', 'Brasil', '40000000'),
('45678901000122', 'Cimento Forte Comércio', 'Rodovia BR-101', '500', 'Galpão A', 'Zona Rural', 'Caruaru', 'PE', 'Brasil', '55000000');

-- Telefones dos fornecedores
INSERT INTO FORNECEDOR_TELEFONE VALUES
('12345678000199', '8133335555'),
('12345678000199', '81991234567'),
('98765432000188', '7144446666');

-- MATERIAL
INSERT INTO MATERIAL (Cod_material, Nome, Quantidade_estoque, Custo_unitario) VALUES
('CIM-001', 'Cimento CPII-32', 1000, 25.50),
('ACO-002', 'Vergalhão 3/8"', 500, 15.00),
('TEL-003', 'Telha Cerâmica', 2000, 2.80),
('PVC-004', 'Tubo PVC 100mm', 100, 35.00),
('TNT-005', 'Tinta Acrílica Branca', 50, 80.00),
('PSO-006', 'Piso Porcelanato 60x60', 300, 45.00);

-- PROJETO
INSERT INTO PROJETO (ID, Orcamento, Rua, Numero, Complemento, Bairro, Cidade, Estado, Pais, CEP) VALUES
('PROJ000001', 500000.00, 'Rua das Palmeiras', '100', 'Casa', 'Boa Vista', 'Recife', 'PE', 'Brasil', '50000000'),
('PROJ000002', 1200000.00, 'Av. Paulista', '50', 'Sala 5', 'Bela Vista', 'São Paulo', 'SP', 'Brasil', '01000000'),
('PROJ000003', 800000.00, 'Rua Sete de Setembro', '10', 'Bloco A', 'Centro', 'Rio de Janeiro', 'RJ', 'Brasil', '20000000'),
('PROJ000004', 750000.00, 'Av. Beira Mar', '80', 'Andar 2', 'Meireles', 'Fortaleza', 'CE', 'Brasil', '60000000'),
('PROJ000005', 900000.00, 'Rua das Palmeiras', '200', 'Lote 5', 'Asa Sul', 'Brasília', 'DF', 'Brasil', '70000000');

-- ETAPA (entidade fraca)
INSERT INTO ETAPA (Projeto_ID, Numero_etapa, Data_inicio, Data_conclusao_prevista, Status_atual) VALUES
('PROJ000001', 1, '2025-01-10', '2025-03-10', 'Concluída'),
('PROJ000001', 2, '2025-03-11', '2025-06-30', 'Em execução'),
('PROJ000002', 1, '2025-02-01', '2025-04-30', 'Em execução');

-- CONTRATO
INSERT INTO CONTRATO (Cliente_CPF, Projeto_ID, Data_assinatura, Valor_total, Condicoes_pagamento) VALUES
('11111111111', 'PROJ000001', '2025-01-05', 500000.00, 'Parcelado em 10x'),
('22222222222', 'PROJ000002', '2025-01-20', 1200000.00, 'Financiamento Bancário'),
('33333333333', 'PROJ000003', '2025-02-10', 800000.00, 'À vista com 5% de desconto');

-- OPERARIO_ALOCADO_PROJETO
INSERT INTO OPERARIO_ALOCADO_PROJETO VALUES
('44444444444', 'PROJ000001'),
('55555555555', 'PROJ000001'),
('44444444444', 'PROJ000002'),
('66666666666', 'PROJ000003'),
('77777777777', 'PROJ000004');

-- ARQUITETO_PROJETA_PROJETO
INSERT INTO ARQUITETO_PROJETA_PROJETO VALUES
('66666666666', 'PROJ000001'),
('77777777777', 'PROJ000002');

-- ENGENHEIRO_PLANEJA_PROJETO
INSERT INTO ENGENHEIRO_PLANEJA_PROJETO VALUES
('88888888888', 'PROJ000001', 'Concluído', 'Concluído'),
('99999999999', 'PROJ000001', 'Concluído', 'Concluído'),
('88888888888', 'PROJ000002', 'Em andamento', 'Pendente');

-- FORNECIMENTO_PROJETO (Aloca material)
INSERT INTO FORNECIMENTO_PROJETO VALUES
('12345678000199', 'CIM-001', 'PROJ000001', '2025-02-15'),
('12345678000199', 'ACO-002', 'PROJ000001', '2025-02-20'),
('98765432000188', 'TEL-003', 'PROJ000002', '2025-03-01'),
('45678901000122', 'PVC-004', 'PROJ000003', '2025-03-10'),
('12345678000199', 'TNT-005', 'PROJ000004', '2025-04-01');