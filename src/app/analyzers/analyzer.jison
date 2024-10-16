/*Analisis léxico*/
%lex
%option case-sensitive

%%
/*Expresiones Regulares*/
[ \t\r\n\f]     {/* Ignorar espacios en blanco */}

"!!".*          return 'comentario1'//Comentario de una linea
"<!--".*"-->"   return 'comentario2'//Comentario de varias lineas

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

<<EOF>>         return 'EOF'

.               return 'INVALID'

/lex

%start ini
%{
    /*Codigo JS*/
%}

%%

ini : comentarios EOF;

comentarios : 