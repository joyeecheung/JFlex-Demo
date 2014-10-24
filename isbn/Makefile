all: run

run: ISBN.class
	java ISBN sample.in

ISBN.class: ISBN.java
	javac ISBN.java

ISBN.java: isbn.flex
	jflex isbn.flex

clean:
	rm -rf *.class *~ ISBN.java
