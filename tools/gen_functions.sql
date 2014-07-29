/***
 * Generation of batch for function generation script calls.
 */

set nocount on

select 'call gen_object.bat functions gen_function.sql ' + CAST(object_id as varchar) + ' ' + cast(schema_id as varchar) + ' ' + name
from sys.objects
where type in (N'FN', N'IF', N'TF', N'FS', N'FT')
and name not like 'dt%'
order by name
