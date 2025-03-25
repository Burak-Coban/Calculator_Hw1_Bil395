# Calculator_Hw1_Bil395

Burak Çoban
201104093

lex calculator.l

yacc -d calculator.y

gcc lex.yy.c y.tab.c -o calculator -lm

./calculator
