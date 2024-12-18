%{
#include <stdio.h>
#include <stdlib.h>
int yylex(void);
void yyerror(const char* message);
int err = 0,ans,buffer,cpy=0,del=0,sw=0;
%}

%union {
    int i;
    char* str;
}
%token <i> NUMBER
%token <str> ADD SUB MUL DIV MOD INC DEC CPY SW DEL
%type <i> numbers lines
%left ADD SUB MUL DIV MOD INC
%left CPY SW DEL
%%
lines: numbers DEL lines {;}
    | numbers {ans=$1;}
    ;

numbers
    : NUMBER {$$ = $1;buffer=$$;}
    | CPY {$$ = buffer;}
    | numbers numbers ADD {
        printf("%s\n",$3);
        $$ = $2 + $1;
        buffer=$$;
    }
    | numbers numbers SUB {
        $$ = $2 - $1;
        buffer=$$;
    }
    | numbers numbers MUL {
        $$ = $2 * $1;
        buffer=$$;
    }
    | numbers numbers MOD {
        $$ = $2 % $1;
        buffer=$$;
    }
    | numbers numbers DIV {
        if($1==0){
            printf("Divide by zero\n");
            err=1;
            YYABORT;
        }
        $$ = $2 / $1;
        buffer=$$;
    }    
    | numbers numbers SW ADD{
        $$ = $1 + $2;
        buffer=$$;
    }
    | numbers numbers SW SUB{
        $$ = $1 - $2;
        buffer=$$;
    }
    | numbers numbers SW MUL{
        $$ = $1 * $2;
        buffer=$$;
    }
    | numbers numbers SW MOD{
        $$ = $1 % $2;
        buffer=$$;
    }  
    | numbers numbers SW DIV{
        if($2==0){
            printf("Divide by zero\n");
            err=1;
            YYABORT;
        }           
        $$ = $1 / $2;
        buffer=$$;
    }
    | numbers numbers DEL {
        $$=$1;
        buffer=$$;
    }
    | numbers numbers SW DEL {
        $$=$2;
        buffer=$$;
    }
    | numbers INC {$$ = $1 + 1; }
    | numbers DEC {$$ = $1 - 1; }
    ;

%%

void yyerror(const char* message) {
    printf("Invalid format\n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();
    if(!err){
        printf("%d",ans);
    }
    return 0;
}
