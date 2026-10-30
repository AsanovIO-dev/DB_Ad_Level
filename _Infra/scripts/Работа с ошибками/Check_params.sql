begin;
do $$
begin
    drop function if exists public.check_input_params(public.input_params);
    drop type if exists public.input_params;
    drop table if exists public.input_param_errors;
 
    create table public.input_param_errors
    (
        id         integer,
        param_name text,
        min_value  numeric,
        max_value  numeric,
        error_text text
    );
    comment on table public.input_param_errors is 'Ошибки входных параметров';
    comment on column public.input_param_errors.id is 'Уникальный код';
    comment on column public.input_param_errors.param_name is 'Имя параметра';
    comment on column public.input_param_errors.min_value is 'Минимальное значение';
    comment on column public.input_param_errors.max_value is 'Максимальное значение';
    comment on column public.input_param_errors.error_text is 'Текст ошибки';
 
    create type public.input_params as (
        equipment_type text,     
        height         integer,  
        temperature    numeric,  
        pressure       integer,   
        wind_direction integer,
        wind_speed     integer,
        bullet_drift   integer  
    );
end
$$;
commit;
 

begin;
do $$
begin
    insert into public.input_param_errors (id, param_name, min_value, max_value, error_text) values
        (1, 'equipment_type',  null, null, 'Тип оборудования: должен быть ДМК или ВР'),
        (2, 'height',          null, null, 'Высота метеопоста: значение не указано'),
        (3, 'temperature',     -58,  58,   'Температура: от -58 до 58, один знак после запятой'),
        (4, 'pressure',        500,  900,  'Давление: от 500 до 900'),
        (5, 'wind_direction',  0,    59,   'Направление ветра: от 0 до 59'),
        (6, 'wind_speed',      0,    15,   'Скорость ветра: от 0 до 15'),
        (7, 'bullet_drift',    0,    150,  'Дальность сноса пуль: от 0 до 150');
end
$$;
commit;
 
 

begin;
do $$
begin
    alter table public.input_param_errors add constraint pk_input_param_errors primary key (id);
    alter table public.input_param_errors add constraint uq_input_param_errors_name unique (param_name);
    alter table public.input_param_errors alter column param_name set not null;
    alter table public.input_param_errors alter column error_text set not null;
end
$$;
commit;
 
 

begin;
do $$
begin
    create function public.check_input_params(p_params public.input_params)
    returns text
    language plpgsql
    as $func$
    declare
        var_errors text[] := '{}';
        var_rule   public.input_param_errors;
    begin

        select * into var_rule from public.input_param_errors where param_name = 'equipment_type';
        if p_params.equipment_type is null or p_params.equipment_type not in ('ДМК', 'ВР') then
            var_errors := array_append(var_errors, var_rule.error_text);
        end if;
 

        select * into var_rule from public.input_param_errors where param_name = 'height';
        if p_params.height is null then
            var_errors := array_append(var_errors, var_rule.error_text);
        end if;
 

        select * into var_rule from public.input_param_errors where param_name = 'temperature';
        if p_params.temperature is null
           or p_params.temperature < var_rule.min_value
           or p_params.temperature > var_rule.max_value
           or p_params.temperature <> round(p_params.temperature, 1) then
            var_errors := array_append(var_errors, var_rule.error_text);
        end if;
 

        select * into var_rule from public.input_param_errors where param_name = 'pressure';
        if p_params.pressure is null
           or p_params.pressure < var_rule.min_value
           or p_params.pressure > var_rule.max_value then
            var_errors := array_append(var_errors, var_rule.error_text);
        end if;
 

        select * into var_rule from public.input_param_errors where param_name = 'wind_direction';
        if p_params.wind_direction is null
           or p_params.wind_direction < var_rule.min_value
           or p_params.wind_direction > var_rule.max_value then
            var_errors := array_append(var_errors, var_rule.error_text);
        end if;


        if p_params.equipment_type = 'ДМК' then
            select * into var_rule from public.input_param_errors where param_name = 'wind_speed';
            if p_params.wind_speed is null
               or p_params.wind_speed < var_rule.min_value
               or p_params.wind_speed > var_rule.max_value then
                var_errors := array_append(var_errors, var_rule.error_text);
            end if;
        end if;
 
     
        if p_params.equipment_type = 'ВР' then
            select * into var_rule from public.input_param_errors where param_name = 'bullet_drift';
            if p_params.bullet_drift is null
               or p_params.bullet_drift < var_rule.min_value
               or p_params.bullet_drift > var_rule.max_value then
                var_errors := array_append(var_errors, var_rule.error_text);
            end if;
        end if;
 

        return array_to_string(var_errors, '; ');
    end;
    $func$;
 
    comment on function public.check_input_params(public.input_params) is
        'Проверка входных параметров: возвращает список ошибок через точку с запятой, пустая строка - ошибок нет';
end
$$;
commit;
 
 
-- проверка
select public.check_input_params(row('ДМК', 100, 15, 750, 0, 0, null)::public.input_params)
    as "ДМК, значения по умолчанию";
 
select public.check_input_params(row('ДМК', 100, 60.55, 400, 70, 20, null)::public.input_params)
    as "ДМК, неверные значения";
 
select public.check_input_params(row('ВР', null, 15, 750, 0, null, 200)::public.input_params)
    as "ВР, неверные значения";
 


















Claude finished the response
