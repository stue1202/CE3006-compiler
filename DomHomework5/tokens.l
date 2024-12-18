%{
#include "parser.tab.h"
int yywrap(){return 1;}
%}

%%
[0-9]+ {yylval = atoi(yytext);return NUMBER;}
inc {return INC;}
dec {return DEC;}
add {return ADD;}
sub {return SUB;}
mul {return MUL;}
mod {return MOD;}
\n {;}
\t {;}
. {;}

%%
