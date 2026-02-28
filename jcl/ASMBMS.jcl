//ASMBMS   JOB (ACCT),'IRON BANK',
//             CLASS=A,
//             MSGCLASS=H,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//*
//MAP     EXEC DFHMAPS,
//             MAPNAME=BANKMAP,
//             MAPLIB='EMMA120.BANKING.MAPLOAD'
//COPY.SYSUT1 DD DSN=EMMA120.BANKING.BMS(BANKMAP),
//            DISP=SHR
