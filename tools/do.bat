@echo off
::::
:: Context-aware Liquibase launcher for main changelog related commands
::::

pushd %~dp0

call context.bat
if errorlevel 1 (
  popd
  exit /b 1
)

echo -- Processing contexts\common\main.xml...
cd %~dp0..\contexts\common
call %~dp0lb.bat ^
  --contexts=%LBL_CONTEXT% ^
  --changeLogFile=main.xml ^
  %*

if exist %~dp0..\contexts\%LBL_CONTEXT%\main.xml (
  echo.
  echo -- Processing contexts\%LBL_CONTEXT%\main.xml...
  cd %~dp0..\contexts\%LBL_CONTEXT%\
  call %~dp0lb.bat ^
    --changeLogFile=main.xml ^
    %*
)

popd
