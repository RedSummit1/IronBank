//ALLOCBMS JOB (ACCT),'IRON BANK',
//             CLASS=A,
//             MSGCLASS=H,
//             MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID
//***********************************************
//* ALLOCATE BMS MAP DATASETS
//***********************************************
//ALLOC   EXEC PGM=IEFBR14
//BMS     DD DSN=&SYSUID..BANKING.BMS,
//           DISP=(NEW,CATLG,DELETE),
//           SPACE=(CYL,(5,2,10)),
//           DCB=(RECFM=FB,LRECL=80,BLKSIZE=3200),
//           UNIT=SYSDA
//LOAD    DD DSN=&SYSUID..BANKING.MAPLOAD,
//           DISP=(NEW,CATLG,DELETE),
//           SPACE=(CYL,(5,2,10)),
//           DCB=(RECFM=U,BLKSIZE=32760),
//           UNIT=SYSDA
