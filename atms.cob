
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
       PROGRAM-ID. atms.
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

       DATA DIVISION.
       FILE SECTION.
       FD MASTER
           RECORD CONTAINS 58 CHARACTERS.
       01 MRECORD.
           02 MNAME PIC A(20).
           02 MACC PIC 9(16).
           02 MPSWD PIC 9(6).
           02 MBALANCE PIC S9(13)V9(2) SIGN leading SEPARATE.
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
       WORKING-STORAGE SECTION.
       01 ATM PIC 9.
       01 OPE PIC A.
       01 OPE2 PIC A.
       01 ACC1 PIC 9(16).
       01 ACC2 PIC 9(16).
       01 AMOUNT PIC 9(5)V9(2).
       01 PSWD PIC 9(6).
       01 STAMP PIC 9(5) VALUE 0.

       PROCEDURE DIVISION.
       WELCOME.
           DISPLAY "#########################################".
           DISPLAY " #                                     #".
           DISPLAY " #         WELCOME TO THE BANK         #".
           DISPLAY " #                                     #".
           DISPLAY "#########################################". 
           
           OPEN OUTPUT TRANS711.
           OPEN OUTPUT TRANS713.

       MAIN-PROCEDURE.
           DISPLAY "=> PLEASE CHOOSE THE ATM".
           DISPLAY "=> PRESS 1 FOR ATM 711".
           DISPLAY "=> PRESS 2 FOR ATM 713".
           ACCEPT ATM.
           IF ATM = 1 THEN GO TO READACC END-IF.
           IF ATM = 2 THEN GO TO READACC END-IF.
           DISPLAY "=> INVALID INPUT".
           GO TO MAIN-PROCEDURE.

       READACC.
           DISPLAY "=> ACCOUNT".
           ACCEPT ACC1.
           DISPLAY "=> PASSWORD".
           ACCEPT PSWD.
           OPEN INPUT MASTER.
           GO TO CMPACC.

       CMPACC.
           READ MASTER
           AT END DISPLAY "=> INCORRECT ACCOUNT/PASSWORD"
               CLOSE MASTER
               GO TO READACC
           NOT AT END IF ACC1 = MACC THEN 
               IF PSWD = MPSWD THEN 
                   IF MBALANCE IS NEGATIVE THEN
                       DISPLAY "=> NEGATIVE REMAINS TRANSACTION ABORT"
                       GO TO MAIN-PROCEDURE 
                       END-IF
                   CLOSE MASTER
                   GO TO READOPE
                   END-IF 
               END-IF
               GO TO CMPACC
           END-READ.

       READOPE.
           DISPLAY "=> PLEASE CHOOSE YOUR SERVICE".
           DISPLAY "=> PRESS D FOR DEPOSIT".
           DISPLAY "=> PRESS W FOR WITHDRWAL".
           DISPLAY "=> PRESS T FOR TRANSFER".
           ACCEPT OPE.
           IF OPE = 'D' THEN GO TO OPED END-IF.
           IF OPE = 'W' THEN GO TO OPEW END-IF.
           IF OPE = 'T' THEN GO TO OPET END-IF.
           DISPLAY "=> INVALID INPUT".
           GO TO READOPE.

       OPED.
           DISPLAY "=> AMOUNT".
           ACCEPT AMOUNT.
           IF AMOUNT IS POSITIVE THEN 
               DISPLAY "=> DEPOSIT ", AMOUNT
               IF ATM = 1 THEN 
                   MOVE ACC1 TO T1ACC
                   MOVE 'D' TO T1OPERATION
                   MOVE AMOUNT TO T1AMOUNT
                   MOVE STAMP TO T1TIME
                   WRITE T1RECORD
                   END-IF
               IF ATM = 2 THEN
                   MOVE ACC1 TO T3ACC
                   MOVE 'D' TO T3OPERATION
                   MOVE AMOUNT TO T3AMOUNT
                   MOVE STAMP TO T3TIME
                   WRITE T3RECORD
                   END-IF
               ADD 1 TO STAMP
               GO TO CONTI 
               END-IF.
           DISPLAY "=> INVALID INPUT".
           GO TO OPED.
                   
                   

       OPEW.

       OPET.

       CONTI.
           DISPLAY "=> CONTINUE?".
           DISPLAY "=> Y FOR YES".
           DISPLAY "=> N FOR NO".
           ACCEPT OPE2.
           IF OPE2 = 'Y' THEN GO TO MAIN-PROCEDURE END-IF.
           IF OPE2 = 'N' THEN GO TO FAREWELL END-IF.
           

       FAREWELL.
           DISPLAY "#########################################".
           DISPLAY " #                                     #".
           DISPLAY " #           HAVE A NICE DAY           #".
           DISPLAY " #                                     #".
           DISPLAY "#########################################". 
           
           CLOSE TRANS711.
           CLOSE TRANS713.
           STOP RUN. 

       END PROGRAM atms.
       
