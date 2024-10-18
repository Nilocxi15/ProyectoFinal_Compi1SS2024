cd D:\Documentos\DocumentosUSAC\Compi1\ProyectoFinal\generator-web\Servidor\src\main\java\analyzers
echo "Eliminando analizadores anteriores"
del Lexer.java
del Parser.java
del Symbols.java
echo "Generando analizadores"
java -jar D:\Documentos\DocumentosUSAC\Compi1\Recursos\jflex-full-1.9.1.jar lexer.flex
java -jar D:\Documentos\DocumentosUSAC\Compi1\Recursos\java-cup-11b.jar -parser Parser -symbols Symbols parser.cup
