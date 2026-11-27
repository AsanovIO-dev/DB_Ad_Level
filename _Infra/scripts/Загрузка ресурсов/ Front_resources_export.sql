do $$
begin
	------ 1. Закупка продукции

	-- Единицы измерения
	create sequence seq_dim_ranges;

	create table dim_ranges
	(
		id bigint primary key default nextval('public.seq_dim_ranges'),
		external_id bigint,
		name text,
		factor float,
		date_add timestamp default now()
	);

	comment on table dim_ranges is 'Ресурсы: единицы измерения (источник: front, таблица size)';
	comment on column dim_ranges.id is 'Внутренний код';
	comment on column dim_ranges.external_id is 'Код в базе Front (size.id)';
	comment on column dim_ranges.name is 'Название единицы измерения (size.sizeid)';
	comment on column dim_ranges.factor is 'Коэффициент единицы измерения (size.portionrate)';
	comment on column dim_ranges.date_add is 'Дата добавления записи';


	-- Категории
	create sequence seq_dim_categories;

	create table dim_categories
	(
		id bigint primary key default nextval('public.seq_dim_categories'),
		external_id bigint,
		name text,
		parent_id bigint,
		date_add timestamp default now()
	);

	comment on table dim_categories is 'Ресурсы: категории товаров (источник: front, таблица category)';
	comment on column dim_categories.id is 'Внутренний код';
	comment on column dim_categories.external_id is 'Код в базе Front (category.id)';
	comment on column dim_categories.name is 'Название категории (category.description)';
	comment on column dim_categories.parent_id is 'Код родительской категории в базе Front (external_id родителя), у корневых категорий пусто';
	comment on column dim_categories.date_add is 'Дата добавления записи';


	-- Поставщики
	create sequence seq_dim_vendors;

	create table dim_vendors
	(
		id bigint primary key default nextval('public.seq_dim_vendors'),
		external_id bigint,
		name text,
		parent_id bigint,
		date_add timestamp default now()
	);

	comment on table dim_vendors is 'Ресурсы: поставщики (источник: front, таблицы vendors и vendorgroup)';
	comment on column dim_vendors.id is 'Внутренний код';
	comment on column dim_vendors.external_id is 'Код в базе Front (vendors.id)';
	comment on column dim_vendors.name is 'Наименование поставщика (vendors.clientid)';
	comment on column dim_vendors.parent_id is 'Код группы поставщиков в базе Front (vendorgroup.vendorgroupid)';
	comment on column dim_vendors.date_add is 'Дата добавления записи';


	-- Товары
	create sequence seq_dim_products;

	create table dim_products
	(
		id bigint primary key default nextval('public.seq_dim_products'),
		external_id bigint,
		code text,
		name text,
		date_add timestamp default now()
	);

	comment on table dim_products is 'Ресурсы: товары, блюда и ингредиенты (источник: front, таблица product)';
	comment on column dim_products.id is 'Внутренний код';
	comment on column dim_products.external_id is 'Код в базе Front (product.id)';
	comment on column dim_products.code is 'Код товара (product.productid)';
	comment on column dim_products.name is 'Наименование товара (product.description)';
	comment on column dim_products.date_add is 'Дата добавления записи';



	------ 2. Продажа товара


	-- Типы оплаты
	create sequence seq_dim_payment_types;

	create table dim_payment_types
	(
		id bigint primary key default nextval('public.seq_dim_payment_types'),
		external_id bigint,
		name text,
		date_add timestamp default now()
	);

	comment on table dim_payment_types is 'Ресурсы: типы оплаты (источник: front, таблица paymenttype)';
	comment on column dim_payment_types.id is 'Внутренний код';
	comment on column dim_payment_types.external_id is 'Код в базе Front (paymenttype.paymenttypeid)';
	comment on column dim_payment_types.name is 'Название типа оплаты (paymenttype.description)';
	comment on column dim_payment_types.date_add is 'Дата добавления записи';

	------ 3. Работа персонала

	-- Сотрудники
	create sequence seq_dim_personnel;

	create table dim_personnel
	(
		id bigint primary key default nextval('public.seq_dim_personnel'),
		external_id bigint,
		name text,
		date_add timestamp default now()
	);

	comment on table dim_personnel is 'Ресурсы: сотрудники и учётные записи касс (источник: front, таблица personnel)';
	comment on column dim_personnel.id is 'Внутренний код';
	comment on column dim_personnel.external_id is 'Код в базе Front (personnel.personid)';
	comment on column dim_personnel.name is 'Фамилия и имя сотрудника (personnel.lastname, personnel.firstname)';
	comment on column dim_personnel.date_add is 'Дата добавления записи';

	------ 4. Остатки

	-- Склады
	create sequence seq_dim_storages;

	create table dim_storages
	(
		-- Внутренний код
		id bigint primary key default nextval('public.seq_dim_storages'),
		-- Код в базе Front (storages.id)
		external_id bigint,
		name text,
		-- Дата добавления
		date_add timestamp default now()
	);

	comment on table dim_storages is 'Ресурсы: склады (источник: front, таблица storages)';
	comment on column dim_storages.id is 'Внутренний код';
	comment on column dim_storages.external_id is 'Код в базе Front (storages.id)';
	comment on column dim_storages.name is 'Название склада (storages.description)';
	comment on column dim_storages.date_add is 'Дата добавления записи';


	-- Типы складских операций
	create sequence seq_dim_storage_operation_types;

	create table dim_storage_operation_types
	(
		id bigint primary key default nextval('public.seq_dim_storage_operation_types'),
		external_id bigint,
		name text,
		factor int,
		date_add timestamp default now()
	);

	comment on table dim_storage_operation_types is 'Ресурсы: типы складских операций (источник: front, таблица bm_storageoperationstype)';
	comment on column dim_storage_operation_types.id is 'Внутренний код';
	comment on column dim_storage_operation_types.external_id is 'Код в базе Front (bm_storageoperationstype.id)';
	comment on column dim_storage_operation_types.name is 'Название операции (bm_storageoperationstype.description)';
	comment on column dim_storage_operation_types.factor is 'Знак операции (bm_storageoperationstype.factor): 1 приход, -1 расход';
	comment on column dim_storage_operation_types.date_add is 'Дата добавления записи';


	-- Причины списания
	create sequence seq_dim_write_off_reasons;

	create table dim_write_off_reasons
	(
		id bigint primary key default nextval('public.seq_dim_write_off_reasons'),
		external_id bigint,
		name text,
		parent_id bigint,
		date_add timestamp default now()
	);

	comment on table dim_write_off_reasons is 'Ресурсы: причины списания (источник: front, таблица bm_reasondebit)';
	comment on column dim_write_off_reasons.id is 'Внутренний код';
	comment on column dim_write_off_reasons.external_id is 'Код в базе Front (bm_reasondebit.id)';
	comment on column dim_write_off_reasons.name is 'Название причины (bm_reasondebit.description)';
	comment on column dim_write_off_reasons.parent_id is 'Код родительской причины в базе Front (external_id родителя), у корневых пусто';
	comment on column dim_write_off_reasons.date_add is 'Дата добавления записи';
end
$$;
