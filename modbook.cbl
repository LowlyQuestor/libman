      IDENTIFICATION DIVISION.
      PROGRAM-ID. MODIFY-BOOK.
      *> modifies user specified book from the library database
      AUTHOR. Aidan Simon.


      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LIBRARY-DATABASE *> Defines the file to be used as the DB
           ASSIGN TO "./library.db"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS BOOK-ISBN
           ALTERNATE RECORD KEY IS BOOK-TITLE WITH DUPLICATES
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
       01 WS-RECORD.
           05 WS-TITLE         PIC X(25).
           05 WS-AUTHOR        PIC X(20).
           05 WS-PUBLISHER     PIC X(20).
           05 WS-YEAR          PIC 9(4).
           05 WS-ISBN          PIC 9(10).
           05 WS-OPTION        PIC 9.
       01 DBS                  PIC X(2).
          88 DBS-OK                  VALUE "00".
 
      PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           PERFORM READ-IN-DATABASE
           PERFORM DISPLAY-OPTIONS
           PERFORM READ-AND-VERIFY-OPTIONS UNTIL WS-OPTION IS EQUAL TO 9
           CLOSE LIBRARY-DATABASE
           STOP RUN.

       READ-IN-DATABASE.
           OPEN OUTPUT LIBRARY-DATABASE. *> Try opening database file
           IF NOT DBS-OK THEN
               DISPLAY "Error opening database file"
               STOP RUN
           END-IF.

       ASK-USER-FOR-BOOK.
           DISPLAY "What is the title of the book you wish to modify?"
           ACCEPT BOOK-TITLE

           READ LIBRARY-DATABASE RECORD *> Search for book in db with title
               KEY IS BOOK-TITLE
               INVALID KEY DISPLAY "error: Book not found"
               NOT INVALID KEY DISPLAY "Book with title "FUNCTION TRIM(BOOK-TITLE) " found"
           END-READ.

       READ-AND-VERIFY-OPTIONS.
           DISPLAY "Please enter a valid choice"
           ACCEPT WS-OPTION
           IF WS-OPTION IS EQUAL TO 1 THEN
               PERFORM ASK-USER-FOR-BOOK
           ELSE
              IF WS-OPTION IS EQUAL TO 7 THEN
                 PERFORM DISPLAY-OPTIONS
              END-IF

               IF WS-OPTION is EQUAL TO 8 THEN
                   PERFORM DISPLAY-INFO
               END-IF
           END-IF.

       DISPLAY-OPTIONS.
           DISPLAY "Book modification menu " FUNCTION TRIM(WS-TITLE) " selected" 
           DISPLAY "1. Search for book by title"
           DISPLAY "2. Modify title"
           DISPLAY "3. Modify author"
           DISPLAY "4. Modify publisher"
           DISPLAY "5. Modify year"
           DISPLAY "6. Modify isbn"
           DISPLAY "7. Display options"
           DISPLAY "8. List book properties"
           DISPLAY "9. Exit".

       MODIFY-TITLE.
           *> TODO
       MODIFY-AUTHOR.
           *> TODO
       MODIFY-PUBLISHER.
           *> TODO
       MODIFY-YEAR.
           *> TODO    
       MODIFY-ISBN.
           *> TODO
       DISPLAY-INFO.
           DISPLAY "title: "     FUNCTION TRIM(BOOK-TITLE).
           DISPLAY "author: "    FUNCTION TRIM(BOOK-AUTHOR).
           DISPLAY "publisher: " FUNCTION TRIM(BOOK-PUBLISHER).
           DISPLAY "year: "      FUNCTION TRIM(BOOK-YEAR).
           DISPLAY "isbn: "      FUNCTION TRIM(BOOK-ISBN).

