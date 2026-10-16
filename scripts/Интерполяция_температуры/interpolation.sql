begin;
do $$
begin
    drop function if exists public.calc_interpolation(numeric, public.interpolation);
    drop function if exists public.get_interpolation_params(numeric);
    drop type if exists public.interpolation;
    drop table if exists public.calc_temperature_correction;

    create table public.calc_temperature_correction
    (
        temperature numeric(8,2) not null primary key,
        correction  numeric(8,2) not null
    );

    insert into public.calc_temperature_correction (temperature, correction)
    values (0, 0.5), (5, 0.5), (10, 1), (20, 1.5), (25, 2), (30, 3.5), (40, 4.5);

    create type public.interpolation as (
        x0 numeric,
        y0 numeric,
        x1 numeric,
        y1 numeric
    );

    create function public.get_interpolation_params(p_temperature numeric)
    returns public.interpolation
    language plpgsql
    as $func$
    declare
        var_result public.interpolation;
    begin
        select
            coalesce((select temperature from public.calc_temperature_correction
                      where temperature <= p_temperature order by temperature desc limit 1), p_temperature),
            coalesce((select correction from public.calc_temperature_correction
                      where temperature <= p_temperature order by temperature desc limit 1),
                     (select correction from public.calc_temperature_correction
                      order by temperature limit 1)),
            coalesce((select temperature from public.calc_temperature_correction
                      where temperature >= p_temperature order by temperature limit 1), p_temperature),
            coalesce((select correction from public.calc_temperature_correction
                      where temperature >= p_temperature order by temperature limit 1),
                     (select correction from public.calc_temperature_correction
                      order by temperature desc limit 1))
        into
            var_result.x0, var_result.y0, var_result.x1, var_result.y1;

        return var_result;
    end;
    $func$;

    create function public.calc_interpolation(p_x numeric, p_params public.interpolation)
    returns numeric
    language plpgsql
    as $func$
    begin
        if p_params.x1 = p_params.x0 then
            return p_params.y0;
        end if;

        return p_params.y0
             + (p_x - p_params.x0) * (p_params.y1 - p_params.y0)
             / (p_params.x1 - p_params.x0);
    end;
    $func$;
end
$$;
commit;

select
    t as "Температура",
    (public.get_interpolation_params(t)).x0 as x0,
    (public.get_interpolation_params(t)).y0 as y0,
    (public.get_interpolation_params(t)).x1 as x1,
    (public.get_interpolation_params(t)).y1 as y1,
    public.calc_interpolation(t, public.get_interpolation_params(t)) as "Поправка"
from (values (-10), (0), (7), (26), (40), (50)) v(t);