

CREATE DATABASE IF NOT EXISTS Enei_Gest;

USE Enei_Gest;

create table Utilizador(
	Id Int auto_increment,
    Nome varchar(100) not null,
    Email varchar(100) not null unique,
    DataRegisto Datetime not null,
    Telefone Varchar(20),
    primary key(Id)
);

create table Organizador(
	Id Int auto_increment,
    NomeEmpresa varchar(100) not null,
    Email varchar(100) not null,
    Contacto Varchar(20),
    primary key(Id)
);

create table `Local`(
	Id Int auto_increment,
    Nome varchar(100) not null,
    Morada varchar(100) not null,
    LotacaoMaxima Int not null,
    primary key(Id)
);

create table Orador(
	Id Int auto_increment,
    Nome varchar(100) not null,
    Email varchar(100),
    Biografia Text,
    InstituicaoEmpresa varchar(100),
    primary key(Id)
);

CREATE TABLE Patrocinador (
    Id INT AUTO_INCREMENT,
    NomeEmpresa VARCHAR(100) NOT NULL,
    NIF VARCHAR(20) NOT NULL UNIQUE,
    PessoaContacto VARCHAR(100),
    PRIMARY KEY(Id)
);

CREATE TABLE Evento (
    Id INT AUTO_INCREMENT,
    Titulo VARCHAR(150) NOT NULL,
    DataInicio DATETIME NOT NULL,
    DataFim DATETIME NOT NULL,
    CapacidadeMaxima INT NOT NULL,
    Organizador_id_Organizador INT NOT NULL,
    Local_id_Local INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Organizador_id_Organizador) REFERENCES Organizador(Id),
    FOREIGN KEY(Local_id_Local) REFERENCES Local(Id)
);

CREATE TABLE Sessao (
    Id INT AUTO_INCREMENT,
    NomeAtividade VARCHAR(100) NOT NULL,
    HoraInicio DATETIME NOT NULL,
    HoraFim DATETIME NOT NULL,
    Evento_id_Evento INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Evento_id_Evento) REFERENCES Evento(Id)
);

CREATE TABLE Bilhete (
    Id INT AUTO_INCREMENT,
    Tipo VARCHAR(50) NOT NULL,
    Preco DECIMAL(6,2) NOT NULL,
    VagasDisponiveis INT NOT NULL,
    Evento_id_Evento INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Evento_id_Evento) REFERENCES Evento(Id)
);

CREATE TABLE Palestra (
    Id INT AUTO_INCREMENT,
    Titulo VARCHAR(100) NOT NULL,
    Resumo TEXT,
    HoraInicio DATETIME NOT NULL,
    HoraFim DATETIME NOT NULL,
    Sessao_id_Sessao INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Sessao_id_Sessao) REFERENCES Sessao(Id)
);

CREATE TABLE Inscricao (
    Id INT AUTO_INCREMENT,
    DataInscricao DATETIME NOT NULL,
    Estado VARCHAR(20) NOT NULL,
    Utilizador_id_Utilizador INT NOT NULL,
    Bilhete_id_Bilhete INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Utilizador_id_Utilizador) REFERENCES Utilizador(Id),
    FOREIGN KEY(Bilhete_id_Bilhete) REFERENCES Bilhete(Id)
);

CREATE TABLE Pagamento (
    Id INT AUTO_INCREMENT,
    Valor DECIMAL(6,2) NOT NULL,
    Metodo VARCHAR(50) NOT NULL,
    DataPagamento DATETIME NOT NULL,
    Inscricao_id_Inscricao INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(Inscricao_id_Inscricao) REFERENCES Inscricao(Id)
);

CREATE TABLE Patrocinio (
    Evento_id_Evento INT NOT NULL,
    Patrocinador_id_Patrocinador INT NOT NULL,
    Tipo VARCHAR(45),
    DataContrato datetime,
    Valor Decimal(6,2),
    PRIMARY KEY(Evento_id_Evento, Patrocinador_id_Patrocinador),
    FOREIGN KEY(Evento_id_Evento) REFERENCES Evento(Id),
    FOREIGN KEY(Patrocinador_id_Patrocinador) REFERENCES Patrocinador(Id)
);

CREATE TABLE Apresenta(
    Orador_id_Orador INT NOT NULL,
    Palestra_id_Palestra INT NOT NULL,
    Papel VARCHAR(45),
    PRIMARY KEY(Orador_id_Orador, Palestra_id_Palestra),
    FOREIGN KEY(Orador_id_Orador) REFERENCES Orador(Id),
    FOREIGN KEY(Palestra_id_Palestra) REFERENCES Palestra(Id)
);