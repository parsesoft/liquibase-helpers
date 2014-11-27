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

echo -- Server: %LBL_SERVER%
echo -- Database: %LBL_DATABASE%

setlocal enabledelayedexpansion

:: Concatenate all arguments except --verbose
set args=
for %%a in (%*) do (
  set last=%%a
  if [%%a] neq [--verbose] (
    set args=!args! %%a
  )
)

:: Append changelog parameters
set args=%args% -Ddatabase.name=%LBL_DATABASE%

:: Append --verbose, if needed
if [%last%] == [--verbose] (
  set args=%args% %last%
)

:: (Un)comment line below to toggle verbose execution
::echo on

:: See http://www.liquibase.org/documentation/command_line.html
call %~dp0liquibase.bat ^
  --defaultsFile=%~dp0lb.properties ^
  --url="jdbc:sqlserver://%LBL_SERVER%;Databasename=%LBL_DATABASE%" ^
  --username=%LBL_USERNAME% ^
  --password=%LBL_PASSWORD% ^
  %args%

endlocal

@echo off
