%{
int state=0;
%}
regbookName ([A-Z][a-z]+(_[A-Z][a-z]+)*|[A-Z][a-z]+)
regauthor [A-Z]+," "[A-Z][a-z]*-[A-Z][a-z]*
regpublicationDate ([0-9]{4}\/(04|06|09|11)\/([0-2][0-9]|30)|[0-9]{4}\/(01|03|05|07|08|10|12)\/([0-2][0-9]|30|31)|[0-9]{4}\/02\/[0-2][0-9])
regISBN 978-[0-9]-[0-9]{6}-[0-9]{2}-[0-9]
%%
{regbookName} {
    if(state==0){
        printf("bookName: %s\n",yytext);
        state+=1;
        state%=4;
    }
}
{regauthor} {
    if(state<=1){
        printf("author: %s\n",yytext);
        state+=1;
        state%=4;
    }
}
{regpublicationDate} {
    if(state<=2){
        printf("publicationDate: %s\n",yytext);
        state+=1;
        state%=4;
    }
}
{regISBN} {
    if(state<=3){
        printf("ISBN: %s\n",yytext);
        state+=1;
        state%=4;
    }
}
. {;}
\n {state=0;}
%%
int yywrap(void) {
    return 1;
}
int main(void) {
    yylex();
    return 0;
}