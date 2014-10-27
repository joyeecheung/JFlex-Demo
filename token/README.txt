Homework

文件说明：
test.txt：词法分析的输入，即待编译的文本.

outgood.txt: test.txt的样例输出

symboltable：每一个模式对应的编号，输出的时候遇到相应的词素，输出在表中相应的类型编号，详细的输出格式请参照outgood.txt

Yytoken.java:存储token的类，大家直接类似jflex/example/simple直接调用即可


其他说明：
1.根据已经给的"test.txt"， 使用jflex生成.java文件对test.txt进行词法分析返回token，其中token对应的符号表是symbol table.pdf。
     注意：1.文件名与string的差别（文件名两边会有<>）
           2.函数名与string的差别（函数名后会有(),括号内部可能会有参数，参数只会有表中列出的类型）

2.输出的token格式TA将已经写好的Yytoken.java附给大家，大家直接调用即可。小tips: 可以模仿JFlex里面官方的版本JFlex/example/simple.

3.测试的用例将是symbletable表中分类的子集（测试中所有的语法规则不会超出表中的范围）

4.请用%debug标签，方便格式化输出

5.空格不需提供token,即没有action动作

6.附上测试用例及输出
