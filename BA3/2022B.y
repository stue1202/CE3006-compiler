%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char* message);
int err = 0;
int ans = 0;
%}

%union {
    int state[2];
}
%token myTrue myFalse
%token andStart andEnd orStart orEnd notStart notEnd ERR
%type <state> bools

%%
answer: bools { 
    if($1[1]>0){//true
        ans=1;
    }else{
        ans=0;
    }
}
bools
    : andStart bools andEnd{   
        if($2[0]>0){//false
            $$[0]=1;
            $$[1]=0;
        }else{
            $$[0]=0;
            $$[1]=1;           
        }
    }
    | orStart bools orEnd {   
        if($2[1]>0){//true
            $$[0]=0;
            $$[1]=1;
        }else{
            $$[0]=1;
            $$[1]=0;           
        }
    }
    | notStart bools notEnd {   
        if($2[1]>0){//true
            $$[0]=1;
            $$[1]=0;
        }else{
            $$[0]=0;
            $$[1]=1;           
        }
    }
    | andStart andEnd{   
        $$[0]=0;
        $$[1]=1;
    }
    | orStart orEnd {   
        $$[0]=1;
        $$[1]=0;
    }
    | myTrue {$$[0]=0;$$[1]=1}
    | myFalse {$$[0]=1;$$[1]=0;}
    | bools bools {$$[1]=$1[1]+$2[1];$$[0]=$1[0]+$2[0];}
    | ERR {
        printf("Wrong Formula\n");
        err = 1;
        YYABORT;
    }
    ;
%%

void yyerror(const char* message) {
    printf("Wrong Formula\n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();
    if(!err){
        (ans==1)?printf("true"):printf("false");
    }
    return 0;
}
