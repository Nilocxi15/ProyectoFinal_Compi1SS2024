/*Analisis léxico*/
%lex
%option case-sensitive

%%

/*Expresiones Regulares*/
[ \t\r\n\f]     {/* Ignorar espacios en blanco */}

//Comentarios
"!!".*\b          return 'comentario1'
"<!--".*"-->"\b   return 'comentario2' 

//Simbolos para operaciones
"+"             return 'mas'
"-"             return 'menos'
"/"             return 'div'
"*"             return 'por'
"=="            return 'igual'
"!="            return 'distinto'
"<"             return 'menor'
"<="            return 'menorigual'
">"             return 'mayor'
">="            return 'mayorigual'
"\|\|"          return 'comparacion'
"&&"            return 'concat'
"!"             return 'negar'
"("             return 'para'
")"             return 'parc'

//Etiquetas HTML
"C_CC"          return 'HTML'
"C_HEAD"       return 'HEAD'
"C_TITLE"       return 'TITLE'
"C_LINK"        return 'LINK'
"C_BODY"        return 'BODY'
"C_SPAN"        return 'SPAN'

<<EOF>>         return 'EOF'

.               return 'INVALID'

/lex

%start ini
%{
    /*Codigo JS*/
%}

%%

ini : comentarios EOF;

comentarios : comentario1
            | comentario2
            | error { console.log('Error: ' + yytext + ' Línea: ' + (this._$.first_line) + ' Columna: ' + (this._$.first_column)); };