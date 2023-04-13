create database LeafProject;
use LeafProject;

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
estado varchar(45),
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
