USE Enei_Gest;

DELIMITER $$
CREATE FUNCTION CalcularReceitaTotal(p_Evento_ID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_bilhetes DECIMAL(10,2);
    DECLARE total_patrocinios DECIMAL(10,2);
    
    SELECT IFNULL(SUM(p.Valor), 0) INTO total_bilhetes
    FROM Pagamento p
    INNER JOIN Inscricao i ON p.Inscricao_id_Inscricao = i.Id
    INNER JOIN Bilhete b ON i.Bilhete_id_Bilhete = b.Id
    WHERE b.Evento_id_Evento = p_Evento_ID;
    
    SELECT IFNULL(SUM(Valor), 0) INTO total_patrocinios
    FROM Patrocinio 
    WHERE Evento_id_Evento = p_Evento_ID;
    
    RETURN total_bilhetes + total_patrocinios;
END $$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER AtualizarEstadoPagamento
AFTER INSERT ON Pagamento
FOR EACH ROW
BEGIN

    UPDATE Inscricao 
    SET Estado = 'Confirmada' 
    WHERE Id = NEW.Inscricao_id_Inscricao;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE GerarAgendaFinal(IN p_Evento_ID INT)
BEGIN
    SELECT 
        s.NomeAtividade AS Sessao,
        p.HoraInicio,
        p.HoraFim,
        p.Titulo AS Palestra,
        IFNULL(o.Nome, 'Orador a definir') AS Orador
    FROM Sessao s
    INNER JOIN Palestra p ON s.Id = p.Sessao_id_Sessao
    LEFT JOIN Apresenta a ON p.Id = a.Palestra_id_Palestra
    LEFT JOIN Orador o ON a.Orador_id_Orador = o.Id
    WHERE s.Evento_id_Evento = p_Evento_ID
    ORDER BY p.HoraInicio ASC;
END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER ReporVagaCancelamento
AFTER UPDATE ON Inscricao
FOR EACH ROW
BEGIN
    IF NEW.Estado = 'Cancelada' AND OLD.Estado != 'Cancelada' THEN
        UPDATE Bilhete
        SET VagasDisponiveis = VagasDisponiveis + 1
        WHERE Id = NEW.Bilhete_id_Bilhete;
    END IF;
END $$
DELIMITER ;