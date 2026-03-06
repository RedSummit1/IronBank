//COMPILE  JOB (ACCT),'IRON BANK',
//             CLASS=A,
//             MSGCLASS=H,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//***********************************************
//* COMPILE IRON BANK CICS APPLICATION
//***********************************************
//APPLPROG EXEC DFHYITVL,
//             PROGLIB='EMMA120.BANKING.LOAD'
//TRN.SYSIN DD DSN=EMMA120.BANKING.COBOL(BANKING),
//             DISP=SHR
