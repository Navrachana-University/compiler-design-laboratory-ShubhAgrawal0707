%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex(void);
void yyerror(const char *msg);

void assign(char *a, char *b) {
    printf("ASSIGN: %s = %s\n", a, b);
}

void print(char *a) {
    printf("PRINT: %s\n", a);
}
%}

%union {
    char *str;
}

%token <str> IDENTIFIER NUMBER BOOLEAN
%token TK_NUM TK_BOOL TK_PRINT
%token IF ELSE FOR
%token SWITCH CASE DEFAULT BREAK
%token ASSIGN SEMICOLON COLON
%token EQ NEQ LT GT LE GE
%token PLUS MINUS MUL DIV
%token LPAREN RPAREN LBRACE RBRACE

%type <str> expression condition

%left PLUS MINUS
%left MUL DIV
%nonassoc EQ NEQ LT GT LE GE
%nonassoc ELSE

%%

program:
    program statement
    | statement
    ;

statement:
      TK_NUM IDENTIFIER SEMICOLON
    | TK_BOOL IDENTIFIER SEMICOLON
    | IDENTIFIER ASSIGN expression SEMICOLON         { assign($1, $3); }
    | TK_PRINT IDENTIFIER SEMICOLON                   { print($2); }
    | IF LPAREN condition RPAREN block
    | IF LPAREN condition RPAREN block ELSE block
    | FOR LPAREN IDENTIFIER ASSIGN expression SEMICOLON condition SEMICOLON IDENTIFIER ASSIGN expression RPAREN block
    | SWITCH LPAREN IDENTIFIER RPAREN LBRACE case_list default_case RBRACE
    ;

case_list:
    case_list CASE NUMBER COLON statements BREAK SEMICOLON
    | CASE NUMBER COLON statements BREAK SEMICOLON
    ;

default_case:
    DEFAULT COLON statements
    | /* empty */
    ;

statements:
    statements statement
    | statement
    ;

block:
    LBRACE statements RBRACE
    ;

expression:
      NUMBER
    | IDENTIFIER
    | BOOLEAN
    | expression PLUS expression
    | expression MINUS expression
    | expression MUL expression
    | expression DIV expression
    ;

condition:
      expression EQ expression
    | expression NEQ expression
    | expression LT expression
    | expression GT expression
    | expression LE expression
    | expression GE expression
    ;

%%

int main() {
    return yyparse();
}

void yyerror(const char *msg) {
    fprintf(stderr, "Syntax Error: %s\n", msg);
}
