%{
#include "parser.tab.h"
#include <string.h>
int yywrap(void){return 1;}
%}
%%
[0-9]+ {printf("float1:%s\n",yytext);yylval.i=atof(yytext);return FLOAT;}
[0-9]+\. {printf("float2:%s\n",yytext);yyleng-=1;yylval.i=atof(yytext);return FLOAT;}
\.[0-9]+ {printf("float3:%s\n",yytext);yylval.i=atof(yytext+1)*0.1;return FLOAT;}
[0-9]+\.[0-9]+ {printf("float4:%s\n",yytext);yylval.i=atof(yytext);return FLOAT;}
\+ {return ADD;}
\- {return SUB;}
\* {return MUL;}
\/ {return DIV;}
" " {;}
\n {;}
. {return ERR;}
%%
