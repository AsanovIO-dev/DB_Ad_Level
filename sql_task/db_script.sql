-- Миграционный скрипт
-- 2026-09-27
drop table if exists military_ranks;
drop table if exists employees;
drop table if exists measurment_types;
drop table if exists measurment_input_params;
drop table if exists measurment_baths;
drop table if exists measurment_parameter_types;
drop table if exists measurment_units;
drop table if exists measurment_base_units;



-- 1. Справочник должностей
create table military_ranks
(
	id integer,
	description character varying(255)
);

comment on table military_ranks is 'Справочник должностей';
comment on column military_ranks.id is 'Уникальный код';
comment on column military_ranks.description is 'Описание';

-- Заполняем данные
insert into military_ranks(id, description)
values(1,'Метеоролог'),(2,'Оператор метеопоста'),(3,'Начальник метеопоста');



-- 2. Пользователи
create table employees
(
    id integer,
	name text,
	birthday timestamp,
	military_rank_id integer
);

comment on table employees is 'Пользователи';
comment on column employees.id is 'Уникальный код';
comment on column employees.name is 'Наименование';
comment on column employees.birthday is 'Дата рождения';
comment on column employees.military_rank_id is 'Уникальный код должности';

-- Заполняем данные (дата рождения в старом скрипте не указана — оставляем NULL)
insert into employees(id, name, military_rank_id)
values(1, 'Иванов Иван Иванович', 1),
(2, 'Петров Пётр Петрович', 2),
(3, 'Александров Александр Александрович', 3);



-- 3. Устройства для измерения
create table measurment_types
(
   id integer,
   short_name  character varying(50),
   description text 
);

comment on table measurment_types is 'Измерительное оборудование';
comment on column measurment_types.id is 'Уникальный код';
comment on column measurment_types.short_name is 'Краткое наименование';
comment on column measurment_types.description is 'Описание';

-- Заполняем данные
insert into measurment_types(id, short_name, description)
values(1, 'ДМК', 'Десантный метео комплект'),
(2,'ВР','Ветровое ружьё');



-- 4. Таблица с параметрами
create table measurment_input_params
(
    id integer,
	measurment_bath_id integer
);

-- Добавляем свзь со справочником 
alter table measurment_input_params add column parameter_type_id integer;
alter table measurment_input_params add column value numeric(8,2) default 0;

comment on table measurment_input_params is 'Таблица с параметрами';
comment on column measurment_input_params.id is 'Уникальный код';
comment on column measurment_input_params.measurment_bath_id is 'Уникальный код пачки';
comment on column measurment_input_params.parameter_type_id is 'Уникальный код типа параметра';
comment on column measurment_input_params.value is 'Значение параметра';

-- Старые ненужные колонки удаляем из таблицы
alter table measurment_input_params drop column if exists height;
alter table measurment_input_params drop column if exists temperature;
alter table measurment_input_params drop column if exists pressure;
alter table measurment_input_params drop column if exists wind_direction;
alter table measurment_input_params drop column if exists wind_speed;

-- Заполняем данные 
insert into measurment_input_params(id, measurment_bath_id, parameter_type_id, value)
values(1, 1, 1, 100),
(2, 1, 2, 25.0),       
(3, 1, 3, 765),       
(4, 1, 4, 15),          
(5, 1, 5, 6),         

(6, 2, 1, 60),          
(7, 2, 2, -5.5),        
(8, 2, 3, 743),        
(9, 2, 4, 7),       
(10, 2, 6, 40),

(11, 3, 1, 100),
(12, 3, 2, 15.0),
(13, 3, 3, 750),      
(14, 3, 4, 0),       
(15, 3, 5, 0);          



-- 5. Таблица с историей
create table measurment_baths
(
	id integer ,
	emploee_id integer,
	measurment_type_id integer,
	started timestamp default now()
);

comment on table measurment_baths is 'Пачки';
comment on column measurment_baths.emploee_id is 'Уникальный код пользователя';
comment on column measurment_baths.measurment_type_id is 'Уникальный код оборудования';
comment on column measurment_baths.started is 'Дата измерения';

-- Заполняем данные (дат в старом скрипте не было — присвоены по порядку)
insert into measurment_baths(id, emploee_id, measurment_type_id, started)
values(1, 1, 1, '2026-09-01'),(2, 2, 2, '2026-09-02'),(3, 3, 1, '2026-09-03');



-- 6. Базовые единицы измерения 
create table measurment_base_units 
(
 	id integer,
	description character varying(255)
);

comment on table measurment_base_units is 'Базовые единицы измерения';
comment on column measurment_base_units.id is 'Уникальный код';
comment on column measurment_base_units.description is 'Описание';

-- Заполняем данные
insert into measurment_base_units(id, description)
values(1, 'Длина'), (2, 'Температура'), (3, 'Давление'), (4, 'Угол'), (5, 'Скорость');



-- 7. Единицы измерения
create table measurment_units
(
	id integer,
	base_unit_id integer,
	short_name character varying(50),
	description text
);

comment on table measurment_units is 'Единицы измерения';
comment on column measurment_units.base_unit_id is 'Уникальный код базовой единицы измерения';
comment on column measurment_units.short_name is 'Краткое наименование';
comment on column measurment_units.description is 'Описание';

-- Заполняем данные
insert into measurment_units (id, base_unit_id, short_name, description) 
values(1, 1, 'м', 'Метр'),
(2, 2, 'С', 'Градус Цельсия'),	
(3, 3, 'гПа', 'Гектопаскаль'),
(4, 4, 'град', 'Градус (угол)'),
(5, 5, 'м/с', 'Метр в секунду');



-- 8. Типы параметров 
create table measurment_parameter_types
(
	id integer,
	unit_id integer,
	short_name character varying(50),
	description text
);

comment on table measurment_parameter_types is 'Типы параметров';
comment on column measurment_parameter_types.unit_id is 'Уникальный код единицы измерения';
comment on column measurment_parameter_types.short_name is 'Краткое наименование';
comment on column measurment_parameter_types.description is 'Описание';

-- Заполняем данные (добавлен новый тип "Дальность сноса пуль" — использует ту же единицу-метр, что и высота)
insert into measurment_parameter_types(id, unit_id, short_name, description)
values(1,1,'Высота','Высота площадки/точки замера'),
(2,2,'Температура','Температура воздуха'),
(3,3,'Давление','Атмосферное давление'),
(4,4,'Направление ветра','Направление ветра'),
(5,5,'Скорость ветра','Скорость ветра'),
(6,1,'Дальность сноса пуль','Дальность сноса пуль (используется при варианте ВР)');

---------------------------------------------------
-- Итоговый запрос
---------------------------------------------------

select 
	b.started as "Дату измерения",
	b.id as "Номер пачки",
	e.name as "ФИО сотрудника",
	pt.short_name as "Наименование параметра",
	u.short_name as "Единица измерения",
	ip.value as "Значение"
from measurment_baths b
inner join employees e
	on e.id = b.emploee_id
inner join measurment_input_params ip 
	on ip.measurment_bath_id = b.id 
inner join measurment_parameter_types pt
	on pt.id = ip.parameter_type_id
inner join measurment_units u
	on u.id = pt.unit_id
order by b.id, 	pt.id;
