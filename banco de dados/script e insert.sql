create database leafSolutions;
use leafSolutions;

create table empresa (
idEmpresa int primary key auto_increment,
razaoSocial varchar(45),
cnpj char(14),
emailEmpresa varchar(40), 
tokenPerm varchar(45)
);

create table endereco (
idEndereco int primary key auto_increment,
logradouro varchar(45),
CEP char(8),
cidade varchar(45),
estado char(2),
numero varchar(4),
complemento varchar(45),
fkEmpresa int,
constraint fkEnderecoEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa)
);

create table funcionario (
idFuncionario int primary key auto_increment,
nome varchar(45),
dtNasc date,
situacao varchar(10),
constraint chkSituacao 
	check (situacao in ('ativo', 'afastado', 'desligado')),
email varchar(40),
senha varchar(20),
cpf char(11),
fkEmpresa int,
constraint fkFuncionarioEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
fkEndereco int,
constraint fkFuncionarioEndereco foreign key (fkEndereco)
	references endereco (idEndereco)
);

create table telefone (
idTelefone int primary key auto_increment,
numero varchar(15),
tipo varchar (15),
fkEmpresa int,
constraint fkTelefoneEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa),
fkFuncionario int,
constraint fkTelefoneFuncionario foreign key (fkFuncionario)
	references funcionario (idFuncionario)
);

create table plantacao (
idPlantacao int primary key auto_increment,
espaco float,
fkEmpresa int,
constraint fkPlantacaoEmpresa foreign key (fkEmpresa)
	references empresa (idEmpresa)
);

create table setorPlantacao (
idSetorPlantacao int auto_increment,
nome varchar(45),
valorMin int,
valorMax int,
espaco float,
tipoPlanta varchar(20),
constraint chkTipoPlanta 
	check (tipoPlanta in ('americana', 'crespa', 'mimosa', 'roxa')),
fkPlantacao int,
constraint pkSetorPlantacao primary key (idSetorPlantacao, fkPlantacao)
);

create table sensor (
idSensor int primary key auto_increment,
modelo varchar(40),
situacao varchar(20),
constraint chkSituacaoSensor 
	check (situacao in ('ativo', 'manutencao', 'inativo')),
fkSetorPlantacao int,
constraint fkSensorSetorPlantacao foreign key (fkSetorPlantacao)
	references setorPlantacao (idSetorPlantacao)
);

create table leituraSensor (
idLeituraSensor int primary key auto_increment,
valor int,
dtLeitura datetime,
fkSensor int,
constraint fkLeituraSensorSensor foreign key (fkSensor)
	references sensor (idSensor)
);

insert into empresa values 
	(null, 'AlfaceTech', '48597652145369', 'alfacetech@email.com', null),
	(null, 'Alfacinho', '54876951234562', 'alfacinho@email.com', null),
	(null, 'Folhas Verdes', '12345678945612', 'folhasverdes@email.com', null),
	(null, 'Leaf Green', '21346523198746', 'leafgreen@email.com', null),
	(null, 'FolhasTech', '12451242369874', 'folhastech@email.com', null);


insert into endereco values 
	(null, 'Rua da Uva', '45678912', 'São Paulo', 'SP', '555', null, 2),
	(null, 'Avenida da Maçã', '36987451', 'Três Corações', 'MG', '1023', '7 andar', 1),
	(null, 'Rua da Jaca', '15421689', 'Caxias', 'MA', '819', 'A', 3),
	(null, 'Rua da Melancia', '78459636', 'Carueri', 'PE', '298', null, 4),
	(null, 'Avenida da Banana', '98656394', 'Fortaleza', 'CE', '5430', null, 5),
	(null, 'Rua do Mamão', '05213489', 'Santos', 'SP', '239', '2 andar', 3),
	(null, 'Avenida da Goiaba', '78459697', 'Niterói', 'RJ', '555', 'B', 4),
	(null, 'Avenida do Melão', '87459630', 'Ouro Preto', 'SP', '8745', null, null),
	(null, 'Avenida da Jabuticaba', '14523698', 'Florianópolis', 'SC', '325', 'A', null),
	(null, 'Avenida da Laranja', '78496735', 'Gramado', 'RS', '9765', null, null),
	(null, 'Avenida da Ameixa', '49312554', 'Salvador', 'BH', '452', 'F', null),
	(null, 'Avenida do Morango', '99999999', 'Maceió', 'AL', '121', '11 andar', null),
	(null, 'Avenida do Tomate', '88888888', 'Olinda', 'PE', '59', null, null),
	(null, 'Avenida da Berinjela', '77777777', 'Natal', 'RN', '963', 'D', null),
	(null, 'Avenida do Quiabo', '66666666', 'Aracaju', 'SE', '348', null, null);

insert into funcionario values 
	(null, 'Kauan', '2000-01-01', 'ativo', 'kauan@email.com', 'goiabinha123', '46597812369', 1, 8),
	(null, 'Isabel', '1998-02-05', 'ativo', 'isabel@email.com', 'qwerty', '87459621364', 2, 9),
	(null, 'Ismael', '1978-03-10', 'afastado', 'ismael@email.com', '12345678', '23654789164', 3, 10),
	(null, 'Israel', '1999-04-15', 'ativo', 'israel@email.com', '1234', '15426789305', 4, 11),
	(null, 'Cauã', '1989-05-20', 'desligado', 'caua@email.com', 'moranguinho321', '02154863975', 5, 12),
	(null, 'Matheus', '2002-06-25', 'ativo', 'matheus@email.com', 'senha', '36536321487', 2, 10),
	(null, 'Samuel', '2004-07-30', 'ativo', 'samuel@email.com', 'password', '89745632363', 3, 13),
	(null, 'Pedro', '1984-08-07', 'ativo', 'pedro@email.com', 'sorteveS2', '00213546879', 1, 15),
	(null, 'Lizandra', '1994-09-13', 'ativo', 'lizandra@email.com', 'floquinho', '58565954712', 5, 9),
	(null, 'Maria', '2001-10-19', 'desligado', 'maria@email.com', 'folhaamarela', '98654872563', 4, 14);
    
insert into telefone values 
	(null, '1185647123', 'Comercial', 1, null),
	(null, '1365686523', 'Comercial', 2, null),
	(null, '2096563214', 'Comercial', 3, null),
	(null, '5512145362', 'Comercial', 4, null),
	(null, '9975481263', 'Comercial', 5, null),
	(null, '1284532164', 'Comercial', 3, null),
    (null, '05998745632', 'Celular', null, 1),
	(null, '27912546325', 'Celular', null, 4),
	(null, '8786965742', 'Fixo', null, 5),
	(null, '4532654874', 'Fixo', null, 3),
	(null, '53999965325', 'Celular', null, 1),
	(null, '48978785452', 'Celular', null, 2),
	(null, '9485647123', 'Fixo', null, 7),
	(null, '35969636632', 'Celular', null, 10),
	(null, '12997845411', 'Celular', null, 3);
	
insert into plantacao values 
	(null, 4500.5, 1),
	(null, 10000.5, 2),
	(null, 3200.0, 3),
	(null, 2100.5, 4),
	(null, 1300.5, 5),
	(null, 3900.5, 3),
	(null, 4050.0, 2),
	(null, 1950.0, 5);
    
insert into setorPlantacao values 
	(null, 'Setor 1', 300, 900, 2500.5, 'Americana', 1),
	(null, 'Setor 2', 500, 700, 2000, 'Crespa', 1),
	(null, 'Setor 1', 450, 1000, 6000, 'Mimosa', 2),
	(null, 'Setor 2', 200, 800, 4000.5, 'Roxa', 2),
	(null, 'Setor 1', 300, 900, 2200, 'Americana', 3),
	(null, 'Setor 2', 500, 700, 1000, 'Crespa', 3),
	(null, 'Setor 1', 200, 800, 1050.25, 'Roxa', 4),
	(null, 'Setor 2', 450, 1000, 1050.25, 'Mimosa', 4),
	(null, 'Setor 1', 300, 900, 1300.5, 'Americana', 5),
	(null, 'Setor 1', 200, 800, 3900.5, 'Roxa', 6),
	(null, 'Setor 1', 500, 700, 2050, 'Crespa', 7),
	(null, 'Setor 2', 450, 1000, 2000, 'Mimosa', 7),
	(null, 'Setor 1', 300, 900, 1450, 'Americana', 8),
	(null, 'Setor 2', 500, 700, 500, 'Crespa', 8);
    
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