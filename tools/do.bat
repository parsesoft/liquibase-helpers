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

set arguments=%*

if [%LBL_CONTEXT%]==[*] (
  for /d %%D in (%~dp0..\contexts\*) do (
    if not [%%~nxD]==[common] (
      set LBL_CONTEXT=%%~nxD
      call :run
      set LBL_CONTEXT=*
    )
  )
) else (
  call :run
)

popd
exit /b 0

:run

echo.
echo -----------------------------
echo -- Context: %LBL_CONTEXT%
echo -----------------------------

echo.
echo -- Processing contexts\common\main.xml...
cd %~dp0..\contexts\common
call %~dp0lb.bat ^
  --contexts=%LBL_CONTEXT% ^
  --changeLogFile=main.xml ^
  %arguments%

if exist %~dp0..\contexts\%LBL_CONTEXT%\main.xml (
  echo.
  echo -- Processing contexts\%LBL_CONTEXT%\main.xml...
  cd %~dp0..\contexts\%LBL_CONTEXT%\
  call %~dp0lb.bat ^
    --changeLogFile=main.xml ^
    %arguments%
)

goto :EOF