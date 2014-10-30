all: output.txt

# test: outputtest2
# 	grep -e "(Text:" outputtest2 > test2.out

# outputtest2: Yylex.class test2.c
# 	java Yylex test2.c > outputtest2

test: output.txt
	grep -e "match:" -e "(Text:" output.txt > output
	diff output outgood

output.txt: Yylex.class test.txt
	java Yylex test.txt > output.txt

Yylex.class: Yylex.java Yytoken.java

%.class: %.java
	javac $^

Yylex.java: token.flex
	jflex token.flex

clean:
	rm -f Yylex.java output.txt *.class *~
	rm -f output.txt output* test2.out

.PHONY: test
