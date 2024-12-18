%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char* message);
int err = 0;
int ans[2];  // ans should be an array of two integers to hold the matrix values
%}

%union {
    int arr[2];
    int i;
}


%token <arr> MARTIX 
%token <i> ADD <i> SUB <i> MUL <i> TRS <i> RBR <i> LBR 
%type <arr> answer
%type <arr> martixs

%left ADD SUB 
%left MUL 
%left TRS
%%

answer: martixs {};

martixs
    : MARTIX {   
        $$[0] = $1[0];
        $$[1] = $1[1];
    }
    | martixs TRS {   
        //printf("successTRS\n%d",$2);
        $$[0] = $1[1]; 
        $$[1] = $1[0];
    }
    | martixs ADD martixs {
        //printf("successADD\n");
        //printf("successADD\n%d",$2);
        if(($3[0] == $1[0])&&($3[1] == $1[1])){
            $$[0] = $1[0];
            $$[1] = $1[1]; 
            
        }else{
            printf("Semantic error on col %d\n",$2);
            err=1;
            YYABORT;            
        }
    }
    | martixs SUB martixs { 
        //printf("successSUB\n%d",$2);
        if(($3[0] == $1[0])&&($3[1] == $1[1])){
            $$[0] = $1[0];
            $$[1] = $1[1]; 
        }else{
            printf("Semantic error on col %d\n",$2);
            err=1;
            YYABORT;            
        }
    }
    | martixs MUL martixs { 
        if($1[1] == $3[0]){
            $$[0] = $1[0];  
            $$[1] = $3[1]; 
        }else{
            printf("Semantic error on col %d\n",$2);
            err=1;
            YYABORT;            
        }
    }
    | LBR martixs RBR {   
        $$[0] = $2[0];
        $$[1] = $2[1];  
    }   
    ;
%%

void yyerror(const char* message) {
    printf("Semantic error on col \n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();  // Parse the input
    if (!err) {
        printf("Accepted\n");
    }
    return 0;
}
