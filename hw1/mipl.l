/* mipl.l
   Description: Lexical Analyzer for mipl. Makes use of start 
   		conditions (see info page for lex) to handle comments and characters.
   Author: Josh Bohde
   Build: make
*/

%{
#include <string.h>

#define T_IDENT      1
#define T_INTCONST   2
#define T_INTERROR   3
#define T_UNKNOWN    4
#define T_OPEN_P     5
#define T_CLOSE_P    6
#define T_STAR	     7
#define T_PLUS	     8
#define T_COMMA	     9
#define T_HYPHEN     10
#define T_DOT	     11
#define T_DOTDOT     12
#define T_COLON	     13
#define T_COLON_E    14
#define T_SEMI	     15
#define T_LESS	     16
#define T_LESS_E     17
#define	T_NOT_E	     18
#define T_EQ	     19
#define T_GREAT	     20
#define T_GREAT_E    21
#define T_OPEN_B     22
#define T_CLOSE_B    23
#define T_AND	     25
#define T_ARRAY	     26
#define T_BEGIN	     27
#define T_BOOL	     28
#define T_DIV	     30
#define T_DO	     31
#define T_ELSE	     32
#define T_END	     33
#define T_FALSE	     34
#define T_IF	     35
#define T_INTEGER    36
#define T_NOT	     37
#define T_OF	     38
#define T_OR	     39
#define T_PROC	     40
#define T_PROG	     41
#define T_READ	     42
#define T_THEN	     43
#define T_TRUE	     44
#define T_VAR	     45
#define T_WHILE	     46
#define T_WRITE	     47
#define T_COMMENT    48
#define T_CHAR	     49
#define T_CHAR_ERROR 50

#define MAX_INT	     "2147483647"
int numLines = 0;
void printTokenInfo(char* tokenType, char* lexeme);
%}

/* Defns of regular expressions go here */
WSPACE            [ \t\r]+
NEWLINE           \n
DIGIT             [0-9]
LETTER            [a-zA-Z]
IDENT             (_|{LETTER})({LETTER}|{DIGIT}|_)*
INTCONST          0*(({DIGIT}{0,9})|([0-1]{DIGIT}{0,9})|(20{DIGIT}{0,8})|(21[0-3]{DIGIT}{0,7})|(214[0-6]{DIGIT}{0,6})|(2147[0-3]{DIGIT}{0,5})|(21474[0-7]{DIGIT}{0,4})|(214748[0-2]{DIGIT}{0,3})|(2147483[0-5]{DIGIT}{0,2})|(21474836[0-3]{DIGIT}{0,1})|(214748364[0-7]))
INTERROR	  {DIGIT}+

%x comment chard
%%



\(\*		  {
			printf("  ----> FOUND A COMMENT\n");
			BEGIN(comment);
			return T_COMMENT;
	          }
<comment>{
	[^*\n]*		 /* do nothing with things that aren't newline or star */
	"*"+[^*\)\n]*    /* star but no end parent */
	{NEWLINE}	 numLines++; 
	\*\)	   	 BEGIN(INITIAL);
}



'		  {	/*Block for handling character constants*/
			BEGIN(chard);
		  }

<chard>{
	\\'	  {	// newline charactesr
			printTokenInfo("CHAR", "'\\n'");
			BEGIN(INITIAL);
			return T_CHAR;
		  }

	\t'	  {	// tab characters
			printTokenInfo("CHAR", "'\\t'");
			BEGIN(INITIAL);
			return T_CHAR;
		  }

	.'	  {	// other charactesr
			char start[3] = "'";
			printTokenInfo("CHAR", strcat(start, yytext));
			BEGIN(INITIAL);
			return T_CHAR;
		  }

	.[^'\n]+' {     // characters not terminated after one character
			printf("**** Invalid character constant: '%s\n", yytext);
			BEGIN(INITIAL);
			return T_CHAR_ERROR;
		  }

	\n	  {	// termination at newline
			printf("**** Unterminated character constant on Line %u\n", numLines);
			numLines++;
			BEGIN(INITIAL);
			return T_CHAR_ERROR;
		  }
}



and               {
                       printTokenInfo("AND", yytext);
                       return T_AND;
                  }

array             {
                       printTokenInfo("ARRAY", yytext);
                       return T_ARRAY;
                  }

begin             {
                       printTokenInfo("BEGIN", yytext);
                       return T_BEGIN;
                  }

boolean           {
                       printTokenInfo("BOOL", yytext);
                       return T_BOOL;
                  }

char              {
                       printTokenInfo("CHAR", yytext);
                       return T_CHAR;
                  }

div               {
                       printTokenInfo("DIV", yytext);
                       return T_DIV;
                  }

do                {
                       printTokenInfo("DO", yytext);
                       return T_DO;
                  }

else              {
                       printTokenInfo("ELSE", yytext);
                       return T_ELSE;
                  }

end               {
                       printTokenInfo("END", yytext);
                       return T_END;
                  }

false             {
                       printTokenInfo("FALSE", yytext);
                       return T_FALSE;
                  }

if                {
                       printTokenInfo("IF", yytext);
                       return T_IF;
                  }

integer           {
                       printTokenInfo("INTEGER", yytext);
                       return T_INTEGER;
                  }

not               {
                       printTokenInfo("NOT", yytext);
                       return T_NOT;
                  }

of                {
                       printTokenInfo("OF", yytext);
                       return T_OF;
                  }

or                {
                       printTokenInfo("OR", yytext);
                       return T_OR;
                  }

procedure         {
                       printTokenInfo("PROC", yytext);
                       return T_PROC;
                  }

program           {
                       printTokenInfo("PROG", yytext);
                       return T_PROG;
                  }

read              {
                       printTokenInfo("READ", yytext);
                       return T_READ;
                  }

then              {
                       printTokenInfo("THEN", yytext);
                       return T_THEN;
                  }

true              {
                       printTokenInfo("TRUE", yytext);
                       return T_TRUE;
                  }

var               {
                       printTokenInfo("VAR", yytext);
                       return T_VAR;
                  }

while             {
                       printTokenInfo("WHILE", yytext);
                       return T_WHILE;
                  }

write             {
                       printTokenInfo("WRITE", yytext);
                       return T_WRITE;
                  }

\(		  {
			printTokenInfo("OPEN_PAREN", yytext);
			return T_OPEN_P;
		  }

\)		  {
			printTokenInfo("CLOSE_PAREN", yytext);
			return T_CLOSE_P;
		  }

\*		  {
			printTokenInfo("STAR", yytext);
			return T_STAR;
		  }

\+		  {
			printTokenInfo("PLUS", yytext);
			return T_PLUS;
		  }

,		  {
			printTokenInfo("COMMA", yytext);
			return T_COMMA;
		  }

-		  {
			printTokenInfo("HYPHEN", yytext);
			return T_HYPHEN;
		  }

\.		  {
			printTokenInfo("DOT", yytext);
			return T_DOT;
		  }

\.\.		  {
			printTokenInfo("DOT_DOT", yytext);
			return T_DOTDOT;
		  }

:		  {
			printTokenInfo("COLON", yytext);
			return T_COLON;
		  }

:=		  {
			printTokenInfo("COLON_EQUALS", yytext);
			return T_COLON_E;
		  }

;		  {
			printTokenInfo("SEMICOLON", yytext);
			return T_SEMI;
		  }

\<		  {
			printTokenInfo("LESS", yytext);
			return T_LESS;
		  }

\<=		  {
			printTokenInfo("LESS_EQUAL", yytext);
			return T_LESS_E;
		  }

\<>		  {
			printTokenInfo("NOT_EQUAL", yytext);
			return T_NOT_E;
		  }

=		  {
			printTokenInfo("EQUAL", yytext);
			return T_EQ;
		  }

>		  {
			printTokenInfo("GREATER", yytext);
			return T_GREAT;
		  }

>=		  {
			printTokenInfo("GREATER_EQUAL", yytext);
			return T_GREAT_E;
		  }

\[		  {
			printTokenInfo("OPEN_BRACKET", yytext);
			return T_OPEN_B;
		  }

\]		  {
			printTokenInfo("CLOSE_BRACKET", yytext);
			return T_CLOSE_B;
		  }

{INTCONST}        {
                        printTokenInfo("INTCONST", yytext);
                        return T_INTCONST;

                  }

{INTERROR}	  {
			printTokenInfo("INTERROR", yytext);
			printf("ERROR: TOKEN IS LARGER THAN MAXINT %s\n", MAX_INT);
			return T_INTERROR;
		  }

{IDENT}           {
                        printTokenInfo("IDENT", yytext);
                        return T_IDENT;
                  }

{NEWLINE}         {
                        numLines++;
                  }

{WSPACE}          { }

.                 {
                        printTokenInfo("UNKNOWN", yytext);
                        return T_UNKNOWN;
                  }
%%
void printTokenInfo(char* tokenType, char* lexeme) {
  printf("TOKEN: %s LEXEME: %s\n", tokenType, lexeme);
}


int yywrap() { return 1; }

int main( ) {
  while ( yylex() ) ;  // Keep processing tokens until 0 returned
  printf("Processed %d lines\n", numLines);
  return 0;
}
