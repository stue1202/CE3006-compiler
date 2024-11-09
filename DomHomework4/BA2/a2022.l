%{
#include <string.h> 
%}
singalAnno \/\/
multiAnno (\/\*|\*\/)
printStmt cout" "<<" ".*" "<<" "endl\;
ifStmt if\((true|false)\)" "\{
%%
{singalAnno} {printf("#");}
{multiAnno} {printf("\"\"\"");}
{printStmt} {
    int start=0;
    printf("print\(");
    for(int i=0;i<strlen(yytext);i++){
        if(yytext[i]==' '&&yytext[i+1]=='<'&&yytext[i+2]=='<'&&yytext[i+3]==' '){
            i+=4;
            start+=1;
        } if(start==1){
            printf("%c",yytext[i]);
        }
    }
    printf("\)");
}
{ifStmt} {
    if(strchr(yytext,'t')){
        printf("if True:");
    }else{
        printf("if False:");
    }
}
\t {printf("tab");}
. {ECHO;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}