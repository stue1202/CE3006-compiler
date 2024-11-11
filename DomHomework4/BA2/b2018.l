%{
#include<stdlib.h>
int myCheck(char* str){
    int l=0,err=0;
    for(int i=0;i<strlen(str);i++){
        if(str[i]=='.'){
            char* tmp=(char*)malloc((i+l+1)*sizeof(char));
            strncpy(tmp,str+l,i-1-l+1);
            tmp[i-l]='\0';
            //printf("%d\n",atoi(tmp));
            if(atoi(tmp)>255||atoi(tmp)<0||(tmp[0]=='0'&&atoi(tmp)!=0)){
                err=1;
            }
            l=i+1;
            free(tmp);
        }else if(i==strlen(str)-1){
            char* tmp=(char*)malloc((i+l+1)*sizeof(char));
            strncpy(tmp,str+l,i-l+1);
            tmp[i-l+1]='\0';
            //printf("%d\n",atoi(tmp));
            if(atoi(tmp)>255||atoi(tmp)<0||(tmp[0]=='0'&&atoi(tmp)!=0)){
                err=1;
            }
            l=i+1;
            free(tmp);
        }
    }
    return err;
}
%}
IP ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+
Email ^[a-zA-Z0-9]+\@[a-zA-Z]+(\.[a-zA-Z]+)+
Word ^[A-Z][a-zA-Z]+
%%
{IP} {if(!myCheck(yytext)){
        printf("IP:%s\n",yytext);
    }
}
{Email} {printf("Email:%s\n",yytext);}
{Word} {printf("Word:%s\n",yytext);}
. {;}
\n {;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}