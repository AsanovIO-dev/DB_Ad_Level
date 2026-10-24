delete from measurment_input_params where id > 60;
delete from measurment_baths where id > 12;
 
insert into measurment_baths(id, emploee_id, measurment_type_id, started)
values
(13, 1, 1, '2026-09-05 09:10:00'),  
(14, 2, 1, '2026-09-07 14:20:00'), 
(15, 3, 2, '2026-09-09 08:05:00'),  
(16, 1, 2, '2026-09-11 11:40:00'),  
(17, 3, 2, '2026-09-14 13:25:00'); 
 

insert into measurment_input_params(id, measurment_bath_id, parameter_type_id, value)
values
(61, 13, 1, 110), (62, 13, 2, 14.8), (63, 13, 3, 752), (64, 13, 4, 12), (65, 13, 5, 7),
(66, 14, 1, 95), (67, 14, 2, 62.5), (68, 14, 3, 748), (69, 14, 4, 30), (70, 14, 5, 20),
(71, 15, 1, 88), (72, 15, 2, 9.5), (73, 15, 3, 755), (74, 15, 4, 20), (75, 15, 6, 55),
(76, 16, 1, 102), (77, 16, 2, 21), (78, 16, 3, 450), (79, 16, 4, 41), (80, 16, 6, 60),
(81, 17, 1, 70), (82, 17, 2, 17.2), (83, 17, 3, 950), (84, 17, 4, 75), (85, 17, 6, 180);


create or replace view batch_errors as
with params as (
    select
        b.id as batch_id,
        b.emploee_id,
        t.short_name as equipment,
        max(p.value) filter (where p.parameter_type_id = 1) as height,
        max(p.value) filter (where p.parameter_type_id = 2) as temperature,
        max(p.value) filter (where p.parameter_type_id = 3) as pressure,
        max(p.value) filter (where p.parameter_type_id = 4) as direction,
        max(p.value) filter (where p.parameter_type_id = 5) as speed,
        max(p.value) filter (where p.parameter_type_id = 6) as drift
    from measurment_baths b
    join measurment_types t on t.id = b.measurment_type_id
    left join measurment_input_params p on p.measurment_bath_id = b.id
    group by b.id, b.emploee_id, t.short_name
)
select *, check_input_params(row(equipment, height::integer, temperature, pressure::integer,direction::integer, speed::integer, drift::integer)::input_params) as errors from params;

-- Список параметров с ошибками
select
    batch_id as "№",
    equipment as "Тип оборудования",
    height as "Высота метеопоста",
    temperature as "Температура",
    pressure as "Давление",
    direction as "Направление ветра",
    speed as "Скорость ветра",
    drift as "Дальность сноса пуль",
    errors <> '' as "Флаг: Есть ошибка",
    errors as "Описание ошибки"
from batch_errors
order by batch_id;


-- Лучший стрелок 
with employee_errors as (
    select
        e.name,
        coalesce(sum(cardinality(string_to_array(b.errors, '; '))), 0) as error_count
    from employees e
    left join batch_errors b on b.emploee_id = e.id
    group by e.id, e.name
)
select
    dense_rank() over (order by error_count) as "Место",
    name as "Сотрудник",
    error_count as "Количество ошибок"
from employee_errors
order by "Место", name;