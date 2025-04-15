%{
#include <stdio.h>

int precedence(char op) {
    if (op == '+' || op == '-') return 1;
    if (op == '*' || op == '/') return 2;
    if (op == '^') return 3;
    return 0;
}

void infix_to_postfix() {
    char stack[100], output[100];
    int top = -1, k = 0;

    while (1) {
        int token = yylex();
        if (token == 0) break;

        if (token == 'N') output[k++] = yylval;
        else if (token == 'O') {
            while (top != -1 && precedence(stack[top]) >= precedence(yylval)) output[k++] = stack[top--];
            stack[++top] = yylval;
        } else if (token == '(') stack[++top] = '(';
        else if (token == ')') {
            while (stack[top] != '(') output[k++] = stack[top--];
            top--;
        }
    }

    while (top != -1) output[k++] = stack[top--];
    for (int i = 0; i < k; i++) printf("%c ", output[i]);
    printf("\n");
}
%}

%%
[0-9A-Za-z]     { yylval = yytext[0]; return 'N'; }
[+\-*/^]         { yylval = yytext[0]; return 'O'; }
\(               { return '('; }
\)               { return ')'; }
[ \t\n]          { }
.                { }
%%

int main() {
    printf("Enter an infix expression: ");
    infix_to_postfix();
    return 0;
}

int yywrap() {
    return 1;
}
