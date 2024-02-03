import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Reporte } from '../models/reporte';
import { Observable } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class ReporteService {

  constructor(private http:HttpClient) { }

  url:string = "https://localhost:7099/ReporteProveProducto";

  getProveedorProducto(){
    return this.http.get(this.url+"/listar");
  }
}
