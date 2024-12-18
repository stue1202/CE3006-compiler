%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE int
int yylex();
void yyerror(const char *message);
int err=0;
int ans;
%}
/* %union{
    int test;
} */

%token NUMBER ADD SUB MUL MOD INC DEC
%left ADD SUB
%left MUL MOD
%right INC DEC
/* %type <test> answer */
/* %type <test> numbers */

%%
answer: numbers {ans=$$;};
numbers
    : NUMBER   {$$ = $1;}
    | numbers numbers ADD {$$ = $2 + $1; }
    | numbers numbers SUB {$$ = $2 - $1; }
    | numbers numbers MUL {$$ = $2 * $1; }
    | numbers numbers MOD {$$ = $2 % $1; }
    | numbers INC {$$ = $1 +1; }
    | numbers DEC {$$ = $1 -1; }
    ;
%%
void yyerror(const char *message) {
    printf("Invalid format");
    err=1;
}

int main(int argc, char** argv[]){
    yyparse();
    if(!err){
        printf("%d\n",ans);
    }
    return 0;
}