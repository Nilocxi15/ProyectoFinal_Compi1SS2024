import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ReportsCaptchaComponent } from './reports-captcha.component';

describe('ReportsCaptchaComponent', () => {
  let component: ReportsCaptchaComponent;
  let fixture: ComponentFixture<ReportsCaptchaComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ReportsCaptchaComponent]
    });
    fixture = TestBed.createComponent(ReportsCaptchaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
