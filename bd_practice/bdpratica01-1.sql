# Mariana Yasmin Santos de Oliveira
# Thiago da Silva de Abreu

CREATE DATABASE bdpratica01;
USE bdpratica01;

CREATE TABLE departamento (
    cod_depart INT PRIMARY KEY,
    nome_depart VARCHAR(30) NOT NULL,
    data_inicial_depart DATE
);

CREATE TABLE funcionario (
    cod_func INT PRIMARY KEY,
    nome_func VARCHAR(100) NOT NULL,
    cpf_func VARCHAR(15) NOT NULL UNIQUE,
    salario_func DECIMAL(7,2) CHECK (salario_func >= 1000.00),
    endereco_func VARCHAR(252),
    sexo_func CHAR(1) CHECK (sexo_func IN ('M', 'F')),
    cod_super_func INT,
    cod_depart INT,
    FOREIGN KEY (cod_super_func) REFERENCES funcionario(cod_func),
    FOREIGN KEY (cod_depart) REFERENCES departamento(cod_depart)
);

CREATE TABLE localizacao (
    cod_depart INT,
    local_local VARCHAR(252),
    PRIMARY KEY (cod_depart, local_local),
    FOREIGN KEY (cod_depart) REFERENCES departamento(cod_depart)
);

CREATE TABLE dependente (
    cod_func INT,
    seq_dep INT,
    nome_dep VARCHAR(100) NOT NULL,
    parentesco_dep VARCHAR(30) NOT NULL CHECK (parentesco_dep IN ('PAI', 'MÃE', 'IRMAOS', 'FILHO')),
    data_nasc_dep DATE,
    PRIMARY KEY (cod_func, seq_dep),
    FOREIGN KEY (cod_func) REFERENCES funcionario(cod_func)
);

CREATE TABLE projeto (
    cod_proj INT PRIMARY KEY,
    cod_depart INT,
    titulo_proj VARCHAR(150) NOT NULL,
    descricao_proj VARCHAR(252),
    data_cad_proj DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (cod_depart) REFERENCES departamento(cod_depart)
);

CREATE TABLE participa (
    cod_func INT,
    cod_proj INT,
    horas_participa VARCHAR(50),
    PRIMARY KEY (cod_func, cod_proj),
    FOREIGN KEY (cod_func) REFERENCES funcionario(cod_func),
    FOREIGN KEY (cod_proj) REFERENCES projeto(cod_proj)
);

show tables
