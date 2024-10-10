import { Component } from '@angular/core';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent {
  line: number = 0;
  column: number = 0;

  title: string = '';

  //Método para la posición del cursor
  updateCursorPosition(event: Event): void {
    const textarea = event.target as HTMLTextAreaElement;
    const text = textarea.value.substring(0, textarea.selectionStart);
    const lines = text.split('\n');
    this.line = lines.length;
    this.column = lines[lines.length - 1].length + 1;
  }

  //Método para leer archivo
  triggerFileInput(): void {
    const fileInput = document.getElementById('fileInput') as HTMLInputElement;
    fileInput.click();
  }

  //Método para un nuevo archivo
  clearContent(): void {
    const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
    textarea.value = '';
    this.title = '';
    this.line = 0;
    this.column = 0;
  }
}