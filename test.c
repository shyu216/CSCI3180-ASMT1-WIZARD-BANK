#include <stdio.h>
#include <stdlib.h>
#include <math.h>
int main(void)
{
	double stamp;
	while (1)

	{
		scanf("%3lf", &stamp);

		char c = '0';
		do
		{
			c = getchar();
			printf("c%d %c\n",c, c);
		} while (c != '\n'&&c!=0);
		// printf("%lf  \n", stamp);
		// char amo[6] = {'0'};
		// int k = 0;
		// int m = lround(100 * (*(&stamp)));
		// printf("%d\n", m);
		// for (int i = 4; i >= 0; i--)
		// {
		// 	k = m % 10;
		// 	// printf("%d\n", k);
		// 	k += 48;
		// 	amo[i] = amo[i] > k ? amo[i] : k;
		// 	m /= 10;
		// }
		// if (stamp < 0)
		// 	printf("neg\n");
		// else
		// 	printf("not\n");
		// puts(amo);
	}

	// char a[10] = "stupid\n";
	// puts(a);
	// char *b = a;
	// puts(b);
}
