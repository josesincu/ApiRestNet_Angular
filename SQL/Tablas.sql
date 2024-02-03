use TiendaX;

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='proveedor' and xtype='U')
    CREATE TABLE proveedor(
		id_proveedor INT PRIMARY KEY ,
		descripcion VARCHAR(100)
	); 
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='presentacion' and xtype='U')
	CREATE TABLE presentacion(
		id_presentacion INT PRIMARY KEY,
		descripcion VARCHAR(50)
	); 
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='marca' and xtype='U')
CREATE TABLE  marca(
	id_marca INT PRIMARY KEY,
	descripcion VARCHAR(100)
);
go

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='zona' and xtype='U')
CREATE TABLE zona(
	id_zona INT PRIMARY KEY,
	descripcion VARCHAR(50)
);
go


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='producto' and xtype='U')
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

/* DELETA TABLE */
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS presentacion;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS zona;


/* INSERT IN TABLE */
INSERT proveedor (id_proveedor,descripcion) VALUES (1,'Zapateria');
INSERT proveedor (id_proveedor,descripcion) VALUES (2,'Camiones');

INSERT producto (id_producto,id_proveedor,precio,stock) VALUES (1,1,10.50,10);

SELECT * FROM TiendaX.dbo.proveedor;
SELECT * FROM TiendaX.dbo.producto;


exec proveedor_obtener 1


select * from proveedor;


select 

