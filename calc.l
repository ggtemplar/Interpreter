/* Calculator: Lexicographer */

%{
# include "calc.tab.h"
%}

%%

"("    { return OP; }
")"    { return CP; }
"+"    { return ADD; }
"-"    { return SUB; }
"*"    { return MUL; }
"/"    { return DIV; }
"|"    { return ABS; }
"&"    { return AND; }
[0-9]+ { yylval = atoi(yytext); return NUMBER; }
0x[a-f0-9]+ { yylval = strtol(yytext, NULL, 16); return NUMBER; }
\n     { return EOL; }
[ \t]  { /* ignore spaces and tabs. */ }
.      { printf("Unknown character. %c\n", *yytext); }
"//".* { return COMMENT; }

%%

