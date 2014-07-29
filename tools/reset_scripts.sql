/**
 * Reset scripts on database changelog table
 */

delete
from DATABASECHANGELOG
where DESCRIPTION = 'sql'
and (1=0
or FILENAME like 'views/%'
or FILENAME like 'procedures/%'
or FILENAME like 'functions/%'
)
