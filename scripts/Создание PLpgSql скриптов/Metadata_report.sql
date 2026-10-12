select
    row_number() over (order by t.object_type desc, t.name) as "№",
    t.name        as "Наименование",
    t.object_type as "Тип"
from (
    select table_name as name, 'Таблица' as object_type
    from information_schema.tables
    where table_schema = 'public' and table_type = 'BASE TABLE'
 
    union all
 
    select sequence_name, 'Счётчик'
    from information_schema.sequences
    where sequence_schema = 'public'
 
    union all
 
    select constraint_name, 'Ограничение'
    from information_schema.table_constraints
    where table_schema = 'public'
      and constraint_type in ('PRIMARY KEY', 'FOREIGN KEY')
) t
order by 1;