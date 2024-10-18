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

//Atributos de HTML
textVal = ({letter}|{number}|{hyphen}|{underscore})+
linkVal = ({Http}|{Https}) ([/.:?=&%] | {textVal})+
hexadecimal = "#"[A-Z0-9]{6}
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

<YYINITIAL> "="                  { System.out.println("Recognized: = at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Assign); }
<YYINITIAL> "+"                  { System.out.println("Recognized: + at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Plus); }
<YYINITIAL> "-"                  { System.out.println("Recognized: - at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Minus); }
<YYINITIAL> "/"                  { System.out.println("Recognized: / at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Div); }
<YYINITIAL> "*"                  { System.out.println("Recognized: * at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Mult); }
<YYINITIAL> "=="                 { System.out.println("Recognized: == at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Equal); }
<YYINITIAL> "!="                 { System.out.println("Recognized: != at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.NotEqual); }
<YYINITIAL> "<"                  { System.out.println("Recognized: < at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LessThan); }
<YYINITIAL> "<="                 { System.out.println("Recognized: <= at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LessEqual); }
<YYINITIAL> ">"                  { System.out.println("Recognized: > at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.GreaterThan); }
<YYINITIAL> ">="                 { System.out.println("Recognized: >= at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.GreaterEqual); }
<YYINITIAL> "||"                 { System.out.println("Recognized: || at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Or); }
<YYINITIAL> "&&"                 { System.out.println("Recognized: && at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.And); }
<YYINITIAL> "!"                  { System.out.println("Recognized: ! at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Not); }
<YYINITIAL> "("                  { System.out.println("Recognized: ( at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ParOpen); }
<YYINITIAL> ")"                  { System.out.println("Recognized: ) at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ParClose); }
<YYINITIAL> "\""                 { System.out.println("Recognized: \" at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Quotes); }
<YYINITIAL> "["                  { System.out.println("Recognized: [ at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BracketOpen); }
<YYINITIAL> "]"                  { System.out.println("Recognized: ] at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BracketClose); }

<YYINITIAL> "C_CC"               { System.out.println("Recognized: C_CC at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Html); }
<YYINITIAL> "C_HEAD"             { System.out.println("Recognized: C_HEAD at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Head); }
<YYINITIAL> "C_TITLE"            { System.out.println("Recognized: C_TITLE at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Title); }
<YYINITIAL> "C_LINK"             { System.out.println("Recognized: C_LINK at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Link); }
<YYINITIAL> "C_BODY"             { System.out.println("Recognized: C_BODY at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Body); }
<YYINITIAL> "C_SPAN"             { System.out.println("Recognized: C_SPAN at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Span); }
<YYINITIAL> "C_INPUT"            { System.out.println("Recognized: C_INPUT at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Input); }
<YYINITIAL> "C_TEXTAREA"         { System.out.println("Recognized: C_TEXTAREA at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Textarea); }
<YYINITIAL> "C_SELECTED"         { System.out.println("Recognized: C_SELECTED at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Select); }
<YYINITIAL> "C_OPTION"           { System.out.println("Recognized: C_OPTION at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Option); }
<YYINITIAL> "C_DIV"              { System.out.println("Recognized: C_DIV at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.DivHtml); }
<YYINITIAL> "C_IMG"              { System.out.println("Recognized: C_IMG at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Img); }
<YYINITIAL> "C_BR"               { System.out.println("Recognized: C_BR at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Br); }
<YYINITIAL> "C_BUTTON"           { System.out.println("Recognized: C_BUTTON at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Button); }
<YYINITIAL> "C_H1"               { System.out.println("Recognized: C_H1 at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.h1); }
<YYINITIAL> "C_P"                { System.out.println("Recognized: C_P at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.p); }
<YYINITIAL> "/C_CC"              { System.out.println("Recognized: /C_CC at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.HtmlEnd); }
<YYINITIAL> "/C_HEAD"            { System.out.println("Recognized: /C_HEAD at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.HeadEnd); }
<YYINITIAL> "/C_TITLE"           { System.out.println("Recognized: /C_TITLE at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TitleEnd); }
<YYINITIAL> "/C_LINK"            { System.out.println("Recognized: /C_LINK at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LinkEnd); }
<YYINITIAL> "/C_BODY"            { System.out.println("Recognized: /C_BODY at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BodyEnd); }
<YYINITIAL> "/C_SPAN"            { System.out.println("Recognized: /C_SPAN at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.SpanEnd); }
<YYINITIAL> "/C_INPUT"           { System.out.println("Recognized: /C_INPUT at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.InputEnd); }
<YYINITIAL> "/C_TEXTAREA"        { System.out.println("Recognized: /C_TEXTAREA at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextareaEnd); }
<YYINITIAL> "/C_SELECTED"        { System.out.println("Recognized: /C_SELECTED at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.SelectEnd); }
<YYINITIAL> "/C_OPTION"          { System.out.println("Recognized: /C_OPTION at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.OptionEnd); }
<YYINITIAL> "/C_DIV"             { System.out.println("Recognized: /C_DIV at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.DivHtmlEnd); }
<YYINITIAL> "/C_IMG"             { System.out.println("Recognized: /C_IMG at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ImgEnd); }
<YYINITIAL> "/C_BR"              { System.out.println("Recognized: /C_BR at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.BrEnd); }
<YYINITIAL> "/C_BUTTON"          { System.out.println("Recognized: /C_BUTTON at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ButtonEnd); }
<YYINITIAL> "/C_H1"              { System.out.println("Recognized: /C_H1 at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.h1End); }
<YYINITIAL> "/C_P"               { System.out.println("Recognized: /C_P at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.pEnd); }

<YYINITIAL> "black"              { System.out.println("Recognized: black at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "olive"              { System.out.println("Recognized: olive at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "teal"               { System.out.println("Recognized: teal at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "red"                { System.out.println("Recognized: red at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "blue"               { System.out.println("Recognized: blue at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "maroon"             { System.out.println("Recognized: maroon at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "navy"               { System.out.println("Recognized: navy at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "gray"               { System.out.println("Recognized: gray at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "lime"               { System.out.println("Recognized: lime at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "fuchsia"            { System.out.println("Recognized: fuchsia at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "green"              { System.out.println("Recognized: green at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "white"              { System.out.println("Recognized: white at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "purple"             { System.out.println("Recognized: purple at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "silver"             { System.out.println("Recognized: silver at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "yellow"             { System.out.println("Recognized: yellow at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }
<YYINITIAL> "aqua"               { System.out.println("Recognized: aqua at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Color); }

<YYINITIAL> "Courier"             { System.out.println("Recognized: Courier at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily);}
<YYINITIAL> "Verdana"             { System.out.println("Recognized: Verdana at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily);}
<YYINITIAL> "Arial"               { System.out.println("Recognized: Arial at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily);}
<YYINITIAL> "Geneva"              { System.out.println("Recognized: Geneva at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily);}
<YYINITIAL> "sans-serif"          { System.out.println("Recognized: sans-serif at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamily);}

<YYINITIAL> "left"                { System.out.println("Recognized: left at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign);}
<YYINITIAL> "right"               { System.out.println("Recognized: right at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign);}
<YYINITIAL> "center"              { System.out.println("Recognized: center at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign);}
<YYINITIAL> "justify"             { System.out.println("Recognized: justify at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlign);}

<YYINITIAL> "text"                { System.out.println("Recognized: text at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type); }
<YYINITIAL> "number"              { System.out.println("Recognized: number at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type); }
<YYINITIAL> "radio"               { System.out.println("Recognized: radio at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type); }
<YYINITIAL> "checkbox"            { System.out.println("Recognized: checkbox at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Type); }

<YYINITIAL> "id"                 { System.out.println("Recognized: id at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.id); }
<YYINITIAL> "name"               { System.out.println("Recognized: name at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.name); }
<YYINITIAL> "href"               { System.out.println("Recognized: href at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.href); }
<YYINITIAL> "background"         { System.out.println("Recognized: background at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Background); }
<YYINITIAL> "color"              { System.out.println("Recognized: color at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ColorSentence); }
<YYINITIAL> "font-size"          { System.out.println("Recognized: font-size at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontSizeSentence); }
<YYINITIAL> "font-family"        { System.out.println("Recognized: font-family at line " + (yyline + 1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontFamilySentence); }
<YYINITIAL> "text-align"         { System.out.println("Recognized: text-align at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TextAlignSentence); }
<YYINITIAL> "type"               { System.out.println("Recognized: type at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.TypeSentence); }
<YYINITIAL> "cols"               { System.out.println("Recognized: cols at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ColsSentence); }
<YYINITIAL> "rows"               { System.out.println("Recognized: rows at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.RowsSentence); }
<YYINITIAL> "onclick()"          { System.out.println("Recognized: onclick() at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.onclickSentence); }
<YYINITIAL> "alt"                { System.out.println("Recognized: alt at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.altSentence); }

//-------> Simbolos ER
<YYINITIAL> {number}             { System.out.println("Recognized: number at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Number); }
<YYINITIAL> {hexadecimal}        { System.out.println("Recognized: hexadecimal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Hexadecimal); }
<YYINITIAL> {fontSize}           { System.out.println("Recognized: fontSize at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.FontSize); }
<YYINITIAL> {textVal}            { System.out.println("Recognized: textVal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.Text); }
<YYINITIAL> {linkVal}            { System.out.println("Recognized: linkVal at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.LinkHtml); }
<YYINITIAL> {imageSize}          { System.out.println("Recognized: imageSize at line " + (yyline +1) + ", column " + (yycolumn + 1) + ", text: " + yytext()); return new Symbol(Symbols.ImageSize); }

//------> Errores Lexicos
.                       { System.out.println("Error Lexico"+yytext()+" Linea "+yyline+" Columna "+yycolumn);}
