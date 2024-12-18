%{
#include <stdio.h>
#define STACK_SIZE 10
int yylex();
void yyerror(const char* message);
int err=0;
struct stack {
int data[STACK_SIZE];
int top;
};
typedef struct stack stack_t;
stack_t stack;

int isEmpty(){}; // to check if the stack is empty
int isFull(); // to check if the stack is full
void push(int i){
    stack.data[stack.top]=i;
    stack.top+=1;
}
int pop(){
    stack.top-=1;
}
void dump(){
    for(int i=0;i<stack.top;i++){
        printf("%d ",stack.data[i]);
    }
    printf("\n");
}
%}

%union {
    int i;
}
%token <i> NUMBER
%token ADD SUB MUL DIV 
%left ADD SUB 
%left MUL DIV
%%

startsymbol : expressions
expressions : expression expressions | expression
expression : ADD {
                if(stack.top<2){
                    printf("Runtime Error: The pop will lead to stack underflow.");
                    YYABORT;
                }
                stack.data[stack.top-2]=stack.data[stack.top-2]+stack.data[stack.top-1];
                stack.top-=1;
                dump();

            }
            | SUB {
                if(stack.top<2){
                    printf("Runtime Error: The pop will lead to stack underflow.");
                    YYABORT;
                }
                stack.data[stack.top-2]=stack.data[stack.top-2]-stack.data[stack.top-1];
                stack.top-=1;
                dump();
                
            }
            | MUL {
                if(stack.top<2){
                    printf("Runtime Error: The pop will lead to stack underflow.");
                    YYABORT;
                }
                stack.data[stack.top-2]=stack.data[stack.top-2]*stack.data[stack.top-1];
                stack.top-=1;
                dump();

            }
            | DIV {
                if(stack.top<2){
                    printf("Runtime Error: The pop will lead to stack underflow.");
                    YYABORT;
                }
                stack.data[stack.top-2]=stack.data[stack.top-2]/stack.data[stack.top-1];
                stack.top-=1;
                dump();

            }
            | NUMBER{
                if(stack.top==10){//記住是index
                    printf("Runtime Error: The pop will lead to stack overflow.");
                    YYABORT;
                }
                //printf("%d:\n",stack.top);
                push($1);
                dump();
            }

%%

void yyerror(const char* message) {
    printf("Invalid Value\n");
    err = 1;
}
int main(int argc, char** argv) {
    yyparse();
    return 0;
}
