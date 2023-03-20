CREATE DATABASE leafproject;
USE leafproject;

CREATE TABLE Usuario (
    ID_Usuário INT PRIMARY KEY AUTO_INCREMENT, 
	Nome VARCHAR(60),
    Sobrenome VARCHAR(60),
	Telefone VARCHAR(12),
    CPF char(15),
	Email VARCHAR(50) NOT NULL,
	Senha VARCHAR(20) NOT NULL
);


CREATE TABLE Empresa (
    ID_Empresa INT PRIMARY KEY AUTO_INCREMENT, 
	Razao_Social VARCHAR(60),
	Telefone VARCHAR(12),
	Email VARCHAR(50) NOT NULL,
	Senha VARCHAR(12) NOT NULL,
	CNPJ CHAR(20) NOT NULL
);

CREATE TABLE Planta (
	ID_Planta INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(40),
    Desenvolvimento_dias INT,
    Area_ocupada  INT,
    Tempo_Luz FLOAT ,
    constraint chkPlanta check (tipo in('Alface','alface'))
    );
    
    
        CREATE TABLE Sensor (
		ID_Sensor INT PRIMARY KEY AUTO_INCREMENT,
		Nome VARCHAR(40),
        Condicao VARCHAR (40),
        Quantidade INT,
        constraint chkSensor check (nome in('LDR',' ldr', 'LDR 5mm','LDR 10mm')),
		constraint chkSensor_CND check (condicao in('ativo','inativo', 'manutenção'))
	);
    
       CREATE TABLE Dados_Sensor (
		ID_Dados INT PRIMARY KEY AUTO_INCREMENT,
        Resistencia FLOAT,
        Hora_Captacao datetime default current_timestamp
	);
    
    
    CREATE TABLE Endereco (
    ID_endereço INT PRIMARY KEY AUTO_INCREMENT,
    Logradouro VARCHAR(40), 
    Complemento VARCHAR(40),
    Bairro VARCHAR(40),
    CEP CHAR(9),
    Cidade VARCHAR(40),
    UF CHAR(2)
    );
    
    
      INSERT INTO Empresa (Razao_Social, Telefone, Email, Senha, CNPJ) VALUE
    ('SUPERMERCADOS BH', 1112345638, 'SUPERMERCADOSBH@gmail.com', '1112345678!', 11123456781112),
    ('EXTRAFRUTI', 2212875678, 'EXTRAFRUTI@gmail.com', '2212345678@', 22123456782212),
    ('HORTIFRUTI GRANJEIROS', 3315325678, 'HORTIFRUTIGRANJEIROS@hotmail.com', '3312345678#', 33123456783312),
    ('LIDER ATACADISTA', 4412675656 , 'LIDER ATACADISTA@gmail.com', '4412345678$', 4412345678441),
    ('GIRUS MERCANTIL LTDA', 5519765688 , 'GIRUS MERCANTILLTDA@hotmail.com', '5512345678%', 5512345678551),
    ('CANTU VERDURAS', 6643545627 , 'CANTUVERDURAS@hotmail.com', '6612345678&', 6612345678661);
    

    
    INSERT INTO Usuario (Nome, Sobrenome, Telefone, CPF, Email, Senha) VALUE
    ('Erika', 'Silva Santos', '8936307464','998.318.011-13','erika123@gmail.com', 11123456781112),
	('Roberto', 'Galvão', '8928870228','302.173.370-07','GVL3@gmail.com', 'sadOThl61C'),
	('Lucca', 'da Paz', '89981848271','054.736.227-71','LuCCa@gmail.com', 'yURuATHJA5'),
	('Maya', 'Rosa Campos', '1135797463','595.285.203-32','Maya321xx@gmail.com', '7zscsQ2hlb'),
	('Isis', 'Esther Corte Reals', '12994645627','936.031.842-62','isis.cortereal@gmail.com', 'YA7taX5Png'),
    ('Tiago', 'Vinicius Bryan Vieira', '1227789470','985.786.131-80','vieira.almaquinas@gmail.com', 'GmITnnGtFg');

        
    INSERT INTO Planta (Tipo, Desenvolvimento_dias, Area_ocupada,  Tempo_Luz)   VALUES 
    ('Alface', 60, 30, 560),
    ('Alface', 75, 50, 600),
    ('Alface', 80, 40, 480);
    
    INSERT INTO Sensor ( Nome, Condicao, Quantidade ) VALUES
    ('LDR 5mm', 'inativo', 1),
	('LDR 5mm', 'ativo', 1),
    ('LDR 5mm', 'ativo', 1),
	('LDR 10mm','ativo', 1);
    
    INSERT INTO Dados_Sensor (Resistencia) VALUES
     (234.05),
     (257.14),
     (187.02),
     (300.00);
    
    INSERT INTO Endereco (Logradouro, Complemento, Bairro, CEP, Cidade, UF) VALUES
			('Rua Agenor Faion','','Vila Bertini','13473510','Americana','SP'),
            ('Rua Abelardo Luz','','Jardim Mutinga','06463260','Baruer','SP'),
            ('Rua Acácio e Silva','','Stella Maris','06463760','Baruer','SP'),
            ('Avenida Majorca','','	Residencial Ibisa','16201076','Birigüi','SP'),
            ('Rua Alaska','','Jardim Klayton','16203034','Birigüi','SP'),
			('Avenida Aníbal Correia','','Parque Viana','06447010','Barueri','SP');
            
           
    
    SELECT * FROM Usuario;
    SELECT * FROM Planta;
	SELECT * FROM Sensor;
    SELECT * FROM Dados_Sensor;
	SELECT * FROM Endereco;
    
    desc Usuario;
    desc Planta;
    desc Sensor;
    desc Dados_Sensor;
    desc Endereco;
    
    
   
   UPDATE usuario SET cpf = '583.800.429-05' WHERE ID_Usuário = 2;
    
    SELECT * FROM endereco WHERE bairro LIKE 'J%';
    
	SELECT nome, cpf FROM usuario WHERE nome LIKE 'L%';
    
	UPDATE sensor SET condicao = 'inativo' WHERE ID_Sensor = 2;
    
     -- testar constraint chkPlanta    
	UPDATE planta SET tipo = 'repolho'  WHERE ID_Planta = 1; 
    
       -- testar constraint chkSensor   
	UPDATE sensor SET nome = 'LDM35'  WHERE ID_Sensor = 4;
    
       -- testar constraint chkSensor_CND    
	UPDATE sensor SET condicao = 'ligado'  WHERE ID_Sensor = 3;
    
    
	SELECT * FROM empresa WHERE telefone LIKE '%8';
    
	SELECT razao_social, telefone, cnpj FROM empresa WHERE cnpj LIKE '_3%';
    
    SELECT * FROM planta WHERE tipo = 'Alface';
    
    UPDATE planta SET area_ocupada = 45  WHERE ID_Planta = 3; 
    
    
    
    
    
