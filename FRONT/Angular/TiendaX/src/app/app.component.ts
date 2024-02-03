import { Component } from '@angular/core';;
import { ProductoComponent } from './componentes/producto/producto.component';
import { RouterOutlet } from '@angular/router';


@Component({
  selector: 'app-root',
  standalone: true,
  imports: [ProductoComponent,RouterOutlet],
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})

export class AppComponent {
  title = "TiendaX";
  constructor(){
    
  }
 
  

  }
