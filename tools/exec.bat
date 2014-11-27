@echo off
::::
:: Execute script
::::

pushd %~dp0

call context.bat
if errorlevel 1 (
  popd
  exit /b 1
)

set filename=%1

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

call ..\contexts\common\config.bat
if exist ..\contexts\%LBL_CONTEXT%\config.bat (
  call ..\contexts\%LBL_CONTEXT%\config.bat
)
echo -- Server: %LBL_SERVER%
echo -- Database: %LBL_DATABASE%

echo.
call sqlcmd.bat -i %filename%.sql

goto :EOF
