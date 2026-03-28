      IDENTIFICATION DIVISION.
      PROGRAM-ID. REMOVE-BOOK.
      *> removes user specified book from the library database
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
       01 WS-ISBN              PIC 9(10).
       01 DBS                  PIC X(2).
          88 DBS-OK                  VALUE "00".
 
      PROCEDURE DIVISION.
           OPEN OUTPUT LIBRARY-DATABASE. *> Try opening database file
           IF NOT DBS-OK THEN
               DISPLAY "Error opening database file"
               STOP RUN
           END-IF.

               DISPLAY "Please enter the ISBN of the book you want to delete".
               ACCEPT WS-ISBN.
               MOVE WS-ISBN TO BOOK-ISBN. *> Search for book in file
               DELETE LIBRARY-DATABASE RECORD
                   INVALID KEY
                       DISPLAY "error: Book not found"
                   NOT INVALID KEY
                       DISPLAY "Book with ISBN" WS-ISBN "deleted successfully"
               END-DELETE.



           CLOSE LIBRARY-DATABASE.
           STOP RUN.
