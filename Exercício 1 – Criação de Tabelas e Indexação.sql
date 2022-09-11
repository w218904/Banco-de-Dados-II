use master 
go

create database st767
go

use st767

create table pessoa (
    codigo int not null,
    nome char(33) not null,
    endereco char (50) not null,
    telefone char (11) not null,
    primary key (codigo)
)

create table cliente (
    codigo int not null,
    rg char (9) not null,
    dtnasc date not null,
    primary key (codigo),
    unique (rg),
    foreign key (codigo) references pessoa
)

create table atendente (
    codigo int not null,
    salario money not null,
    comissao money not null,
    primary key (codigo),
    foreign key (codigo) references pessoa
)

create table livro (
    codigo int not null,
    titulo char(33) not null,
    autor char(33) not null,
    preco money not null,
    qtd_estoque int not null,
    primary key (codigo)
)

create table venda (
    codigo int not null,
    data date not null,
    cod_cli int not null,
    cod_aten int not null,
    primary key (codigo),
    foreign key (cod_cli) references cliente, 
    foreign key (cod_aten) references atendente
)

create table itemvenda (
    cod_venda int not null,
    cod_livro int not null,
    quantidade int not null,
    primary key (cod_venda, cod_livro),
    foreign key (cod_venda) references venda,
    foreign key (cod_livro) references livro 
)
go

create index indice_venda
on Venda (cod_cli, cod_aten)

create index indice_item_venda
on ItemVenda (cod_venda, cod_livro)
go
