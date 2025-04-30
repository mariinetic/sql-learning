-- Mariana Oliveira e Thiago Abreu

-- 1
SELECT p.pes_nome
FROM Emprestimo e
JOIN Pessoa p ON e.pes_cod = p.pes_cod
WHERE e.emp_cod = 1;

-- 2
SELECT edi_descricao
FROM Editora
ORDER BY edi_descricao;

-- 3
SELECT liv_titulo
FROM Livro
WHERE liv_titulo LIKE 'A%';

-- 4
SELECT liv_titulo
FROM Livro
WHERE liv_titulo LIKE 'A%' AND anopublicacao > '2013';

-- 5
SELECT COUNT(*) AS quantidade
FROM Telefone
WHERE tel_ddd = 12;

-- 6
SELECT a.pes_nro_matricula, COUNT(e.emp_cod) AS quantidade
FROM Aluno a
LEFT JOIN Emprestimo e ON a.pes_cod = e.pes_cod
GROUP BY a.pes_nro_matricula;

-- 7
SELECT e.edi_cod, e.edi_descricao, l.liv_cod
FROM Editora e
JOIN Livro l ON e.edi_cod = l.edi_cod;

-- 8
SELECT ex.exe_cod, ex.exe_descricao, e.emp_data_emprestimo
FROM Exemplar ex
JOIN ITEM_EMPRESTIMO ie ON ex.exe_cod = ie.exe_cod
JOIN Emprestimo e ON ie.emp_cod = e.emp_cod
WHERE e.emp_data_emprestimo = '2015-11-03'; 

-- 9
SELECT l.liv_titulo, COUNT(e.exe_cod) AS quantidade_exemplares
FROM Livro l
JOIN Exemplar e ON l.liv_cod = e.liv_cod
GROUP BY l.liv_titulo
HAVING COUNT(e.exe_cod) > 3;

-- 10
SELECT p.pes_nome, pr.titulacao, t.tel_numero
FROM Professor pr
JOIN Pessoa p ON pr.pes_cod = p.pes_cod
LEFT JOIN Telefone t ON p.pes_cod = t.pes_cod;

-- 11
SELECT liv_titulo
FROM Livro
ORDER BY anopublicacao ASC
LIMIT 1;

-- 12
SELECT p.pes_nome, COUNT(e.emp_cod) AS total_emprestimos
FROM Emprestimo e
JOIN Pessoa p ON e.pes_cod = p.pes_cod
GROUP BY p.pes_nome
ORDER BY total_emprestimos DESC
LIMIT 1;

-- 13
SELECT l.liv_titulo, COUNT(e.exe_cod) AS total_exemplares
FROM Livro l
JOIN Exemplar e ON l.liv_cod = e.liv_cod
GROUP BY l.liv_titulo;

-- 14
SELECT liv_titulo
FROM Livro
WHERE liv_titulo LIKE 'A%' AND anopublicacao > '2011';

-- 15
SELECT l.liv_titulo
FROM Livro l
JOIN Exemplar e ON l.liv_cod = e.liv_cod
JOIN ITEM_EMPRESTIMO ie ON e.exe_cod = ie.exe_cod
JOIN Emprestimo em ON ie.emp_cod = em.emp_cod
WHERE em.pes_cod = 1;

-- 16
	-- 1. INNER JOIN: Lista todos os empréstimos com os nomes das pessoas correspondentes (apenas combinações existentes)
	SELECT P.pes_nome, E.emp_cod, E.emp_data_emprestimo
	FROM PESSOA P
	INNER JOIN EMPRESTIMO E ON P.pes_cod = E.pes_cod;

	-- 2. LEFT JOIN: Lista todos os livros e seus exemplares, incluindo livros sem exemplares
	SELECT L.liv_titulo, E.exe_cod
	FROM LIVRO L
	LEFT JOIN EXEMPLAR E ON L.liv_cod = E.liv_cod;

	-- 3. LEFT JOIN com WHERE: Encontra livros que não possuem nenhum exemplar cadastrado
	SELECT L.liv_titulo
	FROM LIVRO L
	LEFT JOIN EXEMPLAR E ON L.liv_cod = E.liv_cod
	WHERE E.exe_cod IS NULL;

	-- 4. RIGHT JOIN: Lista todos os exemplares e seus empréstimos, incluindo exemplares nunca emprestados
	SELECT E.exe_cod, EM.emp_cod
	FROM ITEM_EMPRESTIMO IE
	RIGHT JOIN EXEMPLAR E ON IE.exe_cod = E.exe_cod
	LEFT JOIN EMPRESTIMO EM ON IE.emp_cod = EM.emp_cod;

	-- 5. RIGHT JOIN com WHERE: Encontra empréstimos que não possuem itens associados (inconsistência)
	SELECT EM.emp_cod
	FROM ITEM_EMPRESTIMO IE
	RIGHT JOIN EMPRESTIMO EM ON IE.emp_cod = EM.emp_cod
	WHERE IE.exe_cod IS NULL;

	-- 6. FULL OUTER JOIN: Lista todas as pessoas e todos os telefones, mostrando combinações mesmo quando não existem
	SELECT P.pes_nome, T.tel_numero
	FROM PESSOA P
	LEFT JOIN TELEFONE T ON P.pes_cod = T.pes_cod
	UNION
	SELECT P.pes_nome, T.tel_numero
	FROM PESSOA P
	RIGHT JOIN TELEFONE T ON P.pes_cod = T.pes_cod
	WHERE P.pes_cod IS NULL;

	-- 7. FULL OUTER JOIN com WHERE: Encontra registros inconsistentes (pessoas sem telefone e telefones sem pessoa)
	SELECT P.pes_nome, 'Pessoa sem telefone' AS observacao
	FROM PESSOA P
	LEFT JOIN TELEFONE T ON P.pes_cod = T.pes_cod
	WHERE T.tel_cod IS NULL
	UNION
	SELECT 'N/A', CONCAT('Telefone sem pessoa: ', T.tel_numero)
	FROM PESSOA P
	RIGHT JOIN TELEFONE T ON P.pes_cod = T.pes_cod
	WHERE P.pes_cod IS NULL;
