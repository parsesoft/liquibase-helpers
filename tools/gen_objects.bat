@echo off
::::
:: Objects generation
::::

pushd %~dp0

del /Q /F ..\contexts\common\%1\*.*
call sqlcmd.bat -i gen_%1.sql -o gen_%1.tmp.bat
call gen_%1.tmp.bat
del gen_%1.tmp.bat

popd
