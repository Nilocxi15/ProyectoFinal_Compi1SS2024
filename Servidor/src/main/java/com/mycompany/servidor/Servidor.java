package com.mycompany.servidor;


import analyzers.Lexer;
import analyzers.Parser;
import org.java_websocket.WebSocket;
import org.java_websocket.handshake.ClientHandshake;
import org.java_websocket.server.WebSocketServer;

import java.io.BufferedReader;
import java.io.StringReader;
import java.net.*;

public class Servidor extends WebSocketServer {

  public static void main(String[] args) {
    final int port = 5000;
    Servidor server = new Servidor(port);
    server.start();
    System.out.println("Servidor iniciado en el puerto: " + port);
  }

  public Servidor(int port) {
    super(new InetSocketAddress(port));
  }

  @Override
  public void onOpen(WebSocket webSocket, ClientHandshake clientHandshake) {
    System.out.println("Nueva conexión: " + webSocket.getRemoteSocketAddress());
  }

  @Override
  public void onClose(WebSocket webSocket, int i, String s, boolean b) {
    System.out.println("Conexión cerrada: " + webSocket.getRemoteSocketAddress());
  }

  @Override
  public void onMessage(WebSocket webSocket, String s) {
    String message = s;
    Lexer lexer = new Lexer(new BufferedReader(new StringReader(message)));
    Parser parser = new Parser(lexer);
    try {
      parser.parse();
    } catch (Exception e) {
      e.printStackTrace();
    }
    webSocket.send("Respuesta desde el servidor: " + s);
  }

  @Override
  public void onError(WebSocket webSocket, Exception e) {
    System.out.println("Error: " + e.getMessage());
  }

  @Override
  public void onStart() {
    System.out.println("Servidor iniciado");
  }
}
