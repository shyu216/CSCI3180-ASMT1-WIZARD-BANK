
// CSCI3180 Principles of Programming Languages

// --- Declaration ---

// I declare that the assignment here submitted is original except for source
// material explicitly acknowledged. I also acknowledge that I am aware of
// University policy and regulations on honesty in academic work, and of the
// disciplinary guidelines and procedures applicable to breaches of such policy
// and regulations, as contained in the website
//     http://www.cuhk.edu.hk/policy/academichonesty/

// Assignment 1
// Name : YU Si Hong
// Student ID : 1155141630
// Email Addr : 1155141630@link.cuhk.edu.hk

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

FILE *t1 = NULL, *t2 = NULL, *mtr = NULL;
char *f711 = "trans711.txt", *f713 = "trans713.txt", *fmtr = "master.txt";

int checkAcc(char *acc, char *pswd)
{
    mtr = fopen(fmtr, "r");
    if (mtr == NULL)
    {
        printf("=> ERROR IN OPENING MASTER FILE\n");
        return 3;
    }
    char mrecord[60], mname[20];
    int macc, mpswd, mbalance, match=1;
    while(match){
    if(feof(mtr)){
        fclose(mtr);
        return 1;
    }
    //58 + 1(\r) + 1(\n)
    fgets(mrecord, 60, mtr);
    puts(mrecord);
    }
}

int service()
{
    int atm = 0;
    char *bf;
    //not null not zero are true
    while (1)
    {
        printf("=> PLEASE CHOOSE THE ATM\n=> PRESS 1 FOR ATM 711\n=> PRESS 2 FOR ATM 713\n");
        //read integer or skip other
        scanf("%d", &atm);
        //read skipped and newline
        getchar();
        if (atm == 1 || atm == 2)
        {
            break;
        }
        printf("=> INVALID INPUT\n");
    }

    char acc1[16] = {0}, acc2[16] = {0}, pswd[6] = {0};
    while (1)
    {
        printf("=> ACCOUNT\n");
        gets(acc1);
        printf("=> PASSWORD\n");
        gets(pswd);
        int check = checkAcc(acc1, pswd);
        if (check == 0)
        {
            break;
        }
        if (check == 1)
        {
            printf("=> INCORRECT ACCOUNT/PASSWORD\n");
            continue;
        }
        if (check == 2)
        {
            printf("=> NEGATIVE REMAINS TRANSACTION ABORT\n");
            return 0;
        }
        if (check == 3)
        {
            return 1;
        }
    }

    return 0;
}

int main()
{

    t1 = fopen(f711, "w+");
    t2 = fopen(f713, "w+");

    printf("#########################################\n");
    printf(" #                                     # \n");
    printf(" #         WELCOME TO THE BANK         # \n");
    printf(" #                                     # \n");
    printf("#########################################\n");

    char conti = 'Y', *bf;
    do
    {
        if (service())
        {
            break;
        }
        do
        {
            printf("=> CONTINUE?\n=> Y FOR YES\n=> N FOR NO\n");
            scanf("%c", conti);
            gets(bf);
        } while (conti == 'Y' || conti == 'N');
    } while (conti == 'Y');

    fclose(t1);
    fclose(t2);

    printf("=> BYEBYE\n");

    return 0;
}