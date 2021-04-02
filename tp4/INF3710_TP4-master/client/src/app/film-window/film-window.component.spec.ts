import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { FilmWindowComponent } from './film-window.component';

describe('FilmWindowComponent', () => {
  let component: FilmWindowComponent;
  let fixture: ComponentFixture<FilmWindowComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ FilmWindowComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(FilmWindowComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
