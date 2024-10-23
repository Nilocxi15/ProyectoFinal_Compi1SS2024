#! /bin/bash
clear
cd /home/javier/Documentos/Progra/Compi1/ProyectoFinal_Compi1SS2024/Servidor/src/main/java/analyzers
echo "STARTING JFLEX COMPILING"
java -jar /home/javier/Escritorio/Recursos/jflex-full-1.9.1.jar lexer.flex
echo "STARTING CUP COMPILING"
java -jar /home/javier/Escritorio/Recursos/java-cup-11b.jar -parser Parser -symbols Symbols parser.cup
