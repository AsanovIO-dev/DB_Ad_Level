
-------- 1. Закупка продукции


-- Единицы измерения
select id, sizeid as name, 
portionrate as factor from [size] 

select '    insert into dim_ranges(external_id, name, factor ) values ('
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

select '    insert into dim_categories(external_id, name, parent_id) values ('
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

select '    insert into dim_vendors(external_id, name, parent_id) values ('
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
select id, productid as code, description as name
from product

select '    insert into dim_products(external_id, code, name) values ('
    + cast(id as varchar(max)) + ','''
    + [productid] + ''','''
    + [description] + ''');'
    as [sql]
from product


-------- 2. Продажа товара

-- типы оплаты
select paymenttypeid as id, description as name
from paymenttype

select '    insert into dim_payment_types(external_id, name) values ('
    + cast(paymenttypeid as varchar(max)) + ','''
    + description + ''');'
    as [sql]
from paymenttype



-------- 3. Работа персонала

-- сотрудники 

select personid as id,
ltrim(rtrim(coalesce(lastname, '') + ' ' + coalesce(firstname, ''))) as name
from personnel

select '    insert into dim_personnel(external_id, name) values ('
    + cast(personid as varchar(max)) + ','''
    + ltrim(rtrim(coalesce(lastname, '') + ' ' + coalesce(firstname, ''))) + ''');'
    as [sql]
from personnel

-------- 4. Остатки


-- склады
select id, description as name
from storages

select '    insert into dim_storages(external_id, name) values ('
    + cast(id as varchar(max)) + ','''
    + description + ''');'
    as [sql]
from storages


-- типы складских операций 
select id, description as name, factor
from bm_storageoperationstype

select '    insert into dim_storage_operation_types(external_id, name, factor) values ('
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
