/***
 * Generation of batch for view generation script calls.
 */

set nocount on

select 'call gen_object.bat views gen_view.sql ' + CAST(object_id as varchar) + ' ' + cast(schema_id as varchar) + ' ' + name
from sys.views
order by name
