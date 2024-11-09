%{
#include <string.h> 
int state=0;
%}
name [A-Z]+," "[A-Z][a-z]+\-[A-Z][a-z]+
id [A-Z](1|2)[0-9]{8}
email [0-9]+\@[a-z]+(\.[a-z]+)+
birthday ([0-9]{4}\/(04|06|09|11)\/([0-2][0-9]|30)|[0-9]{4}\/(01|03|05|07|08|10|12)\/([0-2][0-9]|30|31)|[0-9]{4}\/02\/[0-2][0-9])
phone \+886[0-9]{9}
%%
{name} {
    if(state!=0){
        printf("\n%s\n",yytext);
    }else{
        printf("%s\n",yytext);
        state=1;
    }
}
{id} {printf("id:%s\n",yytext);}
{email} {printf("email:%s\n",yytext);}
{birthday} {printf("birthday:%s\n",yytext);}
{phone} {printf("phone:%s\n",yytext);}
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