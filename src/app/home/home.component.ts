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

  // Método para la posición del cursor
  updateCursorPosition(event: Event): void {
    const textarea = event.target as HTMLTextAreaElement;
    const text = textarea.value.substring(0, textarea.selectionStart);
    const lines = text.split('\n');
    this.line = lines.length;
    this.column = lines[lines.length - 1].length + 1;
  }

  // Método para leer archivo
  triggerFileInput(): void {
    this.resetFileInput();
    const fileInput = document.getElementById('fileInput') as HTMLInputElement;
    fileInput.click();
  }

  // Método para resetear el input de archivo
  resetFileInput(): void {
    const fileInput = document.getElementById('fileInput') as HTMLInputElement;
    fileInput.value = '';
  }

  // Método para un nuevo archivo
  clearContent(): void {
    const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
    textarea.value = '';
    this.title = '';
    this.line = 0;
    this.column = 0;
    this.resetFileInput();
  }

  // Método para abrir archivo
  openFile(event: Event): void {
    const input = event.target as HTMLInputElement;
    if (input.files && input.files.length > 0) {
      const file = input.files[0];
      const fileName = file.name;
      const fileExtension = fileName.split('.').pop();

      if (fileExtension === 'cc') {
        const reader = new FileReader();
        reader.onload = () => {
          const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
          textarea.value = reader.result as string;
          this.title = fileName;
          this.updateCursorPosition({ target: textarea } as unknown as Event);
        };
        reader.readAsText(file);
      } else {
        alert('El archivo debe tener una extensión .cc');
      }
    }
  }

  // Método para guardar archivo
  saveFile(): void {
    const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
    const content = textarea.value;
    const blob = new Blob([content], { type: 'text/plain' });
    const link = document.createElement('a');
    link.href = URL.createObjectURL(blob);
    link.download = this.title || 'archivo.cc';
    link.click();
  }

  // Método para guardar archivo como
  saveFileAs(): void {
    const filename = prompt('Ingrese el nombre del archivo:', this.title || 'archivo.cc');
    if (filename) {
      const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
      const content = textarea.value;
      const blob = new Blob([content], { type: 'text/plain' });
      const link = document.createElement('a');
      link.href = URL.createObjectURL(blob);
      link.download = filename.endsWith('.cc') ? filename : `${filename}.cc`;
      link.click();
    }
  }
}