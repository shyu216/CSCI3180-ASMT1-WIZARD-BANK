
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
#include "sort.h"

int try_open(char *fil)
{
    FILE *f = fopen(fil, "r");
    if (f == NULL)
    {
        printf("=> ERROR IN OPENING FILE %s \n", fil);
        return 1;
    }
    fclose(f);
    return 0;
}

void merge_transaction(char *f711, char *f713, char *fus)
{
    FILE *fi1 = fopen(f711, "r");
    FILE *fi2 = fopen(f713, "r");
    FILE *fi3 = fopen(fus, "w");

    char bf[31] = {0};

    // many ways to read and write
    // (a) fgets returns NULL if file ends
    while (fgets(bf, 32, fi1))
    {
        fputs(bf, fi3);
    }

    // (b) feof return True if file ends
    // while (1)
    // {
    //     if (feof(fi1))
    //     {
    //         break;
    //     }
    //     fgets(bf, 31, fi1);
    //     fputs(bf, fi3);
    // }

    // (c) fscanf return EOF if file ends
    while (1)
    {
        if (EOF == fscanf(fi2, "%29s", bf))
            break;
        fgetc(fi2);
        fputs(bf, fi3);
        fprintf(fi3, "\n");
    }

    fclose(fi1);
    fclose(fi2);
    fclose(fi3);

    return;
}

void update_transaction(char *fs, char *fmtr, char *fmup, char *fneg)
{
    // (1) open files
    FILE *fi1 = fopen(fmtr, "r");
    FILE *fi2 = fopen(fmup, "w");
    FILE *fi3 = fopen(fneg, "w");

    // (2) initial record
    char mrecord[60] = {0},
         mname[22] = {0},
         macc[18] = {0},
         mpswd[8] = {0},
         mbalance[18] = {0};
    char trecord[31] = {0},
         tacc[18] = {0},
         topt[3] = {0},
         tamou[9] = {0};

    // (3) read master
    while (fgets(mrecord, 61, fi1))
    {
        strncpy(mname, mrecord, 20);
        strncpy(macc, mrecord + 20, 16);
        strncpy(mpswd, mrecord + 36, 6);
        strncpy(mbalance, mrecord + 42, 16);
        long long int balan = atoll(mbalance);
        // printf("%s => %lld\n", mbalance, balan);

        // (4) read transaction
        FILE *fi4 = fopen(fs, "r");
        while (fgets(trecord, 32, fi4))
        {
            strncpy(tacc, trecord, 16);
            strncpy(topt, trecord + 16, 1);
            strncpy(tamou, trecord + 17, 7);
            long long int amoun = atoll(tamou);

            if (strcmp(tacc, macc) == 0)
            {
                if (topt[0] == 'W')
                {
                    balan -= amoun;
                }
                if (topt[0] == 'D')
                {
                    balan += amoun;
                }
            }
        }
        fclose(fi4);

        // (5) update balance
        int digit = 0, sign;
        sign = balan < 0 ? 1 : 0;
        balan = sign ? 0 - balan : balan;

        for (int i = 15; i > 0; i--)
        {
            digit = balan % 10;
            mbalance[i] = digit + 48;
            balan /= 10;
        }
        mbalance[0] = sign ? '-' : '+';

        // (6) write master
        char urecord[60] = {0};
        strncat(urecord, mname, 20);
        strncat(urecord, macc, 16);
        strncat(urecord, mpswd, 6);
        strncat(urecord, mbalance, 16);

        // printf("=> GENERATE RECORD: ");
        // puts(urecord);

        fputs(urecord, fi2);
        fprintf(fi2, "\n");

        // (7) write report
        if (sign)
        {
            fprintf(fi3, "Name: %20s Account Number: %16s Balance: %16s\n", mname, macc, mbalance);
            // printf("=> GENERATE RECORD: Name: %20s Account Number: %16s Balance: %16s\n", mname, macc, mbalance);
        }
    }

    fclose(fi1);
    fclose(fi2);
    fclose(fi3);

    return;
}

int main()
{

    char *f711 = "trans711.txt",
         *f713 = "trans713.txt",
         *fmtr = "master.txt",
         *fs711 = "transSorted711.txt",
         *fs713 = "transSorted713.txt",
         *fus = "transUnsort.txt",
         *fs = "transSorted.txt",
         *fmup = "updatedMaster.txt",
         *fneg = "negReport.txt";

    // (1) check files existence
    if (try_open(f711) || try_open(f713) || try_open(fmtr))
    {
        return 1;
    }

    // (2) sort
    sort_transaction(f711, fs711);
    sort_transaction(f713, fs713);

    // (3) merge
    merge_transaction(f711, f713, fus);
    sort_transaction(fus, fs);

    // (4) update
    update_transaction(fs, fmtr, fmup, fneg);

    printf("=> ALL DONE SUCCESSFULLY\n=> BYEBYE\n");
    return 0;
}
