%{
#include <stdio.h>
#include <string.h>

int is_palindrome(char* str) {
    int len = strlen(str);
    for (int i = 0; i < len / 2; i++) {
        if (str[i] != str[len - i - 1]) {
            return 0; // Not a palindrome
        }
    }
    return 1; // Is a palindrome
}
%}

%token LETTER

%%
input: 
    | input line
    ;

line:
    word '\n' { 
        if (is_palindrome($1)) {
            printf("Palindrome\n");
        } else {
            printf("Not a palindrome\n");
        }
        free($1);
    }
    ;

word:
    LETTER { 
        char* str = (char*) malloc(2);
        str[0] = $1;
        str[1] = '\0';
        $$ = str;
    }
    | word LETTER {
        int len = strlen($1);
        char* str = (char*) malloc(len + 2);
        strcpy(str, $1);
        str[len] = $2;
        str[len + 1] = '\0';
        free($1);
        $$ = str;
    }
    ;

%%

int main() {
    printf("Enter a string: ");
    yyparse();
    return 0;
}

int yywrap() {
    return 1;
}
