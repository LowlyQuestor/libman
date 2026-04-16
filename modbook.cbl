      IDENTIFICATION DIVISION.
      PROGRAM-ID. MOD-BOOK.
      *> Modifies a user specified book in the database
      AUTHOR. Aidan Simon.
           
      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LIBRARY-DATABASE
           ASSIGN TO "library.db"
           ORGANIZATION IS RELATIVE
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS DBS.
 
       DATA DIVISION.
       FILE SECTION.
       FD LIBRARY-DATABASE
          DATA RECORD IS LIBRARY-RECORD.
 
       01 LIBRARY-RECORD.
           05 BOOK-TITLE       PIC X(25).
           05 BOOK-AUTHOR      PIC X(20).
           05 BOOK-PUBLISHER   PIC X(20).
           05 BOOK-YEAR        PIC 9(4).
           05 BOOK-ISBN        PIC 9(10).
        
       WORKING-STORAGE SECTION.
       01 DBS                  PIC X(2).
           88 DBS-OK                 VALUE "00".
       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM OPEN-FILE

       OPEN-FILE.
           OPEN EXTEND LIBRARY-DATABASE. *> Try opening database file
           IF NOT DBS-OK THEN
               DISPLAY "Error opening database file"
               STOP RUN
           END-IF.

