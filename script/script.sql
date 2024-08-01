--Criação Database
CREATE DATABASE Loja

-- Usa a database Loja
USE Loja

--Criação da tabela pessoa
CREATE TABLE pessoa(
	idPessoa INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nome VARCHAR(255) NOT NULL,
	logradouro VARCHAR(255) NULL,
	cidade VARCHAR(255) NOT NULL,
	estado CHAR(2) NOT NULL,
	telefone VARCHAR(11) NULL,
	email VARCHAR(255) NOT NULL,
)

--Criação da tabela pessoa Fisica
CREATE TABLE pessoaFisica(
	idPessoa_Fisica INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idPessoa_Fk INT NOT NULL,
	cpf VARCHAR(11),
	FOREIGN KEY (idPessoa_Fk) REFERENCES pessoa(idPessoa)
)

--Criação da tabela juridica
CREATE TABLE pessoaJuridica(
	idPessoa_Juridica INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idPessoa_Fk INT NOT NULL,
	cnpj VARCHAR(14),
	FOREIGN KEY (idPessoa_Fk) REFERENCES pessoa(idPessoa)
)

--Criação da tabela usuario
CREATE TABLE usuario(
	idUsuario INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	login VARCHAR(255) NOT NULL,
	senha VARCHAR(255) NOT NULL
)

--Criação da tabela produtos
CREATE TABLE produtos(
	idProduto INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	nome VARCHAR(255)NOT NULL,
	quantidade INT NOT NULL,
	precoVenda NUMERIC NOT NULL,
)

--Criação da tabela movimento
CREATE TABLE movimento(
	idMovimento INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	idUsuario INT NULL,
	idPessoa INT NULL,
	idProduto INT NULL,
	quantidade INT NULL,
	tipo CHAR(1) NULL,
	valorUnitario NUMERIC NULL,
	FOREIGN KEY (idUsuario) REFERENCES usuario(idUsuario),
	FOREIGN KEY (idPessoa) REFERENCES pessoa(idPessoa),
	FOREIGN KEY (idProduto) REFERENCES produtos(idProduto)
)

--Inserindo um registro na tabela pessoa
INSERT INTO pessoa(nome,logradouro,cidade,estado,telefone,email) VALUES ('Lucas','Rua Maria','Nova iguaçu','RJ','1111-1111','email@gmail.com')

--Inserindo o id número 1 da tabela pessoa como pessoa física
INSERT INTO pessoaFisica(idPessoa_Fk,cpf) VALUES (1,'11111111111')

--Inserindo um registro na tabela pessoa
INSERT INTO pessoa(nome,logradouro,cidade,estado,telefone,email) VALUES ('Ana','Rua Santos','Caxias','RJ','2222-2222','email@hotmail.com')

--Inserindo o id número 2 da tabela pessoa como pessoa juridica
INSERT INTO pessoaJuridica(idPessoa_Fk,cnpj) VALUES (2,'22222222222222')

--Dados completos de pessoa jurídica
SELECT * FROM pessoa p INNER JOIN pessoaJuridica pj ON p.idPessoa = pj.idPessoa_Fk

--Dados completos de pessoa fisica
SELECT * FROM pessoa p INNER JOIN pessoaFisica pf ON p.idPessoa = pf.idPessoa_Fk

--Inserindo dados na tabela movimento
INSERT INTO movimento(idPessoa,idProduto,idUsuario,quantidade,tipo,valorUnitario) VALUES (1,1,1,20,'E',20.10) 

--Dados de entrada
SELECT * FROM movimento m WHERE m.tipo = 'E'

--Dados de saida
SELECT * FROM movimento m WHERE m.tipo = 'S'

--Valor das entradas
SELECT * FROM movimento m WHERE m.tipo = 'E' ORDER BY m.idProduto ASC

--Valor das saidas
SELECT * FROM movimento m WHERE m.tipo = 'S' ORDER BY m.idProduto ASC

--Operadores que não efetuaram movimentações de entrada
SELECT * FROM movimento m WHERE m.tipo != 'E' 

--Valor total de entrada
SELECT SUM(m.valorUnitario) valorTotal FROM movimento m WHERE m.tipo = 'E'

--Valor total de saída
SELECT SUM(m.valorUnitario) valorTotal FROM movimento m WHERE m.tipo = 'S'

