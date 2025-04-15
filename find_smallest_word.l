%{
#include <stdio.h>
#include <ctype.h>
void convert_case(char c) {
    if (islower(c)) printf("%c", toupper(c));
    else if (isupper(c)) printf("%c", tolower(c));
    else putchar(c);
}
%}

%%

[\t]+ {}
[a-z] { convert_case(yytext[0]); }
[A-Z] { convert_case(yytext[0]); }
. { putchar(yytext[0]); }

%%

int main() {
    yylex();
    return 0;
}
