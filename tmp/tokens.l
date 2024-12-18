%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int len = 0;
%}

num [0-9]+
blank [ \t\n]
matrix \[{num}{blank}*,{blank}*{num}\]
binary_op [+\-]
mul_op \*
transpose_op "\^T"
paren [\(|\)]

%%
{matrix} {
    len += yyleng;
    yylval.ipair[0] = atoi(strtok(yytext + 1, ","));
    yylval.ipair[1] = atoi(strtok(NULL, "]"));
    // printf("mat %d %d\n", yylval.ipair[0], yylval.ipair[1]);
    return MATRIX;
}
{mul_op} {
    len += yyleng;
    yylval.str.pos = len;
    yylval.sval = strdup(yytext);
    // printf("mul %s\n", yylval.sval);
    return MUL_OP;
}
{transpose_op} {
    len += yyleng;
    yylval.str.sval = strdup(yytext);
    // printf("unary %s\n", yylval.sval);
    return TRANSP_OP;
}
{binary_op} {
    len += yyleng;
    yylval.str.pos = len;
    yylval.str.sval = strdup(yytext);
    // turn yyleng to int
    // printf("binary %s\n", yylval.sval);
    return BINARY_OP;
}
{paren} {
    len += yyleng;
    yylval.sval = strdup(yytext);
    // printf("paren %s\n", yylval.sval);
    return PARENTHESES;
}

\n {
    len += yyleng;
}

[ \t]+ {
    len += yyleng;
}

. {
    len += yyleng;
}
%%

int yywrap(void) {
    return 1;
}
