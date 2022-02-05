#include <stdio.h>
#include <stdlib.h>  // THIS IS WHAT YOU ARE MISSING


int main(void) {
    char s[30] = { "-00000000000512345" };
    long long t = atoll(s);

    printf("Value is: %lld\n", t);
	
    int j = 0;
    for (int i = 4; i >= 0; i--)
    {
        j = t % 10;
         printf("%d\n", j);
        // j += 48;
        // time[i] = time[i] > j ? time[i] : j;
         t /= 10;
    }
	return 0;
}