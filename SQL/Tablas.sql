
/***
* 
*	SE CREA UNA BASES DE DATOS TiendaX SI NO EXISTE
*/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME = 'TiendaX')
  BEGIN
    CREATE DATABASE TiendaX
   END
GO


/*
*
* USAMOS LA BASES DE DATO CREADA RECIENTEMENTE
*/
use TiendaX;


/*
*
*	SE CREAN 5 TABLAS SI NO EXISTEN DICHAS TABLAS SE CREAN LAS CUALES SON:
*	PROVEEDOR
*	MARCA
*	PRESTACION
*	ZONA
*	PRODUCTO
*/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='proveedor' AND xtype='U')
    CREATE TABLE proveedor(
		id_proveedor INT PRIMARY KEY ,
		descripcion VARCHAR(100)
	); 
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='presentacion' AND xtype='U')
	CREATE TABLE presentacion(
		id_presentacion INT PRIMARY KEY,
		descripcion VARCHAR(50)
	); 
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='marca' AND xtype='U')
	CREATE TABLE  marca(
		id_marca INT PRIMARY KEY,
		descripcion VARCHAR(100)
	);
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='zona' AND xtype='U')
	CREATE TABLE zona(
		id_zona INT PRIMARY KEY,
		descripcion VARCHAR(50)
	);
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='producto' AND xtype='U')
	CREATE TABLE producto(
		id_producto INT PRIMARY KEY,
		id_marca INT,
		id_presentacion INT,
		id_proveedor INT,
		id_zona INT,
		codigo INT,
		descripcion_producto VARCHAR(1000),
		precio float NOT NULL,
		stock INT NOT NULL,
		iva INT,
		peso float,

		CONSTRAINT fk_marca FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
		CONSTRAINT fk_presentacion FOREIGN KEY (id_presentacion) REFERENCES presentacion(id_presentacion),
		CONSTRAINT fk_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor),
		CONSTRAINT fk_zona FOREIGN KEY (id_zona) REFERENCES zona(id_zona)
	);
GO

/*
*
* BORRAMOS LAS TABLAS:
*	PRODUCTO
*	MARCA
*	PRESNTACION
*	PROVEEDOR
*	ZONA
*
*/
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS presentacion;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS zona;
