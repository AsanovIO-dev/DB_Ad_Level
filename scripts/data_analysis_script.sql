-- 1. Каждый пользователь имеет одинаковое количество измерений?
select case when t2.min_cnt = t2.max_cnt then 'Да' else 'Нет' end as equal_cnt, t2.min_cnt, t2.max_cnt
from
(
	select min(t1.cnt) as min_cnt, max(t1.cnt) as max_cnt
	from
	(
		select employees.id, count(measurment_input_params.id) as cnt 
		from employees
		left join measurment_baths 
			on measurment_baths.emploee_id = employees.id
		left join measurment_input_params
			on measurment_input_params.measurment_bath_id = measurment_baths.id
		group by employees.id
	) as t1
)as t2;


	
-- 2. Нет пустых пачек измерений?
select case when min(t1.cnt) = 0 then 'Есть пустые пачки' else 'Все пачки полные' end as check_result
from (
    select 
        measurment_baths.id as bath_id, 
        count(measurment_input_params.id) as cnt 
    from measurment_baths	
	left join measurment_input_params
		on measurment_input_params.measurment_bath_id = measurment_baths.id
    group by measurment_baths.id 			
) as t1;


-- 3. Каждая пачка измерений содержит полное количеситво параметров?
select case when t2.min_cnt = 5 and t2.max_cnt = 5 then 'да' else 'нет' end as check_result
from
(
	select min(t1.cnt) as min_cnt, max(t1.cnt) as max_cnt
	from
	(
		select 
			measurment_input_params.measurment_bath_id as bath_id, 
			count(public.measurment_input_params.parameter_type_id) as cnt 
		from measurment_input_params
		group by measurment_input_params.measurment_bath_id
	) as t1
) as t2;



-- 4. Все значения которые сформированы корректны и в рамках нужного нам диаппазонов?
select case when max(t2.is_error) = 1 then 'Есть нарушения диапазонов' else 'Все значения корректны и в рамках нужного диаппазона' end as check_result
from (
    select 
        t1.parameter_type_id,
        t1.value,
        case 
            when t1.parameter_type_id = 1 and (t1.value % 1 != 0) then 1
            when t1.parameter_type_id = 2 and (t1.value < -58.0 or t1.value > 58.0 or (t1.value * 10) % 1 != 0) then 1
            when t1.parameter_type_id = 3 and (t1.value % 1 != 0 or t1.value < 500.00 or t1.value > 900.00) then 1
            when t1.parameter_type_id = 4 and (t1.value < 0 or t1.value > 59 or t1.value % 1 != 0 or length(lpad(cast(t1.value as varchar), 2, '0')) != 2) then 1
            when t1.parameter_type_id = 5 and (t1.value % 1 != 0 or t1.value < 0 or t1.value > 15) then 1
            when t1.parameter_type_id = 6 and (t1.value % 1 != 0 or t1.value < 0 or t1.value > 150) then 1
            else 0 
        end as is_error
    from (
        select 
            measurment_input_params.parameter_type_id, 
            measurment_input_params.value
        from measurment_input_params
    ) as t1
) as t2;


-- 5. Все единицы измерения верны и корректны по отношению к указанным параметрам?
select case when max(t2.is_error) = 1 then 'Не все еденицы верны и корректны' else 'Все единицы верны и корректны' end as check_result
from (
    select 
        t1.parameter_type_id,
        t1.value,
        case 
            when t1.parameter_type_id = 1 and short_name != 'м' then 1
            when t1.parameter_type_id = 2 and short_name != 'С' then 1
            when t1.parameter_type_id = 3 and short_name != 'гПа' then 1
            when t1.parameter_type_id = 4 and short_name != 'град' then 1
            when t1.parameter_type_id = 5 and short_name != 'м/с' then 1
            when t1.parameter_type_id = 6 and short_name != 'м' then 1
            else 0 
        end as is_error
    from (
        select 
            ip.parameter_type_id, 
            ip.value,
            u.short_name as short_name
        from measurment_input_params ip
        inner join measurment_parameter_types pt
            on pt.id = ip.parameter_type_id
        inner join measurment_units u
            on u.id = pt.unit_id
    ) as t1
) as t2;
