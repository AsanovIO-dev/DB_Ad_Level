-- Скрипт выборки данных из OLTP 
-- Ддя проверки
select id, sizeid as name, 
portionrate as factor from [size] 

-- Скрипт переноса данных в OLAP базу данных
select 'insert into dim_ranges(external_id, name, factor ) values ('
    + cast(id as varchar(max)) + ','''   
    + [sizeid] + ''','  
    + caST(portionrate as varchar(max))   + ');' 
    as [sql]
 from [size] 




