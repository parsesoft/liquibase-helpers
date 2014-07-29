@echo off
::::
:: Execute script
::::

pushd %~dp0

call sqlcmd.bat -i %1.sql

popd
