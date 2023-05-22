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
situacao varchar(10) not null,
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
cep char(9) not null,
logradouro varchar(80) not null,
bairro varchar(25) not null,
numero varchar(10) not null,
complemento varchar(30),
uf char(2),
cidade varchar(50)
);


desc endereco;
-- alter table endereco modify cep char(9);desc endereco;
-- alter table endereco modify bairro varchar(25);



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

select * from estufa;
select * from empresa;

create table setor (
idSetor int auto_increment,
valorMin int default 350,
valorMax int default 800,
fkEstufa int,
constraint fkSetorEstufa foreign key (fkEstufa)
	references estufa (idEstufa),
constraint pkSetor primary key (idSetor, fkEstufa)
);

create table tipoAlface (
idTipoAlface int primary key auto_increment,
especie varchar(40) not null
);



create table subSetor (
idSubSetor int auto_increment,
fkSetor int,
fkTipoAlface int,
constraint fkSubSetorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint fkSubSetorTipoAlface foreign key (fkTipoAlface)
	references tipoAlface (idTipoAlface),
constraint pkSubSetor primary key (idSubSetor, fkSetor, fkTipoAlface)
);

create table sensor (
idSensor int auto_increment,
modelo varchar(5) default 'ldr',
situacao varchar(10) not null,
constraint chkSituacaoSensor 
	check (situacao in ('ativo', 'manutencao', 'inativo')),
fkSubSetor int,
constraint fkSensorSubSetor foreign key (fkSubSetor)
	references subSetor (idSubSetor),
constraint pkSensor primary key (idSensor, fkSubSetor)
);

create table Alerta(
idAlerta int primary key auto_increment,
tipo varchar(45)
constraint cnkAlerta check (tipo in ('critico', 'preocupante', 'adequado')) 
);


create table leituraSensor (
idLeituraSensor int auto_increment,
valor int not null,
dtLeitura datetime default current_timestamp not null,
fkSensor int,
fkAlerta int,
constraint fkLeituraSensorSensor foreign key (fkSensor)
	references Sensor (idSensor),
constraint fkAlerta foreign key (fkAlerta)
	references alerta (idAlerta),
constraint pkSensor primary key (idLeituraSensor, fkSensor, fkAlerta)
);


insert into empresa values 
	(null, '21346523198746', 'Leaf Green', 'leafgreen@email.com', '1234567'),
	(null, '12451242369874', 'FolhasTech', 'folhastech@email.com', '87654321');

insert into usuario values 
	(null, 'Isabel', 'Oliveira', 'desligado', 'isabel@email.com', 'qwerty', 2),
	(null, 'Ismael', 'Vieria', 'afastado', 'ismael@email.com', '12345678', 1),
	(null, 'Israel', 'Augusto', 'ativo', 'israel@email.com', '1234', 1),
	(null, 'Lizandra', 'Militão', 'desligado', 'lizandra@email.com', 'wasd', 2);
    
insert into tipoTelefone values
	(null, 'Comercial'),
	(null
    , 'Residencial'),
	(null, 'Fixo'),
	(null, 'Celular');

insert into telefone values 
	(null, '1185647123', 1, 2),
	(null, '1365686523', 2, 1),
	(null, '2096563214', 1, 1),
	(null, '5512145362', 1, 3),
	(null, '8786965742', 2, 4);

insert into endereco values 
	(null, '45678-912', 'Rua da Uva', 'Legumes', '555', null,  'SP', 'São Paulo'),
	(null, '36987-451', 'Avenida da Maçã', 'Legumes', '1023', '7 andar', 'MG', 'Três Corações'),
	(null, '15421-689', 'Rua da Jaca', 'Frutas', '819', 'A', 'MA', 'Caxias'),
	(null, '78459-636', 'Rua da Melancia', 'Verduras', '298', null, 'PE', 'Carueri');

insert into estufa values
(null, 'Leaf estufa', 500, 1, 1);

insert into estufa values 
	(null, 'Guimarães', 300, 1, 1),
	(null, 'Paulista', 400, 1, 4),
    (null, 'Antonio', 300, 1, 3),
	(null, 'Leaf Life', 480, 2, 2);
   
insert into setor values 
	(null, null, null, 1),
	(null, null, null, 1),
	(null, null, null, 2),
	(null, null, null, 2),
	(null, null, null, 3),
	(null, null, null, 3),
	(null, null, null, 4);

insert into tipoAlface values
	(null, 'Americana'),
	(null, 'Mimosa'),
	(null, 'Crespa'),
	(null, 'Roxa');
    
        
insert into subSetor values
	(null, 7, 1),
	(null, 6, 2),
	(null, 5, 3),
	(null, 4, 3),
	(null, 3, 2),
	(null, 2, 1),
	(null, 1, 2),
	(null, 4, 3),
	(null, 4, 1);


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
	(null, null, 'manutencao', 8),
	(null, null, 'ativo', 7);
    
    insert into alerta values 
    (null, 'critico'),
    (null, 'preocupante'),
    (null, 'adequado');
    
 
insert into leituraSensor values 
	(null, 500, '2023-04-01 00:00:00', 1, 1),
	(null, 600, '2023-04-02 00:00:00', 2, 1),
	(null, 700, '2023-04-03 00:00:00', 3, 2),
	(null, 800, '2023-04-04 00:00:00', 4, 3),
	(null, 900, '2023-04-05 00:00:00', 5, 2),
	(null, 500, '2023-04-05 12:00:00', 6, 1),
	(null, 450, default, 7, 3),
	(null, 700, '2023-04-08 00:00:00', 8, 2),
	(null, 350, '2023-04-09 00:00:00', 9, 1),
	(null, 650, '2023-04-10 15:00:00', 10, 2),
	(null, 250, default, 11, 3),
	(null, 750, '2023-04-11 12:00:00', 1, 1),
	(null, 900, '2023-04-12 00:00:00', 2, 1),
	(null, 1000, default, 3, 1),
	(null, 300, '2023-04-03 00:00:00', 4, 2),
	(null, 800, '2023-04-04 00:00:00', 5, 2),
	(null, 800, '2023-04-04 00:00:00', 6, 3),
	(null, 800, '2023-04-04 00:00:00', 7, 3),
	(null, 800, '2023-04-04 00:00:00', 8, 2),
	(null, 800, '2023-04-04 00:00:00', 9, 2),
	(null, 800, default, 10, 1),
	(null, 400, '2023-04-06 19:00:00', 11, 1),
	(null, 900, '2023-04-07 00:00:00', 1, 1),
	(null, 750, '2023-04-08 00:00:00', 2, 3);
	
-- media de luinosidade das estufas
select avg(valor)
	from empresa join estufa
    on idEmpresa = fkEmpresa
    join setor 
    on idEstufa = fkEstufa 
	join subSetor 
    on idSetor = fkSetor 
    join sensor 
    on idSubSetor = fkSubSetor
    join leituraSensor
    on idSensor = fkSensor
		where idEmpresa = 4;
        
        -