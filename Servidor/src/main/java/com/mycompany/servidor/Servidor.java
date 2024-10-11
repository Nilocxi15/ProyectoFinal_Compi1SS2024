package com.mycompany.servidor;

import java.net.*;
import java.io.*;

public class Servidor {

    public static void main(String[] args) {

        ServerSocket servidor = null;
        Socket sc = null;
        DataInputStream in;
        DataOutputStream out;

        final int PUERTO = 5000;

        try {
            servidor = new ServerSocket(PUERTO);
            System.out.println("Servidor iniciado");

            while (true) {
                sc = servidor.accept();

                System.out.println("Cliente conectado");
                in = new DataInputStream(sc.getInputStream());
                out = new DataOutputStream(sc.getOutputStream());

                String mensaje = in.readUTF();

                String response = "";

                out.writeUTF(response);

                sc.close();
                System.out.println("Cliente desconectado");
            }

        } catch (IOException e) {
            System.out.println("Error: no se pudo iniciar el servidor");
            System.out.println(e.getMessage());
        }
    }

}
