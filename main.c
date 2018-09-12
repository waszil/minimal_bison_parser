/* -*- coding: utf-8 -*- */

#include "parser.h"
#include <stdio.h>

extern FILE *yyin;
extern int yylineno;

int main(int argc, char *argv[])
{
    FILE*   inputfile = NULL;
    char*   inputfilename = NULL;
    
    /* command line arguments handling */
    
    inputfilename = argv[1];
    
    /* open the trc file */
    inputfile = fopen(inputfilename, "r");
    if (!inputfile)
    {
        printf("Input not be found! (%s)\n", inputfilename);
        return -1;
    }

	yyin = inputfile;
	
	/* flex through the input: */
	// yylex();
    
    /* do the TRC parsing */
    yyparse();
    
    return 0;
}