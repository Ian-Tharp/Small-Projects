#include <stdio.h>

int main() {
    unsigned char input;

    printf("Enter an ASCII character: ");
    scanf("%c", &input);
    
    printf("The ASCII value of %c is, \n", input);
    printf("\tdec -- %d\n", input);
    printf("\thex -- %x\n", input);
    printf("\tbin -- ");
    
    int temp;
    for(int i = 7; i >= 0; i--) {
        temp = input >> i;
        if (temp & 1)
            printf("1");
        else
            printf("0");
    }
    printf("\n");
};

