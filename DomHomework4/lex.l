%{
#include <string.h> 
int tabCount=0;
%}
%%
[^ \t\n].* {
    if(strchr(yytext,'{')&&!strchr(yytext,'}')){
        for(int i=0;i<tabCount;i++){printf("    ");}
        tabCount=tabCount+1;
        printf(yytext);
    }else if(strchr(yytext,'}')&&!strchr(yytext,'{')){
        tabCount=tabCount-1;
        for(int i=0;i<tabCount;i++){printf("    ");}
        printf(yytext);
    }else{
        for(int i=0;i<tabCount;i++){printf("    ");}
        printf(yytext);
    }
}
\n* {printf(yytext);}
[ \t]* {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}