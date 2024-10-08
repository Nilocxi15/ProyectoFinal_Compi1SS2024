import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { RouterModule, Routes } from '@angular/router';

import { AppComponent } from './app.component';
import { ReportsCaptchaComponent } from './reports-captcha/reports-captcha.component';
import { ListCaptchaComponent } from './list-captcha/list-captcha.component';
import { HomeComponent } from './home/home.component';

const routes: Routes = [
  { path: 'home', component: HomeComponent },
  { path: 'list', component: ListCaptchaComponent },
  { path: 'reports', component: ReportsCaptchaComponent },
  { path: '', redirectTo: '/home', pathMatch: 'full' } // Redirección por defecto
];

@NgModule({
  declarations: [
    AppComponent,
    ReportsCaptchaComponent,
    ListCaptchaComponent,
    HomeComponent
  ],
  imports: [
    BrowserModule,
    RouterModule.forRoot(routes) // Asegúrate de usar forRoot
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }