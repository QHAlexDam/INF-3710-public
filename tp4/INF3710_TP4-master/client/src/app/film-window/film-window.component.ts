import { Router, ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';

@Component({
  selector: 'app-film-window',
  templateUrl: './film-window.component.html',
  styleUrls: ['./film-window.component.css']
})
export class FilmWindowComponent implements OnInit {

  public isAddFilm: boolean;
  public form: FormGroup = new FormGroup({
    title: new FormControl(""),
  });

  public constructor(public router: Router, public route: ActivatedRoute) { }

  ngOnInit(): void {
  }

  public signOut(): void {
    this.router.navigate([`../login`], { relativeTo: this.route })
    .catch(() => {
      console.log("navigation error");
    });
  }
}
