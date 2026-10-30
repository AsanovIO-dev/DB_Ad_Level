do $$
begin
		-- Справочник высот и счетчик
		drop table if exists wind_direction_corrections;
		drop table if exists mean_wind_speeds;
		drop table if exists mean_temp_deviations;
		drop table if exists standard_heights;		
		
		
		create table standard_heights
		(
			height integer primary key check (height > 0) 
		);
	
		comment on table standard_heights is 'Стандарные высоты бюллетеня';
		comment on column standard_heights.height is 'Высота';
	

		insert into standard_heights(height)
		values (200), (400), (800), (1200), (1600), (2000), (2400), (3000), (4000);


		-- Таблица 2: среднее отклонение температуры воздуха
		create table mean_temp_deviations
		(
			height integer,
			delta_tau integer,
			negative_value integer,
			positive_value integer
		);

		comment on table mean_temp_deviations is 'таблица 2: среднее отклонение температуры воздуха';
		comment on column mean_temp_deviations.height is 'стандартная высота, м';
		comment on column mean_temp_deviations.delta_tau is 'отклонение приземной виртуальной температуры, °c';
		comment on column mean_temp_deviations.negative_value is 'значение при отрицательном отклонении';
		comment on column mean_temp_deviations.positive_value is 'значение при положительном отклонении';

		insert into mean_temp_deviations(height, delta_tau, negative_value, positive_value)
		select h.height, t.delta_tau, t.negative_value, case when t.delta_tau <= 30 then t.delta_tau end 
		from (values
			(200, array[-1,-2,-3,-4,-5,-6,-7,-8,-8,-9,-20,-29,-39,-49]),
			(400,  array[-1,-2,-3,-4,-5,-6,-6,-7,-8,-9,-19,-29,-38,-48]),
			(800,  array[-1,-2,-3,-4,-5,-6,-6,-7,-7,-8,-18,-28,-37,-46]),
			(1200, array[-1,-2,-3,-4,-4,-5,-5,-6,-7,-8,-17,-26,-35,-44]),
			(1600, array[-1,-2,-3,-3,-4,-4,-5,-6,-7,-7,-17,-25,-34,-42]),
			(2000, array[-1,-2,-3,-3,-4,-4,-5,-6,-6,-7,-16,-24,-32,-40]),
			(2400, array[-1,-2,-2,-3,-4,-4,-5,-5,-6,-7,-15,-23,-31,-38]),
			(3000, array[-1,-2,-2,-3,-4,-4,-4,-5,-5,-6,-15,-22,-30,-37]),
			(4000, array[-1,-2,-2,-3,-4,-4,-4,-4,-5,-6,-14,-20,-27,-34])
		)as h(height, negative_values),
		unnest(array[1,2,3,4,5,6,7,8,9,10,20,30,40,50], h.negative_values) as t(delta_tau, negative_value);

		
		-- Таблица 3: скорость среднего ветра
		create table mean_wind_speeds
		(
			height integer,
			drift_range integer,
			wind_speed integer
		);
		
		comment on table mean_wind_speeds is 'таблица 3: скорость среднего ветра';
		comment on column mean_wind_speeds.height is 'стандартная высота';
		comment on column mean_wind_speeds.drift_range is 'дальность сноса ветровых пуль';
		comment on column mean_wind_speeds.wind_speed is 'скорость среднего ветра';	

		insert into mean_wind_speeds(height, drift_range, wind_speed)
		select h.height, s.drift_range, s.wind_speed
		from (values
		(200,  array[3,4,5,6,7,7,8,9,10,11,12,12]),
		(400,  array[4,5,6,7,8,9,10,11,12,13,14,15]),
		(800,  array[4,5,6,7,8,9,10,11,13,14,15,16]),
		(1200, array[4,5,7,8,8,9,11,12,13,15,15,16]),
		(1600, array[4,6,7,8,9,10,11,13,14,15,17,17]),
		(2000, array[4,6,7,8,9,10,11,13,14,16,17,18]),
		(2400, array[4,6,8,9,9,10,12,14,15,16,18,19]),
		(3000, array[5,6,8,9,10,11,12,14,15,17,18,19]),
		(4000, array[5,6,8,9,10,11,12,14,16,18,19,20])	
		) as h(height, wind_speeds), 
		unnest(array[40,50,60,70,80,90,100,110,120,130,140,150], h.wind_speeds) as s(drift_range, wind_speed);


		-- Таблица 3: поправка дирекционного угла
		create table wind_direction_corrections
		(
			height integer,
			delta_alpha integer
		);

		
		comment on table wind_direction_corrections is 'таблица 3: на сколько увеличивают дирекционный угол';
		comment on column wind_direction_corrections.height is 'стандартная высота, м';
		comment on column wind_direction_corrections.delta_alpha is 'поправка в тысячных';

		insert into wind_direction_corrections(height, delta_alpha)
		values (200, 0), (400, 100), (800, 200), (1200, 200), (1600, 300), (2000, 300), (2400, 300), (3000, 400), (4000, 400);

		
		-- Первичные ключи 
		alter table mean_temp_deviations
	    add constraint pk_mean_temp_deviations
	    primary key (height, delta_tau);

	    alter table mean_wind_speeds
	    add constraint pk_mean_wind_speeds
	    primary key (height, drift_range);

	    alter table wind_direction_corrections
	    add constraint pk_wind_direction_corrections
	    primary key (height);


		-- Проверки корректности данных
		alter table mean_temp_deviations
		add constraint chk_delta_tau_positive
		check (delta_tau > 0);
		
		alter table mean_temp_deviations
		add constraint chk_negative_value
		check (negative_value < 0);

		alter table mean_temp_deviations
		add constraint chk_positive_value
		check (positive_value is null or positive_value > 0);
		
		alter table mean_wind_speeds
		add constraint chk_drift_range_positive
		check (drift_range > 0);
		
		alter table mean_wind_speeds
		add constraint chk_wind_speed_nonnegative
		check (wind_speed >= 0);
		
		alter table wind_direction_corrections
		add constraint chk_delta_alpha_nonnegative
		check (delta_alpha >= 0);

		
		-- Внешние ключи 
		alter table mean_temp_deviations add constraint fk_mean_temp_deviations_standard_heights
		foreign key (height)
		references standard_heights (height);

		alter table mean_wind_speeds add constraint fk_mean_wind_speeds_standard_heights
		foreign key (height)
		references standard_heights (height);

		alter table public.wind_direction_corrections add constraint fk_wind_direction_corrections_standard_heights
		foreign key (height)
		references public.standard_heights (height);
end$$;	