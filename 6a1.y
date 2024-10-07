%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
int yylex();
void yyerror(char *s);
char AddToTable(char,char,char);
void ThreeAddressCode();
void Quadraple();
void Triple();
int ind=0;
char temp='A';
struct tablecont
{
  char opd1;
  char opd2;
  char opr;
};
%}

%union
{
   char sym;
}
%token<sym> DIGIT LETTER
%type<sym> expr
%left '+' '-'
%left '*' '/'

%%
statements:LETTER '=' expr ';'{AddToTable((char)$1,(char)$3,'=');}
          | expr
          ;
expr:expr '+' expr {$$=AddToTable((char)$1,(char)$3,'+');}
    |expr '-' expr {$$=AddToTable((char)$1,(char)$3,'-');}
    |expr '*' expr {$$=AddToTable((char)$1,(char)$3,'*');}
    |expr '/' expr {$$=AddToTable((char)$1,(char)$3,'/');}
    |'(' expr ')' {$$=$2;}
    |LETTER
    |DIGIT
    ;
%%


struct tablecont table[20];

void yyerror(char *s)
{
   printf("error -> %s",s);
   exit(0);
}

char AddToTable(char opd1,char opd2,char opr)
{
   table[ind].opd1=opd1;
   table[ind].opd2=opd2;
   table[ind].opr=opr;
   char temp1=temp;
   temp++;
   ind++;
   return temp1;
}

void ThreeAddressCode()
{
   int cnt=0;
   printf("\n\nThreeAddressCode\n\n");
   while(cnt<ind)
   {
     if(ind-cnt==1)
     {
     printf("%c\t%c\t%c\t",table[cnt].opd1,table[cnt].opr,table[cnt].opd2);
     }
     else
     {
     printf("%c\t = %c\t%c\t%c\t",temp-ind+cnt,table[cnt].opd1,table[cnt].opr,table[cnt].opd2);
     }
     printf("\n");
     cnt++;
   }
}

void Quadraple()
{
   
   printf("\nQuadruple Code:\n");
    for (int cnt = 0; cnt < ind; cnt++) 
    {
        if(ind-cnt==1)
        {
           printf("%d\t%c\t%c\t%c\n",cnt,table[cnt].opr,table[cnt].opd1,table[cnt].opd2);
        }
        else
        {
        printf("%d\t%c\t%c\t%c\t%c\n", cnt, table[cnt].opr, table[cnt].opd1, table[cnt].opd2, temp - ind + cnt);
        }
    }
}



int main()
{
   printf("enter the expression:\n");
   yyparse();
   ThreeAddressCode();
   Quadraple();

   return 0;
}
       
   
