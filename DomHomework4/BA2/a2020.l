%{
#include<string.h>
#include<ctype.h>
#include<stdlib.h>
%}
ATM \$[0-9]+
Day \+[0-9]+
Time [0-9]{2}\:[0-9]{2}
Place [A-Z]([a-z]|\-|\.)+[A-Z]
%%
{ATM} {
    if(atoi(yytext+1)<100000){
        printf("ATM: %s\n",yytext);
    }
}
{Day} {
    if(atoi(yytext+1)<365){
        printf("Day: %s\n",yytext);
    }
}
{Time} {
    yytext[2]='\0';
    if(atoi(yytext)<23&&atoi(yytext+3)){
        printf("Time: %d:%d\n",atoi(yytext),atoi(yytext+3));
    }
    
}
{Place} {printf("Place: %s\n",yytext);}
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
//test