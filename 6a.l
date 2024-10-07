%{
#include "y.tab.h"
%}

%%
"+" {return '+';}
"-" {return '-';}
"*" {return '*';}
"/" {return '/';}
[a-zA-Z]+ {yylval.sym=(char)yytext[0];return LETTER;}
[0-9]+ {yylval.sym=(char)yytext[0];return DIGIT;}
. {return (char)yytext[0];}
\n {return 0;}
%%

int yywrap()
{
  return 1;
}


