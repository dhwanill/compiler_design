%{
#include <stdio.h>
#include <string.h>

void reverseWord(const char *word) {
    int len = strlen(word);
    for (int i = len - 1; i >= 0; i--) {
        putchar(word[i]);
    }
}
%}

%%
[^\s]+   { reverseWord(yytext); putchar(' '); }
\n       { putchar('\n'); }
%%

int main() {
    yylex();
    return 0;
}
