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
		category_id bigint,
		rangel_id bigint,
		kind int,
		date_add timestamp default now()
	);

	comment on table dim_products is 'Ресурсы: товары, блюда и ингредиенты (источник: front, таблица product)';
	comment on column dim_products.id is 'Внутренний код';
	comment on column dim_products.external_id is 'Код в базе Front (product.id)';
	comment on column dim_products.code is 'Код товара (product.productid)';
	comment on column dim_products.name is 'Наименование товара (product.description)';
	comment on column dim_products.category_id is 'Код категории в базе Front (external_id категории, product.categoryid)';
	comment on column dim_products.range_id is 'Код единицы измерения в базе Front (external_id единицы, product.sizeid)';
	comment on column dim_products.kind is 'Вид позиции (product.flaging): 1 блюдо, 2 ингредиент';
	comment on column dim_products.date_add is 'Дата добавления записи';


	-- Типы документов
	create sequence seq_dim_document_types;

	create table dim_document_types
	(
		id bigint primary key default nextval('public.seq_dim_document_types'),
		external_id bigint,
		name text,
		parent_id bigint,
		parent_name text,
		date_add timestamp default now()
	);

	comment on table dim_document_types is 'Ресурсы: типы документов (источник: front, таблицы bm_journaltypedocuments и bm_journaltype)';
	comment on column dim_document_types.id is 'Внутренний код';
	comment on column dim_document_types.external_id is 'Код в базе Front (bm_journaltypedocuments.id)';
	comment on column dim_document_types.name is 'Название типа документа (bm_journaltypedocuments.description)';
	comment on column dim_document_types.parent_id is 'Код вида журнала в базе Front (bm_journaltype.id)';
	comment on column dim_document_types.parent_name is 'Название вида журнала (bm_journaltype.journalname)';
	comment on column dim_document_types.date_add is 'Дата добавления записи';


	------ 2. Продажа товара

	-- типы операций журнала
	create sequence seq_dim_operation_types;

	create table dim_operation_types
	(
		id bigint primary key default nextval('public.seq_dim_operation_types'),
		external_id bigint,
		name text,
		group_id bigint,
		group_type text,
		date_add timestamp default now()
	);

	comment on table dim_operation_types is 'Ресурсы: типы операций журнала (источник: front, таблица transtype)';
	comment on column dim_operation_types.id is 'Внутренний код';
	comment on column dim_operation_types.external_id is 'Код в базе Front (transtype.transtypeid)';
	comment on column dim_operation_types.name is 'Название типа операции (transtype.description), у части записей пусто';
	comment on column dim_operation_types.group_id is 'Код группы операций (transtype.transgroupid), может быть пустым';
	comment on column dim_operation_types.group_type is 'Вид группы (transtype.previewgrouptype): POS, Cash, Inventory и др.';
	comment on column dim_operation_types.date_add is 'Дата добавления записи';


	------ 3. Работа персонала

	-- Сотрудники
	create sequence seq_dim_personnel;

	create table dim_personnel
	(
		id bigint primary key default nextval('public.seq_dim_personnel'),
		external_id bigint,
		name text,
		parent_id bigint,
		date_add timestamp default now()
	);

	comment on table dim_personnel is 'Ресурсы: сотрудники и учётные записи касс (источник: front, таблица personnel)';
	comment on column dim_personnel.id is 'Внутренний код';
	comment on column dim_personnel.external_id is 'Код в базе Front (personnel.personid)';
	comment on column dim_personnel.name is 'Фамилия и имя сотрудника (personnel.lastname, personnel.firstname)';
	comment on column dim_personnel.parent_id is 'Код уровня доступа в базе Front (securityaccess.securityaccessid)';
	comment on column dim_personnel.date_add is 'Дата добавления записи';


	-- Права
	create sequence seq_dim_security_objects;

	create table dim_security_objects
	(
		id bigint primary key default nextval('public.seq_dim_security_objects'),
		external_id bigint,
		name text,
		code text,
		group_name text,
		system_name text,
		date_add timestamp default now()
	);

	comment on table dim_security_objects is 'Ресурсы: права доступа, объекты безопасности (источник: front, таблица bm_securityobjects)';
	comment on column dim_security_objects.id is 'Внутренний код';
	comment on column dim_security_objects.external_id is 'Код в базе Front (bm_securityobjects.id)';
	comment on column dim_security_objects.name is 'Название права (bm_securityobjects.description)';
	comment on column dim_security_objects.code is 'Имя объекта (bm_securityobjects.objectname)';
	comment on column dim_security_objects.group_name is 'Группа прав (bm_securityobjects.securitygroup)';
	comment on column dim_security_objects.system_name is 'Система (bm_securityobjects.parentsystem): Manager или Front';
	comment on column dim_security_objects.date_add is 'Дата добавления записи';


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