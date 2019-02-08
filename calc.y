/* Calculator: Parser */

%{
#include <stdio.h>
%}

/* Token declarations. */
%token NUMBER
%token ADD SUB MUL DIV ABS
%token EOL
%token OP CP
%token COMMENT
%token AND

%%

calclist: /* nothing */
| calclist exp EOL { printf("Dec: %ld, Hex: 0x%x\n", $2, $2); }
| calclist COMMENT EOL { }
;

exp: factor
| exp COMMENT
| exp ADD factor { $$ = $1 + $3; }
| exp SUB factor { $$ = $1 - $3; }
;

factor: logic
| factor MUL logic { $$ = $1 * $3; }
| factor DIV logic { $$ = $1 / $3; }
;

logic: term
| logic ABS term { $$ = $1 | $3; }
| logic AND term { $$ = $1 & $3; }
;

term: NUMBER
| SUB term { $$ = -$2; }
| ABS term ABS{ $$ = $2 >= 0 ? $2 : -$2; }
| OP exp CP { $$ = $2; }
; 

%%

int main(int argc, char **argv)
{
  yyparse();
  return 0;
}

int yyerror(char *s)
{
  fprintf(stderr, "error: %s\n", s);
}
