# Manual Tecnico
### En nuestro proyecto utilizamos .net para construir la api como backend
### y para para la parte frontend utilice angular/cli
### y nuestra bases de datos fue sql server.

## SQL SERVER:
### Se creo una base de datos de llamada TiendaX
```sql
/***
* 
*	SE CREA UNA BASES DE DATOS TiendaX SI NO EXISTE
*/

IF NOT EXISTS(SELECT * FROM sys.databases WHERE NAME = 'TiendaX')
  BEGIN
    CREATE DATABASE TiendaX
   END
GO
```
### La base de datos contendra las siguientes tablas.
* PROVEEDOR
* MARCA
* PRESENTACION
* ZONA
* PRODUCTO
### cada tabla contiene sus atributos propios.
### comando para crear una tabla se verifica si no existe primero y despues se crea con sus atributos.
```SQL
IF NOT EXISTS (SELECT * FROM sysobjects WHERE NAME='proveedor' AND xtype='U')
    CREATE TABLE proveedor(
		id_proveedor INT PRIMARY KEY ,
		descripcion VARCHAR(100)
	); 
GO
```
### Tambien  los comandos para borrar las tablas si ya no lo necesitamos si existes los borramos y sino no pasa nada.
```SQL
DROP TABLE IF EXISTS producto;
DROP TABLE IF EXISTS marca;
DROP TABLE IF EXISTS presentacion;
DROP TABLE IF EXISTS proveedor;
DROP TABLE IF EXISTS zona;
```
### PROCEDIMIENTOS ALMACENADOS
### En esta parta se crearon procedimientos para facilitar las consultas como crear,modificar,obtener o eliminar un proveedor o producto en la tabla. Tenemos los siguetes procesos.

* proveedor_guardar
* proveedor_obtener
* proveedor_listar
* proveedor_modificar
* proveedor_eliminar
* producto_guardar
* producto_obtener
* producto_listar
* producto_modificar
* producto_eliminar
* reporte_proveedor_producto
* reporte_producto

### Este es la forma de crear un procedimiento cada una de ellos lleva parametros y otras no los parametros son las que van en @.
```sql
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
```
## .NET
### En .net se creo la parte de backend en la cual  su estrutura esta de la siguiete manera.
* CONTROLLERS
* DATA
* MODELS
  
### CONTROLLERS:
### En esta parte se crearon los endpoints para proveedor, producto y reporte. Los endpointes teneos los siguientes:
*   /Proveedor/guardar
*   /Proveedor/obtener
*   /Proveedor/listar
*   /Proveedor/modifcar
*   /Proveedor/eliminar
*   /Producto/guardar
*   /Producto/obtener
*   /Producto/listar
*   /Producto/modifcar
*   /Producto/eliminar
*   /ReporteProveedorProducto/listar
*   /ReporteProducto/listar



### DATA:
### En esta parte se crearon para la data los siguientes proveedor, producto, reporte. Cada una utilizando el paquete de Microsoft Data SqlCliente para realizar las conexiones con la bases de datos. Este metodo Registrar se utilizo para registrar un proveedor recibiendo como parametro un modelo proveedor, ejecutanto las conexiones,procedimientos.

```c#
/*___________________________ REGISTRAR ______________*/
public static bool Registrar(Proveedor oProveedor)
{
    using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
    {
        SqlCommand cmd = new SqlCommand("proveedor_registrar", oConexion);
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@IdProveedor", oProveedor.IdProveedor);
        cmd.Parameters.AddWithValue("@Descripcion", oProveedor.Descripcion);
        try
        {
            
            oConexion.Open();
            cmd.ExecuteNonQuery();
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }
}
```

### MODEL:
### En esta parte solo tenemos los modelos de clases como proveedor,producto,reporte y que nos sirven para mandar  o recibir nuestra entrada como un json. Tenemos Nuestra clase modelo proveedor.
```c#
namespace Api.Models
{
    public class Proveedor
    {
        public int IdProveedor { get; set; }
        public string Descripcion { get; set; }
    }
}
```


## ANGULAR FRONT:
### En esta seccion tres carpetas dentro de la app las cuales son los siguientes.
* Componentes
* Models
* Services
  
### COMPONENTES:
### En  la carpeta componente se crearon los componentes como:
* Producto
* Proveedor
* Reporte
  
### Cada una con sus estilos,formularios.

### MODELS:
### En  la carpeta models se crearon los clases como:
* Producto
* Proveedor
* Reporte
  
### que seria nuestra estructura para nuestra informormacion que recibimos y mandamos.
```typescript
export class Producto {
    IdProducto : number = 0;
	IdMarca : number | null = null;
	IdPresentacion : number | null = null;
	IdProveedor : number | null= null;
	IdZona : number | null = null ;
	Codigo : number | null = null;
	DescripcionProducto : string = "";
	Precio : number = 0;
	Stock : number = 0;
	Iva : number | null = null;
	Peso :number | null = null;


}
```
### Tenemos el modelo de producto que tenemso datos number o null en dado caso que no recibamos parametros y poder validar eso.


### SERVICE:
### En  la carpeta service se crearon los clases como:
* Producto
* Proveedor
* Reporte
  
### aqui es donde se crearon los endpointes para conectar con nuesto servico de backend.
```typescript
import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Proveedor } from '../models/proveedor';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProveedorService {

  constructor(private http:HttpClient) { }

  url:string = "https://localhost:7099/Proveedor";

  getProveedor(){
    return this.http.get(this.url+"/listar");
  }

  addProveedor(proveedor:Proveedor):Observable<Proveedor>{
    return this.http.post<Proveedor>(this.url+"/guardar", proveedor);
  }

  updateProveedor(proveedor:Proveedor):Observable<Proveedor>{
    return this.http.put<Proveedor>(this.url +"/modificar", proveedor);
  }

  deleteProveedor(IdProveedor:number){
    return this.http.delete(this.url +"/eliminar?IdProveedor="+ `${IdProveedor}`);
  }

  
}
```
### Aqui tenemos nuestra endpoints de proveedor como obtener,crear,actualizar y eliminar.




