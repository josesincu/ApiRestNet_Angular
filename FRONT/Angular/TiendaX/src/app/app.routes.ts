import { Routes } from '@angular/router';
import { ProductoComponent } from './componentes/producto/producto.component';
import { ProveedorComponent } from './componentes/proveedor/proveedor.component';
import { ReportesComponent } from './componentes/reportes/reportes.component';
export const routes: Routes = [
    {
        path:'producto',
        component :ProductoComponent
    },
    {
        path:'proveedor',
        component : ProveedorComponent
    },
    {
        path:'reporte',
        component : ReportesComponent
    },
    {
        path:'',
        component : ProveedorComponent
    },
    {
        path:'**',
        component : ProveedorComponent
    }

];
