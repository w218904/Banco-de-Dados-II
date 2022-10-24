--garantindo que estamos no banco master
use master
go

--criação do banco de dados principal
create database exercicio4
go

--garantindo que estamos no banco necessário
use exercicio4
go

create table pessoa (
	codpessoa int not null,
	nome varchar (100) not null,
	endereço varchar (100) not null,
	telefone char (20) not null,
	primary key (codpessoa),
)

create table cliente (
	codcliente int not null,
	rg char (9) not null,
	dtnasc date not null,
	primary key (codcliente),
	unique (rg),
)

create table atendente (
	codatendente int not null,
	salario numeric (6,2) not null,
	comissa numeric (3,2),
	primary key (codatendente),
)

create table livro (
	codlivro int not null,
	titulo varchar (100) not null,
	autor varchar (100) not null,
	preco numeric (3,2) not null,
	qtd_estoque int not null,
	primary key (codlivro),
)

create table venda (
	codvenda int not null,
	data_venda datetime not null,
	codcliente int not null,
	codatendente int not null,
	primary key (codvenda),
	foreign key (codcliente) references cliente,
	foreign key (codatendente) references atendente,
)

create table itemvenda (
	codvenda int not null,
	codlivro int not null,
	quantidade int not null,
	primary key (codvenda, codlivro),
	foreign key (codvenda) references venda,
	foreign key (codlivro) references livro,
)

create index indice_atendente
on atendente (codatendente)

create index indice_livro
on livro (codlivro)

begin transaction 
	insert into pessoa
	values (111, 'João da Silva', 'R. Paschoal Marmo, 1888 - Jardim Nova Italia, Limeira-SP', '(19) 2113-3339')
	if @@rowcount > 0 /*insercao de pessoa bem sucedida */
	begin
		insert into cliente
		values (111, '123456789', 01/01/2000)
		if @@rowcount > 0 /* insercao de cliente bem sucedida */
			commit transaction
		else
			rollback transaction
	end
	else
		rollback transaction

begin transaction 
	insert into pessoa
	values (222, 'Pedro Souza', 'Cidade Universitária Zeferino Vaz - Barão Geraldo, Campinas - SP', '(19) 3521-7000')
	if @@rowcount > 0 /*insercao de pessoa bem sucedida */
	begin
		insert into atendente
		values (222, '987654321', 01/01/2000)
		if @@rowcount > 0 /* insercao de atendente bem sucedida */
			commit transaction
		else
			rollback transaction
	end
	else
		rollback transaction

begin transaction

	insert into venda
	values (1,'2022-08-06 16:44:502', 111, 222)
	if @@rowcount > 0 /*insercao de venda bem sucedido */
	begin
		insert into itemvenda
		values (1, 2, 50), (1, 3, 30)
		if @@rowcount > 0 /* insercao de atendente bem sucedida */
			update livro 
			set qtd_estoque = qtd_estoque - 50
			where livro.codlivro = 2;

			update livro 
			set qtd_estoque = qtd_estoque - 30
			where livro.codlivro = 3;
			if @@rowcount > 0 /* update de estoque bem sucedido */
				commit transaction
			else
				rollback transaction
	end
	else
		rollback transaction
