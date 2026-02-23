>>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
  PROGRAM-ID. CobReport.

ENVIRONMENT DIVISION.
  INPUT-OUTPUT SECTION.
    FILE-CONTROL.
      *> Input data file
      SELECT Sales-File ASSIGN TO "Sales.dat"
        ORGANISATION LINE SEQUENTIAL
        ACCESS SEQUENTIAL.

      *> Output report file
      SELECT Report-File ASSIGN TO "SalesReport.txt"
        ORGANISATION SEQUENTIAL
        ACCESS SEQUENTIAL.

DATA DIVISION.
  FILE SECTION.
    FD Sales-File.
      01 Sales-Record.
        05 FL-Sale-Num PIC 9(5).
        05 FILLER PIC X(4) VALUE ALL SPACES.
        05 FL-Profit PIC $$,$$$,$$$.99.
        05 FILLER PIC X(4) VALUE ALL SPACES.
        05 FL-Department PIC A(25).

    *> Output report file.
    FD Report-File
      *> Link the report to its file.
      REPORT IS Sales-Report.

  WORKING-STORAGE SECTION.
    01 WS-Date PIC 9999/99/99.

  REPORT SECTION.
    RD Sales-Report
      PAGE LIMIT IS 50 LINES
      HEADING 1
      FIRST DETAIL 6
      LAST DETAIL 50.
      01 TYPE IS RH. *> Report Heading
        05 LINE + 1.
          10 COL 1 VALUE "========================================".
        05 LINE + 1.
          10 COL 1 VALUE "|                                      |".
        05 LINE + 1.
          10 COL 1 VALUE "|            Sales Report              |".
        05 LINE + 1.
          10 COL 1 VALUE "|            ~~~~~~~~~~~~              |".
        05 LINE + 1.
          10 COL 1 VALUE "========================================".

      01 TYPE IS PH. *> Page Heading
        05 LINE + 1.
          10 COL 3 PIC 9999/99/99 SOURCE WS-Date.

      01 TYPE PF. *> Page Footer
        05 LINE + 1.
          10 COL 3 PIC X(25) VALUE ALL "*".
        05 LINE + 1.
          *> Page counter
          10 COL 1 VALUE "Page".
          10 COL + 2 SOURCE PAGE-COUNTER PIC Z9.
        05 LINE + 1.
          10 COL 3 PIC X(25) VALUE ALL "*".

PROCEDURE DIVISION.
  MOVE FUNCTION CURRENT-DATE(1:8) TO WS-Date.

  STOP RUN.

END PROGRAM CobReport.
