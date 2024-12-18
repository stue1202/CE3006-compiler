%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char* message);
int err = 0;
float ans;
%}

%union {
    double i;
}
%token <i> FLOAT
%token ADD SUB MUL DIV ERR
%type <i> floats

%left ADD SUB 
%left MUL DIV
%%

answer: floats {ans=$1;}

floats
    : FLOAT {   
        $$=$1;
    }
    | floats ADD floats {   
        $$=$1+$3;
    }
    | floats SUB floats {   
        $$=$1-$3;
    }
    | floats MUL floats {   
        $$=$1*$3;
    }
    | floats DIV floats {   
        if($3==0){
            YYERROR;
        }
        $$=$1/$3;
    };
err: ERR {YYERROR;}
%%

void yyerror(const char* message) {
    printf("Invalid Value\n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();
    if(!err){
        printf("%.3f",ans);
    }
    return 0;
}
