import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListCaptchaComponent } from './list-captcha.component';

describe('ListCaptchaComponent', () => {
  let component: ListCaptchaComponent;
  let fixture: ComponentFixture<ListCaptchaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ListCaptchaComponent]
    });
    fixture = TestBed.createComponent(ListCaptchaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
