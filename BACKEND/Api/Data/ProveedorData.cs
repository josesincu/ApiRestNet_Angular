using Api.Models;
//using System.Data.SqlClient;
using System.Data;
using System.Collections.Generic;
using Microsoft.Data.SqlClient;



namespace Api.Data
{
    public class ProveedorData
    {
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

        /*__________________ OBTENEMOS TODO EL LISTADO DEL PROVEEDORES _____________*/
        public static List<Proveedor> Listar()
        {
            List<Proveedor> oListaProveedor = new List<Proveedor>();

            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {

                SqlCommand cmd = new SqlCommand("proveedor_listar", oConexion);

                cmd.CommandType = CommandType.StoredProcedure;

                try
                {

                    oConexion.Open();

                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            oListaProveedor.Add(new Proveedor()
                            {
                                IdProveedor = Convert.ToInt32(dr["id_proveedor"]),
                                Descripcion = dr["descripcion"].ToString()

                            });

                        }

                    }

                    return oListaProveedor;
                }
                catch (Exception ex)
                {

                    return oListaProveedor;
                }
            }
        }

        /*___________________________ OBTENER UN PROVEEDOR _____________________*/

        public static Proveedor Obtener(int IdProveedor)
        {
            Proveedor oProveedor = new Proveedor();

            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("proveedor_obtener", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProveedor", IdProveedor);

                try
                {
                    oConexion.Open();
                    cmd.ExecuteNonQuery();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {

                        while (dr.Read())
                        {
                            oProveedor = new Proveedor()
                            {
                                IdProveedor = Convert.ToInt32(dr["id_proveedor"]),
                                Descripcion = dr["descripcion"].ToString()

                            };
                        }

                    }



                    return oProveedor;
                }
                catch (Exception ex)
                {
                    return oProveedor;
                }
            }
        }
        /*______________________________________ MODIFICAR DESCRIPCION PROVEEDRO ___________*/
        public static bool Modificar(Proveedor oProveedor)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("proveedor_modificar", oConexion);
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

        /*_________________________________ ELIMINAR UN PROVEEDOR ___________________*/
        public static bool Eliminar(int IdProveedor)
        {
            using (SqlConnection oConexion = new SqlConnection(Conexion.rutaConexion))
            {
                SqlCommand cmd = new SqlCommand("proveedor_eliminar", oConexion);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IdProveedor", IdProveedor);

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
