%{
#include <stdio.h>
%}

%%
[0-9]+          printf("Number: %s\n", yytext);
[a-zA-Z]+       printf("Word: %s\n", yytext);
\n              ; // 忽略換行
.               printf("Unknown character: %s\n", yytext);

%%

int main() {
    yylex();  // 開始詞法分析
    return 0;
}

int yywrap() {
    return 1; // 指示結束
}