import { Component, OnInit } from '@angular/core';
//Importación del analizador jison
import * as parser from '../analyzers/analyzer';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  line: number = 0;
  column: number = 0;
  title: string = '';
  socket: WebSocket;

  constructor() {
    // Crear la conexión WebSocket
    this.socket = new WebSocket('ws://localhost:5000');

    // Manejar eventos de la conexión WebSocket
    this.socket.onopen = () => {
      console.log('Conexión WebSocket abierta');
    };

    this.socket.onmessage = (event) => {
      const message = event.data.toString();
      console.log('Mensaje recibido del servidor:', message);
      this.updateTerminal(message);
    };

    this.socket.onclose = () => {
      console.log('Conexión WebSocket cerrada');
    };

    this.socket.onerror = (error) => {
      console.error('Error en la conexión WebSocket:', error);
    };
  }

  ngOnInit(): void {
    // Cargar contenido del textarea
    this.loadCreateTextareaContent();

    // Agregar event listeners para guardar contenido en localStorage
    const createTextarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
    if (createTextarea) {
      createTextarea.addEventListener('input', this.saveCreateTextareaContent.bind(this));
      createTextarea.addEventListener('keydown', this.handleTabKey.bind(this));
    }
  }

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

  // Método para obtener el contenido del textarea
  getContent(): void {
    const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
    this.sendContent(textarea.value);
  }

  // Método para enviar el contenido del textarea al servidor
  sendContent(scriptCode: string): void {
    if (this.socket.readyState === WebSocket.OPEN) {
      console.log('Enviando contenido al servidor...');
      this.socket.send(scriptCode);
    } else {
      console.error('La conexión WebSocket no está abierta');
    }
  }

  // Método para guardar el contenido de createTextarea en localStorage
  saveCreateTextareaContent(event: Event): void {
    const textarea = event.target as HTMLTextAreaElement;
    localStorage.setItem('createTextareaContent', textarea.value);
  }

  // Método para cargar el contenido de createTextarea desde localStorage
  loadCreateTextareaContent(): void {
    const savedContent = localStorage.getItem('createTextareaContent');
    if (savedContent) {
      const textarea = document.getElementById('scriptTextarea') as HTMLTextAreaElement;
      if (textarea) {
        textarea.value = savedContent;
      }
    }
  }

  // Método para manejar la tecla Tab en el textarea
  handleTabKey(event: KeyboardEvent): void {
    const textarea = event.target as HTMLTextAreaElement;
    if (event.key === 'Tab') {
      event.preventDefault();
      const start = textarea.selectionStart;
      const end = textarea.selectionEnd;

      // Set textarea value to: text before caret + tab + text after caret
      textarea.value = textarea.value.substring(0, start) + '\t' + textarea.value.substring(end);

      // Put caret at right position again
      textarea.selectionStart = textarea.selectionEnd = start + 1;
    }
  }

  //Método para actualizar la terminal
  updateTerminal(result: string): void {
    const terminal = document.getElementById('terminal') as HTMLTextAreaElement;
    terminal.value = result;
  }
}