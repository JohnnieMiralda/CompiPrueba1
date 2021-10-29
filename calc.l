
%option noyywrap
%option yylineno
%{
    #include "tokens.h"
    extern int yyval;
}%


%%

[0-9]+ 
"+" { return Add_op}
"-" {return  Sub_op}
"*" {return Mul_op}
"/" {return Div_op}
">=" {return GreaterEqual}
"<=" {return LessEqual}
"==" {return Equal}
"true" {return K_True}
"false" { return K_False;}
[\n] { return EOL;}
[ \t] { }
. { printf("Error: Caracter no vaidado");}

%%