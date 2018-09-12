# minimal_bison_parser
minimal example for parser with bison

## Info
minimal_grammar.y contains a grammar description that causes shift/reduce errors.

minimal_grammar_corrected.y contains a description that gets rid of the ambiguity. Correction based on this answer: https://stackoverflow.com/a/52299386/1169220

## Howto

### Build on Windows with MinGW-64
`make exe`

### Call
`minimal.exe <input_file_name>`

