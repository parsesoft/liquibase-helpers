@echo off

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

:: See http://technet.microsoft.com/en-us/library/ms162773(v=sql.105).aspx
sqlcmd.exe ^
  -S %LBL_SERVER% ^
  -d %LBL_DATABASE% ^
  -U %LBL_USERNAME% ^
  -P %LBL_PASSWORD% ^
  -Y 0 ^
  -y 0 ^
  %*

popd
