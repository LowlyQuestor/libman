      IDENTIFICATION DIVISION.
      PROGRAM-ID. ADD-BOOK.
      *> Adds user specified information to the library database
      AUTHOR. Aidan Simon.


      ENVIRONMENT DIVISION.
      INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT LIBRARY-DATABASE *> Defines the file to be used as the DB
           ASSIGN TO "library.db"
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
      01 DBS                      PIC X(2).
         88 DBS-OK                      VALUE "00".
 
      PROCEDURE DIVISION.
           OPEN EXTEND LIBRARY-DATABASE. *> Try opening database file
           IF NOT DBS-OK THEN
               DISPLAY "Error opening database file"
               STOP RUN
           END-IF.


           *> Get info from the user
           DISPLAY "Please enter the title of the book: "
           ACCEPT BOOK-TITLE
           DISPLAY "Please enter the author of the book: "
           ACCEPT BOOK-AUTHOR
           DISPLAY "Please enter the publisher of the book: "
           ACCEPT BOOK-PUBLISHER
           DISPLAY "Please enter the year the book was published: "
           ACCEPT BOOK-YEAR
           DISPLAY "Please enter the ISBN of the book (10 digits): "
           ACCEPT BOOK-ISBN

           WRITE LIBRARY-RECORD.

           CLOSE LIBRARY-DATABASE.
           STOP RUN.
