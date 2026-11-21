-- 1. Закупка

-- 1.1. Какие типы складских операций реально используются
select * from bm_storageoperationstype t1
left join
    ( select operationid, count(*) as cnt, sum(amount) as total
      from bm_storageoperations group by operationid
    ) as t2
    on t1.id = t2.operationid


-- 1.2. Поступления по поставщикам
select * from vendors t1
right join
    ( select vendorid, count(*) as cnt, sum(amount) as total
      from bm_storageoperations where operationid = 1 group by vendorid
    ) as t2
    on t1.id = t2.vendorid    


-- 1.3. Самые крупные закупки по товарам
select top 10 * from product t1
right join
    ( select productid, sum(amount) as total
      from bm_storageoperations where operationid = 1 group by productid
    ) as t2
    on t1.id = t2.productid
order by t2.total desc    


-- 1.4. Где хранится количество в поступлениях
select top 5 id, quantity, [count], amount
from bm_storageoperations
where operationid = 1 and amount > 0



-- 2. Продажа

-- 2.1. Продажи по типам операций
select * from transtype t1
right join
    ( select transtype, count(*) as cnt, sum(amount) as total
      from journal group by transtype
    ) as t2
    on t1.transtypeid = t2.transtype


-- 2.2. Какие позиции журнала связаны с товарами
select top 20 * from product t1
right join
    ( select id, count(*) as cnt, sum(amount) as total
      from journal group by id
    ) as t2
    on t1.productid = t2.id
order by t2.total desc


-- 2.3. Чеки и их детализация
select top 10 * from journal t1
right join
    ( select ticketnumber, count(*) as cnt
      from bm_journal_details group by ticketnumber
    ) as t2
    on t1.receiptn = t2.ticketnumber
order by t2.cnt desc



-- 3. Поставщики

-- 3.1. Поставщики по группам
select * from vendorgroup t1
left join
    ( select clientgroup, count(*) as cnt
      from vendors group by clientgroup
    ) as t2
    on t1.vendorgroupid = t2.clientgroup


-- 3.2. Поставщики по городам
select * from city t1
right join
    ( select cityid, count(*) as cnt
      from vendors group by cityid
    ) as t2
    on t1.cityid = t2.cityid


-- 3.3. Прайс-листы по поставщикам
select * from vendors t1
right join
    ( select vendorid, count(*) as cnt, avg(basecost) as avg_cost
      from pricelist group by vendorid
    ) as t2
    on t1.id = t2.vendorid



-- 4. Персонал

-- 4.1. Сотрудники по уровням доступа
select * from securityaccess t1
right join
    ( select securityaccess, count(*) as cnt
      from personnel group by securityaccess
    ) as t2
    on t1.securityaccessid = t2.securityaccess


-- 4.2. Продажи по сотрудникам
select * from personnel t1
right join
    ( select loginid, count(*) as cnt, sum(amount) as total
      from journal group by loginid
    ) as t2
    on t1.personid = try_cast(t2.loginid as int)
order by t2.total desc


-- 4.3. События журнала по сотрудникам
select * from personnel t1
right join
    ( select personid, count(*) as cnt, sum(iserror) as errors
      from bm_journalsessions group by personid
    ) as t2
    on t1.personid = t2.personid


-- 4.4. Права сотрудников
select * from personnel t1
right join
    ( select personid, count(*) as cnt
      from bm_personnelsecurity group by personid
    ) as t2
    on t1.personid = t2.personid 




-- 5. Остатки

-- 5.1. Знак и количество в складских операциях
select operationid, min(quantity) as min_qty, max(quantity) as max_qty,
       sum(quantity) as sum_qty, sum([count]) as sum_count
from bm_storageoperations
group by operationid


-- 5.2. Операции по складам.
select * from storages t1
right join
    ( select storageid, operationid, count(*) as cnt, sum(amount) as total
      from bm_storageoperations group by storageid, operationid
    ) as t2
    on t1.id = t2.storageid


-- 5.3. Расчётный остаток по товарам.
select top 10 * from product t1
right join
    ( select productid, sum(quantity) as balance
      from bm_storageoperations group by productid
    ) as t2
    on t1.id = t2.productid
order by t2.balance


-- 5.4. Сверка stockperiod со складами
select * from storages t1
right join
    ( select storeid, count(*) as cnt, sum(quantityin) as qin,
             sum(quantityout) as qout, sum(quantityclose) as qclose
      from stockperiod group by storeid
    ) as t2
    on t1.id = t2.storeid

