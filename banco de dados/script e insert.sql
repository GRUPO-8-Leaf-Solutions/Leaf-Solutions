create database leafSolutions;
use leafSolutions;

create table empresa (
idEmpresa int primary key auto_increment,
cnpj char(14) not null,
razaoSocial varchar(45) not null,
email varchar(50) not null,  
tokenPerm varchar(8)
);

create table usuario (
idUsuario int auto_increment,
nome varchar(45) not null,
sobrenome varchar(20),
situacao char(10) not null,
email varchar(40) not null unique,
senha varchar(20) not null,
fkEmpresa int,
constraint fkUsuarioEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint pkUsuario primary key (idUsuario, fkEmpresa)
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
cep char(8) not null,
logradouro varchar(80) not null,
bairro varchar(45) not null,
numero varchar(5) not null,
complemento varchar(30),
uf char(2),
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
valorMin int default 350,
valorMax int default 800,
fkEstufa int,
fkEmpresa int,
fkEndereco int,
constraint fkSetorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint fkSetorEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkSetorEndereco foreign key (fkEndereco)
	references endereco (idEndereco),
constraint pkSetor primary key (idSetor, fkEstufa, fkEmpresa, fkEndereco)
);

create table tipoAlface (
idTipoAlface int primary key auto_increment,
especie varchar(40) not null
);

create table subSetor (
idSubSetor int auto_increment,
fkSetor int,
fkEstufa int,
fkEmpresa int,
fkEndereco int,
fkTipoAlface int,
constraint fkSubSetorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint fkSubSetorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint fkSubSetorEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkSubSetorEndereco foreign key (fkEndereco)
	references endereco (idEndereco),
constraint fkSubSetorTipoAlface foreign key (fkTipoAlface)
	references tipoAlface (idTipoAlface),
constraint pkSubSetor primary key (idSubSetor, fkSetor, fkEstufa, fkEmpresa, fkEndereco, fkTipoAlface)
);

create table sensor (
idSensor int auto_increment,
modelo varchar(5) default 'ldr',
situacao varchar(10) not null,
constraint chkSituacaoSensor 
	check (situacao in ('ativo', 'manutencao', 'inativo')),
fkSubSetor int,
fkSetor int,
fkEstufa int,
fkEmpresa int,
fkEndereco int,
fkTipoAlface int,
constraint fkSensorSubSetor foreign key (fkSubSetor)
	references subSetor (idSubSetor),
constraint fkSensorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint fkSensorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint fkSensorEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkSensorEndereco foreign key (fkEndereco)
	references endereco (idEndereco),
constraint fkSensorTipoAlface foreign key (fkTipoAlface)
	references tipoAlface (idTipoAlface),
constraint pkSensor primary key (idSensor, fkSubSetor, fkSetor, fkEstufa, fkEmpresa, fkEndereco, fkTipoAlface)
);

create table leituraSensor (
idLeituraSensor int auto_increment,
valor int not null,
dtLeitura datetime default current_timestamp not null,
fkSensor int,
fkSubSetor int,
fkSetor int,
fkEstufa int,
fkEmpresa int,
fkEndereco int,
fkTipoAlface int,
constraint fkLeituraSensorSensor foreign key (fkSensor)
	references Sensor (idSensor),
constraint fkLeituraSensorSubSetor foreign key (fkSubSetor)
	references subSetor (idSubSetor),
constraint fkLeituraSensorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint fkLeituraSensorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint fkLeituraSensorEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint fkLeituraSensorEndereco foreign key (fkEndereco)
	references endereco (idEndereco),
constraint fkLeituraSensorTipoAlface foreign key (fkTipoAlface)
	references tipoAlface (idTipoAlface),
constraint pkSensor primary key (idLeituraSensor, fkSensor, fkSubSetor, fkSetor, fkEstufa, fkEmpresa, fkEndereco, fkTipoAlface)
);


insert into empresa values 
	(null, '48597652145369', 'AlfaceTech', 'alfacetech@email.com', null),
	(null, '54876951234562', 'Alfacinho',  'alfacinho@email.com', '84957621'),
	(null, '12345678945612', 'Folhas Verdes', 'folhasverdes@email.com', '15478923'),
	(null, '21346523198746', 'Leaf Green', 'leafgreen@email.com', null),
	(null, '12451242369874', 'FolhasTech', 'folhastech@email.com', null);

insert into usuario values 
	(null, 'Kauan', 'Fonseca', 'ativo', 'kauan@email.com', 'goiabinha123', 1),
	(null, 'Isabel', 'Oliveira', 'desligado', 'isabel@email.com', 'qwerty', 2),
	(null, 'Ismael', 'Vieria', 'afastado', 'ismael@email.com', '12345678', 3),
	(null, 'Israel', 'Augusto', 'ativo', 'israel@email.com', '1234', 4),
	(null, 'Cauã', 'Batista', 'ativo', 'caua@email.com', 'moranguinho321', 5),
	(null, 'Matheus', 'Cavalcante', 'ativo', 'matheus@email.com', 'senha', 1),
	(null, 'Samuel', 'Gaglieta', 'afastado', 'samuel@email.com', 'password', 1),
	(null, 'Pedro', 'Pinheiro', 'ativo', 'pedro@email.com', 'sorteveS2', 2),
	(null, 'Lizandra', 'Militão', 'desligado', 'lizandra@email.com', 'floquinho', 3),
	(null, 'Maria', 'Sousa', 'ativo', 'maria@email.com', 'folhaamarela', 5);
    
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
	(null, '45678912', 'Rua da Uva', 'Legumes', '555', null,  'SP', 'São Paulo'),
	(null, '36987451', 'Avenida da Maçã', 'Legumes', '1023', '7 andar', 'MG', 'Três Corações'),
	(null, '15421689', 'Rua da Jaca', 'Frutas', '819', 'A', 'MA', 'Caxias'),
	(null, '78459636', 'Rua da Melancia', 'Verduras', '298', null, 'PE', 'Carueri'),
	(null, '98656394', 'Avenida da Banana', 'Legumes', '5430', null, 'CE', 'Fortaleza'),
	(null, '05213489', 'Rua do Mamão', 'Verduras', '239', '2 andar', 'SP', 'Santos'),
	(null, '78459697', 'Avenida da Goiaba', 'Leguminosas', '555', 'B', 'RJ', 'Niterói'),
	(null, '87459630', 'Avenida do Melão', 'Frutas', '8745', null, 'SP', 'Ouro Preto');

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
	(null, null, null, 1, 1, 1),
	(null, null, null, 1, 1, 1),
	(null, null, null, 1, 1, 1),
	(null, null, null, 2, 1, 2),
	(null, null, null, 2, 1, 2),
	(null, null, null, 2, 1, 2),
	(null, null, null, 3, 2, 3),
	(null, null, null, 3, 2, 3),
	(null, null, null, 3, 2, 3),
	(null, null, null, 4, 3, 4),
	(null, null, null, 4, 3, 4),
	(null, null, null, 4, 3, 4),
	(null, null, null, 5, 3, 5),
	(null, null, null, 5, 3, 5),
	(null, null, null, 5, 3, 5),
	(null, null, null, 6, 4, 6),
	(null, null, null, 6, 4, 6),
	(null, null, null, 6, 4, 6),
	(null, null, null, 7, 4, 7),
	(null, null, null, 7, 4, 7),
	(null, null, null, 7, 4, 7),
	(null, null, null, 8, 5, 8),
	(null, null, null, 8, 5, 8),
	(null, null, null, 8, 5, 8);

insert into tipoAlface values
	(null, 'Americana'),
	(null, 'Mimosa'),
	(null, 'Crespa'),
	(null, 'Roxa');

select 
sub.idSubSetor subSetor,
seto.idSetor Setor,
est.idEstufa Estufa,
emp.idEmpresa Empresa,
en.idEndereco Endereco,
tipo.idTipoALface tipoAlface
	from estufa as est join empresa as emp
		on emp.idEmpresa = est.fkEmpresa
		join endereco as en
		on en.idEndereco = est.fkEndereco
        join setor as seto
        on est.idEstufa = seto.fkEstufa
        join subSetor as sub
        on seto.idSetor = sub.fkSetor
        join tipoAlface as tipo
        on tipo.idTipoAlface = sub.fkTipoAlface;
        
desc sensor;
insert into subSetor values
	(null, 1, 1, 1, 1, 1),
	(null, 2, 1, 1, 1, 2),
	(null, 3, 1, 1, 1, 3),
	(null, 4, 2, 1, 2, 4),
	(null, 5, 2, 1, 2, 1),
	(null, 6, 2, 1, 2, 2),
	(null, 7, 3, 2, 3, 3),
	(null, 8, 3, 2, 3, 4),
	(null, 9, 3, 2, 3, 1),
	(null, 10, 4, 3, 4, 2),
	(null, 11, 4, 3, 4, 3),
	(null, 12, 4, 3, 4, 4),
	(null, 13, 5, 3, 5, 1),
	(null, 14, 5, 3, 5, 2),
	(null, 15, 5, 3, 5, 3),
	(null, 16, 6, 4, 6, 4),
	(null, 17, 6, 4, 6, 1),
	(null, 18, 6, 4, 6, 2),
	(null, 19, 7, 4, 7, 3),
	(null, 20, 7, 4, 7, 4),
	(null, 21, 7, 4, 7, 1),
	(null, 22, 8, 5, 8, 2),
	(null, 23, 8, 5, 8, 3),
	(null, 24, 8, 5, 8, 4);

desc sensor;
insert into sensor values 
	(null, null, 'ativo', 1),
	(null, null, 'manutencao', 2),
	(null, null, 'inativo', 3),
	(null, null, 'ativo', 4), 
	(null, null, 'ativo', 5),
	(null, null, 'ativo', 6),
	(null, null, 'inativo', 7),
	(null, null, 'ativo', 8),
	(null, null, 'ativo', 9),
	(null, null, 'manutencao', 10),
	(null, null, 'ativo', 11),
	(null, null, 'inativo', 12),
	(null, null, 'manutencao', 13),
	(null, null, 'ativo', 14);
 
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
