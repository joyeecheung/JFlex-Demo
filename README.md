## How to use isbn.flex

Suppose the input is in `sample.in`, output will be redirected to `sample.out`

```
$ jflex isbn.flex
$ javac ISBN.java
$ java ISBN sample.in > sample.out
```
Or checkout the `Makefile` on the Github repo.

## How to use token.flex

Suppose the input is in `test.txt`, output will be redirected to `output.txt`

```
$ jflex token.flex
$ javac Yylex.java Yytoken.java
$ java Yylex test.txt > output.txt
```
Or checkout the `Makefile` on the Github repo.

## About

* Author: Qiuyi Zhang
* Time: oct 2014
* E-mail: [joyeec9h3@gmail.com](mailto:joyeec9h3@gmail.com)
* Github Repository: [https://github.com/joyeecheung/JFlex-Demo](https://github.com/joyeecheung/JFlex-Demo)
