--garantindo que estamos no banco master
use master
go

--criação do banco de dados principal
create database exercicio3
go

--garantindo que estamos no banco necessário
use exercicio3
go

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

--a
create view produto_nunca_vendido
as
select p.[codproduto], p.[nome], p.[qtdestoque]
from produto p
where not exists (select 1
	from itemnotafiscal i
        where p.codproduto = i.codproduto)

--b
create view quantidade_total_vendida
as
select p.codproduto, p.nome, sum(i.quantidade) quantidade_total_vendida
from produto p inner join itemnotafiscal i on
p.codproduto = i.codproduto where not exists (select 1 from produto_nunca_vendido p)
group by p.codproduto, p.nome


--c
create view notafiscal_completa
as
select n.numnota, n.valortotal, p.nome, p.preco, i.quantidade, (i.quantidade * p.preco) valor_vendido
from notafiscal n inner join itemnotafiscal i on
n.numnota = i.numnota  inner join produto p on
i.codproduto = p.codproduto


--d
create view notafiscal_com_fatura_pendente
as
select n.numnota, n.valortotal, f.numfatura, f.dtvencimento, f.valor
from notafiscal n inner join fatura f on
n.numnota = f.numnota where f.dtpagamento is null

--e
create view notafiscal_com_faturas_pagas
as
select n.numnota, n.valortotal
from notafiscal n where not exists (select 1
	from notafiscal_com_fatura_pendente q
        where n.numnota = q.numnota)

