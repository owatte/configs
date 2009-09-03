all:
	flex mipl.l
	gcc lex.yy.c -o lexer
	rm lex.yy.c

clean: 
	rm lexer