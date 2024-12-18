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
%x matrixSplit
%%
\[ {
    printf("mrx:%s\n",yytext);
    nowlen+=1;
    BEGIN matrixSplit;

}
<matrixSplit>[0-9]+ {
    nowlen+=yyleng;    
    yylval.arr[0]=atoi(yytext);
   printf("%d\n",yylval.arr[0]);
}
<matrixSplit>\," "*[0-9]+ {
    nowlen+=yyleng;
    for(int c=0;c<yyleng;c++){
        if(*(yytext+c)!=','&&*(yytext+c)!=' '){
            yylval.arr[1]=atoi(yytext+c);
            break;
        }
    } 
    printf(",%d\n",yylval.arr[1]);
}
<matrixSplit>" " {printf("mrxspace:%s\n",yytext);nowlen+=1;}
<matrixSplit>\] {
    nowlen+=1;
    BEGIN 0;
    printf("mrx:%s\n",yytext);
    return MARTIX;
}

\( {nowlen+=1;printf("lbr:%s\n",yytext);yylval.i=nowlen;return LBR;}
\) {nowlen+=1;printf("rbr:%s\n",yytext);yylval.i=nowlen;return RBR;}
\+ {nowlen+=1;printf("add:%s\n",yytext);yylval.i=nowlen;return ADD;}
\- {nowlen+=1;printf("sub:%s\n",yytext);yylval.i=nowlen;return SUB;}
\* {nowlen+=1;printf("mul:%s\n",yytext);yylval.i=nowlen;return MUL;}
\^T {nowlen+=2;yylval.i=nowlen;printf("trs:%s\n",yytext);return TRS;}
\n {;}
" " {nowlen+=1;printf("space:%s\n",yytext);}
. {nowlen+=1;printf("others:%s\n",yytext);}

%%
