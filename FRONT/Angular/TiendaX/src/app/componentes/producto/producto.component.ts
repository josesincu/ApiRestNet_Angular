import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';

import { ProductoService } from '../../services/producto.service';
import { Producto } from '../../models/producto';

@Component({
  selector: 'app-producto',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './producto.component.html',
  styleUrl: './producto.component.css'
})
export class ProductoComponent {

  constructor(private productoService:ProductoService){

  }

  producto:Producto = new Producto();
  datatable:any = [];

  ngOnInit(): void {
    this.onDataTable();
  }

  onDataTable(){
    this.productoService.getProducto().subscribe(res => {
      this.datatable = res;
      console.log(res);
    });
  }

  onAddProducto(producto:Producto):void{
    console.log(producto);
    this.productoService.addProducto(producto).subscribe(res => {
      if(res){
        alert(`El proveedor ${producto.DescripcionProducto} se ha registrado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onUpdateProducto(producto:Producto):void{
    console.log(producto);
    this.productoService.updateProducto(producto).subscribe(res => {
      if(res){
        alert(`El proveedor número ${producto.IdProducto} se ha modificado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onDeleteProducto(id:number):void{
    this.productoService.deleteProducto(id).subscribe(res => {
      if(res){
        alert(`El proveedor número ${id} se ha eliminado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onSetData(select:any){
    
    this.producto.IdProducto = select.idProducto;
    this.producto.IdMarca = select.idMarca;
    this.producto.IdPresentacion = select.idPresentacion;
    this.producto.IdProveedor = select.idProveedor;
    this.producto.IdZona = select.idZona;
    this.producto.Codigo = select.codigo;
    this.producto.DescripcionProducto = select.descripcionProducto;
    this.producto.Precio = select.precio;
    this.producto.Stock = select.stock;
    this.producto.Iva = select.iva;
    this.producto.Peso = select.peso;
    
  }

  clear(){
    this.producto.IdProducto = 0;
    this.producto.IdMarca = null;
    this.producto.IdPresentacion = null;
    this.producto.IdProveedor = null;
    this.producto.IdZona = null;
    this.producto.Codigo = null;
    this.producto.DescripcionProducto = "";
    this.producto.Precio = 0;
    this.producto.Stock = 0;
    this.producto.Iva = null;
    this.producto.Peso = null;
    
  }

}
