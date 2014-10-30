all: output.txt

# test: apple
# 	grep -e "match:" -e "(Text:" apple > apple.out

# apple: Yylex.class apple.c
# 	java Yylex apple.c > apple

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
	rm -f output.txt output

.PHONY: test
