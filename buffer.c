#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>

int main(void)
{
    
    char buff[15]; //Don't need more. Default password policy is 8 chars.
    int pass = 0;

    printf("Enter the password: \n");
    gets(buff);

    if(strcmp(buff, "VasuCrimes"))
    {
        printf ("Wrong Password \n");
    }
    else
    {
        printf ("Correct Password \n");
        pass = 1;
    }

    if(pass)
    {
       /* Now Give root or admin rights to user*/
       printf ("Root privileges given to the user\n");
       setuid(0);
       return system("/bin/bash");
    }

    return 0;
}