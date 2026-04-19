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
       01 IS-FOUND             PIC X(2) VALUE 'N'.
       01 EOF                  PIC X(2) VALUE 'N'.
       01 US-DONE              PIC X(2) VALUE 'N'.
       01 WS-ISBN              PIC 9(10).
       01 USER-INPUT           PIC 9.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM OPEN-FILE
           PERFORM GET-BOOK-ISBN
           PERFORM FIND-BOOK UNTIL EOF IS NOT = 'N' OR IS-FOUND IS NOT = 'N'
           CLOSE LIBRARY-DATABASE
           STOP RUN.

       OPEN-FILE.
           OPEN I-O LIBRARY-DATABASE *> Try opening database file
           IF NOT DBS-OK THEN
               DISPLAY "Error opening database file"
               STOP RUN
           END-IF.

       GET-BOOK-ISBN.
           DISPLAY "Please enter the ISBN of the book to be changed"
           ACCEPT WS-ISBN.

       FIND-BOOK.
           READ LIBRARY-DATABASE
               AT END
                   MOVE 'Y' TO EOF

                   IF IS-FOUND IS EQUAL TO 'N' THEN
                       DISPLAY "book not found"
                   END-IF

               NOT AT END
                   IF BOOK-ISBN IS EQUAL TO WS-ISBN THEN
                       DISPLAY "book found"
                       PERFORM MOD-BOOK UNTIL US-DONE IS EQUAL TO 'Y'
                       MOVE 'Y' TO IS-FOUND
                   END-IF
           END-READ.

       PROCESS-USER-INPUT.
           DISPLAY "What would you like to do?"
           DISPLAY "1. Change book title"
           DISPLAY "2. Change book author"
           DISPLAY "3. Change book publisher"
           DISPLAY "4. Change book year"
           DISPLAY "5. Change book isbn"
           DISPLAY "6. Quit"
           ACCEPT USER-INPUT.

       MOD-BOOK.
           PERFORM PROCESS-USER-INPUT
           EVALUATE USER-INPUT
               WHEN 1
                   DISPLAY "Please enter a new title"
                   ACCEPT BOOK-TITLE
               WHEN 2
                   DISPLAY "Please enter a new author"
                   ACCEPT BOOK-AUTHOR
               WHEN 3
                   DISPLAY "Please enter a new publisher"
                   ACCEPT BOOK-PUBLISHER
               WHEN 4
                   DISPLAY "Please enter a new year"
                   ACCEPT BOOK-YEAR
               WHEN 5
                   DISPLAY "Please enter a new isbn number"
                   ACCEPT BOOK-ISBN
               WHEN 6
                   REWRITE LIBRARY-RECORD
                   DISPLAY "Record changed"
                   MOVE 'Y' TO US-DONE
               WHEN OTHER
                   DISPLAY "Invalid option"
           END-EVALUATE.
