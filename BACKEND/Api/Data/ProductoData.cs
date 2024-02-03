using System.Data;
using System.Data.SqlClient;
using Api.Models;
using Microsoft.Identity.Client;

namespace Api.Data
{
    public class ProductoData
    {
        /*_________________________ REGISTRAR UN NUEVO PRODUCTO ________________*/
        public static bool Registrar(Producto oProducto) 
        {
            
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("producto_registrar", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", oProducto.IdProducto);
                cmd.Parameters.AddWithValue("@IdMarca", oProducto.IdMarca != null ? oProducto.IdMarca: DBNull.Value );
                cmd.Parameters.AddWithValue("@IdPresentacion", oProducto.IdPresentacion != null ? oProducto.IdPresentacion : DBNull.Value);
                cmd.Parameters.AddWithValue("@IdProveedor", oProducto.IdProveedor != null ? oProducto.IdProveedor : DBNull.Value);
                cmd.Parameters.AddWithValue("@IdZona", oProducto.IdZona != null ? oProducto.IdZona : DBNull.Value);
                cmd.Parameters.AddWithValue("@Codigo", oProducto.Codigo != null ? oProducto.Codigo : DBNull.Value);
                cmd.Parameters.AddWithValue("@DescripcionProducto", oProducto.DescripcionProducto != null ? oProducto.DescripcionProducto : DBNull.Value);
                cmd.Parameters.AddWithValue("@Precio", oProducto.Precio);
                cmd.Parameters.AddWithValue("@Stock", oProducto.Stock);
                cmd.Parameters.AddWithValue("@Iva", oProducto.Iva != null ? oProducto.Iva : DBNull.Value);
                cmd.Parameters.AddWithValue("@Peso", oProducto.Peso != null ? oProducto.Peso : DBNull.Value);

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

        /*_________________________ LISTAR TODOS LOS PRODUCTOS PRODUCTO ________________*/
        public static List<Producto> Listar()
        {
            List<Producto> oListaProducto = new List<Producto>();
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("producto_listar", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                           
                            oListaProducto.Add(new Producto()
                            {
                                IdProducto = Convert.ToInt32(dr["id_producto"]),
                                IdMarca = dr["id_marca"] != DBNull.Value ? Convert.ToInt32(dr["id_marca"]) : null,
                                IdPresentacion = dr["id_presentacion"] != DBNull.Value ? Convert.ToInt32(dr["id_presentacion"]) : null,
                                IdProveedor = dr["id_proveedor"] != DBNull.Value ?  Convert.ToInt32(dr["id_proveedor"]) : null,
                                IdZona = dr["id_zona"] != DBNull.Value ?  Convert.ToInt32(dr["id_zona"]) : null,
                                Codigo = dr["codigo"] != DBNull.Value ? Convert.ToInt32(dr["codigo"]) : null,
                                DescripcionProducto = dr["descripcion_producto"] != DBNull.Value ?  dr["descripcion_producto"].ToString() : "",
                                Precio = dr["precio"] != DBNull.Value ? Convert.ToDouble(dr["precio"]) : 0.0,
                                Stock = dr["stock"] != DBNull.Value ? Convert.ToInt32(dr["stock"]) : 0,
                                Iva = dr["iva"] != DBNull.Value ? Convert.ToInt32(dr["iva"]) : null,
                                Peso = dr["peso"] != DBNull.Value ? Convert.ToDouble(dr["peso"]) : null
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

        /*_________________________ OBTENEMOS UN SOLO PRODUCTO ________________*/
        public static Producto Obtener(int IdProducto)
        {
            Producto oProducto = new Producto();

            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("producto_obtener", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", IdProducto);

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            
                            oProducto = new Producto()
                            {
                                IdProducto = Convert.ToInt32(dr["id_producto"]),
                                IdMarca = dr["id_marca"] != DBNull.Value ? Convert.ToInt32(dr["id_marca"]) : 0,
                                IdPresentacion = dr["id_presentacion"] != DBNull.Value ? Convert.ToInt32(dr["id_presentacion"]) : 0,
                                IdProveedor = dr["id_proveedor"] != DBNull.Value ? Convert.ToInt32(dr["id_proveedor"]) : 0,
                                IdZona = dr["id_zona"] != DBNull.Value ? Convert.ToInt32(dr["id_zona"]) : 0,
                                Codigo = dr["codigo"] != DBNull.Value ? Convert.ToInt32(dr["codigo"]) : 0,
                                DescripcionProducto = dr["descripcion_producto"] != DBNull.Value ? dr["descripcion_producto"].ToString() : "",
                                Precio = dr["precio"] != DBNull.Value ? Convert.ToDouble(dr["precio"]) : 0.0,
                                Stock = dr["stock"] != DBNull.Value ? Convert.ToInt32(dr["stock"]) : 0,
                                Iva = dr["iva"] != DBNull.Value ? Convert.ToInt32(dr["iva"]) : 0,
                                Peso = dr["peso"] != DBNull.Value ? Convert.ToDouble(dr["peso"]) : 0.0
                            };
                            
                        }

                    }



                    return oProducto;
                }
                catch (Exception ex)
                {
                    return oProducto;
                }
            }
        }

        /*_________________________ MODIFCAR UN  PRODUCTO ________________*/
        public static bool Modificar(Producto oProducto)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("producto_modificar", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", oProducto.IdProducto);
                cmd.Parameters.AddWithValue("@IdMarca", oProducto.IdMarca != null ? oProducto.IdMarca : DBNull.Value);
                cmd.Parameters.AddWithValue("@IdPresentacion", oProducto.IdPresentacion != null ? oProducto.IdPresentacion : DBNull.Value);
                cmd.Parameters.AddWithValue("@IdProveedor", oProducto.IdProveedor != null ? oProducto.IdProveedor : DBNull.Value);
                cmd.Parameters.AddWithValue("@IdZona", oProducto.IdZona != null ? oProducto.IdZona : DBNull.Value);
                cmd.Parameters.AddWithValue("@Codigo", oProducto.Codigo != null ? oProducto.Codigo : DBNull.Value);
                cmd.Parameters.AddWithValue("@DescripcionProducto", oProducto.DescripcionProducto != null ? oProducto.DescripcionProducto : DBNull.Value);
                cmd.Parameters.AddWithValue("@Precio", oProducto.Precio);
                cmd.Parameters.AddWithValue("@Stock", oProducto.Stock);
                cmd.Parameters.AddWithValue("@Iva", oProducto.Iva != null ? oProducto.Iva : DBNull.Value);
                cmd.Parameters.AddWithValue("@Peso", oProducto.Peso != null ? oProducto.Peso : DBNull.Value);

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

    
        /*_________________________ ELIMINAMOS UN  PRODUCTO ________________*/
        public static bool Eliminar(int IdProducto)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("producto_eliminar", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProducto", IdProducto);

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

    }
}
