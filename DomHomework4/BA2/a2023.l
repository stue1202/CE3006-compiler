%{
#include <string.h> 
int tabCount=0;
void mp(char* str, char el) {
    for (int i = 0; i < strlen(str); i++) {
        if (str[i] != el) {
            printf("%c", str[i]);  // 正確地打印字符
        }
    }
}
%}
%%

^[1-9][0-9]*\n {mp(yytext,'\n');printf(" INTEGER\n");}
^[0-9]*\.[0-9]+\n {mp(yytext,'\n');printf(" FLOAT\n");}
^\"[^\n\"]*\"\n  {mp(yytext,'\n');printf(" STRING\n");}
^\'[^\n\']*\'\n  {mp(yytext,'\n');printf(" STRING\n");}
^[a-zA-z_][a-zA-z0-9_]*\n {mp(yytext,'\n');printf(" VARIABLE\n");}
. {;}
\n {;}
\"[^\n]*\"\n  {;}
\'[^\n]*\'\n {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}