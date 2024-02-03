using Microsoft.AspNetCore.Mvc;
using Api.Data;
using Api.Models;

namespace Api.Controllers
{
    [ApiController]
    [Route("Producto")]
    public class ProductoController : ControllerBase
    {
        [HttpPost]
        [Route("guardar")]
        public dynamic GuardarProducto([FromBody]Producto oProducto)
        {
            return ProductoData.Registrar(oProducto);
        }

        [HttpGet]
        [Route("listar")]
        public dynamic ListarProducto()
        {
            return ProductoData.Listar();
        }

        [HttpGet]
        [Route("obtener")]
        public dynamic ObtenerProducto(int IdProducto)
        {
            return ProductoData.Obtener(IdProducto);
        }

        [HttpPut]
        [Route("modificar")]
        public dynamic ModificarProducto([FromBody]Producto oProducto)
        {
            return ProductoData.Modificar(oProducto);

        }


       
        [HttpDelete]
        [Route("eliminar")]
        public dynamic EliminarProducto(int IdProducto)
            {
            return ProductoData.Eliminar(IdProducto);

            }
        
    }
}
