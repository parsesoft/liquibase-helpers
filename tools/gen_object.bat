set output_dir=%1
set script_file=%2
set object_id=%3
set schema_id=%4
set object_name=%5

::echo object_id=%object_id% schema_id=%schema_id% object_name=%object_name%
echo %output_dir%\%object_name%.sql

call sqlcmd.bat ^
-i %script_file% ^
-o ..\contexts\common\%output_dir%\%object_name%.sql ^
-f 65001 ^
-v ^
  object_id="%object_id%" ^
  schema_id="%schema_id%" ^
  object_name="%object_name%"
