all: sample.out

test: sample.out
	pr -m -t sample.in sample.out

sample.out: ISBN.class sample.in
	java ISBN sample.in > sample.out

ISBN.class: ISBN.java
	javac ISBN.java

ISBN.java: isbn.flex
	jflex isbn.flex

clean:
	rm -rf *.class *~ ISBN.java

.PHONY: test
