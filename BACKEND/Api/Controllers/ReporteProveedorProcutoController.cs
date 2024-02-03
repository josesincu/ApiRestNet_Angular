using Microsoft.AspNetCore.Mvc;
using Api.Data;
using Api.Models;



namespace Api.Controllers
{
    [ApiController]
    [Route("ReporteProveProducto")]
    public class ReporteProveedorProcutoController : ControllerBase
    {
        [HttpGet]
        [Route("listar")]
        public dynamic ListarProducto()
        {
            return ReporteProveedorProductoData.Listar();
        }
    }
}
