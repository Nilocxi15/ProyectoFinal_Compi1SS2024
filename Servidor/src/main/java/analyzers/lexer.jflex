/*------------  1ra Area: Codigo de Usuario ---------*/
//------> Paquetes,importaciones
package analyzers;

import java_cup.runtime.*;

/*------------  2da Area: Opciones y Declaraciones ---------*/
%%

//-------> Directivas
%public
%class L_Analyzer_trivias
%cupsym Symbols_trivias
%cup
%char
%column
%full
%ignorecase //Te recordas de moverle esta cosa dependiendo de lo que diga el auxi
%line

//------> Expresiones Regulares
LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]

//------> Estados

%%


/*------------  3ra Area: Reglas Lexicas ---------*/


//-----> Simbolos


//-------> Simbolos ER
{WhiteSpace} {/* Ignorar espacios en blanco */}

//------> Errores Lexicos
. { System.out.println("Error: Caracter no valido: " + yytext()); }