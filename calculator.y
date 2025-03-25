%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
void yyerror(char *s);
int yylex(void);
%}

%union {
    int ival;
    double dval;
}

%token <ival> NUMBER
%token <dval> FLOAT
%token PLUS MINUS TIMES DIVIDE POWER
%token LPAREN RPAREN

%type <dval> expr

/* Operatör önceliği ve birliktelik kuralları */
%left PLUS MINUS
%left TIMES DIVIDE
%right POWER

%%

input:
      /* boş */
    | input line
    ;

line:
      '\n'
    | expr '\n' {
          if (floor($1) == $1)
              printf("Sonuç: %d\n", (int)$1);
          else
              printf("Sonuç: %.2f\n", $1);
      }
    | expr {
          if (floor($1) == $1)
              printf("Sonuç: %d\n", (int)$1);
          else
              printf("Sonuç: %.2f\n", $1);
      }
    ;

expr:
      expr PLUS expr   { $$ = $1 + $3; }
    | expr MINUS expr  { $$ = $1 - $3; }
    | expr TIMES expr  { $$ = $1 * $3; }
    | expr DIVIDE expr {
          if ($3 == 0) {
              yyerror("Sıfıra bölme hatası");
              $$ = 0;
          } else {
              $$ = $1 / $3;
          }
      }
    | expr POWER expr  { $$ = pow($1, $3); }
    | LPAREN expr RPAREN { $$ = $2; }
    | NUMBER           { $$ = (double)$1; }
    | FLOAT            { $$ = $1; }
    ;

%%

void yyerror(char *s) {
    fprintf(stderr, "Hata: %s\n", s);
}

int main(void) {
    printf("Basit Hesap Makinesi\n");
    printf("İfadeleri giriniz (çıkmak için Ctrl+D):\n");
    yyparse();
    return 0;
}