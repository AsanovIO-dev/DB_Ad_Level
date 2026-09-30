
-- 1. positions -> military_ranks
alter table positions rename to military_ranks;
alter table military_ranks rename column code to id; 
alter table military_ranks rename column name to description;

comment on table military_ranks is 'Справочник должностей';
comment on column military_ranks.id is 'Уникальный код';
comment on column military_ranks.description is 'Описание';


-- 2. equipment_types -> measurment_types
alter table equipment_type rename to measurment_types;
alter table measurment_types rename column code to id;
alter table measurment_types rename column name to description;
alter table measurment_types add column short_name character varying(50);

update measurment_types set short_name = 'ДМК', description = 'Десантный метео комплект' where id = 1;
update measurment_types set short_name = 'ВР', description = 'Ветровое ружьё' where id = 2;

comment on table measurment_types is 'Измерительное оборудование';
comment on column measurment_types.id is 'Уникальный код';
comment on column measurment_types.short_name is 'Краткое наименование';
comment on column measurment_types.description is 'Описание';


-- 3. users -> employees
alter table users rename to employees;
alter table employees rename column code to id;
alter table employees rename column full_name to name;
alter table employees rename column position_code to military_rank_id;
alter table employees add column birthday timestamp;

comment on table employees is 'Пользователи';
comment on column employees.id is 'Уникальный код';
comment on column employees.name is 'Наименование';
comment on column employees.birthday is 'Дата рождения';
comment on column employees.military_rank_id is 'Уникальный код должности'; 


-- 4. batches -> measurment_baths
alter table batches rename to measurment_baths;
alter table measurment_baths rename column code to id;
alter table measurment_baths rename column user_code to emploee_id;
alter table measurment_baths rename column equipment_type_code to measurment_type_id;
alter table measurment_baths add column started timestamp default now();

update measurment_baths set started = '2026-09-01' where id = 1;
update measurment_baths set started = '2026-09-02' where id = 2;
update measurment_baths set started = '2026-09-03' where id = 3;

alter table measurment_baths drop column if exists name;

comment on table measurment_baths is 'Пачки';
comment on column measurment_baths.id is 'Уникальный код';
comment on column measurment_baths.emploee_id is 'Уникальный код пользователя';
comment on column measurment_baths.measurment_type_id is 'Уникальный код оборудования';
comment on column measurment_baths.started is 'Дата измерения';


-- 6. parameters -> measurment_input_params
alter table parameters rename to measurment_input_params;
alter table measurment_input_params rename column code to id;
alter table measurment_input_params rename column batch_code to measurment_bath_id;
alter table measurment_input_params add column parameter_type_id integer;

update measurment_input_params set parameter_type_id = 1 where name = 'Высота метеопоста';
update measurment_input_params set parameter_type_id = 2 where name = 'Температура';
update measurment_input_params set parameter_type_id = 3 where name = 'Давление';
update measurment_input_params set parameter_type_id = 4 where name = 'Направление ветра';
update measurment_input_params set parameter_type_id = 5 where name = 'Скорость ветра';
update measurment_input_params set parameter_type_id = 6 where name = 'Дальность сноса пуль';

alter table measurment_input_params drop column name;

-- value было текстом - переводим в число
alter table measurment_input_params alter column value type numeric(8,2) using value::numeric;
alter table measurment_input_params alter column value set default 0;

comment on table measurment_input_params is 'Таблица с параметрами';
comment on column measurment_input_params.id is 'Уникальный код';
comment on column measurment_input_params.measurment_bath_id is 'Уникальный код пачки';
comment on column measurment_input_params.parameter_type_id is 'Уникальный код типа параметра';
comment on column measurment_input_params.value is 'Значение параметра';



-- 7. measurment_base_units
create table measurment_base_units
(
	id integer,
	description character varying(255)
);

comment on table measurment_base_units is 'Базовые единицы измерения';
comment on column measurment_base_units.id is 'Уникальный код';
comment on column measurment_base_units.description is 'Описание';

insert into measurment_base_units(id, description)
values(1, 'Длина'), (2, 'Температура'), (3, 'Давление'), (4, 'Угол'), (5, 'Скорость');



-- 8. measurment_units
create table measurment_units
(
	id integer,
	base_unit_id integer,
	short_name character varying(50),
	description text
);

comment on table measurment_units is 'Единицы измерения';
comment on column measurment_units.id is 'Уникальный код';
comment on column measurment_units.base_unit_id is 'Уникальный код базовой единицы измерения';
comment on column measurment_units.short_name is 'Краткое наименование';
comment on column measurment_units.description is 'Описание';

insert into measurment_units(id, base_unit_id, short_name, description)
values(1, 1, 'м', 'Метр'),
(2, 2, 'С', 'Градус Цельсия'),
(3, 3, 'гПа', 'Гектопаскаль'),
(4, 4, 'град', 'Градус (угол)'),
(5, 5, 'м/с', 'Метр в секунду');


-- 9. measurment_parameter_types
create table measurment_parameter_types
(
	id integer,
	unit_id integer,
	short_name character varying(50),
	description text
);

comment on table measurment_parameter_types is 'Типы параметров';
comment on column measurment_parameter_types.id is 'Уникальный код';
comment on column measurment_parameter_types.unit_id is 'Уникальный код единицы измерения';
comment on column measurment_parameter_types.short_name is 'Краткое наименование';
comment on column measurment_parameter_types.description is 'Описание';

insert into measurment_parameter_types(id, unit_id, short_name, description)
values(1,1,'Высота','Высота площадки/точки замера'),
(2,2,'Температура','Температура воздуха'),
(3,3,'Давление','Атмосферное давление'),
(4,4,'Направление ветра','Направление ветра'),
(5,5,'Скорость ветра','Скорость ветра'),
(6,1,'Дальность сноса пуль','Дальность сноса пуль');


select
	b.started as "Дата измерения",
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
order by b.id, pt.id;
