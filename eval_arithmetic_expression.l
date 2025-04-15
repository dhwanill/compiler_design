%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int stack[100];
int top = -1;

void push(int val) {
    stack[++top] = val;
}

int pop() {
    return stack[top--];
}

int evaluate() {
    int token;
    while ((token = yylex()) != 0) {
        if (token == 'N') push(yylval);
        else if (token == 'O') {
            int b = pop();
            int a = pop();
            if (yylval == '+') push(a + b);
            else if (yylval == '-') push(a - b);
            else if (yylval == '*') push(a * b);
            else if (yylval == '/') push(a / b);
        }
    }
    return pop();
}
%}

%%
[0-9]+         { yylval = atoi(yytext); return 'N'; }
[+\-*/]         { yylval = yytext[0]; return 'O'; }
[ \t\n]         { }
.               { }
%%

int main() {
    printf("Enter an arithmetic expression: ");
    printf("Result = %d\n", evaluate());
    return 0;
}

int yywrap() {
    return 1;
}
