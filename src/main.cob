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
    *> Input file structure
    FD Sales-File.
      01 Sales-Record.
        05 FL-Sale-Num PIC 9(5).
        *> 4-space Delimiter
        05 FILLER PIC X(4) VALUE ALL SPACES.
        05 FL-Profit PIC Z(6)9.99.
        *> 4-space Delimiter
        05 FILLER PIC X(4) VALUE ALL SPACES.
        05 FL-City PIC A(20).

    *> Output report file.
    FD Report-File
      *> Link the report to its file.
      REPORT IS Sales-Report.

  WORKING-STORAGE SECTION.
    *> Today's date. For use in the report output
    01 WS-Date PIC 9999/99/99.
    *> An end-of-file flag for the input file
    01 EOF-Flag PIC X VALUE "N".

  REPORT SECTION.
    *> Sales report definition
    RD Sales-Report
      PAGE LIMIT IS 50 LINES
      HEADING 1 *> Heading at line 1
      FIRST DETAIL 6 *> First data row at line 6
      LAST DETAIL 50.

      *> Report Heading
      01 TYPE RH.
        05 LINE + 1.
          10 COL 1 VALUE "----------------------------------------------".
        05 LINE + 1.
          10 COL 1 VALUE "|                                            |".
        05 LINE + 1.
          10 COL 1 VALUE "|               Sales Report                 |".
        05 LINE + 1.
          10 COL 1 VALUE "|               ~~~~~~~~~~~~                 |".
        05 LINE + 1.
          10 COL 1 VALUE "----------------------------------------------".

      *> Page Heading
      01 TYPE PH.
        05 LINE + 1.
          *> Display today's date
          10 COL 1 PIC 9999/99/99 SOURCE WS-Date.
        *> Column Headings
        05 LINE + 2.
          10 COL 3 VALUE "Sale Num.".
          10 COL 15 VALUE "City".
          10 COL 35 VALUE "Profit".
        05 LINE + 1.
          10 COL 1 PIC X(40) VALUE ALL "=".

      *> Detail (Row Data)
      01 Report-Detail TYPE DE.
        05 LINE + 1.
          10 COL 3 PIC 9(5) SOURCE FL-Sale-Num.
          10 COL 15 PIC A(20) SOURCE FL-City.
          10 COL 35 PIC $$,$$$,$$$.99 SOURCE FL-Profit.

      *> Page Footer
      01 TYPE PF.
        05 LINE + 1.
          10 COL 3 PIC X(40) VALUE ALL "-".
        05 LINE + 1.
          *> Page counter
          10 COL 1 VALUE "Page".
          10 COL + 2 SOURCE PAGE-COUNTER PIC Z9.
        05 LINE + 1.
          10 COL 3 PIC X(40) VALUE ALL "-".

      *> Report Footer
      01 TYPE RF.
        05 LINE + 1.
          05 COL 3 PIC X(20) VALUE ALL "*".
        05 LINE + 1.
          10 COL 3 VALUE "Confidential – For Internal Use Only".
        05 LINE + 1.
          05 COL 3 PIC X(20) VALUE ALL "*".


PROCEDURE DIVISION.
  *> Store today's date for use in the report
  MOVE FUNCTION CURRENT-DATE(1:8) TO WS-Date.

  *> Open files
  OPEN INPUT Sales-File. *> For report input
  OPEN OUTPUT Report-File. *> For report output

  *> Start generating the sales report
  INITIATE Sales-Report.

  *> Loop through the sales file
  PERFORM UNTIL EOF-Flag = "Y"
    *> Read the next record
    READ Sales-File
      *> Runs when the input file is at EOF or is empty
      AT END
        *> Stop the loop
        MOVE "Y" TO EOF-Flag
      *> Runs for every record
      NOT AT END
        *> Write one row of data to the report
        GENERATE Report-Detail
    END-READ
  END-PERFORM.

  *> End the report generation
  TERMINATE Sales-Report.

  *> Close the files used in the program
  CLOSE Sales-File.
  CLOSE Report-File.

  *> Close the program
  STOP RUN.

END PROGRAM CobReport.
