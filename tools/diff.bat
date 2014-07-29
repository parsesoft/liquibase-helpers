@echo off
::::
:: Liquibase diff changelog launcher
::::

setlocal

pushd %~dp0

call ..\contexts\common\config.bat
call context.bat
if errorlevel 1 (
  popd
  exit /b 1
)
if exist ..\contexts\%LBL_CONTEXT%\config.bat (
  call ..\contexts\%LBL_CONTEXT%\config.bat
)

:: See http://www.liquibase.org/documentation/diff.html
call lb.bat ^
  --url="jdbc:sqlserver://%LBL_SERVER%;Databasename=%1" ^
  diffchangelog ^
  --referenceUrl="jdbc:sqlserver://%LBL_SERVER%;Databasename=%2" ^
  --referenceUsername=%LBL_USERNAME% ^
  --referencePassword=%LBL_PASSWORD% ^

popd
