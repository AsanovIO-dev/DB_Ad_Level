-- Список параметров с ошибками
with params as (
    -- параметры каждой пачки одной строкой
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
),
checked as (
    select *,
        check_input_params(row(equipment, height::integer, temperature, pressure::integer,
                               direction::integer, speed::integer, drift::integer
                          )::input_params) as errors
    from params
)
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
from checked
order by batch_id;






-- Лучший стрелок 
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
),
checked as (
    select *,
        check_input_params(row(equipment, height::integer, temperature, pressure::integer,
                               direction::integer, speed::integer, drift::integer
                          )::input_params) as errors
    from params
),
employee_errors as (
    select
        e.name,
        coalesce(sum(cardinality(string_to_array(c.errors, '; '))), 0) as error_count
    from employees e
    left join checked c on c.emploee_id = e.id
    group by e.id, e.name
)

select
    dense_rank() over (order by error_count) as "Место",
    name as "Сотрудник",
    error_count as "Количество ошибок"
from employee_errors
order by "Место", name;
