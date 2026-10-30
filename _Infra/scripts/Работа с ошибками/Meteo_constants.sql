do $$
begin
    drop function if exists public.get_meteo_bbbtt(integer, numeric);
    drop function if exists public.get_meteo_vvvv(integer);
    drop function if exists public.get_meteo_ddchm(timestamp);
    drop function if exists public.get_meteo_constant(text);
    drop table if exists public.meteo_constants;
 

    create table public.meteo_constants
    (
        name text,
        value numeric,
        description text
    );
	
    comment on table public.meteo_constants is 'Константы для расчёта метеобюллетеня';
    comment on column public.meteo_constants.name is 'Имя константы';
    comment on column public.meteo_constants.value is 'Значение';
    comment on column public.meteo_constants.description is 'Описание';
end 
$$;
commit;

 
begin;
do $$
begin
    insert into public.meteo_constants (name, value, description) values
        ('table_pressure',          750,  'Табличное наземное давление, мм рт. ст.'),
        ('table_temperature',       15.9, 'Табличная виртуальная температура, °C'),
        ('pressure_negative_add',   500,  'Добавка к модулю отклонения давления, если оно отрицательное'),
        ('temperature_negative_add', 50,  'Добавка к модулю отклонения температуры, если оно отрицательное');
end
$$;
commit;



do $$
begin
    -- функция: значение константы по имени
    create function public.get_meteo_constant(p_name text)
    returns numeric
    language plpgsql
    as $func$
    declare
        var_value numeric;
    begin
        select value into var_value
        from public.meteo_constants
        where name = p_name;
 
        return var_value;
    end;
    $func$;
    comment on function public.get_meteo_constant(text) is 'Значение константы по имени';


    -- ДДЧЧМ
    create function public.get_meteo_ddchm(p_started timestamp)
    returns text
    language plpgsql
    as $func$
    begin
        return to_char(p_started, 'DDHH24') || (extract(minute from p_started)::integer / 10)::text;
    end;
    $func$;
    comment on function public.get_meteo_ddchm(timestamp) is 'ДДЧЧМ: день, часы и десятки минут времени измерения';

    -- ВВВВ
    create function public.get_meteo_vvvv(p_height integer)
    returns text
    language plpgsql
    as $func$
    begin
        return lpad(abs(p_height)::text, 4, '0');
    end;
    $func$;
    comment on function public.get_meteo_vvvv(integer) is 'ВВВВ: высота метеопоста в четыре знака';
 
    -- БББТТ
    create function public.get_meteo_bbbtt(p_pressure integer, p_temperature numeric)
    returns text
    language plpgsql
    as $func$
    declare
        var_dp integer; 
        var_dv numeric;   
        var_dt integer; 
        

    begin
        var_dp := p_pressure - public.get_meteo_constant('table_pressure');
 
        if p_temperature < 0 then
            var_dv := 0;
        else
            var_dv := public.calc_interpolation(p_temperature, public.get_interpolation_params(p_temperature));
        end if;
 
        var_dt := round(p_temperature + var_dv - public.get_meteo_constant('table_temperature'));
 
        if var_dp < 0 then
            var_dp := public.get_meteo_constant('pressure_negative_add') - var_dp;
        end if;
        if var_dt < 0 then
            var_dt := public.get_meteo_constant('temperature_negative_add') - var_dt;
        end if;
 
        return lpad(var_dp::text, 3, '0') || lpad(var_dt::text, 2, '0');
    end;
    $func$;
    comment on function public.get_meteo_bbbtt(integer, numeric) is 'БББТТ: отклонение давления и температуры от табличных значений';
end
$$;
commit;
 
 
select public.get_meteo_ddchm('2026-10-24 09:35:00') as "ДДЧЧМ (ожидается 24093)";
select public.get_meteo_vvvv(60) as "ВВВВ (ожидается 0060)";
select public.get_meteo_bbbtt(765, 25) as "БББТТ (ожидается 01511)";
select public.get_meteo_bbbtt(743, 15) as "БББТТ (ожидается 50700)";
