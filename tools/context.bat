@echo off
::::
:: Context setting
::::

if [%1] == [?] (
  :: Ask value if argument is ?
  set /p LBL_CONTEXT=Context? [%LBL_CONTEXT%]:
) else if [%1] neq [] (
  :: Set argument value if not empty
  set LBL_CONTEXT=%1
) else if not defined LBL_CONTEXT (
  :: Ask value if variable is not defined
  set /p LBL_CONTEXT=Context? :
) else (
  :: Let variable as is (noop)
  call
)

:: Validate variable is defined
if not defined LBL_CONTEXT (
  echo Context undefined
  exit /b 1
)

:: Validate value is valid
if /i [%LBL_CONTEXT%]==[common] goto error
if not exist %~dp0..\contexts\%LBL_CONTEXT%\nul goto error

exit /b 0

:error

echo.
echo Invalid context: %LBL_CONTEXT%
echo Available contexts:
for /d %%D in (%~dp0..\contexts\*) do (
  if not [%%~nxD]==[common] echo - %%~nxD
)
echo.
exit /b 1
