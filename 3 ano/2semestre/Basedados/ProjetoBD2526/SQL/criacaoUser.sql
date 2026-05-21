DROP USER IF EXISTS 'gestor_conteudos'@'localhost';
DROP USER IF EXISTS 'gestor_participantes'@'localhost';
-- Gestor
CREATE USER 'gestor_conteudos'@'localhost' IDENTIFIED BY 'Conteudos@123';

GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Evento TO 'gestor_conteudos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Sessao TO 'gestor_conteudos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Palestra TO 'gestor_conteudos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Orador TO 'gestor_conteudos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Local TO 'gestor_conteudos'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Organizador TO 'gestor_conteudos'@'localhost';
GRANT EXECUTE ON PROCEDURE Enei_Gest.GerarAgendaFinal TO 'gestor_conteudos'@'localhost';

	-- User

CREATE USER 'gestor_participantes'@'localhost' IDENTIFIED BY 'Participantes@123';

GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Utilizador TO 'gestor_participantes'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Inscricao TO 'gestor_participantes'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Bilhete TO 'gestor_participantes'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Pagamento TO 'gestor_participantes'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Patrocinador TO 'gestor_participantes'@'localhost';
GRANT SELECT, INSERT, UPDATE ON Enei_Gest.Patrocinio TO 'gestor_participantes'@'localhost';
GRANT EXECUTE ON FUNCTION Enei_Gest.CalcularReceitaTotal TO 'gestor_participantes'@'localhost';
