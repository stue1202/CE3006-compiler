bison -d -o parser.tab.c parser.y
flex tokens.l
gcc -o a parser.tab.c lex.yy.c
Get-Content .\input.txt | .\a.exe