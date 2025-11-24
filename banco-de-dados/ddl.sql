-- Tabela PESSOA (Superclasse)
CREATE TABLE PESSOA (
    CPF VARCHAR(11) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CHECK (REGEXP_LIKE(CPF, '^[0-9]{11}$'))
);

-- Tabelas para atributo multivalorado Telefone
CREATE TABLE PESSOA_TELEFONE (
    Pessoa_CPF VARCHAR(11) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    PRIMARY KEY (Pessoa_CPF, Telefone),
    FOREIGN KEY (Pessoa_CPF) REFERENCES PESSOA(CPF) ON DELETE CASCADE
);

-- Tabela CLIENTE (Subclasse de PESSOA)
CREATE TABLE CLIENTE (
    Pessoa_CPF VARCHAR(11) PRIMARY KEY,
    Email VARCHAR(100) NOT NULL,
    Rua VARCHAR(100),
    Numero VARCHAR(10),
    Complemento VARCHAR(50),
    Bairro VARCHAR(50),
    Cidade VARCHAR(50),
    Estado VARCHAR(2),
    Pais VARCHAR(50),
    CEP VARCHAR(8),
    FOREIGN KEY (Pessoa_CPF) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
    CHECK (REGEXP_LIKE(Email, '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+\.[A-Za-z]+$')),
    CHECK (REGEXP_LIKE(CEP, '^[0-9]{8}$'))
);

-- Tabela ENGENHEIRO (Subclasse de PESSOA)
CREATE TABLE ENGENHEIRO (
    Pessoa_CPF VARCHAR(11) PRIMARY KEY,
    CREA VARCHAR(20) UNIQUE NOT NULL,
    Salario NUMERIC(10,2) NOT NULL CHECK (Salario >= 5000.00),
    Supervisor_CPF VARCHAR(11),
    FOREIGN KEY (Pessoa_CPF) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
    FOREIGN KEY (Supervisor_CPF) REFERENCES ENGENHEIRO(Pessoa_CPF)
);

-- Tabela ARQUITETO (Subclasse de PESSOA)
CREATE TABLE ARQUITETO (
    Pessoa_CPF VARCHAR(11) PRIMARY KEY,
    CAU VARCHAR(20) UNIQUE NOT NULL,
    Salario NUMERIC(10,2) NOT NULL CHECK (Salario >= 3000.00),
    FOREIGN KEY (Pessoa_CPF) REFERENCES PESSOA(CPF) ON DELETE CASCADE
);

-- Tabela OPERARIO (Subclasse de PESSOA)
CREATE TABLE OPERARIO (
    Pessoa_CPF VARCHAR(11) PRIMARY KEY,
    Cargo VARCHAR(50) NOT NULL,
    Salario NUMERIC(10,2) NOT NULL CHECK (Salario >= 1320.00),
    FOREIGN KEY (Pessoa_CPF) REFERENCES PESSOA(CPF) ON DELETE CASCADE
);

-- Tabela FORNECEDOR
CREATE TABLE FORNECEDOR (
    CNPJ VARCHAR(14) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Rua VARCHAR(100),
    Numero VARCHAR(10),
    Complemento VARCHAR(50),
    Bairro VARCHAR(50),
    Cidade VARCHAR(50),
    Estado VARCHAR(2),
    Pais VARCHAR(50),
    CEP VARCHAR(8),
    CHECK (REGEXP_LIKE(CNPJ, '^[0-9]{14}$')),
    CHECK (REGEXP_LIKE(CEP, '^[0-9]{8}$'))
);

-- Tabela para telefone de fornecedor
CREATE TABLE FORNECEDOR_TELEFONE (
    Fornecedor_CNPJ VARCHAR(14) NOT NULL,
    Telefone VARCHAR(15) NOT NULL,
    PRIMARY KEY (Fornecedor_CNPJ, Telefone),
    FOREIGN KEY (Fornecedor_CNPJ) REFERENCES FORNECEDOR(CNPJ) ON DELETE CASCADE
);

-- Tabela MATERIAL
CREATE TABLE MATERIAL (
    Cod_material VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Quantidade_estoque INTEGER NOT NULL CHECK (Quantidade_estoque >= 0),
    Custo_unitario NUMERIC(10,2) NOT NULL CHECK (Custo_unitario > 0)
);

-- Tabela PROJETO
CREATE TABLE PROJETO (
    ID VARCHAR(10) PRIMARY KEY,
    Orcamento NUMERIC(15,2) NOT NULL CHECK (Orcamento > 0),
    Rua VARCHAR(100),
    Numero VARCHAR(10),
    Complemento VARCHAR(50),
    Bairro VARCHAR(50),
    Cidade VARCHAR(50),
    Estado VARCHAR(2),
    Pais VARCHAR(50),
    CEP VARCHAR(8),
    CHECK (REGEXP_LIKE(CEP, '^[0-9]{8}$'))
);

-- Entidade fraca ETAPA
CREATE TABLE ETAPA (
    Projeto_ID VARCHAR(10) NOT NULL,
    Numero_etapa INTEGER NOT NULL,
    Data_inicio DATE NOT NULL,
    Data_conclusao_prevista DATE NOT NULL,
    Status_atual VARCHAR(20) NOT NULL CHECK (Status_atual IN ('Planejada', 'Em execução', 'Concluída', 'Cancelada')),
    PRIMARY KEY (Projeto_ID, Numero_etapa),
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE,
    CHECK (Data_conclusao_prevista >= Data_inicio)
);

-- Relacionamentos M:N
CREATE TABLE CONTRATO (
    Cliente_CPF VARCHAR(11) NOT NULL,
    Projeto_ID VARCHAR(10) NOT NULL,
    Data_assinatura DATE NOT NULL,
    Valor_total NUMERIC(15,2) NOT NULL CHECK (Valor_total > 0),
    Condicoes_pagamento VARCHAR(100),
    PRIMARY KEY (Cliente_CPF, Projeto_ID),
    FOREIGN KEY (Cliente_CPF) REFERENCES CLIENTE(Pessoa_CPF) ON DELETE CASCADE,
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);

CREATE TABLE OPERARIO_ALOCADO_PROJETO (
    Operario_CPF VARCHAR(11) NOT NULL,
    Projeto_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Operario_CPF, Projeto_ID),
    FOREIGN KEY (Operario_CPF) REFERENCES OPERARIO(Pessoa_CPF) ON DELETE CASCADE,
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);

CREATE TABLE ARQUITETO_PROJETA_PROJETO (
    Arquiteto_CPF VARCHAR(11) NOT NULL,
    Projeto_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Arquiteto_CPF, Projeto_ID),
    FOREIGN KEY (Arquiteto_CPF) REFERENCES ARQUITETO(Pessoa_CPF) ON DELETE CASCADE,
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);

CREATE TABLE ENGENHEIRO_PLANEJA_PROJETO (
    Engenheiro_CPF VARCHAR(11) NOT NULL,
    Projeto_ID VARCHAR(10) NOT NULL,
    Status_calculo_estrutural VARCHAR(20) NOT NULL CHECK (Status_calculo_estrutural IN ('Pendente', 'Em andamento', 'Concluído')),
    Status_fundacao VARCHAR(20) NOT NULL CHECK (Status_fundacao IN ('Pendente', 'Em andamento', 'Concluído')),
    PRIMARY KEY (Engenheiro_CPF, Projeto_ID),
    FOREIGN KEY (Engenheiro_CPF) REFERENCES ENGENHEIRO(Pessoa_CPF) ON DELETE CASCADE,
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);

-- Relacionamento ternário: FORNECIMENTO_PROJETO
CREATE TABLE FORNECIMENTO_PROJETO (
    Fornecedor_CNPJ VARCHAR(14) NOT NULL,
    Material_Cod VARCHAR(10) NOT NULL,
    Projeto_ID VARCHAR(10) NOT NULL,
    Previsao_entrega DATE NOT NULL,
    PRIMARY KEY (Fornecedor_CNPJ, Material_Cod, Projeto_ID),
    FOREIGN KEY (Fornecedor_CNPJ) REFERENCES FORNECEDOR(CNPJ) ON DELETE CASCADE,
    FOREIGN KEY (Material_Cod) REFERENCES MATERIAL(Cod_material) ON DELETE CASCADE,
    FOREIGN KEY (Projeto_ID) REFERENCES PROJETO(ID) ON DELETE CASCADE
);