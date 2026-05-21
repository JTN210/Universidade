USE Enei_Gest;

INSERT INTO Utilizador (Nome, Email, DataRegisto, Telefone) VALUES
('João Silva', 'joao.silva@email.com', '2024-01-10 10:30:00', '912345678'),
('Ana Rita Santos', 'ana.santos@email.com', '2024-01-12 14:15:00', '961234567'),
('Carlos Mendes', 'carlos.m@estudante.uminho.pt', '2024-02-15 09:20:00', '933445566'),
('Beatriz Sousa', 'bsousa@estudante.feup.pt', '2024-02-18 11:45:00', '911223344'),
('Tiago Ribeiro', 'tiago.ribeiro@gmail.com', '2024-03-01 16:10:00', '966778899'),
('Mariana Lima', 'mariana.l@isep.ipp.pt', '2024-03-05 14:00:00', '922334455'),
('Pedro Gonçalves', 'pedro.goncalves@dev.com', '2024-03-10 18:30:00', NULL);


INSERT INTO Organizador (NomeEmpresa, Email, Contacto) VALUES
('Tech Events Portugal', 'geral@techevents.pt', '210987654'),
('Cultura Porto', 'info@culturaporto.pt', '220123456'),
('Núcleo de Estudantes de Ciências da Computação', 'geral@necc.pt', '253112233'),
('Associação Académica', 'eventos@academica.pt', '210001122');


INSERT INTO `Local` (Nome, Morada, LotacaoMaxima) VALUES
('Auditório Principal FEUP', 'Porto', 500),
('Altice Arena', 'Lisboa', 2000),
('Pavilhão Rosa Mota', 'Jardins do Palácio de Cristal, Porto', 4000),
('Sala B204 - FEUP', 'Rua Dr. Roberto Frias, Porto', 120);


INSERT INTO Orador (Nome, Email, Biografia, InstituicaoEmpresa) VALUES
('Maria Fernandes', 'maria.f@tech.com', 'Especialista em IA.', 'TechCorp'),
('Rui Costa', 'rui.costa@univ.pt', 'Professor Catedrático.', 'Universidade do Porto'),
('Joana Batista', 'jbatista@microsoft.com', 'Cloud Architect e MVP.', 'Microsoft'),
('Nuno Marques', 'nuno.marques@blip.pt', 'Lead Software Engineer.', 'Blip'),
('Sara Oliveira', 'sara.o@deloitte.pt', 'Consultora de Cibersegurança.', 'Deloitte');


INSERT INTO Patrocinador (NomeEmpresa, NIF, PessoaContacto) VALUES
('MEO Empresas', '500500500', 'Miguel Almeida'),
('Worten', '501501501', 'Sofia Lemos'),
('Microsoft Portugal', '502502502', 'Rita Lemos'),
('Deloitte', '503503503', 'Hugo Silva'),
('Blip', '504504504', 'Inês Castro');


INSERT INTO Evento (Titulo, DataInicio, DataFim, CapacidadeMaxima, Organizador_id_Organizador, Local_id_Local) VALUES
('Future Tech Conference', '2024-05-10 09:00:00', '2024-05-11 18:00:00', 400, 1, 1),
('Lisbon Cultural Fest', '2024-09-20 10:00:00', '2024-09-22 20:00:00', 1500, 2, 2),
('Hackathon Code4Good', '2024-11-15 18:00:00', '2024-11-17 18:00:00', 200, 3, 4),
('ENEI 2025 - Encontro Nacional', '2025-03-20 09:00:00', '2025-03-23 20:00:00', 3500, 1, 3);


INSERT INTO Sessao (NomeAtividade, HoraInicio, HoraFim, Evento_id_Evento) VALUES
('Abertura e Keynotes', '2024-05-10 09:00:00', '2024-05-10 12:30:00', 1),
('Painel de Cibersegurança', '2025-03-21 14:00:00', '2025-03-21 16:00:00', 4),
('Workshops de Programação', '2025-03-22 10:00:00', '2025-03-22 13:00:00', 4),
('Apresentação de Projetos (Pitches)', '2024-11-17 15:00:00', '2024-11-17 17:30:00', 3);


INSERT INTO Bilhete (Tipo, Preco, Evento_id_Evento) VALUES
('Geral', 50.00, 1),
('VIP', 100.00, 1),
('Estudante', 15.00, 4),
('Profissional', 60.00, 4),
('Equipa Hackathon (4 pax)', 20.00, 3);


INSERT INTO Palestra (Titulo, Resumo, HoraInicio, HoraFim, Sessao_id_Sessao) VALUES
('O Futuro da IA', 'Impacto da IA nas empresas.', '2024-05-10 10:00:00', '2024-05-10 11:00:00', 1),
('Ataques Ransomware em 2024', 'Análise dos maiores ataques e como prevenir.', '2025-03-21 14:15:00', '2025-03-21 15:00:00', 2),
('Escalar com Kubernetes', 'Workshop prático de DevOps e Cloud.', '2025-03-22 10:00:00', '2025-03-22 12:00:00', 3);


INSERT INTO Inscricao (DataInscricao, Estado, Utilizador_id_Utilizador, Bilhete_id_Bilhete) VALUES
('2024-02-01 10:00:00', 'Confirmada', 1, 1),
('2024-02-05 15:30:00', 'Pendente', 2, 2),
('2024-03-10 10:00:00', 'Confirmada', 3, 3),
('2024-03-15 14:20:00', 'Confirmada', 4, 3);


INSERT INTO Pagamento (Valor, Metodo, DataPagamento, Inscricao_id_Inscricao) VALUES 
(50.00, 'MBWay', '2024-02-01 10:05:00', 1),
(15.00, 'Referência Multibanco', '2024-03-10 10:15:00', 3),
(15.00, 'MBWay', '2024-03-15 14:25:00', 4);


INSERT INTO Patrocinio (Evento_id_Evento, Patrocinador_id_Patrocinador, Tipo, DataContrato, Valor) VALUES
(1, 1, 'Principal', '2024-01-15 10:00:00', 5000.00),
(1, 2, 'Apoio Prata', '2024-02-10 14:00:00', 1500.00),
(4, 3, 'Sponsor Gold', '2025-01-10 11:00:00', 9999.00),
(4, 4, 'Sponsor Silver', '2025-01-15 15:30:00', 5000.00),
(3, 5, 'Apoio Tecnológico', '2024-09-01 10:00:00', 2000.00);


INSERT INTO Apresenta (Orador_id_Orador, Palestra_id_Palestra, Papel) VALUES
(1, 1, 'Orador Principal'),
(2, 1, 'Moderador'),
(5, 2, 'Orador Principal'), 
(3, 3, 'Formador'),        
(4, 3, 'Assistente');