### Thiago da Silva de Abreu
### Mariana Oliveira

## 1
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Cargo;
DROP TABLE IF EXISTS Departamento;
DROP TABLE IF EXISTS Cidade;
DROP TABLE IF EXISTS Estado;


CREATE TABLE Estado (
    est_cod INT AUTO_INCREMENT PRIMARY KEY,
    est_nome VARCHAR(30) NOT NULL
);

CREATE TABLE Cidade (
    cid_cod INT AUTO_INCREMENT,
    est_cod INT,
    cid_nome VARCHAR(30) NOT NULL,
    PRIMARY KEY (cid_cod, est_cod),
    FOREIGN KEY (est_cod) REFERENCES Estado(est_cod)
);

CREATE TABLE Departamento (
    dep_cod INT AUTO_INCREMENT PRIMARY KEY,
    dep_descricao VARCHAR(20) NOT NULL	
);

CREATE TABLE Cargo (
    car_cod INT AUTO_INCREMENT PRIMARY KEY,
    car_descricao VARCHAR(20) NOT NULL
);

CREATE TABLE Funcionario (
    fun_cod INT AUTO_INCREMENT PRIMARY KEY,
    fun_logradouro VARCHAR(30) NOT NULL,
    fun_nome VARCHAR(30) NOT NULL,
    fun_salario DECIMAL(8,2) NOT NULL,
    fun_cep VARCHAR(8),
    fun_nro INT,
    car_cod INT,
    cid_cod INT,
    est_cod INT,
    dep_cod INT,
    FOREIGN KEY (car_cod) REFERENCES Cargo(car_cod),
    FOREIGN KEY (cid_cod) REFERENCES Cidade(cid_cod),
    FOREIGN KEY (est_cod) REFERENCES Estado(est_cod),
    FOREIGN KEY (dep_cod) REFERENCES Departamento(dep_cod)
);


-- Dados iniciais
INSERT INTO Estado (est_nome) VALUES ('São Paulo'), ('Rio de Janeiro');

INSERT INTO Cidade (est_cod, cid_nome) VALUES (1, 'Campinas'), (2, 'Niterói');

INSERT INTO Departamento (dep_descricao) VALUES ('RH'), ('TI');

INSERT INTO Cargo (car_descricao) VALUES ('Analista'), ('Desenvolvedor');

INSERT INTO Funcionario (fun_logradouro, fun_nome, fun_salario, fun_cep, fun_nro, car_cod, cid_cod, est_cod, dep_cod) VALUES
('Rua A', 'Ana', 3500.00, '13000000', 101, 1, 1, 1, 1),
('Rua B', 'Bruno', 4500.00, '13010000', 102, 2, 2, 2, 2),
('Rua C', 'Carlos', 5500.00, '13020000', 103, 1, 1, 1, 2),
('Rua D', 'Daniela', 3200.00, '13030000', 104, 2, 2, 2, 1),
('Rua E', 'Eduardo', 6000.00, '13040000', 105, 1, 1, 1, 1);


## 2
CREATE VIEW Funcionario_View AS
SELECT 
    f.fun_cod,
    f.fun_nome,
    f.fun_logradouro,
    c.cid_nome,
    e.est_nome AS est_estado,
    ca.car_descricao,
    d.dep_descricao
FROM Funcionario f
JOIN Cidade c ON f.cid_cod = c.cid_cod
JOIN Estado e ON f.est_cod = e.est_cod
JOIN Cargo ca ON f.car_cod = ca.car_cod
JOIN Departamento d ON f.dep_cod = d.dep_cod;

## 3
SELECT * FROM Funcionario_View;

## 4
SELECT * FROM Funcionario;

## 5
INSERT INTO Funcionario (fun_logradouro, fun_nome, fun_salario, fun_cep, fun_nro, car_cod, cid_cod, est_cod, dep_cod) 
VALUES ('Rua F', 'Fernanda', 5000.00, '13050000', 106, 2, 2, 2, 1);

SELECT * FROM Funcionario_View WHERE fun_cod = 6;

## 6
ALTER TABLE Funcionario ADD COLUMN fun_obs VARCHAR(100);

CREATE OR REPLACE VIEW Funcionario_View AS
SELECT 
    f.fun_cod,
    f.fun_nome,
    f.fun_logradouro,
    c.cid_nome,
    e.est_nome AS est_estado,
    ca.car_descricao,
    d.dep_descricao,
    f.fun_obs
FROM Funcionario f
JOIN Cidade c ON f.cid_cod = c.cid_cod
JOIN Estado e ON f.est_cod = e.est_cod
JOIN Cargo ca ON f.car_cod = ca.car_cod
JOIN Departamento d ON f.dep_cod = d.dep_cod;


## 7
SHOW CREATE VIEW Funcionario_View;

## 8 
# ( X ) A. Por meio de uma view os dados apenas podem ser vistos.  
# (   ) B. Tabela virtual na qual os dados estão fisicamente armazenados.  
# ( X ) C. Utilizada para evitar que usuários não autorizados tenham acesso a todos os dados de uma tabela.  
# (   ) D. Para remover uma view utilizamos o seguinte comando delete view <nome da view>.  

