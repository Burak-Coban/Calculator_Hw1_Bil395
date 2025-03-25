# Calculator_Hw1_Bil395

Burak Çoban
201104093

pow() fonksiyonu kullanılması için derleme aşamasında -lm eklenmektedir

lex calculator.l

yacc -d calculator.y

gcc lex.yy.c y.tab.c -o calculator -lm

./calculator
