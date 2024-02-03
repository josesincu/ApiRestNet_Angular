go
use TiendaX

/************************* VALIDAMOS SI EXISTE EL PROCEDIMIENTO PRODUCTO ************************/

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'producto_registrar')
DROP PROCEDURE producto_registrar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'producto_modificar')
DROP PROCEDURE producto_modificar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'producto_obtener')
DROP PROCEDURE producto_obtener

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'producto_listar')
DROP PROCEDURE producto_listar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'producto_eliminar')
DROP PROCEDURE producto_eliminar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'reporte_proveedor_producto')
DROP PROCEDURE reporte_proveedor_producto

go


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'reporte_producto')
DROP PROCEDURE reporte_producto

go

/************************* PROCEDIMIENTOS PARA CREAR PRODCUTO ************************/
create procedure producto_registrar(
	@IdProducto int,
	@IdMarca int,
	@IdPresentacion int,
	@IdProveedor int,
	@IdZona int,
	@Codigo int,
	@DescripcionProducto varchar(1000),
	@Precio float,
	@Stock int,
	@Iva int,
	@Peso float
)
as
begin

insert into producto(
	id_producto,
	id_marca,
	id_presentacion,
	id_proveedor,
	id_zona,
	codigo,
	descripcion_producto,
	precio,
	stock,
	iva,
	peso
	)
values
(
	@IdProducto,
	@IdMarca,
	@IdPresentacion,
	@IdProveedor,
	@IdZona,
	@Codigo,
	@DescripcionProducto,
	@Precio,
	@Stock,
	@Iva,
	@Peso
)
end
go

/* modificar producto */
create procedure producto_modificar(
	@IdProducto int,
	@IdMarca int,
	@IdPresentacion int,
	@IdProveedor int,
	@IdZona int,
	@Codigo int,
	@DescripcionProducto varchar(1000),
	@Precio float,
	@Stock int,
	@Iva int,
	@Peso float
)
as
begin

update producto set 
	id_marca = @IdMarca,
	id_presentacion = @IdPresentacion,
	id_proveedor = @IdProveedor,
	id_zona = @IdZona,
	codigo = @Codigo,
	descripcion_producto = @DescripcionProducto,
	precio = @Precio,
	stock = @Stock,
	iva = @Iva,
	peso = @Peso
where id_producto = @IdProducto
end
go

/* obtener un producto*/
create procedure producto_obtener(@IdProducto int)
as
begin

select * from producto where id_producto = @IdProducto
end



/* Listar todos los productos */
go
create procedure producto_listar
as
begin
	select * from producto
end
go


/* eliminar producto */
go

create procedure producto_eliminar(
	@IdProducto int
)
as
begin

delete from producto where id_producto = @IdProducto

end

go



/************************* VALIDAMOS SI EXISTE EL PROCEDIMIENTO PROVEEDOR ************************/
go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'proveedor_registrar')
DROP PROCEDURE proveedor_registrar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'proveedor_modificar')
DROP PROCEDURE proveedor_modificar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'proveedor_obtener')
DROP PROCEDURE proveedor_obtener

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'proveedor_listar')
DROP PROCEDURE proveedor_listar

go

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'proveedor_eliminar')
DROP PROCEDURE proveedor_eliminar

go

/************************* PROCEDIMIENTOS PARA CREAR PROVEEDOR ************************/
create procedure proveedor_registrar(
	@IdProveedor int,
	@Descripcion varchar(100)
)
as
begin

insert into proveedor(
	id_proveedor,
	descripcion
	)
values
(
	@IdProveedor,
	@Descripcion
)
end
go

/* modificar producto */
create procedure proveedor_modificar(
	@IdProveedor int,
	@Descripcion varchar(100)
)
as
begin

update proveedor set 
	descripcion = @Descripcion
where id_proveedor = @IdProveedor
end
go

/* obtener un producto*/
create procedure proveedor_obtener(@IdProveedor int)
as
begin

select * from proveedor where id_proveedor = @IdProveedor
end

/* Listar todos los productos */
go
create procedure proveedor_listar
as
begin
	select * from proveedor
end
go


/* eliminar producto */
go

create procedure proveedor_eliminar(
	@IdProveedor int
)
as
begin

delete from proveedor where id_proveedor = @IdProveedor

end

go


/* Reporte de proveedor y product total */
go
create procedure reporte_proveedor_producto
as
begin
	select prov.descripcion as proveedor,sum(stock) AS total
	from producto prod
	inner join proveedor prov on prov.id_proveedor = prod.id_proveedor 
	group by prov.descripcion
end
go

/* Reporte Producto */

go
create procedure reporte_producto
as
begin
	select 
		prov.descripcion as PROVEEDOR,
		pres.descripcion as PRESENTACION,
		ma.descripcion as MARCA,
		zo.descripcion as ZONA,
		prod.codigo as CODIGO,
		prod.descripcion_producto as DESCRIPCION,
		prod.precio AS PRECIO,
		prod.stock AS STOCK,
		prod.iva AS IVA,
		prod.peso AS PESO
	from producto prod
		inner join proveedor prov on prod.id_proveedor = prov.id_proveedor   
		inner join presentacion pres on prod.id_presentacion = pres.id_presentacion    
		inner join marca ma on prod.id_marca = ma.id_marca   
		inner join zona zo on prod.id_zona = zo.id_zona
end
go

/**********************************************************************************/

exec producto_listar;

select * from proveedor
exec proveedor_registrar @IdProveedor = 5,@Descripcion = NULL;

exec producto_registrar 
@IdProducto= 5, 
@IdMarca = null,
@IdPresentacion= null , 
@IdProveedor = 1, 
@IdZona = null , 
@codigo = null, 
@DescripcionProducto = null, 
@Precio = 10, 
@Stock= 5, 
@Iva = NULL,
@Peso = null;

select * from producto;
select * from proveedor;

/* REPORTE GENERAL */
select 
	prov.descripcion as PROVEEDOR,
	pres.descripcion as PRESENTACION,
	ma.descripcion as MARCA,
	zo.descripcion as ZONA,
	prod.codigo as CODIGO,
	prod.descripcion_producto as DESCRIPCION,
	prod.precio AS PRECIO,
	prod.stock AS STOCK,
	prod.iva AS IVA,
	prod.peso AS PESO
from producto prod
inner join proveedor prov on prov.id_proveedor = prod.id_proveedor 
inner join presentacion pres on pres.id_presentacion = prod.id_presentacion  
inner join marca ma on ma.id_marca = prod.id_marca 
inner join zona zo on zo.id_zona = prod.id_zona  ;


/* REPORTE PRODUCTO */
select 
	prov.descripcion as PROVEEDOR,
	pres.descripcion as PRESENTACION,
	ma.descripcion as MARCA,
	zo.descripcion as ZONA,
	prod.codigo as CODIGO,
	prod.descripcion_producto as DESCRIPCION,
	prod.precio AS PRECIO,
	prod.stock AS STOCK,
	prod.iva AS IVA,
	prod.peso AS PESO
from producto prod
inner join proveedor prov on prod.id_proveedor = prov.id_proveedor   
inner join presentacion pres on prod.id_presentacion = pres.id_presentacion    
inner join marca ma on prod.id_marca = ma.id_marca   
inner join zona zo on prod.id_zona = zo.id_zona    ;

/* REPORTE PROVEEDOR Y PRODUCTO */
select prov.descripcion as proveedor,sum(stock) AS total
from producto prod
inner join proveedor prov on prov.id_proveedor = prod.id_proveedor 
group by prov.descripcion
;

select * from producto

exec reporte_proveedor_producto
exec reporte_producto