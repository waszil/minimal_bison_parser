/* -*- coding: utf-8 -*- */
 
/* This tells flex to read only one input file */
%option noyywrap
/* This tells flex not to generate input and yyunput function, that we do not use, so no warning thrown */
%option noinput
%option nounput
/* generate accessible variable for actual line number */
%option yylineno

%{
    /* include the header file of the generated parser module, it contains the token definitions */
    #include "parser.h"
    
    /* Function for getting a string token value.
       A string token is in the form: "value". This function gets the
       value between the " characters */
    char* getString(char* str)
    {
        char* substr;
        int len;
        len = strlen(str);
        substr = malloc(len-2+1);
        strncpy(substr, str+1, strlen(str)-2);
        substr[len-2] = 0;
        return substr;
    }
    
%}

WHITESPACE          [ \t]+
NEWLINE             [\n\r]+
COMMENT             \-\-.*
STRING              \"[^"]*\"
/* keywords */
FOO                 foo
BAR_START           bar_start
BAR_END             bar_end
/* other identifiers */
ID                  [a-zA-Z][a-zA-Z0-9_]*

%%

{FOO}                   { return FOO; }
{STRING}                { yylval.string = getString(yytext); return STRING;  }
{BAR_START}             { return BAR_START; }
{BAR_END}               { return BAR_END; }
{ID}                    { yylval.string = strdup(yytext); return ID; }
{WHITESPACE}            { /* eat up whitespace */ }
{COMMENT}               { /* eat up comments */   }
{NEWLINE}               { /* eat up new lines */  }
.	                    { printf( "LEXER: Unrecognized character: %s at line %i\n", yytext, yylineno ); }

%%
