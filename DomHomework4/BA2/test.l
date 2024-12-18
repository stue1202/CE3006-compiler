%{
%}

%x COMMENT

%%

\/\/              { BEGIN COMMENT; }
<COMMENT>[^\n]*   { ; }
<COMMENT>\n       { BEGIN 0; ; }

.|\n              { ECHO; }

%%

int yywrap(void) {
    return 1;
}

int main(void) {
    yylex();
    return 0;
}