
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
#include <math.h>

FILE *t1 = NULL,
     *t2 = NULL,
     *mtr = NULL;

char *f711 = "trans711.txt",
     *f713 = "trans713.txt",
     *fmtr = "master.txt";

char mrecord[60] = {0},
     mname[22] = {0},
     macc[18] = {0},
     mpswd[8] = {0},
     mbalance[18] = {0};

int stamp = 0;

// clean stdin to avoid error
void cleanStdin()
{
    char c = '0';
    do
    {
        c = getchar();
        // printf("the value char %c is %d\n", c, c);
    } while (c != '\n' && c != 0);
    return;
}

// who: 1 for acc1, 2 for acc2
int checkAcc(char *acc, char *pswd, int who)
{
    mtr = fopen(fmtr, "r");
    if (mtr == NULL)
    {
        printf("=> ERROR IN OPENING MASTER FILE\n=> BYEBYE\n");
        exit(1);
    }

    while (1)
    {
        if (feof(mtr))
        {
            fclose(mtr);
            if (who == 1)
            {
                printf("=> INCORRECT ACCOUNT/PASSWORD\n");
            }
            if (who == 2)
            {
                printf("=> TARGET ACCOUNT DOES NOT EXIST\n");
            }
            return 1;
        }
        // 58 + (\r) + (\n)
        // fgets only get n-1
        fgets(mrecord, 61, mtr);
        // puts(mrecord);

        // sscanf cannot handle blank space
        // sscanf(mrecord, "%20s %16s %6s %16s", mname, macc, mpswd, mbalance);

        strncpy(mname, mrecord, 20);
        strncpy(macc, mrecord + 20, 16);
        strncpy(mpswd, mrecord + 36, 6);
        strncpy(mbalance, mrecord + 42, 16);
        // printf("%s\n%s\n%s\n%s\n", mname, macc, mpswd, mbalance);

        if (who == 1)
        {
            if (strncmp(macc, acc, 16) == 0 && 0 == strncmp(mpswd, pswd, 6))
            {
                fclose(mtr);
                if (mbalance[0] == '-')
                {
                    printf("=> NEGATIVE REMAINS TRANSACTION ABORT\n");
                    return 2;
                }
                return 0;
            }
        }
        if (who == 2)
        {
            if (strncmp(macc, acc, 16) == 0)
            {
                fclose(mtr);
                return 0;
            }
        }
    }
}

void writeAtm(char *acc, char *atm, char *opt, double *amount)
{
    // (a) get timestamp string
    char time[6] = {'0'};
    int tim = stamp;
    int j = 0;
    for (int i = 4; i >= 0; i--)
    {
        j = tim % 10;
        // printf("%d\n", j);
        j += 48;
        time[i] = time[i] > j ? time[i] : j;
        tim /= 10;
    }

    // (b) get amount string
    char amou[8] = {'0'};
    long long int amo = (long long int)round(100 * (*amount));
    // printf("%lf %lld\n", *amount, amo);
    int k = 0;
    for (int i = 6; i >= 0; i--)
    {
        k = amo % 10;
        // printf("%d\n", k);
        k += 48;
        amou[i] = amou[i] > k ? amou[i] : k;
        amo /= 10;
    }

    // (c) prepare record
    char record[29] = {0};
    strncat(record, acc, 16);
    strncat(record, opt, 1);
    strncat(record, amou, 7);
    strncat(record, time, 5);
    printf("=> GENERATE RECORD: ");
    puts(record);
    // printf("%c\n", *atm);

    // (d) write to ATM
    if (*atm == '1')
    {
        fputs(record, t1);
        fprintf(t1, "\n");
    }
    if (*atm == '2')
    {
        fputs(record, t2);
        fprintf(t2, "\n");
    }

    stamp++;
    return;
}

double deposit()
{
    double amount = 0;
    while (1)
    {
        printf("=> AMOUNT\n");
        scanf("%8lf", &amount);
        cleanStdin();
        // printf("=> AMOUNT: %lf\n", amount);
        if (round(100 * amount) > 0.000)
        {
            return amount;
        }
        printf("=> INVALID INPUT\n");
    }
}

double withdrawal(char *balance)
{
    double amount = 0;
    while (1)
    {
        printf("=> AMOUNT\n");
        scanf("%8lf", &amount);
        cleanStdin();
        // printf("=> AMOUNT: %lf\n", amount);
        if (round(100 * amount) < 0.000)
        {
            printf("=> INVALID INPUT\n");
            continue;
        }
        // printf("input:%lf\nread:%s\natoi:%lf\n", amount, balance, atoi(balance)/100.0);
        // printf("=> BALANCE: %lf\n", atoll(balance) / 100.000);
        if (round(100.000 * amount) > atoll(balance))
        {
            printf("=> INSUFFICIENT BALANCE\n");
            continue;
        }
        return amount;
    }
}

int service()
{
    // (1) choose atm
    char atm = 0;
    // not null not zero are true
    while (1)
    {
        printf("=> PLEASE CHOOSE THE ATM\n=> PRESS 1 FOR ATM 711\n=> PRESS 2 FOR ATM 713\n");
        // read integer or skip other
        scanf("%c", &atm);
        // read skipped and newline
        cleanStdin();
        if (atm == '1' || atm == '2')
        {
            break;
        }
        printf("=> INVALID INPUT\n");
    }

    // (2) input account&password
    char acc1[18] = {0}, acc2[18] = {0}, pswd[8] = {0};
    while (1)
    {
        printf("=> ACCOUNT\n");
        scanf("%16s", acc1);
        cleanStdin();
        printf("=> PASSWORD\n");
        scanf("%6s", pswd);
        cleanStdin();
        int check = checkAcc(acc1, pswd, 1);
        if (check == 0)
        {
            break;
        }
        if (check == 1)
        {
            continue;
        }
        if (check == 2)
        {
            return 1;
        }
    }

    // (3) choose service
    char opt = 0;
    while (1)
    {
        printf("=> PLEASE CHOOSE YOUR SERVICE\n=> PRESS D FOR DEPOSIT\n=> PRESS W FOR WITHDRWAL\n=> PRESS T FOR TRANSFER\n");
        scanf("%c", &opt);
        cleanStdin();
        if (opt == 'W' || opt == 'D' || opt == 'T')
        {
            break;
        }
        printf("=> INVALID INPUT\n");
    }

    // (4) service

    // (4a) deposit
    if (opt == 'D')
    {
        double amount = deposit();
        writeAtm(acc1, &atm, &opt, &amount);
    }

    // (4b) withdrawal
    if (opt == 'W')
    {
        char *balance = mbalance;
        double amount = withdrawal(balance);
        writeAtm(acc1, &atm, &opt, &amount);
    }

    // (4c) transfer
    if (opt == 'T')
    {
        char balance[18] = {0};
        strcpy(balance, mbalance);
        while (1)
        {
            printf("=> ACCOUNT\n");
            scanf("%16s", acc2);
            cleanStdin();
            if (strcmp(acc1, acc2) == 0)
            {
                printf("=> YOU CANNOT TRANSFER TO YOURSELF\n");
                continue;
            }
            int check = checkAcc(acc2, NULL, 2);
            if (check == 0)
            {
                break;
            }
        }
        // printf("%s\n",balance);
        double amount = withdrawal(balance);
        opt = 'W';
        writeAtm(acc1, &atm, &opt, &amount);
        opt = 'D';
        writeAtm(acc2, &atm, &opt, &amount);
    }

    return 0;
}

int main()
{

    t1 = fopen(f711, "w");
    t2 = fopen(f713, "w");

    printf("#########################################\n");
    printf(" #                                     # \n");
    printf(" #         WELCOME TO THE BANK         # \n");
    printf(" #                                     # \n");
    printf("#########################################\n");

    char conti = '0';
    do
    {
        if (service())
        {
            continue;
        }
        do
        {
            printf("=> CONTINUE?\n=> Y FOR YES\n=> N FOR NO\n");
            scanf("%c", &conti);
            cleanStdin();
        } while (conti != 'Y' && conti != 'N');
    } while (conti != 'N');

    fclose(t1);
    fclose(t2);

    printf("=> BYEBYE\n");

    return 0;
}