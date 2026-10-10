-- 1. Таблицы и счётчики
begin;
do $$
begin
    drop table if exists public.temperature_calc;
    drop table if exists public.measurements;
    drop table if exists public.employees;
    drop table if exists public.military_ranks;
    drop sequence if exists public.seq_temperature_calc;
    drop sequence if exists public.seq_measurements;
    drop sequence if exists public.seq_employees;
    drop sequence if exists public.seq_military_ranks;

    create table public.military_ranks (
        id          integer,
        description text
    );

    create table public.employees (
        id               integer,
        name             text,
        military_rank_id integer
    );

    create table public.measurements (
        id          integer,
        employee_id integer,
        started     timestamp,
        temperature numeric(5,1),
        pressure    integer
    );

    create table public.temperature_calc (
        id          integer,
        t0          text,
        correction  numeric(3,1)
    );
    comment on table public.temperature_calc is 'Расчёт температуры';
    comment on column public.temperature_calc.t0 is 'Диапазон температуры';
    comment on column public.temperature_calc.correction is 'Поправка ΔTv';

    create sequence public.seq_military_ranks   start with 1;
    create sequence public.seq_employees        start with 1;
    create sequence public.seq_measurements     start with 1;
    create sequence public.seq_temperature_calc start with 1;
end
$$;
commit;


-- 2. Тестовые данные
begin;
do $$
begin
    insert into public.military_ranks (id, description) values
        (1, 'Метеоролог'),
        (2, 'Оператор метеопоста'),
        (3, 'Начальник метеопоста');

    insert into public.employees (id, name, military_rank_id) values
        (1, 'Иванов Иван Иванович', 1),
        (2, 'Петров Пётр Петрович', 2),
        (3, 'Александров Александр Александрович', 3);

    insert into public.measurements (id, employee_id, started, temperature, pressure) values
        (1, 1, '2026-09-01 09:00:00', 11.6, 757),
        (2, 1, '2026-09-02 10:30:00', 12.5, 760),
        (3, 2, '2026-09-03 08:15:00', 15.6, 767),
        (4, 3, '2026-09-04 11:00:00', 25.2, 758);

    insert into public.temperature_calc (id, t0, correction) values
        (1, 'Ниже 0', 0),
        (2, '0 - 5',   0.5),
        (3, '10 - 15', 1),
        (4, '20',      1.5),
        (5, '25',      2),
        (6, '30',      3.5),
        (7, '40',      4.5);

    perform setval('public.seq_military_ranks',   (select max(id) from public.military_ranks) + 1, false);
    perform setval('public.seq_employees',        (select max(id) from public.employees) + 1, false);
    perform setval('public.seq_measurements',     (select max(id) from public.measurements) + 1, false);
    perform setval('public.seq_temperature_calc', (select max(id) from public.temperature_calc) + 1, false);
end
$$;
commit;


-- 3. Связи и ограничения
begin;
do $$
begin
    alter table public.military_ranks   add constraint pk_military_ranks   primary key (id);
    alter table public.employees        add constraint pk_employees        primary key (id);
    alter table public.measurements     add constraint pk_measurements     primary key (id);
    alter table public.temperature_calc add constraint pk_temperature_calc primary key (id);

    alter table public.military_ranks   alter column id set default nextval('public.seq_military_ranks');
    alter table public.employees        alter column id set default nextval('public.seq_employees');
    alter table public.measurements     alter column id set default nextval('public.seq_measurements');
    alter table public.temperature_calc alter column id set default nextval('public.seq_temperature_calc');

    alter table public.employees
        add constraint fk_employees_rank
        foreign key (military_rank_id) references public.military_ranks (id);

    alter table public.measurements
        add constraint fk_measurements_employee
        foreign key (employee_id) references public.employees (id);
end
$$;
commit;

select * from public.military_ranks, public.employees, public.measurements;
select * from public.temperature_calc order by id;