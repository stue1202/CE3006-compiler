%{
#include <string.h> 
%}
INTEGER ^[0-9]+$
FLOAT  ^([0-9]*\.[0-9]+|[0-9]+\.[0-9]*)$
STRING ^(\"[^\"]+\"|\'[^\']+\')$
VARIABLE ^[a-zA-Z_][a-zA-Z0-9_]*$
%%
{INTEGER} {printf("I: %s\n",yytext);}
{FLOAT} {printf("F: %s\n",yytext);}
{STRING} {printf("S: %s\n",yytext);}
{VARIABLE} {printf("V: %s\n",yytext);}
. {;}
\n {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}