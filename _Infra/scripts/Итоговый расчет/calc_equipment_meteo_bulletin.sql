do $$
begin

	drop procedure if exists public.fn_calc_equipment_meteo_bulletin(public.input_params, refcursor);
	
	create procedure public.fn_calc_equipment_meteo_bulletin(
		p_params public.input_params,
		inout p_cursor refcursor
	)
	language 'plpgsql'
	as $body$
	declare
		var_error text;
		var_equipment_id integer;
		var_dv numeric;
		var_deviation integer;
		var_tens integer;
		var_units integer;
		var_key numeric;
		var_table2_type_id integer;
		var_speed_type_id integer;
		var_dir_type_id integer;
		var_zero boolean;
		var_x0 integer;
		var_x1 integer;
		var_delta_alpha integer;
		var_values integer[];
		var_header integer[];
		var_speed_header integer[];
		var_interpolation public.interpolation;
		rec_height record;
	begin
		-- Проверка входных параметров
		var_error := public.check_input_params(p_params);
		if coalesce(var_error, '') <> '' then
			raise exception 'Ошибка во входных параметрах: %', var_error;
		end if;

		-- Оборудование
		select t.id into var_equipment_id
		from public.measurment_types as t
		where t.short_name = p_params.equipment_type;

		-- Отклонение приземной виртуальной температуры
		-- ниже 0 поправка равна 0, выше 40 берем значение для 40
		var_dv := case when p_params.temperature < 0 then 0
			   else public.fn_calc_temperature_interpolation(least(p_params.temperature, 40)) end;
		var_deviation := round(p_params.temperature + var_dv - public.get_meteo_constant('table_temperature'));

		-- столбцы таблицы 2: десятки и единицы
		var_tens := abs(var_deviation) / 10 * 10;
		var_units := abs(var_deviation) % 10;

		-- используем прямые ID (8 - положительные, 9 - отрицательные)
		var_table2_type_id := case when var_deviation < 0 then 9 else 8 end;
		
		-- Типы таблиц
		select t.id into var_speed_type_id
		from public.calc_correction_types as t
		where t.parent_id = 2 and t.measurment_equipment_id = var_equipment_id;

		select t.id into var_dir_type_id
		from public.calc_correction_types as t
		where t.parent_id = 3 and t.measurment_equipment_id = var_equipment_id;

		-- Вход таблицы 3
		var_key := case when p_params.equipment_type = 'ДМК' then p_params.wind_speed else p_params.bullet_drift end;

		-- Заголовок таблицы 3 для оборудования
		select hd.header_values into var_speed_header
		from public.calc_correction_types as t
		join public.calc_correction_headers as hd on hd.id = t.header_id
		where t.id = var_speed_type_id;

		-- вход меньше 40
		-- скорость и направление равны нулю на всех высотах
		var_zero := var_key < var_speed_header[1];


		create temp table if not exists tmp_calc_results (
	        height integer,
	        delta_temperature numeric,
	        wind_speed numeric,
	        wind_direction numeric
	    ) on commit drop;
	
	    truncate table tmp_calc_results;

		-- Цикл по стандартным высотам
		for rec_height in
			select h.id, h.height
			from public.calc_correction_heights as h
			order by h.height
		loop
			declare 
				v_height integer := rec_height.height;
				v_delta_t numeric;
				v_wind_speed numeric;
				v_wind_dir numeric;

			begin
				-- таблица 2: столбец десятков + столбец единиц
				select c.row_values, hd.header_values
				into var_values, var_header
				from public.calc_correction as c
				join public.calc_correction_types as t 
					on t.id = c.type_id
				join public.calc_correction_headers as hd 
					on hd.id = t.header_id
				where c.height_id = rec_height.id
				and c.type_id = var_table2_type_id;
	
				delta_temperature := coalesce(var_values[array_position(var_header, var_tens)], 0)
								   + coalesce(var_values[array_position(var_header, var_units)], 0);
	
				if var_zero then
					v_wind_speed := 0;
					v_wind_direction := 0;
				else
					-- таблица 3: скорость ветра
					select c.row_values
					into var_values
					from public.calc_correction as c
					where c.height_id = rec_height.id
					and c.type_id = var_speed_type_id;
	
					-- проверка на наличие данных в справочнике
					if var_values is null then
						v_wind_speed := null;
					else
						select max(k.col) filter (where k.col <= var_key),
							   min(k.col) filter (where k.col >= var_key)
						into var_x0, var_x1
						from unnest(var_speed_header) as k(col);
	
						var_interpolation.x0 := var_x0;
						var_interpolation.x1 := var_x1;
						var_interpolation.y0 := var_values[array_position(var_speed_header, var_x0)];
						var_interpolation.y1 := var_values[array_position(var_speed_header, var_x1)];
	
						-- ДМК: скорость округяется до 1 м/с
						v_wind_speed := round(public.calc_interpolation(var_key, var_interpolation),
											case when p_params.equipment_type = 'ДМК' then 0 else 2 end);
					end if;
	
					-- таблица 3: направление ветра
					select c.row_values[1]
					into var_delta_alpha
					from public.calc_correction as c
					where c.height_id = rec_height.id
					and c.type_id = var_dir_type_id;
	
					v_wind_direction := mod(p_params.wind_direction + coalesce(var_delta_alpha,0), 60);
				end if;

				insert into tmp_calc_results(height, delta_temperature, wind_speed, wind_direction)
				values (v_height, v_delta_t, v_wind_speed, v_wind_dir);
			end;
		end loop;
		
		open p_cursor for 
        	select * from tmp_calc_results order by height;
	end;
	$body$;

	comment on function public.fn_calc_equipment_meteo_bulletin(public.input_params) is 'Расчет метео по типовым высотам для оборудования';
end $$;
