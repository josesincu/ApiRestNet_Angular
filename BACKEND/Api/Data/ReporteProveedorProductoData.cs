using System.Data;
using System.Data.SqlClient;
using Api.Models;

namespace Api.Data
{
    public class ReporteProveedorProductoData
    {
        /*_________________________ LISTAR TODOS LOS PRODUCTOS PRODUCTO ________________*/
        public static List<ReporteProveedorProducto> Listar()
        {
            List<ReporteProveedorProducto> oListaProducto = new List<ReporteProveedorProducto>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("reporte_proveedor_producto", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {

                            oListaProducto.Add(new ReporteProveedorProducto()
                            {
                                Proveedor = dr["proveedor"].ToString(),
                                Total = Convert.ToInt32(dr["total"]),
                                
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
