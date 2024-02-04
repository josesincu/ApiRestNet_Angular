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
  datatableProducto:any = [];

  ngOnInit(): void {
    this.onDataTable();
  }

  onDataTable(){
    this.reporteService.getProveedorProducto().subscribe(res => {
      this.datatable = res;
    });

    this.reporteService.getProducto().subscribe(res => {
      this.datatableProducto = res;
    });
  }
 

  reporteProveedorProducto(){
    var dd: any = {
      content: [
          { text: 'REPORTE DE PROVEEDOR POR PRODUCTO\n\n\n', style: 'header' },
          this.tablaProveedorProducto(this.datatable, [{text: 'Proveedor', style: 'tableHeader', alignment: 'center'}, {text: 'Total', style: 'tableHeader', alignment: 'center'}]),
          
          
          
      ],
      styles: {
        header: {
          fontSize: 18,
          bold: true,
          margin: [0, 0, 0, 10]
        },
        subheader: {
          fontSize: 16,
          bold: true,
          margin: [0, 10, 0, 5]
        },
        tableExample: {
          margin: [0, 5, 0, 15]
        },
        tableHeader: {
          bold: true,
          fontSize: 13,
          color: 'black'
        }
      },
      defaultStyle: {
        alignment: 'justify'
      }
    }

    pdfMake.createPdf(dd).download();
    
  }


  reporteProducto(){
    var dd: any = {
      pageSize: 'A3',
      content: [
        
          { text: 'REPORTE PRODUCTO\n\n\n', style: 'header' },
          this.tablaProducto(this.datatableProducto, 
            [{text: 'Proveedor', style: 'tableHeader', alignment: 'center'}, 
             {text: 'Presentacion', style: 'tableHeader', alignment: 'center'},
             {text: 'Marca', style: 'tableHeader', alignment: 'center'},
             {text: 'Zona', style: 'tableHeader', alignment: 'center'},
             {text: 'Codigo', style: 'tableHeader', alignment: 'center'},
             {text: 'Descripcion', style: 'tableHeader', alignment: 'center'},
             {text: 'Precio', style: 'tableHeader', alignment: 'center'},
             {text: 'Stock', style: 'tableHeader', alignment: 'center'},
             {text: 'Iva', style: 'tableHeader', alignment: 'center'},
             {text: 'Peso', style: 'tableHeader', alignment: 'center'},
          ]),
          
          
          
      ],
      styles: {
        header: {
          fontSize: 18,
          bold: true,
          margin: [0, 0, 0, 10]
        },
        subheader: {
          fontSize: 16,
          bold: true,
          margin: [0, 10, 0, 5]
        },
        tableExample: {
          margin: [0, 5, 0, 15]
        },
        tableHeader: {
          bold: true,
          fontSize: 13,
          color: 'black'
        }
      },
      defaultStyle: {
        alignment: 'justify'
      }
    }

    pdfMake.createPdf(dd).download();
    
  }

/*
* construirCuerpoTablaProveedorProducto 
*  nos ayuda a construir el ceuerpo del repote
*  de la tabla y la informacion que lleva.
*/
 
construirCuerpoTablaProveedorProducto(data:any, columns:any) : any {
  var body :any  = [];

  body.push(columns);

  data.forEach(function(row:any) {
      var dataRow:any = [];
    
      Object.entries(row).forEach(([key, value], index) => {
        dataRow.push(value);
        //console.log(key, value, index);
      });
      
      body.push(dataRow);
  });

  return body;
}
/*
* tablaProveedorProducto(datam,columns)
* retora la tabla para crear el pdf.
*
*/ 
tablaProveedorProducto(data:any, columns:any) {
  return {
      table: {
          headerRows: 1,
          body: this.construirCuerpoTablaProveedorProducto(data, columns)
      },
      layout: {
        hLineWidth: function (i:any, node:any) {
          return (i === 0 || i === node.table.body.length) ? 2 : 2;
        },
        vLineWidth: function (i:any, node:any) {
          return (i === 0 || i === node.table.widths.length) ? 2 : 2;
        },
        hLineColor: function (i:any, node:any) {
          return (i === 0 || i === node.table.body.length) ? 'black' : 'green';
        },
        vLineColor: function (i:any, node:any) {
          return (i === 0 || i === node.table.widths.length) ? 'black' : 'green';
        },
        margin:[200,200],
        font:22
        
      }
  };
}


//--------------------- REPORTE PRODUCTO--------------------
/*
* construirCuerpoTablaProveedorProducto 
*  nos ayuda a construir el ceuerpo del repote
*  de la tabla y la informacion que lleva.
*/
 
construirCuerpoTablaProducto(data:any, columns:any) : any {
  var body :any  = [];

  body.push(columns);

  data.forEach(function(row:any) {
      var dataRow:any = [];
    
      Object.entries(row).forEach(([key, value], index) => {
        dataRow.push(value);
        //console.log(key, value, index);
      });
      
      body.push(dataRow);
  });

  return body;
}
/*
* tablaProveedorProducto(datam,columns)
* retora la tabla para crear el pdf.
*
*/ 
tablaProducto(data:any, columns:any) {
  return {
      table: {
          headerRows: 1,
          body: this.construirCuerpoTablaProducto(data, columns)
      },
      layout: {
        hLineWidth: function (i:any, node:any) {
          return (i === 0 || i === node.table.body.length) ? 2 : 2;
        },
        vLineWidth: function (i:any, node:any) {
          return (i === 0 || i === node.table.widths.length) ? 2 : 2;
        },
        hLineColor: function (i:any, node:any) {
          return (i === 0 || i === node.table.body.length) ? 'black' : 'brack';
        },
        vLineColor: function (i:any, node:any) {
          return (i === 0 || i === node.table.widths.length) ? 'black' : 'black';
        },
        margin:[200,200],
        font:22
        
      }
  };
}


}
