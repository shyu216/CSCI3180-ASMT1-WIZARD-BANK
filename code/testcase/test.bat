@cobc -x atms.cob && cobc -x central.cob
@type .\testcase\testcase.txt | atms.exe
@central.exe

@fc /L trans711.txt .\testcase\trans711.txt
@fc /L trans713.txt .\testcase\trans713.txt
@fc /L transSorted711.txt .\testcase\transac_sorted711.txt
@fc /L transSorted713.txt .\testcase\transac_sorted713.txt
@fc /L transSorted.txt .\testcase\transac_sorted.txt
@fc /L negReport.txt .\testcase\negReport.txt
@REM @ECHO Press to check updatedMaster
@fc /L updatedMaster.txt .\testcase\master_updated.txt
@REM @ECHO Checking Complete

@REM @ECHO Delete ouput files
@del negReport.txt
@del trans*.txt
@del updatedMaster.txt
@del atms.exe
@del central.exe

@gcc -o atms.exe atms.c && gcc -o central.exe sort.c central.c
@type .\testcase\testcase.txt | atms.exe
@central.exe

@REM @ECHO Press to check trans711
@fc /L trans711.txt .\testcase\trans711.txt
@REM @ECHO Press to check trans713
@fc /L trans713.txt .\testcase\trans713.txt
@REM @ECHO Press to check transSorted711
@fc /L transSorted711.txt .\testcase\transac_sorted711.txt
@REM @ECHO Press to check transSorted713
@fc /L transSorted713.txt .\testcase\transac_sorted713.txt
@REM @ECHO Press to check transac_sorted
@fc /L transSorted.txt .\testcase\transac_sorted.txt
@REM @ECHO Press to check negReport
@fc /L negReport.txt .\testcase\negReport.txt
@REM @ECHO Press to check updatedMaster
@fc /L updatedMaster.txt .\testcase\master_updated.txt
@REM @ECHO Checking Complete

@REM @ECHO Delete ouput files
@del negReport.txt
@del trans*.txt
@del updatedMaster.txt
@del atms.exe
@del central.exe