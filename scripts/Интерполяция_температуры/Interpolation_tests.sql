
do $$
declare
    var_params public.interpolation;
    var_y  numeric;
begin
	-- проверка 1
	var_params := public.get_interpolation_params(26);
	if var_params.x0 <> 25 or var_params.y0 <> 2 or var_params.x1 <> 30 or var_params.y1 <> 3.5 then
		raise exception 'проверка 1: неверные параметры для 26';
	end if;
	raise notice 'проверка 1 пройдена';

	    -- проверка 2 
    var_y := public.calc_interpolation(23, public.get_interpolation_params(23));
    if round(var_y, 2) <> 1.8 or round(23 + var_y, 2) <> 24.8 then
        raise exception 'проверка 2: для 23 получено %, ожидалось 1.8', var_y;
    end if;
    raise notice 'проверка 2 пройдена';
 
    -- проверка 3 
    var_y := public.calc_interpolation(25, public.get_interpolation_params(25));
    if round(var_y, 2) <> 2 or round(25 + var_y, 2) <> 27 then
        raise exception 'проверка 3: для 25 получено %, ожидалось 2', var_y;
    end if;
    raise notice 'проверка 3 пройдена';
 
    -- проверка 4
    var_y := public.calc_interpolation(7, public.get_interpolation_params(7));
    if round(var_y, 2) <> 0.7 then
        raise exception 'проверка 4: для 7 получено %, ожидалось 0.7', var_y;
    end if;
    raise notice 'проверка 4 пройдена';
 
    -- проверка 5
    var_y := public.calc_interpolation(0, public.get_interpolation_params(0));
    if round(var_y, 2) <> 0.5 then
        raise exception 'проверка 5: для 0 получено %, ожидалось 0.5', var_y;
    end if;
    raise notice 'проверка 5 пройдена';
 
    -- проверка 6
    var_y := public.calc_interpolation(50, public.get_interpolation_params(50));
    if round(var_y, 2) <> 4.5 then
        raise exception 'проверка 6: для 50 получено %, ожидалось 4.5', var_y;
    end if;
    raise notice 'проверка 6 пройдена';
end
$$;