all: test

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
