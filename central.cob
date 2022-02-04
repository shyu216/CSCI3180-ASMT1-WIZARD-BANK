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
       PROGRAM-ID. central.
       AUTHOR. YU SIHONG.
       
       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.
           SELECT MASTER ASSIGN TO 'master.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS MS.
           SELECT TRANS711 ASSIGN TO 'trans711.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS T1S.
           SELECT TRANS713 ASSIGN TO 'trans713.txt'
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS T3S.
               
      *OPTIONAL: CREATE IF NOT EXIST
           SELECT OPTIONAL SORT711 ASSIGN TO 'transSorted711.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OPTIONAL SORT713 ASSIGN TO 'transSorted713.txt'
               ORGANIZATION IS LINE SEQUENTIAL. 
           SELECT OPTIONAL SORTED ASSIGN TO 'transSorted.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
  
           SELECT OPTIONAL UMASTER ASSIGN TO 'updatedMaster.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OPTIONAL NEGREP ASSIGN TO 'negReport.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

           SELECT OPTIONAL TEMP1 ASSIGN TO 'work.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OPTIONAL TEMP2 ASSIGN TO 'transUnsort.txt'
               ORGANIZATION IS LINE SEQUENTIAL.
                    
       DATA DIVISION.

       FILE SECTION.
       
       FD MASTER.
       01 MRECORD.
           02 MNAME PIC A(20).
           02 MACC PIC 9(16).
           02 MPSWD PIC 9(6).
           02 MBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
      
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

       FD SORT711.
       01 S1RECORD.
              02 S1ACC PIC 9(16).
              02 S1OPERATION PIC A(1).
              02 S1AMOUNT PIC 9(5)V9(2).
              02 S1TIME PIC 9(5).

       FD SORT713.
       01 S3RECORD.
              02 S3ACC PIC 9(16).
              02 S3OPERATION PIC A(1).
              02 S3AMOUNT PIC 9(5)V9(2).
              02 S3TIME PIC 9(5).

       FD SORTED.
       01 SRECORD.
              02 SACC PIC 9(16).
              02 SOPERATION PIC A(1).
              02 SAMOUNT PIC 9(5)V9(2).
              02 STIME PIC 9(5).   

       FD UMASTER.
       01 UMRECORD.
           02 UMNAME PIC A(20).
           02 UMACC PIC 9(16).
           02 UMPSWD PIC 9(6).
           02 UMBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.

       FD NEGREP.
       01 NEGRECORD.
           02 T1 PIC A(4)XX.
           02 NEGNAME PIC A(20).
           02 T2 PIC A(15)XX.
           02 NEGACC PIC 9(16).
           02 T3 PIC A(8)XX.
           02 NEGBALANCE PIC S9(13)V9(2) SIGN LEADING SEPARATE.
              
       SD TEMP1.
       01 TP1RECORD.
              02 TP1ACC PIC 9(16).
              02 TP1OPERATION PIC A(1).
              02 TP1AMOUNT PIC 9(5)V9(2).
              02 TP1TIME PIC 9(5).

       FD TEMP2.
       01 TP2RECORD.
              02 TP2ACC PIC 9(16).
              02 TP2OPERATION PIC A(1).
              02 TP2AMOUNT PIC 9(5)V9(2).
              02 TP2TIME PIC 9(5).
       
       WORKING-STORAGE SECTION.
       77 MS PIC X(02) VALUE SPACES.
       77 T1S PIC X(02) VALUE SPACES.
       77 T3S PIC X(02) VALUE SPACES.

       PROCEDURE DIVISION.
       
      *CHECK INPUT FILE EXISTENCE FIRST
       CHECKFILE.
           OPEN INPUT MASTER.
           IF MS NOT = "00" THEN 
               DISPLAY "=> ERROR IN OPENING MASTER FILE WITH STATUS "
                   , MS
               CLOSE MASTER
               GO TO FAREWELL END-IF.
           CLOSE MASTER.
           OPEN INPUT TRANS711.
           IF T1S NOT = "00" THEN 
               DISPLAY "=> ERROR IN OPENING TRANS711 FILE WITH STATUS "
                   , T1S
               CLOSE TRANS711
               GO TO FAREWELL END-IF.
           CLOSE TRANS711.
           OPEN INPUT TRANS713.
           IF T3S NOT = "00" THEN 
               DISPLAY "=> ERROR IN OPENING TRANS713 FILE WITH STATUS "
                   , T3S
               CLOSE TRANS713
               GO TO FAREWELL END-IF.
           CLOSE TRANS713.

       MAIN-PROCEDURE.
      *SORT 711
           DISPLAY "=> SORT TRANS711".
           SORT TEMP1 ON ASCENDING KEY TP1ACC
               ON ASCENDING KEY TP1TIME
           USING TRANS711 GIVING SORT711.
           DISPLAY "=> DONE".

      *SORT 713
           DISPLAY "=> SORT TRANS713".
           SORT TEMP1 ON ASCENDING KEY TP1ACC
               ON ASCENDING KEY TP1TIME
           USING TRANS713 GIVING SORT713.
           DISPLAY "=> DONE".

      *SORT BOTH
           DISPLAY "=> WRITE INTO ONE"
           OPEN OUTPUT TEMP2.
           OPEN INPUT TRANS711.

       READ711.
           READ TRANS711
           NOT AT END 
               MOVE T1ACC TO TP2ACC
               MOVE T1AMOUNT TO TP2AMOUNT
               MOVE T1OPERATION TO TP2OPERATION
               MOVE T1TIME TO TP2TIME
               WRITE TP2RECORD
               GO TO READ711
           AT END 
               CLOSE TRANS711
               OPEN INPUT TRANS713
               GO TO READ713
           END-READ.

       READ713.
           READ TRANS713
           NOT AT END 
               MOVE T3ACC TO TP2ACC
               MOVE T3AMOUNT TO TP2AMOUNT
               MOVE T3OPERATION TO TP2OPERATION
               MOVE T3TIME TO TP2TIME
               WRITE TP2RECORD
               GO TO READ711
           AT END 
               CLOSE TRANS713
               CLOSE TEMP2
               GO TO SORTATM
           END-READ.

       SORTATM.
           SORT TEMP1 ON ASCENDING KEY TP1ACC
               ON ASCENDING KEY TP1TIME
           USING TEMP2 GIVING SORTED.
           DISPLAY "=> DONE".

      *UPDATE MASTER AWA REPORT NEGACC
           DISPLAY "=> UPDATE".
           OPEN INPUT MASTER.
           OPEN OUTPUT UMASTER.
           OPEN OUTPUT NEGREP.

       DOUPDATE.
           READ MASTER
           NOT AT END 
               MOVE MACC TO UMACC
               MOVE MNAME TO UMNAME
               MOVE MPSWD TO UMPSWD
               MOVE MBALANCE TO UMBALANCE
               OPEN INPUT SORTED
               GO TO READUPDATE
           AT END 
               CLOSE MASTER
               CLOSE UMASTER
               CLOSE NEGREP
               DISPLAY "=> DONE"
               GO TO FAREWELL
           END-READ.

       READUPDATE.
           READ SORTED
           NOT AT END IF SACC = MACC THEN 
                  IF SOPERATION = 'W' THEN 
                      SUBTRACT SAMOUNT FROM UMBALANCE
                      END-IF
                  IF SOPERATION = 'D' THEN
                      ADD SAMOUNT TO UMBALANCE
                      END-IF
                  END-IF 
               GO TO READUPDATE
           AT END CLOSE SORTED
               WRITE UMRECORD
               IF UMBALANCE IS NEGATIVE THEN 
                   MOVE "Name: " TO T1
                   MOVE " Account Number: " TO T2
                   MOVE " Balance: " TO T3
                   MOVE UMNAME TO NEGNAME
                   MOVE UMACC TO NEGACC
                   MOVE UMBALANCE TO NEGBALANCE
                   WRITE NEGRECORD
                   END-IF
               GO TO DOUPDATE
           END-READ.

      *SAY BYEBYE      
       FAREWELL.
           DISPLAY "=> ALL DONE SUCCESSFULLY".
           STOP RUN.

       END PROGRAM central.
       