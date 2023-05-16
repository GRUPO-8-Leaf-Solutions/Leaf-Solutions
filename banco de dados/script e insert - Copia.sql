create database leafSolutions;
use leafSolutions;

create table empresa (
idEmpresa int primary key auto_increment,
CNPJ char(14) not null,
razaoSocial varchar(45) not null,
email varchar(50) not null,  
tokenPerm varchar(8)
);

create table situacao (
idSituacao int primary key auto_increment,
descricao varchar(10)
);

create table usuario (
idUsuario int auto_increment,
nome varchar(45) not null,
sobrenome varchar(20),
email varchar(40) not null unique,
senha varchar(20) not null,
fkEmpresa int,
fkSituacao int,
constraint fkUsuarioEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkUsuarioSituacao foreign key (fkSituacao)
	references situacao (idSituacao),
constraint pkUsuario primary key (idUsuario, fkEmpresa, fkSituacao)
);

create table tipoTelefone(
idTipoTelefone int primary key auto_increment,
descricao varchar(20)
);

create table telefone (
idTelefone int auto_increment,
numero varchar(20),
fkEmpresa int,
fkTipoTelefone int,
constraint fkTelefoneEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkTelefoneTipoTelefone foreign key (fkTipoTelefone)
	references tipoTelefone (idTipoTelefone),
constraint pkTelefone primary key (idTelefone, fkEmpresa, fkTipoTelefone)
);

create table endereco (
idEndereco int primary key auto_increment,
CEP char(8) not null,
logradouro varchar(80) not null,
numero varchar(5) not null,
complemento varchar(30),
estado char(2),
cidade varchar(50)
);

create table estufa (
idEstufa int auto_increment,
nome varchar(45),
area int not null,
fkEmpresa int,
fkEndereco int,
constraint fkEstufaEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkEstufaEndereco foreign key (fkEndereco)
	references endereco (idEndereco),
constraint pkEstufa primary key (idEstufa, fkEmpresa, fkEndereco)
);

create table setor (
idSetor int auto_increment,
tipo varchar(20) not null,
valorMin int,
valorMax int,
fkEstufa int,
constraint chkTipo 
	check (tipo in ('americana', 'crespa', 'mimosa', 'roxa')),
constraint fkSetorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint pkSetorEstufa primary key (idSetor, fkEstufa)
);

create table sensor (
idSensor int auto_increment,
modelo varchar(5),
situacao varchar(10) not null,
fkSetor int,
constraint chkSituacaoSensor 
	check (situacao in ('ativo', 'manutencao', 'inativo')),
constraint fkSensorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint pkSensor primary key (idSensor, fkSetor)
);

create table leituraSensor (
idLeituraSensor int auto_increment,
valor int not null,
dtLeitura datetime default current_timestamp not null,
fkSensor int,
constraint fkLeituraSensorSensor foreign key (fkSensor)
	references sensor (idSensor),
constraint pkLeituraSensor primary key (idLeituraSensor, fkSensor)
);

insert into empresa values 
	(null, '48597652145369', 'AlfaceTech', 'alfacetech@email.com', null),
	(null, '54876951234562', 'Alfacinho',  'alfacinho@email.com', '84957621'),
	(null, '12345678945612', 'Folhas Verdes', 'folhasverdes@email.com', '15478923'),
	(null, '21346523198746', 'Leaf Green', 'leafgreen@email.com', null),
	(null, '12451242369874', 'FolhasTech', 'folhastech@email.com', null);

insert into situacao values
	(null, 'ativo'),
	(null, 'afastado'),
	(null, 'desligado');

insert into usuario values 
	(null, 'Kauan', 'Fonseca', 'kauan@email.com', 'goiabinha123', 1, 1),
	(null, 'Isabel', 'Oliveira', 'isabel@email.com', 'qwerty', 2, 1),
	(null, 'Ismael', 'Vieria', 'ismael@email.com', '12345678', 3, 2),
	(null, 'Israel', 'Augusto', 'israel@email.com', '1234', 4, 1),
	(null, 'Cauã', 'Batista', 'caua@email.com', 'moranguinho321', 5, 1),
	(null, 'Matheus', 'Cavalcante', 'matheus@email.com', 'senha', 1, 1),
	(null, 'Samuel', 'Gaglieta', 'samuel@email.com', 'password', 1, 3),
	(null, 'Pedro', 'Pinheiro', 'pedro@email.com', 'sorteveS2', 2, 1),
	(null, 'Lizandra', 'Militão', 'lizandra@email.com', 'floquinho', 3, 2),
	(null, 'Maria', 'Sousa', 'maria@email.com', 'folhaamarela', 5, 3);
    
insert into tipoTelefone values
	(null, 'Comercial'),
	(null, 'Residencial'),
	(null, 'Fixo'),
	(null, 'Celular');

insert into telefone values 
	(null, '1185647123', 1, 2),
	(null, '1365686523', 2, 1),
	(null, '2096563214', 3, 3),
	(null, '5512145362', 4, 4),
	(null, '9975481263', 3, 1),
	(null, '1284532164', 5, 3),
    (null, '05998745632', 3, 3),
	(null, '27912546325', 4, 1),
	(null, '8786965742', 1, 1);
    
insert into endereco values 
	(null, '45678912', 'Rua da Uva', '555', null,  'SP', 'São Paulo'),
	(null, '36987451', 'Avenida da Maçã', '1023', '7 andar', 'MG', 'Três Corações'),
	(null, '15421689', 'Rua da Jaca', '819', 'A', 'MA', 'Caxias'),
	(null, '78459636', 'Rua da Melancia', '298', null, 'PE', 'Carueri'),
	(null, '98656394', 'Avenida da Banana', '5430', null, 'CE', 'Fortaleza'),
	(null, '05213489', 'Rua do Mamão', '239', '2 andar', 'SP', 'Santos'),
	(null, '78459697', 'Avenida da Goiaba', '555', 'B', 'RJ', 'Niterói'),
	(null, '87459630', 'Avenida do Melão', '8745', null, 'SP', 'Ouro Preto');
    
insert into estufa values 
	(null, 'Estufa da esquerda', 300, 1, 1),
	(null, 'Estufa da direita', 300, 1, 2),
	(null, 'Estufa central', 500, 2, 3),
	(null, 'Estufa superior', 400, 3, 4),
	(null, 'Estufa inferior', 400, 3, 5),
	(null, 'Estufa maior', 300, 4, 6),
	(null, 'Estufa menor', 200, 4, 7),
	(null, 'Estufa central', 480, 5, 8);

insert into setor values 
	(null, 'Americana', 300, 900, 1),
	(null, 'Crespa', 500, 700, 1),
	(null, 'Mimosa', 450, 1000, 2),
	(null, 'Roxa', 200, 800, 2),
	(null, 'Americana', 300, 900,3),
	(null, 'Crespa', 500, 700, 3),
	(null, 'Roxa', 200, 800, 4),
	(null, 'Mimosa', 450, 1000, 4),
	(null, 'Americana', 300, 900,  5),
	(null, 'Roxa', 200, 800, 6),
	(null, 'Crespa', 500, 700, 7),
	(null, 'Mimosa', 450, 1000, 7),
	(null, 'Americana', 300, 900, 8),
	(null, 'Crespa', 500, 700, 8);
    
insert into sensor values 
	(null, 'ldr', 'ativo', 1),
	(null, 'ldr', 'manutencao', 2),
	(null, 'ldr', 'inativo', 3),
	(null, 'ldr', 'ativo', 4), 
	(null, 'ldr', 'ativo', 5),
	(null, 'ldr', 'ativo', 6),
	(null, 'ldr', 'inativo', 7),
	(null, 'ldr', 'ativo', 8),
	(null, 'ldr', 'ativo', 9),
	(null, 'ldr', 'manutencao', 10),
	(null, 'ldr', 'ativo', 11),
	(null, 'ldr', 'inativo', 12),
	(null, 'ldr', 'manutencao', 13),
	(null, 'ldr', 'ativo', 14);
 
insert into leituraSensor values 
	(null, 500, '2023-04-01 00:00:00', 1),
	(null, 600, '2023-04-02 00:00:00', 1),
	(null, 700, '2023-04-03 00:00:00', 2),
	(null, 800, '2023-04-04 00:00:00', 3),
	(null, 900, '2023-04-05 00:00:00', 4),
	(null, 500, '2023-04-05 12:00:00', 4),
	(null, 450, default, 5),
	(null, 700, '2023-04-08 00:00:00', 6),
	(null, 350, '2023-04-09 00:00:00', 7),
	(null, 650, '2023-04-10 15:00:00', 8),
	(null, 250, default, 9),
	(null, 750, '2023-04-11 12:00:00', 9),
	(null, 900, '2023-04-12 00:00:00', 9),
	(null, 1000, default, 10),
	(null, 300, '2023-04-03 00:00:00', 10),
	(null, 800, '2023-04-04 00:00:00', 11),
	(null, 800, default, 11),
	(null, 400, '2023-04-06 19:00:00', 12),
	(null, 900, '2023-04-07 00:00:00', 13),
	(null, 750, '2023-04-08 00:00:00', 14);
        
select 
setor.idSetor as "N° setor",
lei.valor as Captação,
setor.valorMin as "Alerta do mínimo",
setor.valorMax as "Alerta do máximo",
lei.dtLeitura as Horário
	from setor join sensor as sen
	on idSetor = fkSetor
    join leituraSensor as lei
    on idSensor = fkSensor;
    
select
setor.idSetor as "N° setor",
lei.valor as Captação,
sen.situacao as "Status"
	from setor join sensor as sen
	on idSetor = fkSetor
    join leituraSensor as lei
    on idSensor = fkSensor;
    
select 
emp.razaoSocial as "Nome empresa",
est.nome as "Nome estufa",
endereco.logradouro as "Local",
endereco.numero as Número
	from empresa as emp join estufa as est  
	on idEmpresa = fkEmpresa
    join endereco 
    on idEndereco = fkEndereco;