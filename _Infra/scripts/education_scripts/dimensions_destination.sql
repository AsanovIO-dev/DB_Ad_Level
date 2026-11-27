
-- Скрипт создания OLAP базы данных
-- Загрузка ресурсов

-- create database db2026;

do $$
begin

  begin
  -- Создаем DML структуры
    
    create SEQUENCE seq_dim_ranges;

    -- Ресурсы еди ницы изхмерения
    create table dim_ranges
    (
          --- Внутрений код
        id bigint primary key DEFAULT nextval('public.seq_dim_ranges'),
        external_id bigint,
        name text,
        factor float,
        -- Дата добавления
        date_add timestamp default now()
    );

  end;

  begin
    -- Перенос данных
      
    insert into dim_ranges(external_id, name, factor ) values (1,'порция',1.000);
    insert into dim_ranges(external_id, name, factor ) values (2,'100г',100.000);
    insert into dim_ranges(external_id, name, factor ) values (3,'Бут.500мл.',500.000);
    insert into dim_ranges(external_id, name, factor ) values (4,'50 мл',50.000);
    insert into dim_ranges(external_id, name, factor ) values (5,'1 день',1.000);
    insert into dim_ranges(external_id, name, factor ) values (6,'г',1.000);
    insert into dim_ranges(external_id, name, factor ) values (7,'мл',1.000);
    insert into dim_ranges(external_id, name, factor ) values (8,'300мл',300.000);
    insert into dim_ranges(external_id, name, factor ) values (9,'50мл',50.000);
    insert into dim_ranges(external_id, name, factor ) values (10,'200г',200.000);
    insert into dim_ranges(external_id, name, factor ) values (11,'SNG',1.000);
    insert into dim_ranges(external_id, name, factor ) values (12,'Бут.330мл',330.000);
    insert into dim_ranges(external_id, name, factor ) values (13,'20г',20.000);
    insert into dim_ranges(external_id, name, factor ) values (14,'40г',40.000);
    insert into dim_ranges(external_id, name, factor ) values (15,'150г',150.000);
    insert into dim_ranges(external_id, name, factor ) values (16,'190г',190.000);
    insert into dim_ranges(external_id, name, factor ) values (17,'180г',180.000);
    insert into dim_ranges(external_id, name, factor ) values (18,'30г',30.000);
    insert into dim_ranges(external_id, name, factor ) values (19,'Бут.250мл',250.000);
    insert into dim_ranges(external_id, name, factor ) values (20,'Ч400мл',400.000);
    insert into dim_ranges(external_id, name, factor ) values (21,'пачка',1.000);
    insert into dim_ranges(external_id, name, factor ) values (22,'30Л',30000.000);
    insert into dim_ranges(external_id, name, factor ) values (23,'10мл',1.000);
    insert into dim_ranges(external_id, name, factor ) values (24,'Бут.750мл.',750.000);
    insert into dim_ranges(external_id, name, factor ) values (25,'Бут.350мл',350.000);
    insert into dim_ranges(external_id, name, factor ) values (26,'10г',10.000);
    insert into dim_ranges(external_id, name, factor ) values (27,'350мл',200.000);
    insert into dim_ranges(external_id, name, factor ) values (28,'140г',140.000);
    insert into dim_ranges(external_id, name, factor ) values (29,'500мл',500.000);
    insert into dim_ranges(external_id, name, factor ) values (30,'280мл',280.000);
    insert into dim_ranges(external_id, name, factor ) values (31,'120 мл',120.000);
    insert into dim_ranges(external_id, name, factor ) values (32,'250мл',250.000);
    insert into dim_ranges(external_id, name, factor ) values (33,'340мл',340.000);
    insert into dim_ranges(external_id, name, factor ) values (34,'185мл',185.000);
    insert into dim_ranges(external_id, name, factor ) values (35,'75мл',75.000);
    insert into dim_ranges(external_id, name, factor ) values (36,'60мл',60.000);
    insert into dim_ranges(external_id, name, factor ) values (37,'80мл',80.000);
    insert into dim_ranges(external_id, name, factor ) values (38,'310мл',310.000);
    insert into dim_ranges(external_id, name, factor ) values (39,'литр',1000.000);
    insert into dim_ranges(external_id, name, factor ) values (40,'1000 г',1000.000);
    insert into dim_ranges(external_id, name, factor ) values (41,'50 г',50.000);
    insert into dim_ranges(external_id, name, factor ) values (42,'кг',1000.000);
    insert into dim_ranges(external_id, name, factor ) values (43,'Бут.700мл',700.000);
    insert into dim_ranges(external_id, name, factor ) values (44,'Бут.600мл',600.000);
    insert into dim_ranges(external_id, name, factor ) values (45,'0,5 литра',500.000);
    insert into dim_ranges(external_id, name, factor ) values (46,'0,3 литра',300.000);
    insert into dim_ranges(external_id, name, factor ) values (47,'200мл',1.000);
    insert into dim_ranges(external_id, name, factor ) values (48,'150  мл',1.000);
    insert into dim_ranges(external_id, name, factor ) values (49,'150мл',150.000);
    insert into dim_ranges(external_id, name, factor ) values (50,'пакет',1.000);
    insert into dim_ranges(external_id, name, factor ) values (51,'5л',5000.000);
    insert into dim_ranges(external_id, name, factor ) values (52,'850г',850.000);
    insert into dim_ranges(external_id, name, factor ) values (53,'500г',500.000);
    insert into dim_ranges(external_id, name, factor ) values (54,'550г',550.000);
    insert into dim_ranges(external_id, name, factor ) values (55,'570г',570.000);
    insert into dim_ranges(external_id, name, factor ) values (56,'400г',400.000);
    insert into dim_ranges(external_id, name, factor ) values (57,'250г',250.000);
    insert into dim_ranges(external_id, name, factor ) values (58,'160г',160.000);
    insert into dim_ranges(external_id, name, factor ) values (59,'48г',48.000);
    insert into dim_ranges(external_id, name, factor ) values (60,'90г',90.000);
    insert into dim_ranges(external_id, name, factor ) values (61,'0,97л',970.000);
    insert into dim_ranges(external_id, name, factor ) values (62,'уп 24шт',24.000);
    insert into dim_ranges(external_id, name, factor ) values (63,'100мл',100.000);
    insert into dim_ranges(external_id, name, factor ) values (64,'Бут.375мл',375.000);
    insert into dim_ranges(external_id, name, factor ) values (65,'Бут.640мл',640.000);
    insert into dim_ranges(external_id, name, factor ) values (66,'Бут.610мл',610.000);
    insert into dim_ranges(external_id, name, factor ) values (67,'Бут.580мл',580.000);
    insert into dim_ranges(external_id, name, factor ) values (68,'Упаковка 100',100.000);
    insert into dim_ranges(external_id, name, factor ) values (69,'шт',1.000);
    insert into dim_ranges(external_id, name, factor ) values (70,'Пачка 50',50.000);
    insert into dim_ranges(external_id, name, factor ) values (71,'80 г',80.000);
    insert into dim_ranges(external_id, name, factor ) values (72,'Бут 1,25',1250.000);
    insert into dim_ranges(external_id, name, factor ) values (73,'Бут 2л',2000.000);
    insert into dim_ranges(external_id, name, factor ) values (74,'Бут 1,75 л',1075.000);
    insert into dim_ranges(external_id, name, factor ) values (75,'Бут. 1 л',1000.000);
    insert into dim_ranges(external_id, name, factor ) values (76,'1,5 литра',1500.000);
    insert into dim_ranges(external_id, name, factor ) values (77,'Бут. 450 мл',1.000);
    insert into dim_ranges(external_id, name, factor ) values (78,'Бут.200мл',1.000);
end;

end $$;

