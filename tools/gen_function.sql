/***
 * Generation of script in Liquibase SQL format
 *
 * Variables such as $(object_name) are passed to sqlcmd.bat by gen_object.bat
 */

set nocount on

declare @schema_name varchar(max)
declare @qualified_name varchar(max)
set @schema_name = SCHEMA_NAME($(schema_id))
set @qualified_name = '[' + @schema_name + '].[$(object_name)]'

select
  '--liquibase formatted sql'
+ CHAR(13) + CHAR(10)
+ '--http://www.liquibase.org/documentation/sql_format.html'
+ CHAR(13) + CHAR(10)
+ CHAR(13) + CHAR(10)
+ '--changeset ' + USER + ':FUNCTION-' + @schema_name + '-$(object_name)'
+ ' runOnChange:true'
+ ' stripComments:false'
+ ' dbms:mssql'
+ CHAR(13) + CHAR(10)
+ CHAR(13) + CHAR(10) + 'IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N''' + @qualified_name + ''') AND type in (N''FN'', N''IF'', N''TF'', N''FS'', N''FT''))'
+ CHAR(13) + CHAR(10) + 'DROP FUNCTION ' + @qualified_name
+ CHAR(13) + CHAR(10) + 'GO'
+ CHAR(13) + CHAR(10)
+ CHAR(13) + CHAR(10) + RTRIM(LTRIM(OBJECT_DEFINITION($(object_id))))
+ CHAR(13) + CHAR(10)
+ CHAR(13) + CHAR(10) + 'GO'
+ CHAR(13) + CHAR(10)
+ '--rollback DROP FUNCTION ' + @qualified_name
