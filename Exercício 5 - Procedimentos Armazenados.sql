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
values (1, 'João', 'Rua do João', 1998387261)
begin
if @@rowcount > 0 /* insercao de pessoa bem sucedida */
	insert into cliente
	values (1, 8746351728, '18/12/2000')
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


create procedure cadastrar_atendente
@codigo numeric(6,0),
@nome char(40),
@endereco char(40),
@telefone numeric(12,0),
@rg char(10),
@dtnasc datetime
as
begin transaction
insert into pessoa
values (2, 'Pedro', 'Rua do Pedro', 19987152771)
begin
if @@rowcount > 0 /* insercao de pessoa bem sucedida */
	insert into cliente
	values (2, 6748591872, '24/02/1995')
	if @@rowcount > 0 /* insercao de atendente bem sucedida */
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
