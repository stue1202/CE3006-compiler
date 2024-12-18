%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char* message);
int err = 0;
int ans;
int stage(int j){
    int t=1;
    for(int i=1;i<=j;i++){
        t*=i;
    }
    return t;
}
%}

%union {
    int i;
}
%token <i> NUMBER
%token ADD SUB MUL DIV P C
%type <i> numbers

%left ADD SUB 
%left MUL DIV
%%

answer: numbers {ans=$1;}

numbers
    : NUMBER {   
        $$=$1;
    }
    | P NUMBER NUMBER {   
        $$=stage($2)/stage($2-$3);
    }
    | C NUMBER NUMBER {   
        $$=stage($2)/(stage($3)*stage($2-$3));
    }
    | numbers ADD numbers {   
        $$=$1+$3;
    }
    | numbers SUB numbers {   
        $$=$1-$3;
    }
    | numbers MUL numbers {   
        $$=$1*$3;
    }
    | numbers DIV numbers {   
        if($3==0){
            YYERROR;
        }
        $$=$1/$3;
    };
%%

void yyerror(const char* message) {
    printf("Wrong Formula\n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();
    if(!err){
        printf("%d",ans);
    }
    return 0;
}
