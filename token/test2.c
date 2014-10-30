#include<stdio.h>

int main(void)
{
    int num;
    int dectotal;
    int doztotal;
    int hextotal;

    for ( num = 2992; num <= 9999; num++ )
    {
        dectotal = (num % 10) + (num % 100)/10 + (num % 1000)/100 + num / 1000;
        doztotal = (num % 12) + (num % 144)/12 + (num % 1728)/144 + num / 1728;
        hextotal = (num % 16) + (num % 256)/16 + (num % 4096)/256 + num / 4096;
        if (num > 1)
            printf("%d\n", num);
    }


    return (0);
}