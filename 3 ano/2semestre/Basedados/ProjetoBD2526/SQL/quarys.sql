USE Enei_Gest;

SET @Evento_ID = 4;
SET @Orador_ID = 5;

-- Lucro Total de um Evento bilhetes+patrocinios

SELECT
	e.Titulo AS Evento,
    (SELECT SUM(Valor) FROM Pagamento p
    INNER JOIN Inscricao i ON p.Inscricao_id_Inscricao=i.Id
    INNER JOIN Bilhete b ON i.Bilhete_id_Bilhete = b.Id
    WHERE b.Evento_id_Evento = @Evento_ID) AS Total_Bilhetes,
    (SELECT SUM(Valor) FROM Patrocinio WHERE Evento_id_Evento = @Evento_ID) AS Total_Patrocinios,
    (SELECT SUM(Valor) FROM Pagamento p
    INNER JOIN Inscricao i ON p.Inscricao_id_Inscricao = i.Id
    INNER JOIN Bilhete b ON i.Bilhete_id_Bilhete = b.Id
    WHERE b.Evento_id_Evento = @Evento_ID) + (SELECT SUM(Valor) FROM Patrocinio WHERE Evento_id_Evento = @Evento_ID) AS Receita_Total
FROM Evento e
WHERE e.Id = @Evento_ID;

-- Listrar as palestras de um orador

SELECT 
	o.Nome AS Orador,
    p.Titulo As Tema_Palestra,
    p.HoraInicio,
    a.Papel
FROM Orador o
INNER JOIN Apresenta a ON o.Id = a.Orador_id_Orador
INNER JOIN Palestra p ON a.Palestra_id_Palestra = p.Id
WHERE o.Id = @Orador_ID
ORDER BY p.HoraInicio ASC;


-- Contagem de inscriçoes Confirmadas por Evento

SELECT
	e.Titulo AS Evento,
    COUNT(i.Id) AS Bilhetes_Vendidos
FROM Evento e
INNER JOIN Bilhete b ON e.Id = b.Evento_id_Evento
INNER JOIN Inscricao i on b.Id =i.Bilhete_id_Bilhete
WHERE i.Estado = 'Confirmada'
GROUP BY e.Titulo
ORDER BY Bilhetes_Vendidos DESC;


-- Verificar o metodo de pagamento mais popular

SELECT 
	Metodo AS Metodo_Pagamento,
    COUNT(id) AS Quantidade_Utilizacoes,
    SUM(Valor) AS Volume_Euros
FROM Pagamento
GROUP BY Metodo
ORDER BY Quantidade_Utilizacoes DESC
LIMIT 1;


-- Listar utilizadores com inscricoes pendentes

SELECT
	u.Nome,
    u.Email,
    b.Tipo AS Tipo_Bilhete,
    b.Preco AS Valor_Em_Divida
FROM Utilizador u
INNER JOIN Inscricao i ON u.Id = i.Utilizador_id_Utilizador
INNER JOIN Bilhete b ON i.Bilhete_id_Bilhete=b.Id
LEFT JOIN Pagamento p ON i.Id = p.Inscricao_id_Inscricao
WHERE i.Estado = 'Pendente' AND p.Id IS NULL;


-- TOP 3 oradores com mais participantes ativos

SELECT
	o.Nome AS Orador,
    o.InstituicaoEmpresa AS Empresa,
    COUNT(a.Palestra_id_Palestra) AS Total_Participantes
FROM Orador o
INNER JOIN Apresenta a ON o.Id=a.Orador_id_Orador
GROUP BY o.Id, o.Nome, o.InstituicaoEmpresa
ORDER BY Total_Participantes DESC
LIMIT 3;