%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int result = 0;
int power = 0;
%}

%%
[01]+   {
            char *binary = yytext;
            result = 0;
            power = 0;

            for (int i = strlen(binary) - 1; i >= 0; i--) {
                if (binary[i] == '1') {
                    result += pow(2, power);
                }
                power++;
            }

            printf("Binary: %s => Decimal: %d\n", binary, result);
        }

\n      { }
.       { }

%%

int main() {
    printf("Enter a binary number: ");
    yylex();
    return 0;
}

int yywrap() {
    return 1;
}
