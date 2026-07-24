#include <stdio.h>

char *itoa(int n, char *str) {
	int new = n;
	int i = 0;
	if (n == 0) {
		str[0] = '0';
		return str;
	}
	while (new) {
		for (int j = i; j > 0; j--) {
			str[j] = str[j-1];
		}

		str[0] = (new%10)+'0';

		new = new/10;
		if (!new)
			break;

		i++;
	}
	
	str[i+1] = '\0';

    return str;
}

int main() {
	char s1[32];
	char s2[32];
  itoa(0, s1);
  itoa(10500, s2);
	
	printf("String 1 - %s\nString 2 - %s\n", s1, s2);
	return 0;
}
