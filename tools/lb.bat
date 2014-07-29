@echo off
::::
:: Configuration and context-aware Liquibase wrapper
::::

call %~dp0..\contexts\common\config.bat
call %~dp0context.bat
if errorlevel 1 (
  exit /b 1
)
if exist %~dp0..\contexts\%LBL_CONTEXT%\config.bat (
  call %~dp0..\contexts\%LBL_CONTEXT%\config.bat
)

:: (Un)comment line below to toggle verbose execution
::echo on

:: See http://www.liquibase.org/documentation/command_line.html
call %~dp0liquibase.bat ^
  --defaultsFile=%~dp0lb.properties ^
  --url="jdbc:sqlserver://%LBL_SERVER%;Databasename=%LBL_DATABASE%" ^
  --username=%LBL_USERNAME% ^
  --password=%LBL_PASSWORD% ^
  %*

@echo off
