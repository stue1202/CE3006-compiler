%{

%}

valid_id        [_a-zA-Z][a-zA-Z0-9_]*
non_blank       [^ \t\n]+

%%
{valid_id}      { printf("Valid Identifier: %s\n", yytext); }
{non_blank}     { printf("Invalid Identifier: %s\n", yytext); }
\n              { ; }
.               { ; }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    const char* sFile = "input.txt";
    FILE* fp = fopen(sFile, "r");
    if (fp == NULL) {
        printf("cannot open %s\n", sFile);
        return -1;
    }
    yyin = fp;
    yylex();
    return 0;
}