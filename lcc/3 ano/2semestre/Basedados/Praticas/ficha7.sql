-- Exercicio 1

create database if not exists fabrica;

Use fabrica;

-- exercicio 2

create table Familia(
	Id Int auto_increment,
    Designacao varchar(75) Not null,
    primary key(Id)
);
    
-- Drop Table Familia

-- Tabela Operaçoes

create table operacoes(
	Id Int auto_increment,
    Designacao varchar(75) Not null,
    custohora decimal(8,2) Not null,
    primary key(Id),
    constraint chk_custohora_positivo check (custohora>0)
);

-- Tabela Tecnicos 

create table Tecnicos(
Id Int auto_increment,
Nome varchar(75),
Funcao varchar(100) not null,
CurriculumVitae text,
Responsavel int,
primary key(Id),
foreign key(responsavel) references Tecnicos(Id)
);

-- Tabela Tecnicos Operacoes 

create table TecnicosOperacoes(
Tecnico int,
Operacao int,
primary key(Tecnico,Operacao),
foreign key(Tecnico) references Tecnicos(Id),
foreign key(Operacao) references Operacoes(Id)
);



