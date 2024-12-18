%{
%}
%x multiAnnoBody
ifStatement if\((true|false)\)" "\{
printStatement cout" "<<" "(\".*\"|[0-9]+)" "<<" "endl;
singalAnno \/\/.*
multiAnno \/\*
%%
{ifStatement} {
    if(yytext[3]=='t'){
        printf("if True:");
    }else{
        printf("if False:");
    }
}
{printStatement} {
    yytext[yyleng-9]='\0'; 
    printf("print\(%s\)",yytext+8);
}
{singalAnno} {
    printf("#%s",yytext+2);
}
{multiAnno} {
    printf("\"\"\"");
    BEGIN multiAnnoBody;
}
<multiAnnoBody>. {ECHO;}
<multiAnnoBody>\n {ECHO;}
<multiAnnoBody>\*\/ {
    printf("\"\"\"");
    BEGIN 0;
}
[\t" "]*\}\n {;}
\t|" " {ECHO;}
. {;}
%% 
int yywrap(void) {
    return 1;
}

int main(int argc, char argv[]) {
    yylex();
    return 0;
}