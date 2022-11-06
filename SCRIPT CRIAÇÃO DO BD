/*lista desejo como tabela e não atributo de cliente*/
create database st767
go

use st767
go

drop database st767

create table Pessoa (
	codigo int not null,
	nome varchar(200) not null,
	tipo int not null, -- 1 para Física, 2 para Editora
	primary key (codigo)
);


create table Fisica (
	codigo int not null,
	cpf char(11) not null,
	sexo char(1) not null, --F/M
	foreign key (codigo) references Pessoa,
	unique (cpf),
	primary key (codigo)
)

create table Juridica (
	codigo int not null,
	cnpj char(14) not null,
  razaoSocial varchar(100) not null,
	foreign key (codigo) references Pessoa,
	unique (cnpj),
	primary key (codigo)
)

create table Cliente (
	codigo int not null,
	login varchar(50) not null,
	senha varchar(50) not null,
	foreign key (codigo) references Pessoa,
	primary key (codigo)
)

create table Funcionario (
	codigo int not null,
	dataAdmissao date not null,
	dataDemissao date null,
	salario decimal(11,2) not null,
	comissao decimal(5,2) null,
	horaEntrada date not null,
	horaSaida date not null,
	foreign key (codigo) references Pessoa,
	primary key (codigo)
);

create table Endereco (
	codigo int not null,
	codPessoa int not null,
	tipo varchar not null,
	cidade varchar not null,
	numero varchar(6) not null,
	cep char(8) not null,
	complemento varchar(125) null,
	tipoLogradouro varchar(25) not null,
	nomeEnd varchar(100) not null,
	primary key (codigo),
	foreign key (codPessoa) references Pessoa
);

create table Autor ( /*Autor poderia ser uma pessoa*/
	codigo int not null,
	nome varchar(70) not null,
	bibliografia varchar(MAX) not null,
	sexo char(1) not null,
	dataNasc date not null,
	dataMorte date null,
	primary key (codigo)
);

create table Genero (
	codigo int not null,
	nome varchar(25) not null,
	descricao varchar(280) null,
	primary key (codigo)	
);

create table Livro (
	codigo int not null,
	isbn char(13) not null,
	titulo varchar(125) not null,
	dataLancamento date not null,
	numPaginas int not null,
	desconto decimal(5,2) not null,
	idioma varchar(50) not null, --tabela
	preco smallmoney not null,
	edicao varchar(50) not null,
	unique (isbn),
	primary key (codigo)
);

create table LivroFisico (
	codigo int not null,
	qtdeEstoque int not null,
	tipoCapa varchar(140) not null,
	disponibilidade bit not null,
	foreign key (codigo) references Livro,
	primary key (codigo)	
);

create table eBook (
	codigo int not null,
	statusDisponibilidade bit not null,
	foreign key (codigo) references Livro,
	primary key (codigo)	
);

Create table ListaDesejo (
  codigo int not null,
  codigoPessoa int not null,
  codigoLivro Int not null,
  primary key (codigo),
  foreign key (codigoLivro) references Livro,
  foreign key (codigoPessoa) references Pessoa
)


create table Estante(
	num_estante int not null,
	corredor int not null,
	categoria varchar(50) not null,
	quantidade int not null
	primary key (num_estante, corredor)
);

create table Avaliacao (
	codigo int not null,
	codigoCliente int not null,
	codigoLivro int not null,
	nota char(1) not null, -- 1 a 5
	comentario varchar(MAX) null,
	data date not null,
	foreign key (codigoCliente) references Cliente,
	foreign key (codigoLivro) references Livro,
	unique (codigoCliente, codigoLivro),
	primary key (codigo)
);

create index ix_codcli on Avaliacao(codigoCliente);
create index ix_codlivro on Avaliacao(codigoLivro);

create table Venda (
	codigo int not null,
	codigoCliente int not null,
	data smalldatetime not null,
	valorTotal decimal(11,2) not null,
	qtd_parcelamento int not null,
	tipo int not null, -- 1- Presencial, 2- Online
	primary key (codigo)
);

create table Online (
	codigo int not null,
	valorFrete decimal(8,2) not null,
	statusSeparacao varchar(100) null,
	codRastreio varchar(35) null,
	statusEntrega varchar(100) null,
	foreign key (codigo) references Venda,
	primary key (codigo)	
);

create table Presencial (
	codigo int not null,
	codigoFunc int not null,
	foreign key (codigo) references Venda,
	foreign key (codigoFunc) references Funcionario,
	primary key (codigo)
);

create index ix_codfunc on Presencial(codigoFunc);

create table Fatura (
	codigo int not null,
	codVenda int not null,
	metodo varchar(50) not null, --tabela
	dataVenc date not null,
	dataPag date null,
	valorParc decimal(11,2) not null,
	primary key (codigo),
	foreign key (codVenda) references Venda	
);
