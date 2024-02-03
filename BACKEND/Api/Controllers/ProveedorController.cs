using Microsoft.AspNetCore.Mvc;
using Api.Data;
using Api.Models;  

namespace Api.Controllers
{
    [ApiController]
    [Route("Proveedor")]
    public class ProveedorController : ControllerBase
    {

        [HttpPost]
        [Route("guardar")]
        public dynamic GuardarProveedor([FromBody] Proveedor oProveedor)
        {

            return ProveedorData.Registrar(oProveedor);

        }

        [HttpGet]
        [Route("listar")]
        public dynamic ListarProveedor()
        {
            return ProveedorData.Listar();
            
        }

        [HttpGet]
        [Route("obtener")]
        public dynamic ObtenerProveedor(int IdProveedor)
        {
            return ProveedorData.Obtener(IdProveedor);

        }


        [HttpPut]
        [Route("modificar")]
        public dynamic ModifcarProveedor([FromBody] Proveedor oProveedor)
        {
            return ProveedorData.Modificar(oProveedor);
        }

        [HttpDelete]
        [Route("eliminar")]
        public dynamic EliminarProveedor(int IdProveedor)
        {
            return ProveedorData.Eliminar(IdProveedor);

        }


        
    }
}
