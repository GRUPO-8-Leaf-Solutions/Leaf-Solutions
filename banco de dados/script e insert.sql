create database leafSolutions;
use leafSolutions;

create table empresa (
idEmpresa int primary key auto_increment,
CNPJ char(14) not null,
razaoSocial varchar(45) not null,
email varchar(50) not null,  
tokenPerm varchar(8)
);

create table endereco (
idEndereco int auto_increment,
CEP char(8) not null,
logradouro varchar(80) not null,
numero varchar(5) not null,
complemento varchar(30),
estado char(2),
cidade varchar(50),
fkEmpresa int,
constraint fkEnderecoEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint pkEndereco primary key (idEndereco, fkEmpresa)
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
constraint fkTelefoneTipo foreign key (fkTipoTelefone)
	references tipoTelefone (idTipoTelefone),
constraint pkTelefone primary key (idTelefone, fkEmpresa, fkTipoTelefone)
);

create table estufa (
idEstufa int auto_increment,
nome varchar(45),
area int not null,
fkEmpresa int,
constraint fkEstufaEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
constraint pkEstufa primary key (idEstufa, fkEmpresa)
);

create table setor (
idSetor int auto_increment,
tipo varchar(20) not null,
valorMin int,
valorMax int,
fkEstufa int,
constraint chkTipo 
	check (tipo in ('americana', 'crespa', 'mimosa', 'roxa')),
constraint pkSetorEstufa primary key (idSetor, fkEstufa)
);

create table sensor (
idSensor int auto_increment,
modelo varchar(5),
situacao varchar(10),
fkSetor int,
constraint chkSituacaoSensor 
	check (situacao in ('ativo', 'manutencao', 'inativo')),
constraint fkSensorSetor foreign key (fkSetor)
	references setor (idSetor),
constraint pkSensor primary key (idSensor, fkSetor)
);

create table leituraSensor (
idLeituraSensor int auto_increment,
valor int,
dtLeitura datetime default current_timestamp,
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

insert into endereco values 
	(null, '45678912', 'Rua da Uva', '555', null,  'SP', 'São Paulo',  1),
	(null, '36987451', 'Avenida da Maçã', '1023', '7 andar', 'MG', 'Três Corações', 1),
	(null, '15421689', 'Rua da Jaca', '819', 'A', 'MA', 'Caxias', 2),
	(null, '78459636', 'Rua da Melancia', '298', null, 'PE', 'Carueri', 3),
	(null, '98656394', 'Avenida da Banana', '5430', null, 'CE', 'Fortaleza', 3),
	(null, '05213489', 'Rua do Mamão', '239', '2 andar', 'SP', 'Santos', 3),
	(null, '78459697', 'Avenida da Goiaba', '555', 'B', 'RJ', 'Niterói', 4),
	(null, '87459630', 'Avenida do Melão', '8745', null, 'SP', 'Ouro Preto', 4),
	(null, '14523698', 'Avenida da Jabuticaba', '325', 'A', 'SC', 'Florianópolis', 5);
    
    /* + enderecos
	(null, 'Avenida da Laranja', '78496735', 'Gramado', 'RS', '9765', null, null),
	(null, 'Avenida da Ameixa', '49312554', 'Salvador', 'BH', '452', 'F', null),
	(null, 'Avenida do Morango', '99999999', 'Maceió', 'AL', '121', '11 andar', null),
	(null, 'Avenida do Tomate', '88888888', 'Olinda', 'PE', '59', null, null),
	(null, 'Avenida da Berinjela', '77777777', 'Natal', 'RN', '963', 'D', null),
	(null, 'Avenida do Quiabo', '66666666', 'Aracaju', 'SE', '348', null, null);
    */

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
	(null, '9975481263', 5, 1),
	(null, '1284532164', 6, 3),
    (null, '05998745632', 7, 3),
	(null, '27912546325', 8, 1),
	(null, '8786965742', 3, 1);
    
    /* + telefones
	(null, '4532654874', 'Fixo', null, 3),
	(null, '53999965325', 'Celular', null, 1),
	(null, '48978785452', 'Celular', null, 2),
	(null, '9485647123', 'Fixo', null, 7),
	(null, '35969636632', 'Celular', null, 10),
	(null, '12997845411', 'Celular', null, 3);
	*/

insert into estufa values 
	(null, 'Estufa da esquerda', 300, 1),
	(null, 'Estufa da direita', 300, 1),
	(null, 'Estufa central', 500, 2),
	(null, 'Estufa superior', 400, 3),
	(null, 'Estufa inferior', 400, 3),
	(null, 'Estufa maior', 300, 4),
	(null, 'Estufa menor', 200, 4),
	(null, 'Estufa central', 480, 5);

 /* falta ver isso aqui*/
insert into setor values 
	(null, 'Americana', 300, 900, 2500.5, 1),
	(null, 'Crespa', 700, 2000, 'Crespa', 1),
	(null, 'Mimosa', 450, 1000, 6000, 'Mimosa', 2),
	(null, 'Roxa', 200, 800, 4000.5, 'Roxa', 2),
	(null, 'Americana', 300, 900, 2200, 'Americana', 3),
	(null, 'Crespa', 500, 700, 1000, 'Crespa', 3),
	(null, 'Roxa', 200, 800, 1050.25, 'Roxa', 4),
	(null, 'Mimosa', 450, 1000, 1050.25, 'Mimosa', 4),
	(null, 'Americana', 300, 900, 1300.5, 'Americana', 5),
	(null, 'Roxa', 200, 800, 3900.5, 'Roxa', 6),
	(null, 'Crespa', 500, 700, 2050, 'Crespa', 7),
	(null, 'Mimosa', 450, 1000, 2000, 'Mimosa', 7),
	(null, 'Americana', 300, 900, 1450, 'Americana', 8),
	(null, 'Crespa', 500, 700, 500, 'Crespa', 8);
    
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
	(null, 450, '2023-04-07 00:00:00', 5),
	(null, 700, '2023-04-08 00:00:00', 6),
	(null, 350, '2023-04-09 00:00:00', 7),
	(null, 650, '2023-04-10 15:00:00', 8),
	(null, 250, '2023-04-11 00:00:00', 9),
	(null, 750, '2023-04-11 12:00:00', 9),
	(null, 900, '2023-04-12 00:00:00', 9),
	(null, 1000, '2023-04-02 00:00:00', 10),
	(null, 300, '2023-04-03 00:00:00', 10),
	(null, 800, '2023-04-04 00:00:00', 11),
	(null, 800, '2023-04-05 12:00:00', 11),
	(null, 400, '2023-04-06 19:00:00', 12),
	(null, 900, '2023-04-07 00:00:00', 13),
	(null, 750, '2023-04-08 00:00:00', 14);