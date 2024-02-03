import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Proveedor } from '../../models/proveedor';
import { ProveedorService } from '../../services/proveedor.service';

@Component({
  selector: 'app-proveedor',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './proveedor.component.html',
  styleUrl: './proveedor.component.css'
})
export class ProveedorComponent {

  constructor(private proveedorService:ProveedorService){

  }

  proveedor:Proveedor = new Proveedor();
  datatable:any = [];

  ngOnInit(): void {
    this.onDataTable();
  }

  onDataTable(){
    this.proveedorService.getProveedor().subscribe(res => {
      this.datatable = res;
      console.log(res);
    });
  }

  onAddProveedor(proveedor:Proveedor):void{
    console.log(proveedor);
    this.proveedorService.addProveedor(proveedor).subscribe(res => {
      if(res){
        alert(`El proveedor ${proveedor.Descripcion} se ha registrado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onUpdateProveedor(proveedor:Proveedor):void{
    console.log(proveedor);
    
    this.proveedorService.updateProveedor(proveedor).subscribe(res => {
      if(res){
        alert(`El proveedor número ${proveedor.IdProveedor} se ha modificado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onDeleteProveedor(IdProveedor:number):void{
    
    this.proveedorService.deleteProveedor(IdProveedor).subscribe(res => {
      if(res){
        alert(`El proveedor número ${IdProveedor} se ha eliminado con exito!`);
        this.clear();
        this.onDataTable();
      } else {
        alert('Error! :(')
      }
    });
  }

  onSetData(select:any){
    this.proveedor.IdProveedor = select.idProveedor;
    this.proveedor.Descripcion = select.descripcion;
  }

  clear(){
    this.proveedor.IdProveedor = 0;
    this.proveedor.Descripcion = "";
  }
}
