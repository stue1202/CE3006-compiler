%{
#include "parser.tab.h"
#include <string.h>
int yywrap(void){return 1;}
int find(char* str,char target){
    for (int i = 0; str[i] != '\0'; i++) {
        if (str[i] == target) {
            return i;  // 返回找到的索引
        }
    }
    return -1;  // 未找到    
}
int nowlen=0;
int tmp[2]={0,0};
%}
%%

\-?[0-9]+ {yylval.i=nowlen;return NUM;}
\( {yylval.i=nowlen;return LBR;}
\) {yylval.i=nowlen;return RBR;}
\+ {yylval.i=nowlen;return ADD;}
\- {yylval.i=nowlen;return SUB;}
\* {yylval.i=nowlen;return MUL;}
\> {yylval.i=nowlen;return UPPER;}
\< {yylval.i=nowlen;return LOWER;}
\= {yylval.i=nowlen;return EQU;}
mod {yylval.i=nowlen;return MOD;}
\#t {yylval.i=nowlen;return T;}
\#f {yylval.i=nowlen;return F;}


\n {;}
" " {nowlen+=1;}
. {nowlen+=1;}

%%
