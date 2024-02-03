import { Component,OnInit } from '@angular/core';
import { ReporteService } from '../../services/reporte.service';

import  pdfMake from 'pdfmake/build/pdfmake.js';
import  pdfFonts from 'pdfmake/build/vfs_fonts.js';
(pdfMake as any).vfs = pdfFonts.pdfMake.vfs;

@Component({
  selector: 'app-reportes',
  standalone: true,
  imports: [],
  templateUrl: './reportes.component.html',
  styleUrl: './reportes.component.css'
})
export class ReportesComponent  {
  
  constructor(private reporteService:ReporteService){

  }

  datatable:any = [];

  ngOnInit(): void {
    this.onDataTable();
  }

  onDataTable(){
    this.reporteService.getProveedorProducto().subscribe(res => {
      this.datatable = res;
      console.log(res);
    });
  }
 
  reporteProveedorProducto(){
    let datos:any=[["Proveedor","Total"]];
    
    for(let item of this.datatable){
      datos.push([item.proveedor,item.total])

    }
    console.log(datos[0]);
    console.log("Aqui andes de reporte");
    
    var docDefinition = {
      content: [
        {text: 'REPORTE DE PROVEEDORES DE PRODUCTO', fontSize:20 , bold: true},
        {
          
          table: {
            color: '#6576b4',
            
            body: [
              datos
            ],
            
          }
        }
      ]
    };

    pdfMake.createPdf(docDefinition).open();

    
  }

  

  reporteProducto(){

  }

}
