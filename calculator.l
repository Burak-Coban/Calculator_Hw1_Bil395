%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"  /* Yacc tarafından oluşturulan header */
%}

%%

[0-9]+\.[0-9]+   { yylval.dval = atof(yytext); return FLOAT; }
[0-9]+           { yylval.ival = atoi(yytext); return NUMBER; }
"+"              { return PLUS; }
"-"              { return MINUS; }
"*"              { return TIMES; }
"/"              { return DIVIDE; }
"^"              { return POWER; }
"("              { return LPAREN; }
")"              { return RPAREN; }
[ \t]+           { /* boşluk ve tab karakterleri yok sayılıyor */ }
\n               { return '\n'; }
.                { printf("Geçersiz karakter: %s\n", yytext); }

%%

int yywrap(void) {
    return 1;
}
