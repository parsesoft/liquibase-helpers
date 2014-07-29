/***
 * Generation of batch for procedure generation script calls.
 */

set nocount on

select 'call gen_object.bat procedures gen_procedure.sql ' + CAST(object_id as varchar) + ' ' + cast(schema_id as varchar) + ' ' + name
from sys.objects
where type in (N'P', N'PC')
and name not like 'dt%'
order by name
