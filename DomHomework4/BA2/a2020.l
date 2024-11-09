%{
    
%}
ATM \$([0-9]|[1-9][0-9]{1,4}|100000)
Day \+([0-2][0-9]{2}|3[0-5][0-9]|36[0-5])
Time ([0-1][0-9]|2[0|1|2|3])\:[0-5][0-9]
Place [A-Z]([a-z]|\-|\.)+[A-Z]
%%
{ATM} {printf("ATM: %s\n",yytext);}
{Day} {printf("Day: %s\n",yytext);}
{Time} {printf("Time: %s\n",yytext);}
{Place} {printf("Place: %s\n",yytext);}
. {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}