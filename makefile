# -*- coding: utf-8 -*-

# 64bit gcc
CCW64=/cygdrive/c/mingw-w64/mingw64/bin/gcc

# add the 64bit mingw bin to path
export PATH:=/cygdrive/c/mingw-w64/mingw64/bin;$(PATH)

CFLAGS = -O3 -Wall
DEPS =
SRCS = parser.c lexer.c main.c
DLLSRCS = parser.c lexer.c
TARGETNAME = minimal

.PHONY: clean all

all : exe

# compile with 64bit mingw	
exe: $(SRCS) $(DEPS)
	$(CCW64) -o $(TARGETNAME) $^ $(CFLAGS)
	@echo ------ 64 bit make succeeded -------
	
# rule for parser: generate parser module with bison based on the .y grammar file
parser.c parser.h: minimal_grammar.y $(DEPS)
	bison -v -o parser.c --defines=parser.h minimal_grammar.y

# rule for lexer: generate lexer module with flex based on the .l lexer file
lexer.c: minimal_tokens.l parser.h $(DEPS)
	flex -o lexer.c minimal_tokens.l

clean:
	rm -f lexer.c parser.h parser.c parser.output *.exe
	@echo ------ clean succeeded -------