drop table if exists tmp_meteo_test;
create temp table tmp_meteo_test
(
	test_no integer,
	test_name text,
	height integer,
	delta_temperature numeric,
	wind_speed numeric,
	wind_direction numeric
);

do $$
declare
	var_test record;
begin

	-- Расчет для типовых входных данных
	for var_test in
		select t.test_no, t.test_name, t.params
		from (values
			(1, 'ДМК, по умолчанию: t=15, давление 750, направление 0, скорость 0',
				row('ДМК', 100, 15, 750, 0, 0, null)::public.input_params),
			(2, 'ДМК, пример из алгоритма: t=3, давление 750, направление 12, скорость 5',
				row('ДМК', 100, 3, 750, 12, 5, null)::public.input_params),
			(3, 'ВР, пачка 2: t=-5.5, давление 743, направление 7, дальность 40',
				row('ВР', 60, -5.5, 743, 7, null, 40)::public.input_params),
			(4, 'ВР, пачка 10: t=25.2, давление 758, направление 59, дальность 71',
				row('ВР', 93, 25.2, 758, 59, null, 71)::public.input_params)
		) as t(test_no, test_name, params)
		order by t.test_no
	loop
		insert into tmp_meteo_test(test_no, test_name, height, delta_temperature, wind_speed, wind_direction)
		select var_test.test_no, var_test.test_name, r.height, r.delta_temperature, r.wind_speed, r.wind_direction
		from public.fn_calc_equipment_meteo_bulletin(var_test.params) as r;
	end loop;


	-- Проверка результатов
	-- тест 1: скорость 0 меньше 3, поэтому скорость и направление равны нулю, отклонение температуры 0
	if exists (select 1 from tmp_meteo_test
			   where test_no = 1 and (delta_temperature <> 0 or wind_speed <> 0 or wind_direction <> 0)) then
		raise exception 'тест 1: неверный результат';
	end if;
	raise notice 'тест 1 пройден';

	-- тест 2: высота 200
	if not exists (select 1 from tmp_meteo_test
				   where test_no = 2 and height = 200
				   and delta_temperature = -11 and wind_speed = 8 and wind_direction = 13) then
		raise exception 'тест 2: неверный результат для 200 м';
	end if;
	raise notice 'тест 2 пройден';

	-- тест 3: высота 4000
	if not exists (select 1 from tmp_meteo_test
				   where test_no = 3 and height = 4000
				   and delta_temperature = -15 and wind_speed = 5 and wind_direction = 11) then
		raise exception 'тест 3: неверный результат для 4000 м';
	end if;
	raise notice 'тест 3 пройден';

	-- тест 4: высота 400 (интерполяция скорости, направление переходит через 60)
	if not exists (select 1 from tmp_meteo_test
				   where test_no = 4 and height = 400
				   and delta_temperature = 11 and wind_speed = 7.1 and wind_direction = 0) then
		raise exception 'тест 4: неверный результат для 400 м';
	end if;
	raise notice 'тест 4 пройден';

end $$;


-- Результаты расчета
select
	test_no as "№",
	test_name as "Тест",
	height as "Высота, м",
	delta_temperature as "Отклонение температуры",
	wind_speed as "Скорость ветра",
	wind_direction as "Направление ветра"
from tmp_meteo_test
order by test_no, height;