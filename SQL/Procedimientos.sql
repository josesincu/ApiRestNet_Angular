/**
*
*	USAMOS NUESTRA BASES DE DATOS
*
*/
GO
USE TiendaX


/*
*
*  SE BORRAN LOS PROCEDIMIENTOS ALMACENADOS PARA PRODUCTO
*  LAS CUALES SON:
*	PRODUCTO_REGISTRAR
*	PRODUCTO_MODIFICAR
*	PRODUCTO_OBTENER
*	PRODUCTO_LISTAR
*	PRODUCTO_ELIMINAR
*	REPORTE_PROVEEDOR_PRODUCTO
*	REPORTE_PRODUCTO
*
*/

GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'producto_registrar')
	DROP PROCEDURE producto_registrar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'producto_modificar')
	DROP PROCEDURE producto_modificar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'producto_obtener')
	DROP PROCEDURE producto_obtener
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'producto_listar')
	DROP PROCEDURE producto_listar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'producto_eliminar')
	DROP PROCEDURE producto_eliminar

GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'reporte_proveedor_producto')
	DROP PROCEDURE reporte_proveedor_producto
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'reporte_producto')
	DROP PROCEDURE reporte_producto
GO

/*
*
*  SE CREAN LOS PROCEDIMIENTOS ALMACENADOS PARA PRODUCTO
*  CON SUS RESPECTIVOS PARAMETROS LAS CUALES SON:
*	PRODUCTO_REGISTRAR
*	PRODUCTO_MODIFICAR
*	PRODUCTO_OBTENER
*	PRODUCTO_LISTAR
*	PRODUCTO_ELIMINAR
*	REPORTE_PROVEEDOR_PRODUCTO
*	REPORTE_PRODUCTO
*
*/

CREATE PROCEDURE producto_registrar(
	@IdProducto INT,
	@IdMarca INT,
	@IdPresentacion INT,
	@IdProveedor INT,
	@IdZona INT,
	@Codigo INT,
	@DescripcionProducto VARCHAR(1000),
	@Precio FLOAT,
	@Stock INT,
	@Iva INT,
	@Peso FLOAT
)
AS
BEGIN

INSERT INTO producto(
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
VALUES
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
END
GO

/*
*	MODIFICAMOS EL PRODUCTO 
*/

CREATE PROCEDURE producto_modificar(
	@IdProducto INT,
	@IdMarca INT,
	@IdPresentacion INT,
	@IdProveedor INT,
	@IdZona INT,
	@Codigo INT,
	@DescripcionProducto VARCHAR(1000),
	@Precio FLOAT,
	@Stock INT,
	@Iva INT,
	@Peso FLOAT
)
AS
BEGIN

UPDATE producto SET 
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
WHERE id_producto = @IdProducto
END
GO

/*
*
* OBTENEMOS UN PRODUCTO RECIBE COMO PARAMETRO UN INT ID
*/

CREATE PROCEDURE producto_obtener(
	@IdProducto INT
)
AS
BEGIN
	SELECT * FROM producto WHERE id_producto = @IdProducto
END
GO


/*
*
*	LISTAMOS TODOS LOS PRODUCTOS
*
*/

CREATE PROCEDURE producto_listar
AS
BEGIN
	SELECT * FROM producto
END
GO


/* *
*
*	ELIMINAMOS UN PRODUCTO RECIBE PARAMETRO ID 
*/

CREATE PROCEDURE producto_eliminar(
	@IdProducto INT
)
AS
BEGIN
	DELETE FROM producto WHERE id_producto = @IdProducto
END
GO





/*
*
* BORRAMOS  CUALQUIER PROCEDIMIENTO PROVEEDOR PODRIA 
* DAR CONFLICTO DESPUES SI EXISTE DOS IGUALES:
* PROVEEDOR_REGISTRAR
*  PROVEEDOR_MODIFICAR
*  PROVEEDOR_OBTENER
*  PROVEEDOR_LISTAR
*  PROVEEDOR_ELIMINAR
*
*/

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'proveedor_registrar')
	DROP PROCEDURE proveedor_registrar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'proveedor_modificar')
	DROP PROCEDURE proveedor_modificar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'proveedor_obtener')
	DROP PROCEDURE proveedor_obtener
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'proveedor_listar')
	DROP PROCEDURE proveedor_listar
GO

IF EXISTS (SELECT * FROM sys.objects WHERE TYPE = 'P' AND NAME = 'proveedor_eliminar')
	DROP PROCEDURE proveedor_eliminar
GO


/*
*
* CREAMOS CUALQUIER PROCEDIMIENTO PROVEEDOR CON SUS
* RESPECTIVOS PARAMETROS
* PROVEEDOR_REGISTRAR
*  PROVEEDOR_MODIFICAR
*  PROVEEDOR_OBTENER
*  PROVEEDOR_LISTAR
*  PROVEEDOR_ELIMINAR
*
*/

CREATE PROCEDURE proveedor_registrar(
	@IdProveedor INT,
	@Descripcion VARCHAR(100)
)
AS
BEGIN
INSERT INTO proveedor(
	id_proveedor,
	descripcion
)
VALUES
(
	@IdProveedor,
	@Descripcion
)
END
GO

/* 
*	MODIFICAR PROVEEDOR 
*
*/

CREATE PROCEDURE proveedor_modificar(
	@IdProveedor INT,
	@Descripcion VARCHAR(100)
)
AS
BEGIN
	UPDATE proveedor SET 
		descripcion = @Descripcion
	WHERE id_proveedor = @IdProveedor
END
GO

/*
*
* OBTENEMOS UN PROVEEDOR POR SU ID
*
*/

CREATE PROCEDURE proveedor_obtener(@IdProveedor INT)
AS
BEGIN
	SELECT * FROM proveedor WHERE id_proveedor = @IdProveedor
END
GO
/*
*
* OBTENEMOS UNA LISTA DE PROVEEDORES
* 
*/

CREATE PROCEDURE proveedor_listar
AS
BEGIN
	SELECT * FROM proveedor
END
GO


/*
*
* ELIMINAMOS UN PROVEEDOR POR SU ID
*
*/

CREATE PROCEDURE proveedor_eliminar(
	@IdProveedor INT
)
AS
BEGIN
	DELETE FROM proveedor WHERE id_proveedor = @IdProveedor
END
GO


/*
*
* GENERACION DE REPORTE PARA PROVEEDOR:
* REPORTE_PRODUCTO Y PRODUCTO
* REPORTE_PRODUCTO
*/

CREATE PROCEDURE reporte_proveedor_producto
AS
BEGIN
	SELECT prov.descripcion AS proveedor,SUM(stock) AS total
	FROM producto prod
	INNER JOIN proveedor prov ON prov.id_proveedor = prod.id_proveedor 
	GROUP BY prov.descripcion
END
GO

/*
* CREACION PROCEDIMIENTO reporte_producto
*/

CREATE PROCEDURE reporte_producto
AS
BEGIN
	SELECT 
		prov.descripcion AS PROVEEDOR,
		pres.descripcion AS PRESENTACION,
		ma.descripcion AS MARCA,
		zo.descripcion AS ZONA,
		prod.codigo AS CODIGO,
		prod.descripcion_producto AS DESCRIPCION,
		prod.precio AS PRECIO,
		prod.stock AS STOCK,
		prod.iva AS IVA,
		prod.peso AS PESO
	FROM producto prod
		INNER JOIN proveedor prov ON prod.id_proveedor = prov.id_proveedor   
		INNER JOIN presentacion pres ON prod.id_presentacion = pres.id_presentacion    
		INNER JOIN marca ma ON prod.id_marca = ma.id_marca   
		INNER JOIN zona zo ON prod.id_zona = zo.id_zona
END
GO

/*FIN DE PROCEDIMIENTOS ALMACENADOS */



/*
*
*	EXTRAS EJECUCION DE PROCEDIMIENTOS
*
*
*/

exec producto_listar;
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



/*
* 
* SCRIP PARA GENERARL REPORTES
*/
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
inner join zona zo on prod.id_zona = zo.id_zona;

/* REPORTE PROVEEDOR Y PRODUCTO */
select prov.descripcion as proveedor,sum(stock) AS total
from producto prod
inner join proveedor prov on prov.id_proveedor = prod.id_proveedor 
group by prov.descripcion
;




/*******************************************************************************************************/
/*Laptop HP Pavilion

Proveedor: TechWorld Distributors
Marca: HP
Presentación: 15.6 pulgadas
Zona: Internacional*/
INSERT INTO proveedor(id_proveedor,descripcion) VALUES (1,'TechWorld Distributors');
INSERT INTO marca(id_marca,descripcion) VALUES (1,'HP');
INSERT INTO presentacion(id_presentacion,descripcion) VALUES (1,'15.6 pulgadas');
INSERT INTO zona(id_zona,descripcion) VALUES (1,'Internaciona');

/*
Café Arabica Premium

Proveedor: Global Coffee Importers
Marca: BeanElegance
Presentación: Bolsa de 500g
Zona: América Latina
*/

INSERT INTO proveedor(id_proveedor,descripcion) VALUES (2,'Global Coffee Importers');
INSERT INTO marca(id_marca,descripcion) VALUES (2,'BeanElegance');
INSERT INTO presentacion(id_presentacion,descripcion) VALUES (2,'Bolsa de 500g');
INSERT INTO zona(id_zona,descripcion) VALUES (2,'América Latina');

/*
Zapatillas Deportivas Nike Air Max

Proveedor: Athletic Gear Suppliers
Marca: Nike
Presentación: Tallas variadas
Zona: Norteamérica
*/

INSERT INTO proveedor(id_proveedor,descripcion) VALUES (3,'Athletic Gear Suppliers');
INSERT INTO marca(id_marca,descripcion) VALUES (3,'Nike');
INSERT INTO presentacion(id_presentacion,descripcion) VALUES (3,'Tallas variadas');
INSERT INTO zona(id_zona,descripcion) VALUES (3,' Norteamérica');

/*
Aceite de Oliva Extra Virgen

Proveedor: Olive Grove Farms
Marca: PureGold
Presentación: Botella de 1 litro
Zona: Europa
*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (4,'Olive Grove Farms');
INSERT INTO marca(id_marca,descripcion)					VALUES (4,'PureGold');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (4,'Botella de 1 litro');
INSERT INTO zona(id_zona,descripcion)					VALUES (4,'Europa');

/*
Televisor LED Samsung Smart TV

Proveedor: Electronics Hub
Marca: Samsung
Presentación: 55 pulgadas
Zona: Asia
*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (5,'Electronics Hub');
INSERT INTO marca(id_marca,descripcion)					VALUES (5,'Samsung');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (5,'55 pulgadas');
INSERT INTO zona(id_zona,descripcion)					VALUES (5,'Asia');

/*
Libro "Cien años de soledad"

Proveedor: Book Haven Publishers
Marca: García Márquez Ediciones
Presentación: Tapa dura
Zona: Internacional
*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (6,'Book Haven Publishers');
INSERT INTO marca(id_marca,descripcion)					VALUES (6,'García Márquez Ediciones');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (6,'Tapa dura');
INSERT INTO zona(id_zona,descripcion)					VALUES (6,'Internacional');

/*
Juego de Mesa Monopoly

Proveedor: FunPlay Games
Marca: Hasbro
Presentación: Edición clásica
Zona: Norteamérica
*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (7,'FunPlay Games');
INSERT INTO marca(id_marca,descripcion)					VALUES (7,'Hasbro');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (7,'Edición clásica');
INSERT INTO zona(id_zona,descripcion)					VALUES (7,'Norteamérica');

/*
Silla de Oficina Ergonómica

Proveedor: Office Furniture Solutions
Marca: ErgoComfort
Presentación: Negra con ajustes
Zona: Europa

*/
INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (8,'Office Furniture Solutions');
INSERT INTO marca(id_marca,descripcion)					VALUES (8,'ErgoComfort');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (8,'Negra con ajustes');
INSERT INTO zona(id_zona,descripcion)					VALUES (8,'Europa');

/*
Cámara Digital Canon EOS

Proveedor: PhotoTech Suppliers
Marca: Canon
Presentación: Kit con lentes
Zona: Asia
*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (9,'PhotoTech Suppliers');
INSERT INTO marca(id_marca,descripcion)					VALUES (9,'Canon');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (9,'Kit con lentes');
INSERT INTO zona(id_zona,descripcion)					VALUES (9,'Asia');

/*
Smartphone Samsung Galaxy

Proveedor: Mobile Connect Solutions
Marca: Samsung
Presentación: Modelo S21
Zona: Internacional

*/

INSERT INTO proveedor(id_proveedor,descripcion)			VALUES (10,'Mobile Connect Solutions');
INSERT INTO marca(id_marca,descripcion)					VALUES (10,'Samsung');
INSERT INTO presentacion(id_presentacion,descripcion)	VALUES (10,'Modelo S21');
INSERT INTO zona(id_zona,descripcion)					VALUES (10,'Internacional');

SELECT * FROM proveedor;
SELECT * FROM marca;
SELECT * FROM presentacion;
SELECT * FROM zona;
SELECT * FROM producto;