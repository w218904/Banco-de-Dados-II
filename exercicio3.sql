--garantindo que estamos no banco master
use master
go

--criação do banco de dados principal
create database exercicio3
go

--garantindo que estamos no banco necessário
use exercicio3

create table produto (
	codproduto int not null,
	nome char (20) not null,
	preco numeric (6,2),
	qtdestoque int,
	primary key (codproduto)
)
go

create table notafiscal (
	numnota int not null,
	valortotal numeric (6,2) not null,
	primary key (numnota)
)
go

create table itemnotafiscal (
	numnota int not null,
	codproduto int not null,
	quantidade int not null,
	primary key (codproduto, numnota),
	foreign key (codproduto) references produto,
	foreign key (numnota) references notafiscal,
)

create table fatura (
	numfatura int not null,
	dtvencimento date not null,
	dtpagamento date not null,
	valor numeric (6,2) not null,
	numnota int not null,
	primary key (numfatura),
	foreign key (numnota) references notafiscal
)

select p.[nome] 
from produto p
where not exists (select 1
                  from itemnotafiscal i
                  where p.codproduto = i.codproduto)
order by p.[nome];
