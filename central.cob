      *     
      *CSCI3180 Principles of Programming Languages
      *     
      *--- Declaration ---
      *     
      *I declare that the assignment here submitted is original except for source
      *material explicitly acknowledged. I also acknowledge that I am aware of
      *University policy and regulations on honesty in academic work, and of the
      *disciplinary guidelines and procedures applicable to breaches of such policy
      *and regulations, as contained in the website
      *    http://www.cuhk.edu.hk/policy/academichonesty/
      *   
      *Assignment 1
      *Name : YU Si Hong
      *Student ID : 1155141630
      *Email Addr : 1155141630@link.cuhk.edu.hk
      *     
       IDENTIFICATION DIVISION.
       PROGRAM-ID. central.
       AUTHOR. YU SIHONG.
       
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT MASTER ASSIGN TO 'master.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANS711 ASSIGN TO 'trans711.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT TRANS713 ASSIGN TO 'trans713.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
               
           SELECT SORT711 ASSIGN TO 'transSorted711.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT SORT713 ASSIGN TO 'transSorted713.txt'
               ORGANIZATION IS LINE SEQUENTIAL. 
           SELECT SORTED ASSIGN TO 'transSorted.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
      *https://www.ibm.com/docs/en/cobol-zos/4.2?topic=statements-sort-statement

           SELECT UMASTER ASSIGN TO 'master.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT NEGREP ASSIGN TO 'negReport.txt'
               ORGANIZATION IS LINE SEQUENTIAL.         

       DATA DIVISION.
       FILE SECTION.
       FD MASTER
           RECORD CONTAINS 58 CHARACTERS.
       01 MRECORD.
           02 MNAME PIC A(20).
           02 MACC PIC 9(16).
           02 MPSWD PIC 9(6).
           02 MBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
      *https://www.ibm.com/docs/en/cobol-zos/4.2?topic=data-examples-numeric-internal-representation

       FD TRANS711
           RECORD CONTAINS 29 CHARACTERS.
       01 T1RECORD.
              02 T1ACC PIC 9(16).
              02 T1OPERATION PIC A(1).
              02 T1AMOUNT PIC 9(5)V9(2).
              02 T1TIME PIC 9(5).
       FD TRANS713
           RECORD CONTAINS 29 CHARACTERS.
       01 T3RECORD.
              02 T3ACC PIC 9(16).
              02 T3OPERATION PIC A(1).
              02 T3AMOUNT PIC 9(5)V9(2).
              02 T3TIME PIC 9(5).

       FD SORT711
           RECORD CONTAINS 29 CHARACTERS.
       01 S1RECORD.
              02 S1ACC PIC 9(16).
              02 S1OPERATION PIC A(1).
              02 S1AMOUNT PIC 9(5)V9(2).
              02 S1TIME PIC 9(5).
       FD SORT713
           RECORD CONTAINS 29 CHARACTERS.
       01 S3RECORD.
              02 S3ACC PIC 9(16).
              02 S3OPERATION PIC A(1).
              02 S3AMOUNT PIC 9(5)V9(2).
              02 S3TIME PIC 9(5).
       FD SORTED
           RECORD CONTAINS 29 CHARACTERS.
       01 SRECORD.
              02 SACC PIC 9(16).
              02 SOPERATION PIC A(1).
              02 SAMOUNT PIC 9(5)V9(2).
              02 STIME PIC 9(5).   

       FD UMASTER
           RECORD CONTAINS 58 CHARACTERS.
       01 UMRECORD.
           02 UMNAME PIC A(20).
           02 UMACC PIC 9(16).
           02 UMPSWD PIC 9(6).
           02 UMBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
       FD NEGREP
           RECORD CONTAINS 69 CHARACTERS.
       01 NEGRECORD.
           02 T1 PIC A(6).
           02 NEGNAME PIC A(20).
           02 T2 PIC A(17).
           02 NEGACC PIC 9(16).
           02 T3 PIC 9(10).
           02 NEGBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
              
       PROCEDURE DIVISION.
           SORT TRANS711 ON DESCENDING KEY STUDENT-ID-O
           USING INPUT GIVING OUTPUT.