--garantindo que estamos no banco necessário
use exercicio5
go

create procedure cadastrar_cliente
@codigo numeric(6,0),
@nome char(40),
@endereco char(40),
@telefone numeric(12,0),
@rg char(10),
@dtnasc datetime
as
begin transaction
insert into pessoa
values (@codigo, @nome, @endereco, @telefone)
if @@rowcount > 0 /* insercao de pessoa bem sucedida */
begin
	insert into cliente
	values (@codigo, @rg, @dtnasc)
	if @@rowcount > 0 /* insercao de cliente bem sucedida */
	begin
		commit transaction
		return 1
	end
	else
	begin
		rollback transaction
		return 0
	end
end
else
begin
	rollback transaction
	return 0
end


create procedure cadastrar_livro
@codigo numeric(6,0),
@titulo char(30),
@autor char(30),
@preco numeric(7,2),
@qtd_estoque numeric(3,0)
as
begin transaction
insert into livro
values (@codigo, @titulo, @autor, @preco, @qtd_estoque)
if @@rowcount > 0 /* insercao de livor bem sucedida */
begin
	commit transaction
	return 1
end
else
begin
	rollback transaction
	return 0
end
