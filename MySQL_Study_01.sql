CREATE database cadastro;

USE cadastro;

CREATE TABLE pessoas(
	nome varchar(30),
    idade tinyint,
    sexo char(1),
	peso float,
    altura float,
    nacionalidade varchar(20)
);

describe pessoas; #descreve uma TABLE. Poder ser resumido por desc

drop database cadastro; #apaga o database

CREATE database cadastro
DEFAULT character set utf8 #parametro (constraints)
DEFAULT collate utf8_general_ci; #collation

CREATE database meubanco; #apenas para ver a diferença
drop database meubanco;

USE cadastro;

CREATE TABLE pessoas(  #É um comando DDL (Data Definition Language)
	id int not null auto_increment, #auto increment faz com que automaticamente seja incrementado ao novo cadastro
    nome varchar(30) not null,
	nascimento date,
    sexo enum('M','F'),
    peso decimal(5,2),
    altura decimal(3,2),
    nacionalidade varchar(20) DEFAULT 'Brasil',
    PRIMARY KEY (id)
) DEFAULT charset = utf8;

insert into pessoas
	(nome, nascimento, sexo, peso, altura, nacionalidade)
values
    ('Godofredo', '1984-01-02', 'M', '78.5', '1.83', 'Brasil');
    
select * from pessoas;

insert into pessoas
	(nome, nascimento, sexo, peso, altura, nacionalidade)
values
    ('Maria', '1999-12-30', 'F', '55.2', '1.65', 'Portugal');
    
select * from pessoas;

insert into pessoas
	(id, nome, nascimento, sexo , peso, altura, nacionalidade)
values
	(DEFAULT, 'Creuza', '1920-12-30', 'F', '50.2', '1.65', DEFAULT);
	#Note que usamos uma constraint DEFAULT para auto escolher ID
    
select * from pessoas;

insert into pessoas values
	(DEFAULT, 'Adalgiza', '1936-11-2', 'F', '63.2', '1.75', 'Irlanda');
    
select * from pessoas;

insert into pessoas values #É um comando DML(Data Manipulation Language)
	(DEFAULT, 'Claudio', '1975-4-22', 'M', '99.0', '2.15', 'Brasil'),
    (DEFAULT, 'Pedro', '1999-12-3', 'M', '87', '2', DEFAULT),
    (DEFAULT, 'Janaina', '1987-11-12', 'F', '75.4', '1.66', 'EUA');
    #É possivel inserir vários dados em apenas um insert into
    
select * from pessoas;

alter TABLE pessoas
	add column profissao varchar(10);
    
describe pessoas;

alter TABLE pessoas
	drop column profissao;
    
alter TABLE pessoas
	add column profissao varchar(10) after nome;
    
describe pessoas;

alter TABLE pessoas
	add codigo int first; #A palavra column é opcional. Caso queira adicionar na primeira posição, usa-se first.alter

describe pessoas;

alter TABLE pessoas
	modify column profissao varchar(20);
    
describe pessoas;
select * from pessoas;

alter TABLE pessoas
	modify column profissao varchar(20) DEFAULT '';
    
alter TABLE pessoas
	change column profissao prof varchar(20); #Se quiser mudar o nome da coluna, tem que se utilizar change
    
select * from pessoas;

alter TABLE pessoas
	rename to funcionarios; #muda o nome da tabela inteira
    
desc funcionarios;

CREATE TABLE  if not exists cursos(
	nome varchar(30) not null unique, #unique nao deixa colocar dois cursos com o mesmo nome
	descricao text,
    carga int unsigned,
    totaulas int unsigned,
    ano year DEFAULT '2016'
)DEFAULT charset=utf8;

alter TABLE cursos
	add column idcurso int first;
    
desc cursos;

alter TABLE cursos
	add primary key (idcurso);
    
desc cursos;

CREATE TABLE if not exists teste(
id int,
nome varchar(30),
idade int
);

insert into teste value
	('1', 'Pedro', '22'),
    ('2', 'Maria', '12'),
    ('3', 'Joao', '77');
    
select * from teste;

drop TABLE teste;

select * from funcionarios;

insert into cursos values
	('1', 'HTML4', 'Curso de HTMLS', '40', '37', '2014'),
    ('2', 'Algoritmos', 'Lógica de Programação', '20', '15', '2014'),
	('3', 'Photoshop', 'Dicas de Photoshop CC', '10', '8', '2014'),
    ('4', 'PGP', 'Curso de PHP para iniciantes', '40', '20', '2010'),
    ('5', 'jarva', 'Introdução à Linguagem Java', '10', '29', '2000'),
    ('6', 'MySQL', 'Bancos de Dados MySQL', '30', '15', '2016'),
    ('7', 'Word', 'Curso completo de Word', '40', '30', '2016'),
    ('8', 'Sapateado', 'Danças Rítmicas', '40', '30', '2018'),
    ('9', 'Coinha Árabe', 'Aprenda a fazer Kibes', '40', '30', '2018'),
    ('10', 'YouTuber', 'Gerar polêmica e ganhar inscritos', '5', '2', '2018');
    
select * from cursos;

update cursos #Para mudar valores de registros
	set nome = 'HTML5'
	where idcurso = '1';
    
update cursos  
	set nome = 'PHP', ano = '2015'  #Para mudar mais de uma coluna ao mesmo tempo
	where idcurso = '4';
    
update cursos
	set nome = 'Java', carga = '40', ano = '2015'
    where idcurso = '5'
    limit 1;
    
update cursos
	set ano = '2050', carga = '800'  #PERIGOSO! Mudou tudo que tem 2018
    where ano = '2018';
    
update cursos
	set ano = '2018', carga = '0'
    where ano = '2050'
    limit 1;
    
delete from cursos
	where idcurso = '8';
    
delete from cursos
	where ano = '2018';
 
 delete from cursos
	where ano = '2050';
    
truncate cursos; #Apaga todos os registros da tabela cursos

select * from cursos;

drop database cadastro;	#Após o dump, apaguei o database todo

select * from amigos;

USE cadastro;

#Novos usos do Select

select * from cursos
	order by nome desc; #Ordem descrescente
    
select nome, carga, ano from cursos
	order by nome;

select * from cursos
	where ano = '2016'
    order by nome;
    
select nome, descricao, ano from cursos
	where ano <= '2015'
    order by nome;

select nome, ano from cursos
	where ano between 2014 and 2016;
    
select nome, descricao, ano from cursos #A diferença entre in e between é que o in escolhe valores e between escolhe faixas
	where ano in (2014, 2016)
    order by ano;
    
select nome, ano from cursos
	where nome like 'P%'; #que comece com p e tenha mais ou nenhuma letra

select nome, ano from cursos
	where nome like '%a'; #termine com a

select nome, ano from cursos
	where nome like '%a%'; #que tenha a em qualquer lugar
    
select nome, ano from cursos
	where nome not like '%A%'; #não tenha a em nenhum lugar
    
select nome, ano from cursos
	where nome like 'php_'; #que tenha um caracter necessariamente no final
    
select distinct nacionalidade from gafanhotos #Apenas seleciona os valores distintos
	order by nacionalidade;

select count(*) from cursos
	where carga > 40;
    
select max(carga) from cursos;
   
#EXERCÍCIOS 
 
 select * from gafanhotos
	where sexo = 'F';
    
select * from gafanhotos
	where nascimento between '2000-01-01' and '2015-12-31'
    order by nascimento;
    
select * from gafanhotos
	where sexo = 'M' and profissao like 'progr%';

select * from gafanhotos
	where sexo = 'F' and nome like 'J%' and nacionalidade = 'Brasil';
    
select nome, nacionalidade from gafanhotos
	where nome like '%Silva%' and nacionalidade != 'Brasil' and peso < '100';
    

select max(altura) from gafanhotos
	where sexo = 'M' and nacionalidade = 'Brasil';
    
select avg(peso) from gafanhotos;

select min(peso) from gafanhotos
	where nacionalidade != 'Brasil' and nascimento between '1990-01-01' and '2000-12-31';
    
#FIM DOS EXERCÍCIOS

select carga, count(nome) from cursos
	group by carga #O grup faz algo semelhante ao distinct, não mostrando dados repetidos.
	having count(nome) > 3;

select avg(carga) from cursos;

select carga, count(*) from cursos
	where ano > 2015
    group by carga
    having carga > (select avg(carga) from cursos);
    
#	MAIS EXERCÍCIOS

select profissao, count(*) from gafanhotos
	group by profissao;
    
select sexo, count(*) from gafanhotos 
	where nascimento > '2005-01-01'
	group by sexo;
    
select nacionalidade, count(nome) from gafanhotos
	where nacionalidade != 'Brasil'
    group by nacionalidade
    having count(nome) > 3;
    
select altura, count(id) from gafanhotos
	where peso > '100'
    group by altura
    having altura > (select avg(altura) from gafanhotos);
    
ALTER TABLE gafanhotos
	ADD cursopreferido int;
    
desc gafanhotos;

ALTER TABLE gafanhotos
	ADD foreign KEY (cursopreferido)
    references cursos(idcurso);
    
update gafanhotos set cursopreferido = '6' where id = '1';

select * from gafanhotos;

delete from cursos where idcurso = '6';

select	gafanhotos.nome, cursos.nome, cursos.ano #join para relacionar a chava primaria com a chave estrangeira
from gafanhotos join cursos
on cursos.idcurso = gafanhotos.cursopreferido;
    


    
    
    
    
    
    