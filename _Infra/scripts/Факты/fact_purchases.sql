do $$
begin
	create sequence seq_fact_purchases;
	
	create table fact_purchases
    (
        id bigint primary key default nextval('public.seq_fact_purchases'),
        time_id int not null,
        vendor_id bigint, 
        category_id bigint, 
        range_id bigint,
        product_id bigint not null,
        nomenclature_id bigint, 
        nomenclature_group_id bigint,
        amount numeric(18, 2),
        quantity numeric(18, 4),
        date_add timestamp default now(),

		constraint fk_fact_purchasses_time foreign key (time_id) references public.metric_time(id),
		constraint fk_fact_purchasses_vendor foreign key (vendor_id) references public.dim_vendors(id),
		constraint fk_fact_purchases_category foreign key (category_id) references public.dim_categories(id),
        constraint fk_fact_purchases_range foreign key (range_id) references public.dim_ranges(id),public.dim_ranges
        constraint fk_fact_purchases_product foreign key (product_id) references public.dim_products(id)
		
	);

	
	comment on table fact_purchases is 'Таблица aакты: закупка продукции';
    comment on column fact_purchases.id is 'Код';
    comment on column fact_purchases.time_id is 'Код временного отрезка';
    comment on column fact_purchases.vendor_id is 'Код поставщика';
    comment on column fact_purchases.category_id is 'Код категории';
    comment on column fact_purchases.range_id is 'Код единицы измерения';
    comment on column fact_purchases.product_id is 'Код продукта';
    comment on column fact_purchases.nomenclature_id is 'Код номенклатуры';
    comment on column fact_purchases.nomenclature_group_id is 'Код группы номенклатуры';
    comment on column fact_purchases.amount is 'Сумма';
    comment on column fact_purchases.date_add is 'Дата вставки';
    comment on column fact_purchases.quantity is 'Количество';

	comment on constraint fk_fact_purchasses_time on public.fact_purchases is 'Внешний ключ на таблицу времени';
	comment on constraint fk_fact_purchasses_vendor on public.fact_purchases is 'Внешний ключ на таблицу поставщиков';
	comment on constraint fk_fact_purchases_category on public.fact_purchases is 'Внешний ключ на таблицу категорий';
	comment on constraint fk_fact_purchases_range on public.fact_purchases is 'Внешний ключ на таблицу единиц измерения';
	comment on constraint fk_fact_purchases_product on public.fact_purchases is 'Внешний ключ на таблицу продуктов';
end
$$