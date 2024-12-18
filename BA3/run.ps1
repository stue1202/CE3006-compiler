bison -d -o parser.tab.c 2021B.y
flex 2021B.l
gcc -o a parser.tab.c lex.yy.c
Get-Content .\input.txt | .\a.exe