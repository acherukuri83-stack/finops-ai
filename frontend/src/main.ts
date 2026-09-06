import {bootstrapApplication} from '@angular/platform-browser';
import {provideHttpClient} from '@angular/common/http';
import {Component, inject} from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {CommonModule} from '@angular/common';
@Component({selector:'app-root',standalone:true,imports:[CommonModule],template:`
<div style="font-family:Arial;max-width:1100px;margin:40px auto;padding:0 20px">
<h1>FinOps AI — Phase 1</h1><p>Simulated Trade & Settlement Operations Platform</p>
<button (click)="load('T100245')">Investigate T100245</button>
<pre *ngIf="data" style="background:#f4f4f4;padding:20px;overflow:auto">{{data | json}}</pre>
<h2>Phase 1 goal</h2><p>Verify the backend truth before adding AI. T100245 should show account SSI participant 1234 vs counterparty participant 5678.</p>
</div>`})
class App { http=inject(HttpClient); data:any; load(id:string){this.http.get('http://localhost:8080/api/trades/'+id+'/investigation').subscribe(v=>this.data=v);} }
bootstrapApplication(App,{providers:[provideHttpClient()]});
