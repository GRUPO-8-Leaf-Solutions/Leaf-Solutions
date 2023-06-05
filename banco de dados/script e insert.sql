drop database leafsolutions;
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

create table alerta(
idAlerta int primary key auto_increment,
tipo varchar(45)
constraint cnkAlerta check (tipo in ('critico', 'preocupante', 'adequado')) 
);

create table leituraSensor (
idLeituraSensor int auto_increment,
valor int not null,
leituraDate DATE,
leituraTime TIME,
fkSensor int,
fkAlerta int,
constraint fkLeituraSensorSensor foreign key (fkSensor)
	references Sensor (idSensor),
constraint fkAlerta foreign key (fkAlerta)
	references alerta (idAlerta),
constraint pkSensor primary key (idLeituraSensor, fkSensor, fkAlerta)
);


-- INSERTS MOCADOS
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
	(null, 'Residencial'),
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
	(null, 'aiqnseioqmacarraocomsalsichapaocomlinguica', 500, 1, 1),
	(null, '1am CHAMA O BOY', 400, 1, 2),
    (null, 'leafOG', 300, 1, 3),
	(null, 'manga', 480, 1, 2),
    (null, 'valeuTmj', 480, 1, 2);
    
    desc estufa;
    
    
   
insert into setor values 
	(null, null, null, 1),
	(null, null, null, 2),
	(null, null, null, 2),
	(null, null, null, 3),
	(null, null, null, 3),
    (null, null, null, 3),
	(null, null, null, 4),
	(null, null, null, 4),
	(null, null, null, 4),
	(null, null, null, 4),
    (null, null, null, 5),
	(null, null, null, 5),
	(null, null, null, 5),
	(null, null, null, 5),
	(null, null, null, 5);
	

	desc setor;

insert into tipoAlface values
	(null, 'Americana'),
	(null, 'Mimosa'),
	(null, 'Crespa'),
	(null, 'Roxa');
    
insert into subSetor values
	(null, 1, 1),
    (null, 1, 1),
	(null, 2, 2),
	(null, 2, 3),
    (null, 2, 3),
	(null, 3, 1),
	(null, 3, 2),
    (null, 4, 1),
	(null, 4, 2),
	(null, 4, 3),
	(null, 5, 2),
    (null, 5, 2),
    (null, 6, 3),
	(null, 6, 2),
    (null, 6, 2),
    (null, 7, 3),
	(null, 7, 2),
    (null, 8, 2),
    (null, 8, 3),
	(null, 8, 2),
    (null, 9, 3),
	(null, 9, 2),
    (null, 10, 2),
    (null, 10, 3),
	(null, 10, 2),
    (null, 11, 3),
	(null, 11, 2),
    (null, 12, 2),
    (null, 12, 3),
	(null, 12, 2),
    (null, 13, 3),
	(null, 13, 2),
    (null, 14, 2),
    (null, 14, 3),
	(null, 14, 2),
    (null, 15, 3),
	(null, 15, 2)
	;
    
    desc subSetor;
    
insert into sensor values 
	(null, null, 'ativo', 1),
	(null, null, 'ativo', 1), 
	(null, null, 'ativo', 2),
	(null, null, 'ativo', 2),
	(null, null, 'ativo', 3),
	(null, null, 'ativo', 3),
    (null, null, 'ativo', 4),
	(null, null, 'ativo', 4),
	(null, null, 'ativo', 5),
	(null, null, 'ativo', 5),
    (null, null, 'ativo', 6),
	(null, null, 'ativo', 6), 
	(null, null, 'ativo', 7),
	(null, null, 'ativo', 7),
	(null, null, 'ativo', 8),
	(null, null, 'ativo', 8),
    (null, null, 'ativo', 9),
	(null, null, 'ativo', 9),
	(null, null, 'ativo', 10),
	(null, null, 'ativo', 10),
    (null, null, 'ativo', 11),
	(null, null, 'ativo', 11),
    (null, null, 'ativo', 12),
	(null, null, 'ativo', 12),
    (null, null, 'ativo', 13),
	(null, null, 'ativo', 13),
    (null, null, 'ativo', 14),
	(null, null, 'ativo', 14),
    (null, null, 'ativo', 15),
	(null, null, 'ativo', 15),
    (null, null, 'ativo', 16),
	(null, null, 'ativo', 16),
    (null, null, 'ativo', 17),
	(null, null, 'ativo', 17),
    (null, null, 'ativo', 18),
	(null, null, 'ativo', 18),
    (null, null, 'ativo', 19),
	(null, null, 'ativo', 19),
    (null, null, 'ativo', 20),
	(null, null, 'ativo', 20),
    (null, null, 'ativo', 21),
	(null, null, 'ativo', 21),
    (null, null, 'ativo', 22),
	(null, null, 'ativo', 22),
    (null, null, 'ativo', 23),
	(null, null, 'ativo', 23),
    (null, null, 'ativo', 24),
	(null, null, 'ativo', 24),
    (null, null, 'ativo', 25),
	(null, null, 'ativo', 25),
    (null, null, 'ativo', 26),
    (null, null, 'ativo', 26),
	(null, null, 'ativo', 27),
    (null, null, 'ativo', 27),
	(null, null, 'ativo', 28),
    (null, null, 'ativo', 28),
	(null, null, 'ativo', 29),
    (null, null, 'ativo', 29),
	(null, null, 'ativo', 30),
    (null, null, 'ativo', 30),
	(null, null, 'ativo', 31),
    (null, null, 'ativo', 31),
    (null, null, 'ativo', 32),
    (null, null, 'ativo', 32),
	(null, null, 'ativo', 33),
    (null, null, 'ativo', 33),
    (null, null, 'ativo', 34),
    (null, null, 'ativo', 34),
    (null, null, 'ativo', 35),
    (null, null, 'inativo', 35)
    ;
        
        desc sensor;
        select * from sensor;
        
insert into alerta values 
    (null, 'critico'),
    (null, 'preocupante'),
    (null, 'adequado');
    
    
    desc leituraSensor;
insert into leituraSensor values 
	(null, 400, CURDATE(), CURTIME(), 1, 1),
	(null, 500, CURDATE(), CURTIME(), 2, 1),
	(null, 600, CURDATE(), CURTIME(), 3, 2),
	(null, 700, CURDATE(), CURTIME(), 4, 2),
	(null, 800, CURDATE(), CURTIME(), 5, 1),
	(null, 400, CURDATE(), CURTIME(), 6, 1),
	(null, 550, CURDATE(), CURTIME(), 7, 2),
	(null, 600, CURDATE(), CURTIME(), 8, 2),
	(null, 450, CURDATE(), CURTIME(), 9, 1),
	(null, 550, CURDATE(), CURTIME(), 1, 1),
	(null, 150, CURDATE(), CURTIME(), 2, 2),
	(null, 650, CURDATE(), CURTIME(), 3, 2),
	(null, 800, CURDATE(), CURTIME(), 4, 1),
	(null, 500, CURDATE(), CURTIME(), 5, 1),
	(null, 100, CURDATE(), CURTIME(), 6, 3),
	(null, 50, CURDATE(), CURTIME(), 7, 3),
	(null, 400, CURDATE(), CURTIME(), 8, 3),
	(null, 900, CURDATE(), CURTIME(), 9, 3),
	(null, 900, CURDATE(), CURTIME(), 1, 3),
	(null, 800, CURDATE(), CURTIME(), 2, 3),
	(null, 700, CURDATE(), CURTIME(), 3, 3),
	(null, 600, CURDATE(), CURTIME(), 4, 3);

insert into leituraSensor values 
    (null, 289, 3, 2, CURDATE(), CURTIME());
insert into leituraSensor values 
    (null, 909, 1, 1, CURDATE(), CURTIME());
    
truncate leituraSensor;
desc leituraSensor;

INSERT INTO leituraSensor 
VALUES 
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 1, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 2, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 3, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 4, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 5, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 6, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 7, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 8, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 9, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 10, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 11, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 12, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 13, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 14, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 15, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 16, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 17, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 18, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 19, 2),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 20, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 21, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 22, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 23, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 24, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 25, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 26, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 27, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 28, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 29, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 30, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 31, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 32, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 33, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 34, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 35, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 36, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 37, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 38, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 39, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 40, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 41, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 42, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 43, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 44, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 45, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 46, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 47, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 48, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 49, 1),
    (null, FLOOR(RAND() * (955 - 100 + 1) + 100), CURDATE(), CURTIME(), 50, 1),
    (null, 527, CURDATE(), CURTIME(), 51, 3),
    (null, 527, CURDATE(), CURTIME(), 52, 3),
    (null, 527, CURDATE(), CURTIME(), 53, 3),
    (null, 527, CURDATE(), CURTIME(), 54, 3),
    (null, 527, CURDATE(), CURTIME(), 55, 3),
    (null, 527, CURDATE(), CURTIME(), 56, 3),
    (null, 527, CURDATE(), CURTIME(), 57, 3),
    (null, 527, CURDATE(), CURTIME(), 58, 3),
    (null, 527, CURDATE(), CURTIME(), 59, 3),
    (null, 527, CURDATE(), CURTIME(), 60, 3),
    (null, 527, CURDATE(), CURTIME(), 61, 3),
    (null, 527, CURDATE(), CURTIME(), 62, 3),
    (null, 527, CURDATE(), CURTIME(), 63, 3),
    (null, 527, CURDATE(), CURTIME(), 64, 3),
    (null, 527, CURDATE(), CURTIME(), 65, 3),
    (null, 527, CURDATE(), CURTIME(), 66, 3),
    (null, 527, CURDATE(), CURTIME(), 67, 3),
    (null, 527, CURDATE(), CURTIME(), 68, 3),
    (null, 527, CURDATE(), CURTIME(), 69, 3),
    (null, 527, CURDATE(), CURTIME(), 70, 3);

select * from leituraSensor ;
select * from sensor;
select * from subSetor;
select * from setor;
select * from subSetor;

select idSubSetor subSetor from subSetor join setor on idSetor = fkSetor where idSetor = 1;
select idSensor Sensor from subSetor join sensor on idSubSetor = fkSubSetor where idSubSetor = 1;

SELECT 
MIN(leituraSensor.valor) AS valor_minimo,
estufa.nome,
setor.idSetor,
sensor.idSensor,
TIME(leituraSensor.dtLeitura) AS hora_leitura
	FROM leituraSensor JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
	JOIN subsetor ON sensor.fkSubSetor = subSetor.idSubsetor
	JOIN setor ON subSetor.fkSetor = setor.idSetor
	JOIN estufa ON setor.fkEstufa = estufa.idEstufa
	JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
		WHERE empresa.idEmpresa = 1
		AND leituraSensor.dtLeitura = '2023-05-28 21:24';


SELECT count(idSubSetor) as totalSubSetores 
    from empresa
    left join estufa on empresa.idEmpresa = estufa.fkEmpresa
    left join setor on estufa.idEstufa = setor.fkEstufa
    left join subSetor on setor.idSetor = subSetor.fkSetor
    where idEmpresa = 1
    group by idSetor;



SELECT e.estufa_id, s.setor_id, ss.subsetor_id, ls.sensor_id, v.estado, ls.data_leitura, ls.hora_leitura
FROM estufa e
JOIN setor s ON s.estufa_id = e.estufa_id
JOIN subsetor ss ON ss.setor_id = s.setor_id
JOIN (
    SELECT sensor_id, MAX(data_leitura) AS ultima_leitura
    FROM leituraSensor
    GROUP BY sensor_id
) ul ON ul.sensor_id = ss.sensor_id
JOIN leituraSensor ls ON ls.sensor_id = ul.sensor_id AND ls.data_leitura = ul.ultima_leitura
JOIN valores v ON ls.valor = v.valor
ORDER BY e.estufa_id, s.setor_id, ss.subsetor_id;

SELECT s.idSetor, a.tipo AS estado, COUNT(*) AS quantidade
FROM estufa e
    join empresa ON e.fkEmpresa = empresa.idEmpresa
    JOIN setor s ON s.fkEstufa = e.idEstufa
    JOIN subSetor ss ON ss.fkSetor = s.idSetor
    JOIN sensor se ON se.fkSubSetor = ss.idSubSetor
    JOIN leituraSensor ls ON ls.fkSensor = se.idSensor
JOIN (
    SELECT MAX(idLeituraSensor) AS ultima_leitura, fkSensor
    FROM leituraSensor
    GROUP BY fkSensor
) ul ON ul.fkSensor = ls.fkSensor AND ul.ultima_leitura = ls.idLeituraSensor
JOIN alerta a ON a.idAlerta = ls.fkAlerta
where empresa.idEmpresa = 1 and ls.leituraDate = curdate()
GROUP BY s.idSetor, a.tipo
ORDER BY s.idSetor;


desc leiturasensor;

select nomeEstufa
    from(
SELECT
    estufa.nome nomeEstufa,
    idSetor setor,
    idSubSetor subSetor,
    idSensor Sensor,
    valor Indice,
    leituraTime Horario
        FROM estufa JOIN setor 
        ON estufa.idEstufa = setor.fkEstufa
        JOIN subSetor 
        ON setor.idSetor = subSetor.fkSetor
        JOIN sensor 
        ON subSetor.idSubSetor = sensor.fkSubSetor
        JOIN leituraSensor 
        ON sensor.idSensor = leituraSensor.fkSensor
           WHERE fkEmpresa = 1 && leituraDate = curDate()
           group by sensor);
           

  select 
	count(a.Alerta)
    from(
			select
			estufa.nome Estufa,
			fkAlerta Alerta,
			count(fkAlerta) qtde
			from estufa 
			join setor on idEstufa = fkEstufa 
			join subSetor on idSetor = fkSetor 
			join sensor on idSubSetor = fkSubSetor
			join leituraSensor on idSensor = fkSensor
            where fkEmpresa = 1 && leituraDate = curDate()
            group by estufa.nome, fkAlerta) as a 
            group by Alerta;


-- select de coletar menor indice
/*
SELECT 
MAX(leituraSensor.valor) AS valor_maximo,
estufa.nome AS nome_estufa,
setor.idSetor,
sensor.idSensor,
leituraSensor.leituraTime AS horaLeitura
	FROM leituraSensor
	JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
	JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
	JOIN setor ON subsetor.fkSetor = setor.idSetor
	JOIN estufa ON setor.fkEstufa = estufa.idEstufa
	JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
		WHERE empresa.idEmpresa = 1 AND leituraSensor.leituraDate = CURDATE()
			GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime
			ORDER BY valor_maximo DESC
			LIMIT 1;
*/

-- OUTRO SELECT
select * from leituraSensor
	;
SELECT 
estufa.idEstufa, 
estufa.nome AS 'nome_estufa', 
ROUND(AVG(leituraSensor.valor),0) AS 'media_Valor', 
leituraSensor.leituraTime
        FROM empresa
        LEFT JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
        LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
        LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
        LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
        LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor WHERE idEmpresa = 1 && leituraDate = curDate() 
        GROUP BY empresa.idEmpresa, estufa.nome, leituraSensor.leituraTime, leituraSensor.idLeituraSensor, estufa.idEstufa
        order by leituraSensor.idLeituraSensor ;

select * from leituraSensor
JOIN setor ON estufa.idEstufa = setor.fkEstufa
	JOIN subSetor ON setor.idSetor = subSetor.fkSetor
	JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
	JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor 
	where idEstufa = 1;

truncate leituraSensor;
select * from leituraSensor;

SELECT 
idEstufa ID,
estufa.nome Estufa,
count(leituraSensor.valor) Valor
	FROM estufa
	JOIN setor ON estufa.idEstufa = setor.fkEstufa
	JOIN subSetor ON setor.idSetor = subSetor.fkSetor
	JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
	JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor 
	WHERE estufa.fkEmpresa = 1 
    group by idEstufa, estufa.nome;
        
     
SELECT
    estufa.nome AS nomeEstufa,
    setor.idSetor,
    subSetor.idSubSetor,
    sensor.idSensor,
    leituraSensor.valor AS indiceAtual,
    leituraSensor.leituraTime AS horarioLeitura
FROM
    estufa
    JOIN setor ON estufa.idEstufa = setor.fkEstufa
    JOIN subSetor ON setor.idSetor = subSetor.fkSetor
    JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
    JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
WHERE
    estufa.fkEmpresa = 1
    AND leituraSensor.leituraTime = (
        SELECT MAX(leituraTime)
        FROM leituraSensor
        WHERE fkSensor = sensor.idSensor
        AND DATE(leituraDate) = CURDATE()
    );
     
     
     
     
-- OUTRO SELECT
/*
SELECT COUNT(leituraSensor.idLeituraSensor) AS total_leituras, estufa.nome AS nome_estufa
FROM leituraSensor
LEFT JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
LEFT JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
LEFT JOIN setor ON subsetor.fkSetor = setor.idSetor
LEFT JOIN estufa ON setor.fkEstufa = estufa.idEstufa
LEFT JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
WHERE leituraSensor.leituraDate = CURDATE() AND empresa.idEmpresa = 1 AND (leituraSensor.valor < 500 OR leituraSensor.valor > 600)
GROUP BY estufa.nome
ORDER BY COUNT(leituraSensor.idLeituraSensor) DESC;
*/

truncate leituraSensor;

SELECT
    estufa.nome AS nomeEstufa,
    setor.idSetor,
    subSetor.idSubSetor,
    sensor.idSensor,
    leituraSensor.valor AS indiceAtual,
    leituraSensor.leituraTime AS horarioLeitura
    FROM estufa
    JOIN setor ON estufa.idEstufa = setor.fkEstufa
    JOIN subSetor ON setor.idSetor = subSetor.fkSetor
    JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
    JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
    JOIN (
        SELECT
            fkSensor,
            MAX(leituraTime)
				FROM leituraSensor
				GROUP BY fkSensor) as lizsandra 
    WHERE estufa.fkEmpresa = 1;



          SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', leituraSensor.leituraTime AS 'ultima_leitura'
          FROM estufa
          JOIN setor ON estufa.idEstufa = setor.fkEstufa
          JOIN subSetor ON setor.idSetor = subSetor.fkSetor
          JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
          JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor AND DATE(leituraSensor.leituraDate) = CURDATE()
          WHERE estufa.fkEmpresa = 1
          GROUP BY estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
          ORDER BY ultima_leitura DESC limit 5;
-- OUTRO SELECT
/*
SELECT leituraSensor.*, estufa.nome FROM leituraSensor
JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
JOIN subSetor ON sensor.fkSubSetor = subSetor.idSubSetor
JOIN setor ON subSetor.fkSetor = setor.idSetor
JOIN estufa ON setor.fkEstufa = estufa.idEstufa;
*/

-- media de luinosidade das estufas
/*
select avg(valor)
	from empresa join estufaon idEmpresa = fkEmpresa
    join setor on idEstufa = fkEstufa 
	join subSetor on idSetor = fkSetor 
    join sensor on idSubSetor = fkSubSetor
    join leituraSensoron idSensor = fkSensor
		where idEmpresa = 4;
*/
    
-- select kaua e trindas
/*
SELECT 
estufa.nome AS 'nome estufa',
ROUND(AVG(leituraSensor.valor), 0) AS 'media Valor',
leituraSensor.leituraDate AS momento_grafico
	FROM empresa
	LEFT JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
	LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
	LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
	LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
	LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
		WHERE empresa.idEmpresa = 1
		GROUP BY empresa.idEmpresa, estufa.nome, leituraSensor.leituraDate
		ORDER BY leituraSensor.idLeituraSensor
		LIMIT 7;
*/

-- OUTRO SELECT
/*
SELECT
    estufa.nome AS nomeEstufa,
    setor.idSetor,
    subSetor.idSubSetor,
    leituraSensor.valor AS indiceAtual,
    leituraTime as horarioLeitura
        FROM estufa JOIN setor 
        ON estufa.idEstufa = setor.fkEstufa
        JOIN subSetor 
        ON setor.idSetor = subSetor.fkSetor
        JOIN sensor 
        ON subSetor.idSubSetor = sensor.fkSubSetor
        JOIN leituraSensor 
        ON sensor.idSensor = leituraSensor.fkSensor
           WHERE fkEmpresa = 1 && leituraDate = curDate();	
*/
     
-- OUTRO SELECT
/*
select 
coalesce(avg(leituraSensor.valor), 0), 
leituraSensor.leituraTime 
	from leituraSensor 
	group by leituraTime limit 5;
*/
           
-- SALADA
/*
SELECT 
estufa.nome AS 'nome_estufa', 
leituraSensor.leituraTime AS 'ultima_leitura'
	FROM estufa
	LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
	LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
	LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
	LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
	left join (select coalesce(avg(leituraSensor.valor), 0) as media_leitura, 
    leituraSensor.leituraTime from leituraSensor group by leituraSensor.leituraTime limit 5) as mediasValores
	on leituraSensor.idLeituraSensor = mediasValores.idLeituraSensor
            WHERE estufa.fkEmpresa = 1
            GROUP BY estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
            ORDER BY ultima_leitura DESC;
            
select 
estufa.nome as 'nome_estufa', leituraSensor.leituraTime
	from empresa
	left join estufa on estufa.fkEmpresa = empresa.idEmpresa
	left join setor on setor.fkEstufa = estufa.idEstufa
	left join subSetor on subSetor.fkSetor = setor.idSetor
	left join sensor on sensor.fkSubSetor = subSetor.idSubSetor
	left join(select fkSensor, coalesce(round(avg(leituraSensor.valor), 0), 0) as "media_valor" 
	
    from leituraSensor
	group by fkSensor
	) as ultimaLeitura ON sensor.idSensor = ultimaLeitura.fkSensor 
	left join leituraSensor on ultimaLeitura.fkSensor AND ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
	group by estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
	order by leituraSensor.leituraTime DESC;
                
            SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', leituraSensor.leituraTime AS 'ultima_leitura'
                FROM estufa
                LEFT JOIN setor ON estufa.idEstufa = setor.fkEstufa
                LEFT JOIN subSetor ON setor.idSetor = subSetor.fkSetor
                LEFT JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
                LEFT JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor 
                WHERE estufa.fkEmpresa = 1 AND leituraSensor.leituraDate = curDate()
                GROUP BY estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
                ORDER BY ultima_leitura DESC;
*/
			
-- select nao sei oq
/*
SELECT 
estufa.nome AS nome_estufa, 
COUNT(alerta.idAlerta) AS total_alertas
FROM estufa JOIN setor 
ON estufa.idEstufa = setor.fkEstufa
JOIN subsetor 
ON setor.idSetor = subsetor.fkSetor
JOIN sensor 
ON subsetor.idSubsetor = sensor.fkSubSetor
JOIN leituraSensor
ON sensor.idSensor = leituraSensor.fkSensor
JOIN alerta 
ON leituraSensor.idLeituraSensor = alerta.fkLeituraSensor
WHERE DATE(leituraSensor.dtLeitura) = CURDATE()
GROUP BY estufa.idEstufa, estufa.nome
ORDER BY total_alertas DESC
LIMIT 3;
*/

-- INSERT DE MALUCO
/*
insert into estufa values
(null, 'Leaf estufa', 500, 1, 1);

insert into estufa values
(null, 'socoro jesus', 500, 1, 1);
*/

-- SELECT CONTAR SETORES 
/*
SELECT count(idSetor) as totalSetores, 
		estufa.idEstufa 
    from empresa
    left join estufa on empresa.idEmpresa = estufa.fkEmpresa
    left join setor on estufa.idEstufa = setor.fkEstufa
    where idEmpresa = 1
    group by idEstufa;
*/
    
-- SELECT NAO SEI OQ
/*
 select min(leituraSensor.valor), estufa.nomeEstufa, setor.id, sensor.id FROM leitura sensor
join sensor on leituraSensor.fkSensor = sensor.idSensor
join subsetor on sensor.fkSubSetor = subSetor.idSubsetor
join setor on subSetor.fkSetor = setor.idSetor
join estufa on setor.fkEstufa = estufa.idEstufa
join empresa on estufa.fkEmpresa = empresa.idEmpresa
WHERE empresa.idEmpresa = 1 AND leituraSensor.dtLeitura = "2023-05-28 21:24";
*/


SELECT Min(leituraSensor.valor) AS valor_minimo,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = 1 AND leituraSensor.leituraDate = CURDATE() AND sensor.idSensor = 1 AND subsetor.idSubsetor = 1 AND estufa.idEstufa = 1 and setor.idSetor = 1
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_minimo;
    
    SELECT Min(leituraSensor.valor) AS valor_minimo,
    leituraSensor.leituraTime AS horaLeitura
    FROM leituraSensor
    JOIN sensor ON leituraSensor.fkSensor = sensor.idSensor
    JOIN subsetor ON sensor.fkSubSetor = subsetor.idSubSetor
    JOIN setor ON subsetor.fkSetor = setor.idSetor
    JOIN estufa ON setor.fkEstufa = estufa.idEstufa
    JOIN empresa ON estufa.fkEmpresa = empresa.idEmpresa
    WHERE empresa.idEmpresa = 1 AND leituraSensor.leituraDate = CURDATE() AND sensor.idSensor = 1 AND subsetor.idSubsetor = 1 AND estufa.idEstufa = 1 AND setor.idSetor = 1
    GROUP BY estufa.nome, setor.idSetor, sensor.idSensor, leituraSensor.leituraTime, subSetor.idSubsetor
    ORDER BY valor_minimo;
    
    select * from leituraSensor order by leituraTime desc;
select * from alerta;
     select
	count(a.Alerta) as situacao
    from(
			select
			estufa.nome Estufa,
			fkAlerta Alerta,
            max(leituraSensor.leituraTime) AS horarioLeitura,
			count(fkAlerta) qtde
			from estufa 
			join setor on idEstufa = fkEstufa 
			join subSetor on idSetor = fkSetor 
			join sensor on idSubSetor = fkSubSetor
			join leituraSensor on sensor.idSensor = leituraSensor.fkSensor
            where fkEmpresa = 1 && leituraDate = curDate()
            group by estufa.nome, fkAlerta) as a 
            group by Alerta;
            
            select * from leituraSensor;
            
 select
		count(a.Alerta)
		from(
	select estufa.nome, max(fkAlerta) as Alerta, max(leituraSensor.leituraTime) as ultimaLeitura, count(fkAlerta) qtde
        from estufa
		left join setor on idEstufa = fkEstufa 
		left join subSetor on idSetor = fkSetor 
		left join sensor on idSubSetor = fkSubSetor
        left join (select fkSensor, max(leituraTime) as ultima_leitura
            from leituraSensor
            group by fkSensor
        ) as ultimaLeitura on sensor.idSensor = ultimaLeitura.fkSensor 
         left join leituraSensor on ultimaLeitura.fkSensor = leituraSensor.fkSensor and ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
        where fkEmpresa = 1
        group by estufa.nome
        order by ultimaLeitura desc) as a
         group by Alerta;
         
select estufa.nome as 'nome_estufa', coalesce(round(avg(leituraSensor.valor), 0), 0) as "media_valor", leituraSensor.leituraTime
        from empresa
        left join estufa on estufa.fkEmpresa = empresa.idEmpresa
        left join setor on setor.fkEstufa = estufa.idEstufa
        left join subSetor on subSetor.fkSetor = setor.idSetor
        left join sensor on sensor.fkSubSetor = subSetor.idSubSetor
        join(select fkSensor, max(leituraTime) as ultima_leitura
            from leituraSensor
            group by fkSensor
        ) as ultimaLeitura ON sensor.idSensor = ultimaLeitura.fkSensor 
        left join leituraSensor on ultimaLeitura.fkSensor AND ultimaLeitura.ultima_leitura = leituraSensor.leituraTime
        where idEmpresa = 1
        group by estufa.idEstufa, estufa.nome, leituraSensor.leituraTime
        order by leituraSensor.leituraTime DESC;
        
        SELECT estufa.nome AS 'nome_estufa', COALESCE(ROUND(AVG(leituraSensor.valor), 0), 0) AS 'media_Valor', max(leituraSensor.leituraTime) AS 'ultima_leitura'
          FROM estufa
          JOIN setor ON estufa.idEstufa = setor.fkEstufa
          JOIN subSetor ON setor.idSetor = subSetor.fkSetor
          JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
          JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor AND DATE(leituraSensor.leituraDate) = CURDATE()
          WHERE estufa.fkEmpresa = 1
          GROUP BY estufa.idEstufa, estufa.nome
          ORDER BY ultima_leitura DESC;
          
	SELECT
MAX(leituraSensor.leituraTime) as 'hora'
,
leituraSensor.valor as 'valorAtual'
FROM empresa JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
JOIN setor ON estufa.idEstufa = setor.fkEstufa
JOIN subSetor ON setor.idSetor = subSetor.fkSetor
JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
WHERE empresa.idEmpresa = 1
AND
estufa.idEstufa = 1
AND
setor.idSetor = 1
AND
subSetor.idSubSetor = 1
AND
sensor.idSensor = 1
GROUP BY leituraSensor.valor
LIMIT 1;

insert into leituraSensor values
(null, 572, curdate(), curtime(), 6, 1);

 	SELECT
leituraSensor.leituraTime as 'hora'
,
leituraSensor.valor as 'valorAtual'
FROM empresa JOIN estufa ON empresa.idEmpresa = estufa.fkEmpresa
JOIN setor ON estufa.idEstufa = setor.fkEstufa
JOIN subSetor ON setor.idSetor = subSetor.fkSetor
JOIN sensor ON subSetor.idSubSetor = sensor.fkSubSetor
JOIN leituraSensor ON sensor.idSensor = leituraSensor.fkSensor
WHERE empresa.idEmpresa = 1
AND
estufa.idEstufa = 1
AND
setor.idSetor = 1
AND
subSetor.idSubSetor = 1
AND
sensor.idSensor = 1
order by leituraSensor.leituraTime desc;

select * from sensor;
select * from subSetor;

select 
    alerta.idAlerta,
    count(estufa.idEstufa) as qtdEstufas
from alerta
    left join (
        select
            estufa.idEstufa,
            leituraSensor.fkAlerta,
            leituraSensor.leituraTime,
            row_number() over (partition by estufa.idEstufa order by leituraTime desc) as rowNum
        from leituraSensor
            left join sensor on sensor.idSensor = leituraSensor.fkSensor
            left join subSetor on subSetor.idSubSetor = sensor.fkSubSetor
            left join setor on setor.idSetor = subSetor.fkSetor
            left join estufa on estufa.idEstufa = setor.fkEstufa
        where
        estufa.fkEmpresa = 1
    ) as leituraSensor on alerta.idAlerta = leituraSensor.fkAlerta
    left join estufa on estufa.idEstufa = leituraSensor.idEstufa
    where leituraSensor.rowNum = 1
    group by alerta.idAlerta
    order by qtdEstufas desc;