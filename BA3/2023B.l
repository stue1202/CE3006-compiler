%{
#include "parser.tab.h"
#include <string.h>
int yywrap(void){return 1;}
%}
%%
\-?[0-9]+ {yylval.i=atoi(yytext);return NUMBER;}
\+ {return ADD;}
\- {return SUB;}
\* {return MUL;}
\/ {return DIV;}
" " {;}
\n {;}
. {;}
%%
