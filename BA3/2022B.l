%{
#include "parser.tab.h"
#include <string.h>
int yywrap(void){return 1;}
%}
%%
\<and\> {return andStart;}
\<or\> {return orStart;}
\<not\> {return notStart;}
\<\/and\> {return andEnd;}
\<\/or\> {return orEnd;}
\<\/not\> {return notEnd;}
\<true\/\> {return myTrue;}
\<false\/\> {return myFalse;}
" "|\t {;}
\n {;}
%%
