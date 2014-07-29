@echo off
::::
:: Liquibase generate changelog launcher
::::

pushd %~dp0

set BASELINE=baseline.xml

cd %~dp0..\contexts\common

:: Delete baseline, otherwise Liquibase throws an error.
del %BASELINE%

:: Generate baseline
call %~dp0lb.bat ^
  --changeLogFile=%BASELINE% ^
  generateChangeLog

:: Generate views
call %~dp0gen_objects.bat views

:: Generate functions
call %~dp0gen_objects.bat functions

:: Generate procedures
call %~dp0gen_objects.bat procedures

popd