/* -*- coding: utf-8 -*- */
 
/*==================================================*/
/* PART 1: C declarations */
/*==================================================*/
%{
    #include <stdio.h>
    /* include the header file of the generated parser module */
    #include "parser.h"
    
    int yyerror(char *s);
    /* externs */
    extern int yylex();
    extern int yyparse();
    extern FILE *yyin;
%}

%union{
  char* string;
}

%token <token> FOO BAR_START BAR_END
%token <string> ID STRING

%type <token> head contents foobar

%%

input:
    head contents tail  { printf("> Finished.\n"); }
    ;

head:
    ID                  {printf("> head: <ID>: %s\n", $1); free($1); }
    | head ID           {printf("> head: <head ID>: %s\n", $2); free($2); }
    ;
contents:
    foobar              {printf("> contents: <foobar>\n");}
    | contents foobar   {printf("> contents: <contents foobar>\n");}
    ;
foobar:
    foos                {printf("> foobar: <foos>\n");}
    | bars              {printf("> foobar: <bars>\n");}
    ;
foos:
    foo                 {printf("> foos: <foo>\n");}
    | foos foo          {printf("> foos: <foos foo>\n"); }
    ;
foo:
    FOO STRING          {printf("> FOO: %s\n", $2); free($2); }
    ;
bars:
    bar                 {printf("> bars: <bar>\n");}
    | bars bar          {printf("> bars: <bars bar>\n");}
    ;
bar:
    BAR_START ID STRING BAR_END
    {
                        printf("> BAR: %s, %s.\n", $2, $3);
                        free($2); free($3);
    }
    ;
tail:
    STRING              {printf("> tail <STRING>: %s\n", $1); free($1);}
    | tail STRING       {printf("> tail: <tail STRING>: %s\n", $2); free($2);}
    ;

%%

int yyerror(char *s)
{
  extern int yylineno;
  extern char *yytext;
  printf("PARSER ERROR: %s at symbol %s\n", s, yytext);
  printf("  on line %d\n", yylineno);
  return -1;
}
