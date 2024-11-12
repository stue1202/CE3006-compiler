%{
#include<stdlib.h>
%}
EXP ^[\+\-]?[0-9](\.[0-9]+)?E[\+\-]?[0-9]+
%%
{EXP} {printf("%s\n",yytext);}
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