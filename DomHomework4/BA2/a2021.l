%{
#include <string.h> 
%}
nonTypeOne [\+\-][0-9]*\.[0-9]+\n
nonTypeTwo [\+\-][0-9]+\.[0-9]*\n
nonTypeThree [\+\-]([0-9]*\.[0-9]+|[0-9]+\.[0-9]*|[0-9]+)(E|e)(\+|\-)?[0-9]+\n
floatOne [0-9]*\.[0-9]+\n
floatTwo [0-9]+\.[0-9]*\n
science ([0-9]*\.[0-9]+|[0-9]+\.[0-9]*|[0-9]+)(E|e)(\+|\-)?[0-9]+\n
%%
{floatOne} {printf("%s",yytext);}
{floatTwo} {printf("%s",yytext);}
{science} {printf("%s",yytext);}
{nonTypeOne} {;}
{nonTypeTwo} {;}
{nonTypeThree} {;}
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