      IDENTIFICATION DIVISION.
      PROGRAM-ID. REMOVE-BOOK.
      *> removes user specified book from the library database
      AUTHOR. Aidan Simon.


      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LIBRARY-DATABASE *> Defines the file to be used as the DB
           ASSIGN TO "./library.db"
           ORGANIZATION IS RELATIVE
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS DBS.
 
       DATA DIVISION.
       FILE SECTION.
       FD  LIBRARY-DATABASE
           DATA RECORD IS LIBRARY-RECORD.

       01  LIBRARY-RECORD.
           05 BOOK-TITLE       PIC X(25).
           05 BOOK-AUTHOR      PIC X(20).
           05 BOOK-PUBLISHER   PIC X(20).
           05 BOOK-YEAR        PIC 9(4).
           05 BOOK-ISBN        PIC 9(10).
           
       WORKING-STORAGE SECTION.
       01 WS-ISBN              PIC 9(10).
       01 EOF                  PIC X(2) VALUE 'N'.
       01 IS-FOUND             PIC X(2) VALUE 'N'.
       01 DBS                  PIC X(2).
          88 DBS-OK                  VALUE "00".
 
      PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM OPEN-DATABASE
           PERFORM GET-BOOK-ISBN
           PERFORM FIND-AND-DELETE-BOOK UNTIL EOF IS NOT = 'N' OR IS-FOUND IS NOT = 'N'
           CLOSE LIBRARY-DATABASE
           STOP RUN.

       OPEN-DATABASE.
           OPEN I-O LIBRARY-DATABASE. *> Try opening database file
           IF NOT DBS-OK THEN
              DISPLAY "Error opening database file"
              STOP RUN
           END-IF.

       GET-BOOK-ISBN.
           DISPLAY "Please enter the ISBN of the book to be deleted"
           ACCEPT WS-ISBN.

       FIND-AND-DELETE-BOOK.
           READ LIBRARY-DATABASE
                AT END
                    MOVE 'Y' TO EOF

                    IF IS-FOUND IS EQUAL TO 'N' THEN
                        DISPLAY "book not found"
                    END-IF

                NOT AT END
                    IF BOOK-ISBN IS EQUAL TO WS-ISBN THEN
                        PERFORM DELETE-BOOK
                        MOVE 'Y' TO IS-FOUND
                    END-IF
           END-READ.

       DELETE-BOOK.
           DELETE LIBRARY-DATABASE RECORD
           DISPLAY "book deleted".
