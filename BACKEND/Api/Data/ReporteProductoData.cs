using System.Data;
using System.Data.SqlClient;
using Api.Models;

namespace Api.Data
{
    public class ReporteProductoData
    {
        /*_________________________ LISTAR TODOS LOS PRODUCTOS PRODUCTO ________________*/
        public static List<ReporteProducto> Listar()
        {
            List<ReporteProducto> oListaProducto = new List<ReporteProducto>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("reporte_producto", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {

                            oListaProducto.Add(new ReporteProducto()
                            {
                                Proveedor = dr["PROVEEDOR"].ToString(),
                                Presentacion = dr["PRESENTACION"].ToString(),
                                Marca = dr["MARCA"].ToString(),
                                Zona = dr["ZONA"].ToString(),
                                Codigo = Convert.ToInt32(dr["CODIGO"]),
                                Descripcion = dr["DESCRIPCION"].ToString(),
                                Precio = Convert.ToDouble(dr["PRECIO"]),
                                Stock = Convert.ToInt32(dr["STOCK"]),
                                Iva = Convert.ToInt32(dr["IVA"]),
                                Peso = Convert.ToDouble(dr["PESO"])

                            });

                        }

                    }



                    return oListaProducto;
                }
                catch (Exception ex)
                {
                    return oListaProducto;
                }
            }
        }


    }
}
