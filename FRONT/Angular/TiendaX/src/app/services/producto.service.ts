import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Producto } from '../models/producto';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProductoService {

  constructor(private http:HttpClient) { }

  url:string = "https://localhost:7099/Producto";

  getProducto(){
    return this.http.get(this.url+"/listar");
  }

  addProducto(producto:Producto):Observable<Producto>{
    console.log(producto)
    return this.http.post<Producto>(this.url+"/guardar", producto);
  }

  updateProducto(producto:Producto):Observable<Producto>{
    return this.http.put<Producto>(this.url +"/modificar", producto);
  }

  deleteProducto(id:number){
    return this.http.delete(this.url +"/eliminar?IdProducto="+ `${id}`);
  }

}
