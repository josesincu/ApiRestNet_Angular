using Microsoft.AspNetCore.Mvc;
using Api.Data;
namespace Api.Controllers
{
    [ApiController]
    [Route("ReporteProducto")]
    public class ReporteProductoController : ControllerBase
    {

        [HttpGet]
        [Route("listar")]
        public dynamic ListarProducto()
        {
            return ReporteProductoData.Listar();
        }
    }
}
