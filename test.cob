       IDENTIFICATION DIVISION.
       PROGRAM-ID. HELLO.
       
       ENVIRONMENT DIVISION.
          INPUT-OUTPUT SECTION.
          FILE-CONTROL.
             SELECT INPUT ASSIGN TO IN.
             SELECT OUTPUT ASSIGN TO OUT.
             SELECT WORK ASSIGN TO WRK.
       
       DATA DIVISION.
          FILE SECTION.
          FD INPUT.
          01 INPUT-STUDENT.
                05 STUDENT-ID-I PIC 9(5).
                05 STUDENT-NAME-I PIC A(25).
          FD OUTPUT.
          01 OUTPUT-STUDENT.
                05 STUDENT-ID-O PIC 9(5).
                05 STUDENT-NAME-O PIC A(25).
          SD WORK.
          01 WORK-STUDENT.
                05 STUDENT-ID-W PIC 9(5).
                05 STUDENT-NAME-W PIC A(25).
       
       PROCEDURE DIVISION.
           SORT WORK ON DESCENDING KEY STUDENT-ID-O
           USING INPUT GIVING OUTPUT.
           DISPLAY 'Sort Successful'.
       STOP RUN.