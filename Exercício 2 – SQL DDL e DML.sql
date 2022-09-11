--garantindo que estamos no banco master--
use master
go

--criação do banco de dados principal--
create database Reboque
go

--garantindo que estamos no banco necessário--
use Reboque

--criação das tabelas do banco--
create table motorista (
    codigo int not null,
    nome char(33) not null,
    nro_carteira int not null,
    hora_entrada time not null,
    hora_saida time not null,
    primary key (codigo)
)

create table cliente (
    codigo int not null,
    rg char(9) not null,
    nome char(33) not null,
    endereco char(44) not null,
    primary key (codigo)
)

create table veiculo (
    placa char(7) not null,
    marca char(11) not null,
    cor char(11) not null,
    primary key (placa)
)

create table ocorrencia (
    codigo int not null,
    end_busca char(44) not null,
    end_entrega char (44) not null,
    data date not null,
    distancia numeric(8,2) not null,
    preco money not null,
    pago char(1) not null,
    cod_motorista int not null,
    cod_cliente int not null,
    placa char(7) not null,
    primary key (codigo),
	foreign key (cod_motorista) references motorista,
    foreign key (cod_cliente) references cliente,
    foreign key (placa) references veiculo
)
go

--criação de indices para as chaves estrangeiras--

create index ix_ocorrencia_mot
on ocorrencia (cod_motorista)

create index ix_ocorrencia_cli
on ocorrencia (cod_cliente)

create index ix_ocorrencia_veiculo
on ocorrencia (placa)

insert into motorista
values ('1', 'Pedrinho', '123', '09:30', '13:45')

insert into cliente
values ('1', '123456789', 'Ciclano', 'Avenida Brasil 123')

insert into veiculo
values ('ABC1234', 'Renault', 'Amarelo')

insert into ocorrencia
values ('1', 'Avenida Brasil 321', 'Avenida Paulista 9000', '2022-04-06', '250.12', '963.28', '0', '1', '1', 'ABC1234')

update ocorrencia
set pago = '1'
where codigo = 10

update motorista
set hora_saida = '18:00'
where codigo = 5

delete from ocorrencia 
where data < '2022-01-01' and pago = '1'

delete from veiculo 
where placa = 'AAA5555'

select *
from motorista
where hora_entrada = '6:00' and hora_saida = '13:00'

--j) Listar o número total de ocorrências já pagas (atributo pago = ‘S’).
select count(*)
from ocorrencia
where pago = 'S'

select data 'Data', avg(preco) 'Preço Médio' 
from ocorrencia 
group by data
order by data desc

select nome
from cliente c inner join ocorrencia o
	on c.codigo = cod_cliente
where pago = 'N'

select v.placa, nome, data, distancia
from ocorrencia o inner join veiculo v
	on o.codigo = v.placa
	inner join motorista m
	on o.cod_motorista = m.codigo
order by data desc

select c.nome, m.nome, data, preco
from ocorrencia o inner join cliente c
	on o.codigo = cod_cliente
	inner join motorista m
	on o.cod_motorista = m.codigo
order by data, c.nome desc

/* desfazer o banco de dados
use master
go
drop database reboque
*/
