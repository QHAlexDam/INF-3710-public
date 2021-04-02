import { NgModule } from "@angular/core";
import { RouterModule, Routes } from "@angular/router";
import { FilmWindowComponent } from './film-window/film-window.component';
import { LoginWindowComponent } from './login-window/login-window.component';

import { AppComponent } from "./app.component";
//import { HotelComponent } from "./hotel/hotel.component";
//import { RoomComponent } from "./room/room.component";

const routes: Routes = [
  { path: "app", component: AppComponent },
  { path: "login", component: LoginWindowComponent },
  { path: "filmWindow", component: FilmWindowComponent }
  //{ path: "room", component: RoomComponent },
  //{ path: "hotel", component: HotelComponent }
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule { }
