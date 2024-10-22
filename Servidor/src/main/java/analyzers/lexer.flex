/*------------  1ra Area: Codigo de Usuario ---------*/
//------> Paquetes,importaciones
package analyzers;
import java_cup.runtime.*;

/*------------  2da Area: Opciones y Declaraciones ---------*/
%%
%{
    //----> Codigo de usuario en sintaxis java
%}

//-------> Directivas
%public
%class Lexer
%cupsym Symbols
%cup
%char
%column
%full
%ignorecase
%line

//------> Expresiones Regulares

//------> Espacios
LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t\f]
InputCharacter = [^\r\n]

//------> Comentarios
CommentContent = ([^<!-]|[^->])
Comment1 = "!!"{InputCharacter}*{LineTerminator}?
DocumentationComment = "<!--" {CommentContent}* "-->"

//Texto
number = [0-9]+
letter = [a-zA-ZÁÉÍÓÚáéíóúñÑ]
hyphen = "-"
underscore = "_"
Http = "http://"
Https = "https://"
signs = [.,:;!?¿¡]
symbols = [#$%&]

//Atributos de HTML
textVal = ({letter}|{number}|{hyphen}|{underscore}|{signs}|{symbols})+
linkVal = ({Http}|{Https}) ([/.:?=&%] | {textVal})+
hexadecimal = "#"[A-Za-z0-9]{6}
fontSize = {number}+"px"
imageSize = {number}+"%"

//------> Estados

%%
/*------------  3raa Area: Reglas Lexicas ---------*/

//-----> Simbolos
//------> Espacios
{WhiteSpace}                     {/* Espacios en blanco, se ignoran */}
{Comment1}                       {/* Comentarios de una linea, se ignoran */ System.out.println("Comentario de una linea");}
{DocumentationComment}           {/* Comentarios multilinea, se ignoran */ System.out.println("Comentario multilinea");}

<YYINITIAL> "="                  { System.out.println("Recognized: = at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Assign, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "+"                  { System.out.println("Recognized: + at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Plus, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "-"                  { System.out.println("Recognized: - at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Minus, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/"                  { System.out.println("Recognized: / at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Div, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "*"                  { System.out.println("Recognized: * at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Mult, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "=="                 { System.out.println("Recognized: == at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Equal, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "!="                 { System.out.println("Recognized: != at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.NotEqual, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "<"                  { System.out.println("Recognized: < at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LessThan, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "<="                 { System.out.println("Recognized: <= at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LessEqual, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> ">"                  { System.out.println("Recognized: > at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.GreaterThan, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> ">="                 { System.out.println("Recognized: >= at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.GreaterEqual, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "||"                 { System.out.println("Recognized: || at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Or, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "&&"                 { System.out.println("Recognized: && at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.And, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "!"                  { System.out.println("Recognized: ! at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Not, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "("                  { System.out.println("Recognized: ( at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ParOpen, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> ")"                  { System.out.println("Recognized: ) at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ParClose, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "\""                 { System.out.println("Recognized: \" at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Quotes, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "["                  { System.out.println("Recognized: [ at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BracketOpen, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "]"                  { System.out.println("Recognized: ] at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BracketClose, (yycolumn + 1), (yyline + 1), (yytext())); }

<YYINITIAL> "C_CC"               { System.out.println("Recognized: C_CC at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Html, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_HEAD"             { System.out.println("Recognized: C_HEAD at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Head, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_TITLE"            { System.out.println("Recognized: C_TITLE at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Title, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_LINK"             { System.out.println("Recognized: C_LINK at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Link, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_BODY"             { System.out.println("Recognized: C_BODY at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Body, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_SPAN"             { System.out.println("Recognized: C_SPAN at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Span, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_INPUT"            { System.out.println("Recognized: C_INPUT at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Input, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_TEXTAREA"         { System.out.println("Recognized: C_TEXTAREA at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Textarea, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_SELECTED"         { System.out.println("Recognized: C_SELECTED at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Select, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_OPTION"           { System.out.println("Recognized: C_OPTION at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Option, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_DIV"              { System.out.println("Recognized: C_DIV at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.DivHtml, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_IMG"              { System.out.println("Recognized: C_IMG at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Img, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_BR"               { System.out.println("Recognized: C_BR at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Br, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_BUTTON"           { System.out.println("Recognized: C_BUTTON at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Button, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_H1"               { System.out.println("Recognized: C_H1 at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.h1, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "C_P"                { System.out.println("Recognized: C_P at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.p, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_CC"              { System.out.println("Recognized: /C_CC at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.HtmlEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_HEAD"            { System.out.println("Recognized: /C_HEAD at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.HeadEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_TITLE"           { System.out.println("Recognized: /C_TITLE at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TitleEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_LINK"            { System.out.println("Recognized: /C_LINK at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LinkEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_BODY"            { System.out.println("Recognized: /C_BODY at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BodyEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_SPAN"            { System.out.println("Recognized: /C_SPAN at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.SpanEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_INPUT"           { System.out.println("Recognized: /C_INPUT at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.InputEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_TEXTAREA"        { System.out.println("Recognized: /C_TEXTAREA at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextareaEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_SELECTED"        { System.out.println("Recognized: /C_SELECTED at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.SelectEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_OPTION"          { System.out.println("Recognized: /C_OPTION at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.OptionEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_DIV"             { System.out.println("Recognized: /C_DIV at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.DivHtmlEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_IMG"             { System.out.println("Recognized: /C_IMG at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ImgEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_BR"              { System.out.println("Recognized: /C_BR at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BrEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_BUTTON"          { System.out.println("Recognized: /C_BUTTON at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ButtonEnd, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_H1"              { System.out.println("Recognized: /C_H1 at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.h1End, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "/C_P"               { System.out.println("Recognized: /C_P at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.pEnd, (yycolumn + 1), (yyline + 1), (yytext())); }

<YYINITIAL> "black"              { System.out.println("Recognized: black at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "olive"              { System.out.println("Recognized: olive at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "teal"               { System.out.println("Recognized: teal at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "red"                { System.out.println("Recognized: red at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "blue"               { System.out.println("Recognized: blue at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "maroon"             { System.out.println("Recognized: maroon at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "navy"               { System.out.println("Recognized: navy at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "gray"               { System.out.println("Recognized: gray at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "lime"               { System.out.println("Recognized: lime at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "fuchsia"            { System.out.println("Recognized: fuchsia at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "green"              { System.out.println("Recognized: green at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "white"              { System.out.println("Recognized: white at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "purple"             { System.out.println("Recognized: purple at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "silver"             { System.out.println("Recognized: silver at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "yellow"             { System.out.println("Recognized: yellow at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "aqua"               { System.out.println("Recognized: aqua at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color, (yycolumn + 1), (yyline + 1), (yytext())); }

<YYINITIAL> "Courier"             { System.out.println("Recognized: Courier at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "Verdana"             { System.out.println("Recognized: Verdana at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "Arial"               { System.out.println("Recognized: Arial at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "Geneva"              { System.out.println("Recognized: Geneva at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "sans-serif"          { System.out.println("Recognized: sans-serif at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily, (yycolumn + 1), (yyline + 1), (yytext()));}

<YYINITIAL> "left"                { System.out.println("Recognized: left at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "right"               { System.out.println("Recognized: right at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "center"              { System.out.println("Recognized: center at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign, (yycolumn + 1), (yyline + 1), (yytext()));}
<YYINITIAL> "justify"             { System.out.println("Recognized: justify at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign, (yycolumn + 1), (yyline + 1), (yytext()));}

<YYINITIAL> "text"                { System.out.println("Recognized: text at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "number"              { System.out.println("Recognized: number at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "radio"               { System.out.println("Recognized: radio at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "checkbox"            { System.out.println("Recognized: checkbox at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type, (yycolumn + 1), (yyline + 1), (yytext())); }

<YYINITIAL> "id"                 { System.out.println("Recognized: id at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.id, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "name"               { System.out.println("Recognized: name at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.name, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "href"               { System.out.println("Recognized: href at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.href, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "background"         { System.out.println("Recognized: background at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Background, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "color"              { System.out.println("Recognized: color at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ColorSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "font-size"          { System.out.println("Recognized: font-size at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontSizeSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "font-family"        { System.out.println("Recognized: font-family at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamilySentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "text-align"         { System.out.println("Recognized: text-align at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlignSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "type"               { System.out.println("Recognized: type at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TypeSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "cols"               { System.out.println("Recognized: cols at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ColsSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "rows"               { System.out.println("Recognized: rows at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.RowsSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "onclick()"          { System.out.println("Recognized: onclick() at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.onclickSentence, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> "alt"                { System.out.println("Recognized: alt at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.altSentence, (yycolumn + 1), (yyline + 1), (yytext())); }

//-------> Simbolos ER
<YYINITIAL> {number}             { System.out.println("Recognized: number at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Number, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> {hexadecimal}        { System.out.println("Recognized: hexadecimal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Hexadecimal, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> {fontSize}           { System.out.println("Recognized: fontSize at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontSize, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> {textVal}            { System.out.println("Recognized: textVal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Text, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> {linkVal}            { System.out.println("Recognized: linkVal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LinkHtml, (yycolumn + 1), (yyline + 1), (yytext())); }
<YYINITIAL> {imageSize}          { System.out.println("Recognized: imageSize at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ImageSize, (yycolumn + 1), (yyline + 1), (yytext())); }

//------> Errores Lexicos
.                       { System.out.println("Error Lexico"+yytext()+" Linea "+yyline+" Columna "+yycolumn);}
