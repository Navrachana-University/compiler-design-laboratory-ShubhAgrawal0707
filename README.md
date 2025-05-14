Program Description
This project defines a basic compiler front-end using Lex (scanner) and Yacc (parser). The goal is to build a small programming language that supports variable declarations, conditionals, loops, expressions, and switch-case constructs — all with Gujarati language keywords.

Lex File (Scanner)
The Lex code (.l) defines the token patterns used to identify keywords, operators, identifiers, and literals. Here's a breakdown:

Token Definitions
Gujarati Keywords for Data Types:
"સંખ્યા" → TK_NUM (number)
"સત્યતા" → TK_BOOL (boolean)
"હા" → BOOLEAN (true)
"ના" → BOOLEAN (false)
"દરશાવો" → TK_PRINT (print)

Control Flow Keywords:
"જો" → IF
"નહીંતર" → ELSE
"માટે" → FOR
"switch" / "case" / "default" / "break" → respective tokens

Operators:
Relational: ==, !=, <, >, <=, >=
Arithmetic: +, -, *, /
Assignment: =
Symbols: ;, :, {, }, (, )

Identifiers and Numbers:
[0-9]+ → NUMBER
[a-zA-Z_][a-zA-Z0-9_]* → IDENTIFIER

Note:
-Whitespace is skipped.
-Unknown characters are reported.

Yacc File (Parser)
The Yacc code (.y) handles the grammar and structure of the language. It processes the token stream from the lexer and performs semantic actions.

Declarations
Token types and yylval use char *str for simplicity.
assign() and print() functions simulate action execution.

| Feature                              | Description                                                              |
| ------------------------------------ | ------------------------------------------------------------------------ |
| **Gujarati Keywords**                | Data types, control structures in Gujarati (e.g., `"સંખ્યા"` for number)  |
| **Arithmetic & Boolean Expressions** | `+`, `-`, `*`, `/`, relational ops                                       |
| **Control Flow**                     | `if-else`, `for`, `switch-case`                                          |
| **I/O Operation**                    | `"દરશાવો"` acts like a `print` statement                                 |
| **Simple Semantic Actions**          | `assign()` and `print()` simulate runtime behavior                       |
| **Error Handling**                   | `yyerror()` prints syntax errors                                         |
