
-------- 1. Закупка продукции


-- Единицы измерения
select id, sizeid as name, 
portionrate as factor from [size] 

select 'insert into dim_ranges(external_id, name, factor ) values ('
    + cast(id as varchar(max)) + ','''   
    + [sizeid] + ''','  
    + caST(portionrate as varchar(max))   + ');' 
    as [sql]
 from [size] 


-- категории
select * from
(
select id,  description as name,
   case when coalesce( ParentID,0) = 0 
        then null else parentId end as parent_id
          from category
) as t1
order by parent_id, name

select 'insert into dim_categories(external_id, name, parent_id) values ('
    + cast(id as varchar(max)) + ','''
    + [name] + ''','
    + isnull(cast(parent_id as varchar(max)), 'null') + ');'
    as [sql]
from
(
select id,  description as name,
   case when coalesce( ParentID,0) = 0 
        then null else parentId end as parent_id
          from category
) as t1
order by parent_id, name


-- Поставщики
select * from
(
    select t1.id,  t1.clientid as name, t1.clientgroup as parent_id
    from vendors t1
    inner join vendorgroup t2 on t1.clientgroup = t2.vendorgroupid
) as t1 
order by parent_id

select 'insert into dim_vendors(external_id, name, parent_id) values ('
    + cast(id as varchar(max)) + ','''
    + [name] + ''','
    + cast(parent_id as varchar(max)) + ');'
    as [sql]
from
(
    select t1.id,  t1.clientid as name, t1.clientgroup as parent_id
    from vendors t1
    inner join vendorgroup t2 on t1.clientgroup = t2.vendorgroupid
) as t1 
order by parent_id


-- товары 
select productid as code, description, categoryid, sizeid as range_id, flaging as kind  
from product

select 'insert into dim_products(external_id, code, name, category_id, rangel_id, kind) values ('
    + cast(id as varchar(max)) + ','''
    + [productid] + ''','''
    + [description] + ''', '
    + isnull(cast(categoryid as varchar(max)), 'null') + ', '
    + isnull(cast(sizeid as varchar(max)), 'null') + ', '
    + isnull(cast(flaging as varchar(max)), 'null') + ');'
    as [sql]
from product 


-- Типы документов
select * from
(
    select t1.id, t1.description as name, t1.journalid as parent_id,
    t2.journalname as parent_name
    from bm_journaltypedocuments t1
    inner join bm_journaltype t2 on t1.journalid = t2.id
) as t1
order by parent_id, name 

select 'insert into dim_document_types(external_id, name, parent_id, parent_name) values ('
    + cast(id as varchar(max)) + ','''
    + [name] + ''','
    + cast(parent_id as varchar(max)) + ','''
    + [parent_name] + ');'
    as [sql]
FROM
(
    select t1.id, t1.description as name, t1.journalid as parent_id,
    t2.journalname as parent_name
    from bm_journaltypedocuments t1
    inner join bm_journaltype t2 on t1.journalid = t2.id
) as t1
order by parent_id, name 



-------- 2. Продажа товара

-- типы оперций журнала 
select transtypeid as id, description as name,
transgroupid as group_id, previewgrouptype as group_type
from transtype

select 'insert into dim_operation_types(external_id, name, group_id, group_type) values ('
    + cast(transtypeid as varchar(max)) + ','''
    + coalesce(description, '') + ''','
    + isnull(cast(transgroupid as varchar(max)), 'null') + ','''
    + previewgrouptype + ''');'
    as [sql]
from transtype



-------- 3. Работа персонала

-- сотрудники 

select * from
(
    select t1.personid as id,
    ltrim(rtrim(coalesce(t1.lastname, '') + ' ' + coalesce(t1.firstname, ''))) as name,
    t1.securityaccess as parent_id,
    t2.[description] as parent_name
    from personnel t1
    left join securityaccess t2 on t1.securityaccess = t2.securityaccessid
) as t1 order by parent_id

select 'insert into dim_personnel(external_id, name, parent_id) values ('
    + cast(personid as varchar(max)) + ','''
    + ltrim(rtrim(coalesce(lastname, '') + ' ' + coalesce(firstname, ''))) + ''','
    + cast(securityaccess as varchar(max)) + ');'
    as [sql]
from personnel


-- права 
select id, description as name, objectname as code,
securitygroup as group_name, parentsystem as system_name
from bm_securityobjects

select 'insert into dim_security_objects(external_id, name, code, group_name, system_name) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''','''
    + objectname + ''','''
    + securitygroup + ''','''
    + coalesce(parentsystem, '') + ''');'
    as [sql]
from bm_securityobjects



-------- 4. Остатки


-- склады
select id, description as name
from storages

select 'insert into dim_storages(external_id, name) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''');'
    as [sql]
from storages


-- типы складских операций 
select id, description as name, factor
from bm_storageoperationstype

select 'insert into dim_storage_operation_types(external_id, name, factor) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''','
    + cast(factor as varchar(max)) + ');'
    as [sql]
from bm_storageoperationstype


-- причины списания
select * from
(
select id, description as name,
   case when coalesce(parentid, 0) = 0
        then null else parentid end as parent_id
          from bm_reasondebit
) as t1
order by parent_id, name

select '    insert into dim_write_off_reasons(external_id, name, parent_id) values ('
    + cast(id as varchar(max)) + ','''
    + name + ''','
    + isnull(cast(parent_id as varchar(max)), 'null') + ');'
    as [sql]
from
(
select id, description as name,
   case when coalesce(parentid, 0) = 0
        then null else parentid end as parent_id
          from bm_reasondebit
) as t1
order by parent_id, name