USE Enei_Gest;

CREATE VIEW AgendaPublica AS
SELECT
	e.Titulo AS NomeEvento,
    s.NomeAtividade AS NomeSessao,
    p.Titulo AS NomePalestra,
    p.HoraInicio,
    p.HoraFim,
    o.Nome AS NomeOrador,
    a.Papel
FROM Evento e
INNER JOIN Sessao s ON e.Id=s.Evento_id_Evento
INNER JOIN Palestra p ON s.Id= p.Sessao_id_Sessao
LEFT JOIN Apresenta a ON p.Id=a.Palestra_id_Palestra
LEFT JOIN Orador o ON a.Orador_id_Orador=o.Id;

CREATE VIEW DetalhesInscricoes AS 
SELECT
	u.Nome AS Participante,
    u.Email,
    e.Titulo AS Evento,
    b.Tipo AS TipoBilhete,
    b.Preco AS PrecoBilhete,
    i.Estado AS EstadoInscricao,
    pg.Valor AS ValorPago,
    pg.Metodo AS MetodoPagamento
FROM Utilizador u
INNER JOIN Inscricao i ON u.Id = i.Utilizador_id_Utilizador
INNER JOIN Bilhete b ON i.Bilhete_id_Bilhete=b.Id
INNER JOIN Evento e ON b.Evento_id_Evento=e.Id
LEFT JOIN Pagamento pg ON i.Id=pg.Inscricao_id_Inscricao;

SELECT * FROM DetalhesInscricoes;