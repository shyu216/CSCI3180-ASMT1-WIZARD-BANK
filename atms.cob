      *     
      *CSCI3180 Principles of Programming Languages
      *     
      *--- Declaration ---
      *     
      *I declare that the assignment here submitted is original except f
      *or sourcematerial explicitly acknowledged. I also acknowledge tha
      *t I am aware ofUniversity policy and regulations on honesty in ac
      *ademic work, and of thedisciplinary guidelines and procedures app
      *licable to breaches of such policyand regulations, as contained i
      *n the website
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
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS MS.
           SELECT OPTIONAL TRANS711 ASSIGN TO 'trans711.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OPTIONAL TRANS713 ASSIGN TO 'trans713.txt'
               ORGANIZATION IS LINE SEQUENTIAL.           

       DATA DIVISION.
       FILE SECTION.
       FD MASTER.
       01 MRECORD.
           02 MNAME PIC A(20).
           02 MACC PIC 9(16).
           02 MPSWD PIC 9(6).
           02 MBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
      *READ NUMBER WITH SIGN

       FD TRANS711.
       01 T1RECORD.
              02 T1ACC PIC 9(16).
              02 T1OPERATION PIC A(1).
              02 T1AMOUNT PIC 9(5)V9(2).
              02 T1TIME PIC 9(5).
       FD TRANS713.
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
       01 AMOUNT PIC S9(5)V9(2).
       01 PSWD PIC 9(6).
       01 STAMP PIC 9(5) VALUE 0.
       01 TBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
       77 MS PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.
       WELCOME.
           DISPLAY "#########################################".
           DISPLAY " #                                     #".
           DISPLAY " #         WELCOME TO THE BANK         #".
           DISPLAY " #                                     #".
           DISPLAY "#########################################".
           OPEN OUTPUT TRANS711.
           OPEN OUTPUT TRANS713.

      *CHOOSE ATM FIRST
       MAIN-PROCEDURE.
           DISPLAY "=> PLEASE CHOOSE THE ATM".
           DISPLAY "=> PRESS 1 FOR ATM 711".
           DISPLAY "=> PRESS 2 FOR ATM 713".
           ACCEPT ATM.
           IF ATM = 1 THEN GO TO READACC END-IF.
           IF ATM = 2 THEN GO TO READACC END-IF.
           DISPLAY "=> INVALID INPUT".
           GO TO MAIN-PROCEDURE.

      *GET ACC
       READACC.
           DISPLAY "=> ACCOUNT".
           ACCEPT ACC1.
           DISPLAY "=> PASSWORD".
           ACCEPT PSWD.
           OPEN INPUT MASTER.
           IF MS NOT = "00" THEN 
               DISPLAY "=> ERROR IN OPENING MASTER FILE WITH STATUS "
                   , MS
               GO TO FAREWELL END-IF. 
      *FILE STATUS: 00 SUCCESSFUL, 35 FILE NOT FOUND
      
           GO TO CMPACC.

      *CHECK ACC WITH VALID PSWD & BALANCE
       CMPACC.
           READ MASTER
           AT END DISPLAY "=> INCORRECT ACCOUNT/PASSWORD"
               CLOSE MASTER
               GO TO READACC
           NOT AT END IF ACC1 = MACC THEN 
               IF PSWD = MPSWD THEN 
                   IF MBALANCE IS NEGATIVE THEN
                       DISPLAY "=> NEGATIVE REMAINS TRANSACTION ABORT"
                       CLOSE MASTER
                       GO TO MAIN-PROCEDURE 
                       END-IF
                   CLOSE MASTER
                   MOVE MBALANCE TO TBALANCE
                   GO TO READOPE
                   END-IF 
               END-IF
               GO TO CMPACC
           END-READ.

      *CHOOSE SERVICE OPTION
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

      *DEPOSIT
       OPED.
           DISPLAY "=> AMOUNT".
           ACCEPT AMOUNT.
           IF AMOUNT IS POSITIVE THEN 
               DISPLAY "=> DEPOSIT ", AMOUNT, " TO ", ACC2
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

      *WITHDRAWAL    
       OPEW.
           DISPLAY "=> AMOUNT".
           ACCEPT AMOUNT.
           IF AMOUNT IS NEGATIVE THEN
               DISPLAY "=> INVALID INPUT"
               GO TO OPEW
               END-IF.
           IF AMOUNT > MBALANCE THEN
               DISPLAY "=> INSUFFICIENT BALANCE"
               GO TO OPEW
               END-IF.
           DISPLAY "=> WITHDRAW ", AMOUNT, " TO ", ACC1.
           IF ATM = 1 THEN 
               MOVE ACC1 TO T1ACC
               MOVE 'W' TO T1OPERATION
               MOVE AMOUNT TO T1AMOUNT
               MOVE STAMP TO T1TIME
               WRITE T1RECORD
               END-IF.
           IF ATM = 2 THEN
               MOVE ACC1 TO T3ACC
               MOVE 'W' TO T3OPERATION
               MOVE AMOUNT TO T3AMOUNT
               MOVE STAMP TO T3TIME
               WRITE T3RECORD
               END-IF.
           ADD 1 TO STAMP.
           GO TO CONTI. 

      *TRANSFER
       OPET.
           DISPLAY "=> TARGET ACCOUNT".
           ACCEPT ACC2.
           IF ACC2 = ACC1 THEN 
               DISPLAY "=> YOU CANNOT TRANSFER TO YOURSELF"
               GO TO OPET
               END-IF.
           OPEN INPUT MASTER.
           IF MS NOT = "00" THEN 
               DISPLAY "=> ERROR IN OPENING MASTER FILE WITH STATUS "
                   , MS
               GO TO FAREWELL END-IF. 
           GO TO CMPACC2.

      *GET THE RECEIVER ACC
       CMPACC2.
           READ MASTER
           AT END DISPLAY "=> TARGET ACCOUNT DOES NOT EXIST"
               CLOSE MASTER
               GO TO OPET
           NOT AT END IF MACC = ACC2 THEN 
                   CLOSE MASTER
                   GO TO OPET2 
                   END-IF
               GO TO CMPACC2
           END-READ.
       
      *CONTINUE TO TRANSFER
       OPET2.
           DISPLAY "=> AMOUNT".
           ACCEPT AMOUNT.
           IF AMOUNT IS NEGATIVE THEN
               DISPLAY "=> INVALID INPUT"
               GO TO OPET2
               END-IF.
           IF AMOUNT > TBALANCE THEN
               DISPLAY "=> INSUFFICIENT BALANCE"
               GO TO OPET2
               END-IF.
           DISPLAY "=> WITHDRAW ", AMOUNT, " TO ", ACC1.
           IF ATM = 1 THEN 
               MOVE ACC1 TO T1ACC
               MOVE 'W' TO T1OPERATION
               MOVE AMOUNT TO T1AMOUNT
               MOVE STAMP TO T1TIME
               WRITE T1RECORD
               END-IF.
           IF ATM = 2 THEN
               MOVE ACC1 TO T3ACC
               MOVE 'W' TO T3OPERATION
               MOVE AMOUNT TO T3AMOUNT
               MOVE STAMP TO T3TIME
               WRITE T3RECORD
               END-IF.
           ADD 1 TO STAMP.
           DISPLAY "=> DEPOSIT ", AMOUNT, " TO ", ACC2.
           IF ATM = 1 THEN 
               MOVE ACC2 TO T1ACC
               MOVE 'D' TO T1OPERATION
               MOVE AMOUNT TO T1AMOUNT
               MOVE STAMP TO T1TIME
               WRITE T1RECORD
               END-IF.
           IF ATM = 2 THEN
               MOVE ACC2 TO T3ACC
               MOVE 'D' TO T3OPERATION
               MOVE AMOUNT TO T3AMOUNT
               MOVE STAMP TO T3TIME
               WRITE T3RECORD
               END-IF.
           ADD 1 TO STAMP.
           GO TO CONTI. 

      *CHECK CONTINUE
       CONTI.
           DISPLAY "=> CONTINUE?".
           DISPLAY "=> Y FOR YES".
           DISPLAY "=> N FOR NO".
           ACCEPT OPE2.
           IF OPE2 = 'Y' THEN GO TO MAIN-PROCEDURE END-IF.
           IF OPE2 = 'N' THEN GO TO FAREWELL END-IF.
           DISPLAY "=> INVALID INPUT".
           GO TO CONTI.

      *SAY BYEBYE
       FAREWELL.
           DISPLAY "=> BYEBYE".

           CLOSE TRANS711.
           CLOSE TRANS713.
           STOP RUN. 

       END PROGRAM atms.
       
