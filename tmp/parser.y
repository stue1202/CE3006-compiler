%{
#include <stdio.h>
#include <string.h>
#include <stdbool.h>
void yyerror(const char *message);
int yylex(void);

bool is_valid = true;
int lll;
%}

%union {
    struct {
        char *sval;
        int pos;
    } str;
    char *sval;
    int ipair[2];
}

%token <ipair> MATRIX
%token <str> BINARY_OP
%token <sval> TRANSP_OP
%token <str> MUL_OP
%token <sval> PARENTHESES
%type <ipair> expr

%left PARENTHESES
%left BINARY_OP
%left MUL_OP
%left TRANSP_OP
%left MATRIX
%nonassoc TRANSP
%%


expr:
    MATRIX {
        $$[0] = $1[0];
        $$[1] = $1[1];
        // printf("mat %d %d\n", $$[0], $$[1]);
    }
    | expr TRANSP_OP %prec TRANSP {
        if (strcmp($2, "^T") == 0) {
            $$[0] = $1[1];
            $$[1] = $1[0];
            // printf("unary %d %d\n", $$[0], $$[1]);
        }
    }
    | expr MUL_OP expr {
        if ($1[1] == $3[0]) {
            $$[0] = $1[0];
            $$[1] = $3[1];
            // printf("mul %d %d\n", $$[0], $$[1]);
        } else {
            printf("Semantic error on col %d\n", $2.pos);
            is_valid = false;
            YYABORT;
        }
    }
    | expr BINARY_OP expr {
        if (strcmp($2.sval, "+") == 0 && $1[0] == $3[0] && $1[1] == $3[1]) {
            $$[0] = $1[0];
            $$[1] = $1[1];
            // printf("+ %d", $2.pos);
            // printf("add %d %d\n", $$[0], $$[1]);
        } else if (strcmp($2.sval, "-") == 0 && $1[0] == $3[0] && $1[1] == $3[1]) {
            $$[0] = $1[0];
            $$[1] = $1[1];
            // printf("- %d", $2.pos);
            // printf("sub %d %d\n", $$[0], $$[1]);
        } else {
            printf("Semantic error on col %d\n", $2.pos);
            is_valid = false;
            YYABORT;
        }
    }
    | PARENTHESES expr PARENTHESES {
        $$[0] = $2[0];
        $$[1] = $2[1];
        // printf("paren %d %d\n", $$[0], $$[1]);
    }
    ;
%%

void yyerror (const char *message) {
    printf("Semantic error on col %d\n", lll);
    is_valid = false;
}

int main(int argc, char *argv[]) {
    yyparse();
    if (is_valid) {
        printf("Accepted\n");
    }
    return(0);
}