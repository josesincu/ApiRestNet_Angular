# ApiRestNet_Angular
##  En este proyecto consiste en crear una api rest en .net como backend,
##  utilizando como bases de datos sql server y para el front angular/cli.
### HERRAMIENTAS UTILIZADAS:
*   Microsoft Visual Studio 2022
*   Visual Code
*   Sistema Operativo Windows 10
*   Angular/Cli Version 17.
*   .Net 8.0
*   SQL Server Magnement Studio 19

## SCRIP TOP POR MARCA POR ZONA
```SQL
SELECT z.descripcion AS zona, m.descripcion AS marca, COUNT(p.id_producto) AS cantidad_productos
FROM zona z
iNNER JOIN producto p ON p.id_zona = z.id_zona
INNER JOIN marca m ON p.id_marca = m.id_marca
GROUP BY z.id_zona, m.id_marca
ORDER BY z.descripcion, cantidad_productos DESC;
```


## VIDEO:
### Minuto 0:00 - 19:30 Fin explicacion
### Minuto 19:30 -30:00 ejecucion de crud

## https://screenrec.com/share/mXPyERdrbu
## https://drive.google.com/drive/folders/1VKmw9Crr8sa71QqSTMxkoRC6Z8QfPNgB?usp=sharing