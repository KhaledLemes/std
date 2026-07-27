#include <stdio.h>

char *itoa(int n, char *str) {
	int new = n; 
	int negative = (n < 0);
  int i = 0;
	
	if (n == 0) {
		str[0] = '0';
		str[1] = '\0';
		return str;
	}
	
	while (new) {
		for (int j = i; j > 0; j--) {
			str[j] = str[j-1];
		}
        
        int mod = new%10;
        if (negative) 
            mod = -mod;
		str[0] = mod+'0';

		new = new/10;
		if (!new)
			break;

		i++;
	}
	if (negative) {
	    for (int j = i+1; j > 0; j--) {
			str[j] = str[j-1];
		}
		str[0] = '-';
		i++;
	}
	str[i+1] = '\0';

    return str;
}

int main() {
	char s1[32];
	char s2[32];
  char s3[32];

  itoa(0, s1);
  itoa(-10500, s2);
	itoa(1234567890, s3);

	printf("String 1 is %s\nString 2 is %s\nString 3 is %s\n", s1, s2, s3);
	return 0;
}

