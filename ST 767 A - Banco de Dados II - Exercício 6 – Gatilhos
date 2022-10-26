--Apagando o banco de dados antigo e criando um novo
use master
go

drop database st767
go

use master
go

create database st767
go

--Criando as tabelas
use st767
go

create table pproduto (
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
foreign key (codproduto) references pproduto
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
insert into pproduto values (1, 'lapis', 1.00, 100)
insert into pproduto values (2, 'caneta', 1.50, 100)
insert into pproduto values (3, 'borracha', 1.00, 100)
insert into pproduto values (4, 'papel', 0.50, 100)

insert into notafiscal values (1940028922, 0)

go

--Selects para teste
select * from pproduto
select * from notafiscal
select * from itemnotafiscal
go

--Criação dos gatilhos
create trigger inclusaoitemnotafiscal
on itemnotafiscal for insert
as
begin
	update pproduto 
	set qtdestoque = qtdestoque - (select quantidade from inserted)
	if @@ROWCOUNT = 0
	rollback transaction
end
begin
	update notafiscal
	set valortotal = valortotal +  (select p.preco * (i.quantidade - d.quantidade)
									from pproduto p inner join inserted i
									on p.codproduto = i.codproduto
									inner join deleted d
									on i.codproduto = d.codproduto and
									i.numnota = d.numnota)
	if @@ROWCOUNT = 0
	rollback transaction
end
