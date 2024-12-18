%{
int tabCount=0;
%}
stmtWithLB \}(" "*\/\/.*)?
stmtWithRB [^" "\t\n\{\}]+[^\n\{\}]*\{(" "*\/\/.*)?
stmtWithEnterRB \{(" "*\/\/.*)?
stmt [^ \t\n\{\}]+[^\n\{\}]*
frontTab [" "\t]+
%%
{stmtWithLB} {tabCount-=1 ; for(int i=0;i<tabCount;i++){printf("    ");} ;  printf("%s",yytext) ;}
{stmtWithEnterRB} {for(int i=0;i<tabCount;i++){printf("    ");} ; tabCount+=1 ; printf("%s",yytext) ;}
{stmtWithRB} {for(int i=0;i<tabCount;i++){printf("    ");} ; tabCount+=1 ; printf("%s",yytext) ;}
{stmt} {for(int i=0;i<tabCount;i++){printf("    ");}; printf("%s",yytext) ;}
\n+ {printf("%s",yytext);}
{frontTab} {;}
. {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}