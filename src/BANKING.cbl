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

       01 WS-TRANSACTION.
          05 WS-AMOUNT            PIC 9(10)V99 VALUE 0.
          05 WS-CHOICE            PIC 9(1)     VALUE 0.

       01 WS-MESSAGES.
          05 WS-INSUFFICIENT      PIC X(30)
             VALUE 'INSUFFICIENT FUNDS'.
          05 WS-INVALID           PIC X(30)
             VALUE 'INVALID OPTION'.

       PROCEDURE DIVISION.
       MAIN-PARA.
           PERFORM DISPLAY-MENU
           PERFORM PROCESS-CHOICE
           PERFORM DISPLAY-BALANCE
           STOP RUN.

       DISPLAY-MENU.
           DISPLAY '========================='
           DISPLAY '    IRON BANK OF BRAAVOS  '
           DISPLAY '========================='
           DISPLAY 'ACCOUNT: ' WS-ACCOUNT-NUMBER
           DISPLAY 'NAME:    ' WS-ACCOUNT-NAME
           DISPLAY 'BALANCE: ' WS-BALANCE
           DISPLAY '========================='
           DISPLAY '1. DEPOSIT'
           DISPLAY '2. WITHDRAW'
           DISPLAY '========================='
           DISPLAY 'ENTER CHOICE: '
           ACCEPT WS-CHOICE.

       PROCESS-CHOICE.
           EVALUATE WS-CHOICE
               WHEN 1
                   PERFORM DEPOSIT
               WHEN 2
                   PERFORM WITHDRAW
               WHEN OTHER
                   DISPLAY WS-INVALID
           END-EVALUATE.

       DEPOSIT.
           DISPLAY 'ENTER DEPOSIT AMOUNT: '
           ACCEPT WS-AMOUNT
           ADD WS-AMOUNT TO WS-BALANCE
           DISPLAY 'DEPOSIT SUCCESSFUL'.

       WITHDRAW.
           DISPLAY 'ENTER WITHDRAWAL AMOUNT: '
           ACCEPT WS-AMOUNT
           IF WS-AMOUNT > WS-BALANCE
               DISPLAY WS-INSUFFICIENT
           ELSE
               SUBTRACT WS-AMOUNT FROM WS-BALANCE
               DISPLAY 'WITHDRAWAL SUCCESSFUL'
           END-IF.

       DISPLAY-BALANCE.
           DISPLAY '========================='
           DISPLAY 'UPDATED BALANCE: ' WS-BALANCE
           DISPLAY '========================='.
