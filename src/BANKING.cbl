       IDENTIFICATION DIVISION.
       PROGRAM-ID. BANKING.
       AUTHOR. JONATHAN.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-ACCOUNT.
          05 WS-ACCOUNT-NUMBER    PIC 9(8)   VALUE 00000001.
          05 WS-ACCOUNT-NAME      PIC X(20)  VALUE 'JONATHAN'.
          05 WS-BALANCE           PIC 9(10)V99 VALUE 1000.00.
          05 WS-BALANCE-DISP      PIC Z(10).99.

       01 WS-SCREEN-DATA.
          05 WS-INPUT             PIC X(80).
          05 WS-OUTPUT            PIC X(1920).
          05 WS-MSG               PIC X(78).
          05 WS-CHOICE            PIC X(1).
          05 WS-AMOUNT            PIC 9(10)V99.
          05 WS-AMOUNT-STR        PIC X(12).

       01 WS-LENGTHS.
          05 WS-INPUT-LEN         PIC S9(4) COMP VALUE 80.
          05 WS-OUTPUT-LEN        PIC S9(4) COMP VALUE 1920.

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM SEND-MENU
           EXEC CICS RETURN
               TRANSID('BANK')
               COMMAREA(WS-ACCOUNT)
               LENGTH(32)
           END-EXEC.

       SEND-MENU.
           MOVE WS-BALANCE TO WS-BALANCE-DISP
           MOVE SPACES TO WS-OUTPUT
           STRING
               '================================' DELIMITED SIZE
               '=IRON BANK OF BRAAVOS==========='DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               'ACCOUNT: ' WS-ACCOUNT-NUMBER     DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               'NAME:    ' WS-ACCOUNT-NAME       DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               'BALANCE: ' WS-BALANCE-DISP       DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               '================================'DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               '1. DEPOSIT'                      DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               '2. WITHDRAW'                     DELIMITED SIZE
               X'15'                             DELIMITED SIZE
               'ENTER CHOICE: '                  DELIMITED SIZE
               INTO WS-OUTPUT
           EXEC CICS SEND TEXT
               FROM(WS-OUTPUT)
               LENGTH(WS-OUTPUT-LEN)
               ERASE
           END-EXEC.

       RECEIVE-INPUT.
           EXEC CICS RECEIVE
               INTO(WS-INPUT)
               LENGTH(WS-INPUT-LEN)
           END-EXEC
           MOVE WS-INPUT(1:1) TO WS-CHOICE.

       PROCESS-CHOICE.
           EVALUATE WS-CHOICE
               WHEN '1'
                   PERFORM DEPOSIT
               WHEN '2'
                   PERFORM WITHDRAW
               WHEN OTHER
                   MOVE 'INVALID OPTION' TO WS-MSG
           END-EVALUATE.

       DEPOSIT.
           EXEC CICS SEND TEXT
               FROM('ENTER DEPOSIT AMOUNT: ')
               LENGTH(22)
               ERASE
           END-EXEC
           EXEC CICS RECEIVE
               INTO(WS-AMOUNT-STR)
               LENGTH(WS-INPUT-LEN)
           END-EXEC
           MOVE WS-AMOUNT-STR TO WS-AMOUNT
           ADD WS-AMOUNT TO WS-BALANCE
           MOVE 'DEPOSIT SUCCESSFUL' TO WS-MSG.

       WITHDRAW.
           EXEC CICS SEND TEXT
               FROM('ENTER WITHDRAWAL AMOUNT: ')
               LENGTH(25)
               ERASE
           END-EXEC
           EXEC CICS RECEIVE
               INTO(WS-AMOUNT-STR)
               LENGTH(WS-INPUT-LEN)
           END-EXEC
           MOVE WS-AMOUNT-STR TO WS-AMOUNT
           IF WS-AMOUNT > WS-BALANCE
               MOVE 'INSUFFICIENT FUNDS' TO WS-MSG
           ELSE
               SUBTRACT WS-AMOUNT FROM WS-BALANCE
               MOVE 'WITHDRAWAL SUCCESSFUL' TO WS-MSG
           END-IF.
