import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Proveedor } from '../models/proveedor';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ProveedorService {

  constructor(private http:HttpClient) { }

  url:string = "https://localhost:7099/Proveedor";

  getProveedor(){
    return this.http.get(this.url+"/listar");
  }

  addProveedor(proveedor:Proveedor):Observable<Proveedor>{
    return this.http.post<Proveedor>(this.url+"/guardar", proveedor);
  }

  updateProveedor(proveedor:Proveedor):Observable<Proveedor>{
    return this.http.put<Proveedor>(this.url +"/modificar", proveedor);
  }

  deleteProveedor(IdProveedor:number){
    return this.http.delete(this.url +"/eliminar?IdProveedor="+ `${IdProveedor}`);
  }

  
}
