USE Enei_Gest;


CREATE INDEX idx_inscricao_utilizador_id ON Inscricao(Utilizador_id_Utilizador);
CREATE INDEX idx_inscricao_bilhete_id ON Inscricao(Bilhete_id_Bilhete);


CREATE INDEX idx_palestra_sessao_id ON Palestra(Sessao_id_Sessao);


CREATE INDEX idx_sessao_evento_id ON Sessao(Evento_id_Evento);