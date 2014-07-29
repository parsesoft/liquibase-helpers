@echo off

setlocal enabledelayedexpansion

pushd %~dp0

:: config.bat could set a context by default
call ..\contexts\common\config.bat

:start

echo.
echo =====================
echo   Liquibase helpers
echo =====================
echo.
echo 1. do validate         : Validate changelog.
echo 2. do status --verbose : Display pending changes.
echo 3. do updateSQL        : SQL preview of update command.
echo 4. do update           : Run after changes in changelog.
echo 5. do changelogSync    : Mark whole changelog as executed.
echo 6. exec reset_scripts  : Reset scripts on database changelog table.
echo 7. exec reset_all      : Reset all changes on database changelog table.
echo 8. generate            : Generate baseline and scripts (common context only).
set menu_exit=9& echo !menu_exit!. exit
echo.
echo (All "do" commands run over main.xml in both common and specific contexts)
echo.

:choice
set /p choice=Choose [%choice%]:
if not defined choice (
  goto choice
)

:context
if not [%choice%]==[%menu_exit%] (
  call context.bat ?
  if errorlevel 1 goto context
)

echo.

if [%choice%]==[1] call do validate
if [%choice%]==[2] call do status --verbose
if [%choice%]==[3] call do updateSQL
if [%choice%]==[4] call do update
if [%choice%]==[5] call do changelogSync
if [%choice%]==[6] call exec reset_scripts
if [%choice%]==[7] call exec reset_all
if [%choice%]==[8] call generate.bat
if [%choice%]==[%menu_exit%] goto end

echo.
goto start

:end
popd
