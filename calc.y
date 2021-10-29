%{

    #include <iostream>
    #include <stdexcept>
    #include <unordered_map>
    #include <string>
    using namespace std;

    int yylex();
    extern int yylineno;
    void yyerror(const char * s){
        fprintf(stderr, "Line: %d, error: %s\n", yylineno, s);
    }

%}

%union{

    int int_t;
    bool boolean_t;

}

//Declaracion de Tokens
%token<int_t> Number
%token Add_op
%token Sub_op
%token Mul_op
%token Div_op
%token EOL
%token Error
%token GreaterEqual
%token LessEqual
%token Equal
%token K_True
%token K_False

%type<int_t>expr term factor

//Gramatica
%%

expr: expr Add_op term { $$ = $1 + $3; }
        | expr Sub_op term { $$ = $1 - $3; }
        | expr Add_op K_True { throw runtime_error("Error: No se puede sumar un entero con un booleano!\n"); }
        | expr Sub_op K_True { throw runtime_error("Error: No se puede restar un entero con un booleano!\n"); }
        | expr Add_op K_False { throw runtime_error("Error: No se puede sumar un entero con un booleano!\n"); }
        | expr Sub_op K_False { throw runtime_error("Error: No se puede restar un entero con un booleano!\n"); }
        | term { $$ = $1; }
    ;

    term: term Mul_op factor { $$ = $1 * $3; }
        | term Div_op factor { 

            if($3 == 0){
                throw runtime_error("Error: No se puede dividir entre 0!\n");
            }else{
                $$ = $1 / $3;
            }

        }
        | term Mul_op K_True { throw runtime_error("Error: No se puede multiplicar un entero con un booleano!\n"); }
        | term Mul_op K_False { throw runtime_error("Error: No se puede multiplicar un entero con un booleano!\n"); }
        | term Div_op K_True { throw runtime_error("Error: No se puede dividir un entero con un booleano!\n"); }
        | term Div_op K_False { throw runtime_error("Error: No se puede dividir un entero con un booleano!\n"); }
        | factor { $$ = $1; }
    ;

    factor: Number { $$ = $1; }
    ;

%%