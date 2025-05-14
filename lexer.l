%{
#include "parser.tab.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);

// strdup definition (for systems missing it)
char *strdup(const char *str) {
    char *copy = malloc(strlen(str) + 1);
    if (copy) {
        strcpy(copy, str);
    }
    return copy;
}
%}

%%

"સંખ્યા"               { return TK_NUM; }
"સત્યતા"               { return TK_BOOL; }
"હા"                   { yylval.str = strdup("true"); return BOOLEAN; }
"ના"                   { yylval.str = strdup("false"); return BOOLEAN; }
"દરશાવો"               { return TK_PRINT; }

"જો"                   { return IF; }
"નહીંતર"               { return ELSE; }

"માટે"                 { return FOR; }

"switch"               { return SWITCH; }
"case"                 { return CASE; }
"default"              { return DEFAULT; }
"break"                { return BREAK; }

"=="                   { return EQ; }
"!="                   { return NEQ; }
"<="                   { return LE; }
">="                   { return GE; }
"<"                    { return LT; }
">"                    { return GT; }

"+"                    { return PLUS; }
"-"                    { return MINUS; }
"*"                    { return MUL; }
"/"                    { return DIV; }

"="                    { return ASSIGN; }
";"                    { return SEMICOLON; }
":"                    { return COLON; }

"("                    { return LPAREN; }
")"                    { return RPAREN; }
"{"                    { return LBRACE; }
"}"                    { return RBRACE; }

[0-9]+                 { yylval.str = strdup(yytext); return NUMBER; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return IDENTIFIER; }

[ \t\n\r]+             ;  // skip whitespace
.                      { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
