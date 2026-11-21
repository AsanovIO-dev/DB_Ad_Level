do $$
begin 

	drop table if exists metric_time;
	create sequence seq_metric_time;
	
	create table if not exists metric_time 
	(
		id int default nextval('seq_metric_time') primary key, 
		date_start_month date,
		date_end_month date,
		name_month text,
		year int,
		quarter_number int,
		name_quarter text
	);
	comment on table metric_time is 'Справочник времени: один календарный месяц';
	comment on column metric_time.id is 'Ключ месяца';
	comment on column metric_time.date_start_month is 'Первый день месяца';
	comment on column metric_time.date_endings_month is 'Последний день месяца';
	comment on column metric_time.name_month is 'Название месяца';
	comment on column metric_time.year is 'Год';
	comment on column metric_time.flat_number is 'Сквозной порядковый номер месяца от начала периода';
	comment on column metric_time.quarter_number is 'Номер квартала';
	comment on column metric_time.name_quarter is 'Название квартала';
end
$$