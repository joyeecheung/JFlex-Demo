import java.util.Stack;

%%
%unicode
%debug

INCLUDE=\#include
ALPHA=[A-Za-z]
DIGIT=[0-9]

FILENAME=\<.*\>
ID=[A-Za-z_]({ALPHA}|{DIGIT}|_)*
STRING_TEXT=(\\\"|[^\n\r\"]|\\{WHITE_SPACE_CHAR}+\\)*
FUNCTION={ID}

WHITE_SPACE_CHAR=[\\n\\r\\ \\t\\b\\012]

NUMBER=DIGIT+
WHITE_SPACE=[\ \t\b\f]+|\r\n|\n

%x FUNC
%{
  private Stack<String> func = new Stack<String>();
  private int parenthese = 0;
%}

%%

<YYINITIAL, FUNC> {
  {INCLUDE} { return (new Yytoken(1, yytext())); }
  {FILENAME} { return (new Yytoken(2, yytext())); }
  {FUNCTION}\(\) { return (new Yytoken(3, yytext())); }
  {FUNCTION}\( {
                yybegin(FUNC);
                return (new Yytoken(3, yytext() + ")"));
              }
  \"{STRING_TEXT}\" { return (new Yytoken(4, yytext())); }

  "," { return (new Yytoken(6, yytext())); }
  ";" { return (new Yytoken(7, yytext())); }
  "{" { return (new Yytoken(8, yytext())); }
  "}" { return (new Yytoken(9, yytext())); }
  "+" { return (new Yytoken(10, yytext())); }
  "-" { return (new Yytoken(11, yytext())); }
  "*" { return (new Yytoken(14, yytext())); }
  "/" { return (new Yytoken(15, yytext())); }
  "<" { return (new Yytoken(16, yytext())); }
  ">" { return (new Yytoken(17, yytext())); }
  "=" { return (new Yytoken(18, yytext())); }
  "int"      { return (new Yytoken(19, yytext())); }
  "double"   { return (new Yytoken(20, yytext())); }
  "if"       { return (new Yytoken(21, yytext())); }
  "return"   { return (new Yytoken(22, yytext())); }

  {ID}  { return (new Yytoken(24, yytext())); }
  {DIGIT}+ { return (new Yytoken(23, yytext())); }
  {WHITE_SPACE} {  }
}

<YYINITIAL> {
    "(" { return (new Yytoken(12, yytext())); }
    ")" { return (new Yytoken(13, yytext())); }
    . {   }
}

<FUNC> {
    "(" { parenthese++; return (new Yytoken(12, yytext())); }
    ")" { if (parenthese > 0) {
            parenthese--;
            return (new Yytoken(12, yytext()));
          } else {
            yybegin(YYINITIAL);
          }
        }
    . {   }
}
