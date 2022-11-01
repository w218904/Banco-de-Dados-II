--Apagando o banco de dados antigo
use master
go

drop database st767
go

--criando um banco de dados novo

use master
go

create database st767
go

--Criando as tabelas
use st767
go

create table produto (
codproduto int not null,
nome varchar(60) not null,
preco numeric(5,2) not null,
qtdestoque int not null,
primary key (codproduto)
)
go

create table notafiscal (
numnota numeric(10,0) not null,
valortotal numeric(10,2) not null,
primary key (numnota)
)
go

create table itemnotafiscal (
numnota numeric(10,0) not null,
codproduto int not null,
quantidade int not null,
primary key (numnota,codproduto),
foreign key (numnota) references notafiscal,
foreign key (codproduto) references produto
)
go

create table fatura (
numfatura int not null,
dtvencimento datetime not null,
dtpagamento datetime null,
valor numeric(5,2) not null,
numnota numeric(10,0) not null,
primary key (numfatura),
foreign key (numnota) references notafiscal
)
go

--Criação dos índices para chaves estrangeiras
create index ixitemnota_codproduto on itemnotafiscal(codproduto)
go

create index ixfatura_numnota on fatura(numnota)
go

--Inserindo dados para teste
insert into produto values (1, 'lapis', 1.00, 100)
insert into produto values (2, 'caneta', 1.50, 100)
insert into produto values (3, 'borracha', 1.00, 100)
insert into produto values (4, 'papel', 0.50, 100)

insert into notafiscal values (1, 0)
go

--Criação dos gatilhos
use st767
go

--Exercício A
create trigger inclusaoitemnotafiscal
on itemnotafiscal for insert
as
begin
	update produto 
	set qtdestoque = qtdestoque - (select quantidade from inserted)
		where codproduto = (select codproduto from inserted)
	if @@ROWCOUNT = 0
	rollback transaction
end
begin
	update notafiscal
	set valortotal = valortotal +  (select p.preco * i.quantidade
									from produto p inner join inserted i
									on p.codproduto = i.codproduto)
	if @@ROWCOUNT = 0
	rollback transaction
end
go
-- ******************************************************

--Exercício B
create trigger exclusaoitemnotafiscal
on itemnotafiscal for delete
as
begin
	update produto 
	set qtdestoque = qtdestoque + (select quantidade from deleted)
		where codproduto = (select codproduto from deleted)
	if @@ROWCOUNT = 0
	rollback transaction
end
begin
	update notafiscal
	set valortotal = valortotal -  (select p.preco * d.quantidade
									from produto p inner join deleted d
									on p.codproduto = d.codproduto)
	if @@ROWCOUNT = 0
	rollback transaction
end
go
-- ******************************************************

--Exercício C
create trigger atualizaitemnotafiscal
on itemnotafiscal for update
as
if update (quantidade)
begin
	update produto 
	set qtdestoque = qtdestoque - (select (i.quantidade - d.quantidade)
									from produto p inner join inserted i
									on p.codproduto = i.codproduto
									inner join deleted d
									on i.codproduto = d.codproduto)
		where codproduto = (select codproduto from deleted)
	if @@ROWCOUNT = 0
	rollback transaction
	else
	begin
		update notafiscal
		set valortotal = valortotal + (select p.preco * (i.quantidade - d.quantidade)
										from produto p inner join inserted i
										on p.codproduto = i.codproduto
										inner join deleted d
										on i.codproduto = d.codproduto and
										i.numnota = d.numnota)
			where numnota = (select codproduto from inserted)
		if @@ROWCOUNT = 0
		rollback transaction
	end
end
go
-- ******************************************************

--Exercício D

-- criação da tabela faturapaga
create table faturapaga (
numfatura int not null,
dtvencimento datetime not null,
dtpagamento datetime not null,
valor numeric(5,2) not null,
numnota numeric(10,0) not null,
primary key (numfatura),
foreign key (numnota) references notafiscal
)
go

create index ixfatura_numnota on faturapaga(numnota)
go

-- trigger
create trigger atualizarfatura
on fatura for update
as
if update (dtpagamento)
begin

	delete from fatura
	where numfatura = numfatura	
	if @@ROWCOUNT = 0
	rollback transaction
	else
	insert into faturapaga(numfatura, dtvencimento, dtpagamento, valor, numnota)
	select numfatura, dtvencimento, dtpagamento, valor, numnota from deleted
	if @@ROWCOUNT = 0
	rollback transaction
end
go
-- ******************************************************

--Inserções para teste
insert into itemnotafiscal values (1, 2, 10)
insert into itemnotafiscal values (1, 3, 2)
insert into itemnotafiscal values (1, 1, 2)
insert into itemnotafiscal values (1, 4, 5)
go

--Selects para teste
select * from produto
select * from notafiscal
select * from itemnotafiscal
go

--Apagar Gatilho
use st767
go
drop trigger inclusaoitemnotafiscal, exclusaoitemnotafiscal
go
drop trigger atualizaitemnotafiscal
go

--deletes para teste
delete from itemnotafiscal where codproduto = 1
delete from itemnotafiscal where codproduto = 2
delete from itemnotafiscal where codproduto = 3
delete from itemnotafiscal where codproduto = 4
go

--updates para teste
update itemnotafiscal
	set quantidade = 20 
	where codproduto = 1
go
update itemnotafiscal
	set quantidade = 20 
	where codproduto = 2
go
update itemnotafiscal
	set quantidade = 20 
	where codproduto = 3
go
update itemnotafiscal
	set quantidade = 20 
	where codproduto = 4
go

--Deletes para as rows de itemnotafiscal
delete from itemnotafiscal
where numnota = 1
delete from itemnotafiscal
where numnota = 2
delete from itemnotafiscal
where numnota = 3
delete from itemnotafiscal
where numnota = 4
go

--Selects para teste
select * from produto
select * from notafiscal
select * from itemnotafiscal
go

--drop geral
use st767
go
drop table itemnotafiscal
go
drop table fatura
go
drop table produto, notafiscal
go
