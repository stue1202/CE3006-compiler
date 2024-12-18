%{
#include "parser.tab.h"
#include <string.h>
int yywrap(void){return 1;}
%}
%%
load" "[0-9]+ {yylval.i=atoi(yytext+5);return NUMBER;}
add {yylval.str=strdup(yytext);return ADD;}
sub {return SUB;}
mul {return MUL;}
div {return DIV;}
mod {return MOD;}
inc {return INC;}
dec {return DEC;}
copy {return CPY;}
delete {return DEL;}
switch {return SW;}
" " {;}
\n {;}
%%
