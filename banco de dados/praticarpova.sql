CREATE DATABASE pratica04;

USE pratica04;

CREATE TABLE grupo(
	idGrupo INT PRIMARY KEY AUTO_INCREMENT,
    nomeGrupo VARCHAR(45),
    descricao VARCHAR(100));
    
CREATE TABLE aluno(
	RA CHAR(8) PRIMARY KEY,
    nomeAluno VARCHAR(45),
    email VARCHAR(45),
    fkGrupo int,
    FOREIGN KEY (fkGrupo) REFERENCES grupo(idGrupo));

CREATE TABLE professor(
	idProfessor INT PRIMARY KEY AUTO_INCREMENT,
	nomeProfessor VARCHAR(45),
    disciplina VARCHAR(20)) auto_increment=1000;
    
-- ASSOCIATIVA
CREATE TABLE avaliacao(
	idAvaliacao INT AUTO_INCREMENT,
	fkGrupo INT,
    FOREIGN KEY (fkGrupo) REFERENCES grupo(idGrupo),
    fkProfessor INT,
    FOREIGN KEY (fkProfessor) REFERENCES professor(idProfessor),
    dataHora DATETIME,
    nota FLOAT,
    PRIMARY KEY (idAvaliacao, fkGrupo,fkProfessor));
    
INSERT INTO grupo(nomeGrupo, descricao) VALUES 
	('Groontech','Monitoramento de temperatura e luminosidade em estufas de ervas medicinais'),
    ('GreenSensor','Monitoramento de temperatura e umidade em estufas hidroponicas'),
    ('H2O++','Monitoramente de umidade em estações de tratamento de água' ),
    ('DataControl','Monitoramento de temperatura e umidade em datacenters');

INSERT INTO aluno VALUES 
	('01202061','Lucas Lima', 'lucas.lima@bandtec.com.br',1),
	('01202048','Roberto Alves','roberto.alves@bandtec.com.br',1),
	('01202093', 'Victoria Andrade', 'victoria.andrade@bandtec.com.br',2),
	('01202081','Milena Soares','milena.soares@bandtec.com.br',2),
	('01202049','Jénifer Sintra', 'Jénifer.Sintra@bandtec.com.br',3),
	('01202002','Bruno Azevedo','bruno.azevedo@bandtec.com.br',3),
	('01202042','André Dias', 'andre.dias@bandtec.com.br',4),
	('01202032','José Maias', 'jose.maias@bandtec.com.br',4);

INSERT INTO professor(nomeProfessor,disciplina) VALUES 
	('Vivian Silva', 'Banco de dados'),
	('Fernando Brandão','Pesquisa e inovação'),
	('Caio Santos','Algoritimos'),
	('Thiago Gimenez','TI'),
	('Marise Miranda','ArqComp');

select * from professor;
desc avaliacao;

INSERT INTO avaliacao VALUES 
	(1,1000,'2020-10-29 10:00',10.0),
    (1,1001,'2020-10-29 10:00',9.5),
    (1,1004,'2020-10-29 10:00',8.5),
    (2,1000,'2020-10-29 10:30',8.0),
    (2,1001,'2020-10-29 10:30',9.5),
	(2,1002,'2020-10-29 10:30',8.5),
    (3,1000,'2020-10-29 11:00',7.0),
    (3,1001,'2020-10-29 11:00',6.5),
    (3,1003,'2020-10-29 11:00',6.5),
    (4,1003,'2020-10-29 11:30',7.0),
    (4,1001,'2020-10-29 11:30',8.0),
	(4,1002,'2020-10-29 11:30',6.5);
    
-- Exibir todos os dados de cada tabela criada, separadamente
	SELECT * FROM grupo;
    SELECT * FROM aluno;
    SELECT * FROM professor;
    SELECT * FROM avaliacao;

-- Exibir os dados dos grupos e os dados de seus respectivos alunos.
	SELECT
		grupo.nomeGrupo as "Nome do Grupo" , 
        grupo.descricao as 'Descrição',
        aluno.nomeAluno as 'Nome do Aluno',
        aluno.ra,
        aluno.email
			FROM grupo
				INNER JOIN aluno
					on idGrupo=fkGrupo;
                    
--  Exibir os dados de um determinado grupo e os dados de seus respectivos alunos.
	SELECT 
		grupo.nomeGrupo as "Nome do Grupo" , 
        grupo.descricao as 'Descrição',
        aluno.nomeAluno as 'Nome do Aluno',
        aluno.ra,
        aluno.email
			FROM grupo
				INNER JOIN aluno
					ON idGrupo=fkGrupo
						WHERE idGrupo=1;
    
-- Exibir a média das notas atribuídas aos grupos, no geral.
	SELECT TRUNCATE (AVG(nota),2) AS 'Nota média dos grupos' FROM avaliacao;
    
-- Exibir a nota mínima e a nota máxima que foi atribuída aos grupos, no geral.
	SELECT MIN(nota) AS "Nota mínima" FROM avaliacao;
    SELECT MAX(nota) AS "Nota máxima" FROM avaliacao;
	SELECT MIN(nota) AS "Nota mínima",  MAX(nota) AS "Nota máxima" FROM avaliacao;
    
-- Exibir a soma das notas dadas aos grupos, no geral
	SELECT SUM(nota) AS "Soma de notas" FROM avaliacao;
    
-- Exibir os dados dos professores que avaliaram cada grupo, os dados dos grupos, a data e o horário da avaliação.
	SELECT
		grupo.*,
        professor.nomeProfessor,
        professor.disciplina,
		avaliacao.dataHora,
        avaliacao.nota
			FROM avaliacao
				INNER JOIN professor
					on fkprofessor=idprofessor
				INNER JOIN grupo
					on fkGrupo=idGrupo;
	
   SELECT
		grupo.*,
        professor.nomeProfessor,
        professor.disciplina,
		avaliacao.dataHora,
        avaliacao.nota
			FROM avaliacao
				INNER JOIN professor
					on fkprofessor=idprofessor
				INNER JOIN grupo
					on fkGrupo=idGrupo;
    
    
--  Exibir os dados dos professores que avaliaram um determinado grupo, os dados do grupo, a data e o horário da avaliação.
		SELECT
			grupo.*,
			professor.nomeProfessor,
			professor.disciplina,
			avaliacao.dataHora,
			avaliacao.nota
				FROM avaliacao
					INNER JOIN professor
						on fkprofessor=idprofessor
					INNER JOIN grupo
						on fkGrupo=idGrupo
							WHERE idGrupo=1;
							
--  Exibir os nomes dos grupos que foram avaliados por um determinado professor.
		SELECT 
			grupo.nomeGrupo,
			avaliacao.nota,
			professor.nomeProfessor
				FROM avaliacao
					INNER JOIN professor
						on fkprofessor=idprofessor
					INNER JOIN grupo
						on fkGrupo=idGrupo
							WHERE idProfessor=1001;
                            
--   Exibir os dados dos grupos, os dados dos alunos correspondentes, os dados dos professores que avaliaram, a data e o horário da avaliação.
		SELECT
			grupo.nomeGrupo AS 'Nome do grupo',
            grupo.descricao AS 'Descrição do projeto',
            aluno.ra,
            aluno.nomeAluno AS 'Nome do aluno',
            aluno.email,
            professor.idprofessor,
            professor.nomeProfessor AS 'Nome do Professor',
            professor.disciplina,
            avaliacao.dataHora AS 'Agenda da apresentação'
				FROM grupo
					INNER JOIN aluno
						ON aluno.fkGrupo=idGrupo
					INNER JOIN avaliacao
						ON avaliacao.fkGrupo=idGrupo
					INNER JOIN professor
						ON fkprofessor=idprofessor;

-- Exibir a quantidade de notas distintas.
	SELECT COUNT(DISTINCT(nota)) AS 'Notas distintas' FROM avaliacao;
    SELECT DISTINCT(nota) AS 'Notas distintas' FROM avaliacao;
    
-- Exibir a identificação do professor (pode ser o fk ou o nome), a média das notas e a soma das notas atribuídas, agrupadas por professor.
	SELECT 
		professor.nomeProfessor AS 'Nome do professor',  
		TRUNCATE(AVG(avaliacao.nota),2) AS 'Média de notas',
		SUM(avaliacao.nota) AS 'Soma das notas'
			FROM avaliacao
				INNER JOIN professor 
					ON idprofessor=fkprofessor
						GROUP BY nomeProfessor;
  
			
-- Exibir a identificação do grupo (pode ser o fk ou o nome), a média das notas e a soma das notas atribuídas, agrupadas por grupo.	
	SELECT 
		grupo.nomeGrupo AS 'Nome do grupo',
		TRUNCATE(AVG(avaliacao.nota),2) AS 'Nota média',
		SUM(avaliacao.nota) AS 'Soma das notas'
			FROM avaliacao
				INNER JOIN grupo
					ON fkgrupo=idgrupo
						GROUP BY nomeGrupo;
	
-- Exibir a identificação do professor (pode ser o fk ou o nome), a menor nota e a maior nota atribuída, agrupada por professor.
	SELECT 
		professor.nomeProfessor AS 'Nome do Professor',
		Max(avaliacao.nota) AS 'Nota máxima',
        Min(avaliacao.nota) AS 'Nota mínima'
			FROM avaliacao
				INNER JOIN professor
					ON idprofessor=fkprofessor
						GROUP BY idProfessor;

-- Exibir a identificação do grupo (pode ser o fk ou o nome), a menor nota e a maior nota atribuída, agrupada por grupo.
	SELECT
		grupo.nomegrupo AS 'Nome do Grupo',
		Max(avaliacao.nota) AS 'Maior nota',
        Min(avaliacao.nota) AS 'Menor nota'
			FROM avaliacao
				INNER JOIN grupo
					ON idGrupo=fkGrupo
						GROUP BY idGrupo;


-- EXTRA/DESAFIOS --

-- Exibir a identificação e a nota média dos grupos que obtiveram nota média acima da média dos outros grupos
	SELECT 
		grupo.nomegrupo AS 'Nome do Grupo',
        TRUNCATE(AVG(NOTA),2) AS Nota2
			FROM avaliacao
				INNER JOIN grupo
					ON idGrupo = fkGrupo
						GROUP BY nomeGrupo
							HAVING AVG(NOTA)> (SELECT AVG(NOTA) FROM avaliacao);

SELECT * FROM ALUNO;	
	
-- ADD um aluno sem grupo								
	INSERT INTO ALUNO VALUES 
    ('01202076','Laun Ivis', 'luan.ivis@bandtec.com.br',null);						

-- Exibir os dados de todos os aluno e seus respectivos grupos, se possuirem
-- Resolução 1	
	SELECT * FROM aluno
		LEFT JOIN grupo
			ON idgrupo=fkGrupo;
	
-- Resolução 1	
	SELECT * FROM grupo
		RIGHT JOIN aluno
			ON idGrupo=fkGrupo;

-- Exibir a maior nota recebida, nome do grupo que a recebeu e o nome do professor o qual deu a nota.
-- Resolução 1	
    SELECT 
		avaliacao.nota, 
		grupo.nomeGrupo as "Nome do grupo" ,
        professor.nomeProfessor	as 'Nome do professor'
		FROM avaliacao
			INNER JOIN grupo
				ON idGrupo=fkGrupo
			INNER JOIN professor
				ON idprofessor=fkProfessor
                    WHERE 
						nota=(SELECT MAX(nota) FROM avaliacao);
-- Resolução 2	                     
    SELECT 
		avaliacao.nota, 
		grupo.nomeGrupo as "Nome do grupo" ,
		professor.nomeProfessor	as 'Nome do professor'
		FROM avaliacao
			INNER JOIN grupo
				ON idGrupo=fkGrupo
            INNER JOIN professor
				ON fkProfessor=idProfessor
					ORDER BY
						nota DESC
							LIMIT 1;      
   

							
-- Exibir a menor nota media recebida e nome do grupo que a recebeu.
	SELECT 
		AVG(avaliacao.nota),
		grupo.nomeGrupo as "Nome do grupo" 
		FROM avaliacao
			INNER JOIN grupo 
				ON idGrupo=fkGrupo
					GROUP BY idGrupo
						ORDER BY nota ASC 
							LIMIT 1;
							