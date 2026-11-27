do $$
begin
	------ 1. Закупка продукции

	-- Единицы измерения
	delete from dim_ranges;
	insert into dim_ranges(external_id, name, factor ) values (1,'порция',1.000);
	insert into dim_ranges(external_id, name, factor ) values (2,'100г',100.000);
	insert into dim_ranges(external_id, name, factor ) values (3,'Бут.500мл.',500.000);
	insert into dim_ranges(external_id, name, factor ) values (4,'50 мл',50.000);
	insert into dim_ranges(external_id, name, factor ) values (5,'1 день',1.000);
	insert into dim_ranges(external_id, name, factor ) values (6,'г',1.000);
	insert into dim_ranges(external_id, name, factor ) values (7,'мл',1.000);
	insert into dim_ranges(external_id, name, factor ) values (8,'300мл',300.000);
	insert into dim_ranges(external_id, name, factor ) values (9,'50мл',50.000);
	insert into dim_ranges(external_id, name, factor ) values (10,'200г',200.000);
	insert into dim_ranges(external_id, name, factor ) values (11,'SNG',1.000);
	insert into dim_ranges(external_id, name, factor ) values (12,'Бут.330мл',330.000);
	insert into dim_ranges(external_id, name, factor ) values (13,'20г',20.000);
	insert into dim_ranges(external_id, name, factor ) values (14,'40г',40.000);
	insert into dim_ranges(external_id, name, factor ) values (15,'150г',150.000);
	insert into dim_ranges(external_id, name, factor ) values (16,'190г',190.000);
	insert into dim_ranges(external_id, name, factor ) values (17,'180г',180.000);
	insert into dim_ranges(external_id, name, factor ) values (18,'30г',30.000);
	insert into dim_ranges(external_id, name, factor ) values (19,'Бут.250мл',250.000);
	insert into dim_ranges(external_id, name, factor ) values (20,'Ч400мл',400.000);
	insert into dim_ranges(external_id, name, factor ) values (21,'пачка',1.000);
	insert into dim_ranges(external_id, name, factor ) values (22,'30Л',30000.000);
	insert into dim_ranges(external_id, name, factor ) values (23,'10мл',1.000);
	insert into dim_ranges(external_id, name, factor ) values (24,'Бут.750мл.',750.000);
	insert into dim_ranges(external_id, name, factor ) values (25,'Бут.350мл',350.000);
	insert into dim_ranges(external_id, name, factor ) values (26,'10г',10.000);
	insert into dim_ranges(external_id, name, factor ) values (27,'350мл',200.000);
	insert into dim_ranges(external_id, name, factor ) values (28,'140г',140.000);
	insert into dim_ranges(external_id, name, factor ) values (29,'500мл',500.000);
	insert into dim_ranges(external_id, name, factor ) values (30,'280мл',280.000);
	insert into dim_ranges(external_id, name, factor ) values (31,'120 мл',120.000);
	insert into dim_ranges(external_id, name, factor ) values (32,'250мл',250.000);
	insert into dim_ranges(external_id, name, factor ) values (33,'340мл',340.000);
	insert into dim_ranges(external_id, name, factor ) values (34,'185мл',185.000);
	insert into dim_ranges(external_id, name, factor ) values (35,'75мл',75.000);
	insert into dim_ranges(external_id, name, factor ) values (36,'60мл',60.000);
	insert into dim_ranges(external_id, name, factor ) values (37,'80мл',80.000);
	insert into dim_ranges(external_id, name, factor ) values (38,'310мл',310.000);
	insert into dim_ranges(external_id, name, factor ) values (39,'литр',1000.000);
	insert into dim_ranges(external_id, name, factor ) values (40,'1000 г',1000.000);
	insert into dim_ranges(external_id, name, factor ) values (41,'50 г',50.000);
	insert into dim_ranges(external_id, name, factor ) values (42,'кг',1000.000);
	insert into dim_ranges(external_id, name, factor ) values (43,'Бут.700мл',700.000);
	insert into dim_ranges(external_id, name, factor ) values (44,'Бут.600мл',600.000);
	insert into dim_ranges(external_id, name, factor ) values (45,'0,5 литра',500.000);
	insert into dim_ranges(external_id, name, factor ) values (46,'0,3 литра',300.000);
	insert into dim_ranges(external_id, name, factor ) values (47,'200мл',1.000);
	insert into dim_ranges(external_id, name, factor ) values (48,'150  мл',1.000);
	insert into dim_ranges(external_id, name, factor ) values (49,'150мл',150.000);
	insert into dim_ranges(external_id, name, factor ) values (50,'пакет',1.000);
	insert into dim_ranges(external_id, name, factor ) values (51,'5л',5000.000);
	insert into dim_ranges(external_id, name, factor ) values (52,'850г',850.000);
	insert into dim_ranges(external_id, name, factor ) values (53,'500г',500.000);
	insert into dim_ranges(external_id, name, factor ) values (54,'550г',550.000);
	insert into dim_ranges(external_id, name, factor ) values (55,'570г',570.000);
	insert into dim_ranges(external_id, name, factor ) values (56,'400г',400.000);
	insert into dim_ranges(external_id, name, factor ) values (57,'250г',250.000);
	insert into dim_ranges(external_id, name, factor ) values (58,'160г',160.000);
	insert into dim_ranges(external_id, name, factor ) values (59,'48г',48.000);
	insert into dim_ranges(external_id, name, factor ) values (60,'90г',90.000);


	-- Категории
	delete from dim_categories;
	insert into dim_categories(external_id, name, parent_id) values (373,'Бонусы',null);
	insert into dim_categories(external_id, name, parent_id) values (147,'Меню доставка',null);
	insert into dim_categories(external_id, name, parent_id) values (148,'Меню кафе',null);
	insert into dim_categories(external_id, name, parent_id) values (358,'Проживание',null);
	insert into dim_categories(external_id, name, parent_id) values (149,'Склад',null);
	insert into dim_categories(external_id, name, parent_id) values (372,'Аренда',147);
	insert into dim_categories(external_id, name, parent_id) values (366,'Бизнес ланч (доставка)',147);
	insert into dim_categories(external_id, name, parent_id) values (175,'Блины Бурито Бургеры',147);
	insert into dim_categories(external_id, name, parent_id) values (176,'Гарниры',147);
	insert into dim_categories(external_id, name, parent_id) values (181,'Десерты',147);
	insert into dim_categories(external_id, name, parent_id) values (182,'Дополнительные начинки',147);
	insert into dim_categories(external_id, name, parent_id) values (197,'Доставка',147);
	insert into dim_categories(external_id, name, parent_id) values (359,'Комбо наборы',147);
	insert into dim_categories(external_id, name, parent_id) values (173,'Ланч боксы',147);
	insert into dim_categories(external_id, name, parent_id) values (325,'Мод. кухня',147);
	insert into dim_categories(external_id, name, parent_id) values (177,'Мясо',147);
	insert into dim_categories(external_id, name, parent_id) values (186,'Напитки',147);
	insert into dim_categories(external_id, name, parent_id) values (249,'Напитки 1',147);
	insert into dim_categories(external_id, name, parent_id) values (357,'Паста',147);
	insert into dim_categories(external_id, name, parent_id) values (183,'Пиво',147);
	insert into dim_categories(external_id, name, parent_id) values (174,'Пироги',147);
	insert into dim_categories(external_id, name, parent_id) values (150,'Пицца',147);
	insert into dim_categories(external_id, name, parent_id) values (180,'Пицца в конусе',147);
	insert into dim_categories(external_id, name, parent_id) values (172,'Салаты',147);
	insert into dim_categories(external_id, name, parent_id) values (329,'Сендвичи',147);
	insert into dim_categories(external_id, name, parent_id) values (178,'Соусы',147);
	insert into dim_categories(external_id, name, parent_id) values (179,'Сырные палочки',147);
	insert into dim_categories(external_id, name, parent_id) values (233,'Японика',147);
	insert into dim_categories(external_id, name, parent_id) values (210,'2-е мясные блюда',148);
	insert into dim_categories(external_id, name, parent_id) values (344,'Банкетное меню',148);
	insert into dim_categories(external_id, name, parent_id) values (228,'Блины',148);
	insert into dim_categories(external_id, name, parent_id) values (213,'Бургеры',148);
	insert into dim_categories(external_id, name, parent_id) values (222,'Буррито',148);
	insert into dim_categories(external_id, name, parent_id) values (209,'Гарниры',148);
	insert into dim_categories(external_id, name, parent_id) values (214,'Десерты',148);
	insert into dim_categories(external_id, name, parent_id) values (221,'Конус пицца',148);
	insert into dim_categories(external_id, name, parent_id) values (217,'Кофе',148);
	insert into dim_categories(external_id, name, parent_id) values (230,'Ланч боксы',148);
	insert into dim_categories(external_id, name, parent_id) values (215,'Напитки',148);
	insert into dim_categories(external_id, name, parent_id) values (216,'Пиво',148);


	-- Поставщики
	delete from dim_vendors;
	insert into dim_vendors(external_id, name, parent_id) values (91,'Габур',31);
	insert into dim_vendors(external_id, name, parent_id) values (92,'Столярская',31);
	insert into dim_vendors(external_id, name, parent_id) values (93,'Столярская',31);
	insert into dim_vendors(external_id, name, parent_id) values (94,'5 Армия',31);
	insert into dim_vendors(external_id, name, parent_id) values (95,'Вираж',31);
	insert into dim_vendors(external_id, name, parent_id) values (96,'Пепсико',31);
	insert into dim_vendors(external_id, name, parent_id) values (97,'Авангард',31);
	insert into dim_vendors(external_id, name, parent_id) values (98,'Молочные продукты',31);
	insert into dim_vendors(external_id, name, parent_id) values (99,'Лидер',31);
	insert into dim_vendors(external_id, name, parent_id) values (100,'Консерватор (Захаров)',31);
	insert into dim_vendors(external_id, name, parent_id) values (101,'Рузавина',31);
	insert into dim_vendors(external_id, name, parent_id) values (102,'Кока- кола',31);
	insert into dim_vendors(external_id, name, parent_id) values (103,'Алида',31);
	insert into dim_vendors(external_id, name, parent_id) values (104,'Упак торг',31);
	insert into dim_vendors(external_id, name, parent_id) values (105,'Элит Трейд',31);
	insert into dim_vendors(external_id, name, parent_id) values (106,'ПЭТ Бутылка',31);
	insert into dim_vendors(external_id, name, parent_id) values (107,'Овощи',31);
	insert into dim_vendors(external_id, name, parent_id) values (108,'Покупка в розницу',31);
	insert into dim_vendors(external_id, name, parent_id) values (109,'СБС',31);
	insert into dim_vendors(external_id, name, parent_id) values (110,'Кладовы',31);
	insert into dim_vendors(external_id, name, parent_id) values (111,'СХ Белореченское',31);
	insert into dim_vendors(external_id, name, parent_id) values (112,'ООО МЕТРО',31);
	insert into dim_vendors(external_id, name, parent_id) values (113,'Мир специй',31);
	insert into dim_vendors(external_id, name, parent_id) values (114,'Клецко Д.А.',31);
	insert into dim_vendors(external_id, name, parent_id) values (115,'Сибирский холод',31);
	insert into dim_vendors(external_id, name, parent_id) values (116,'ИП Хухрянский',31);
	insert into dim_vendors(external_id, name, parent_id) values (117,'ООО "Сибирский холод"',31);
	insert into dim_vendors(external_id, name, parent_id) values (118,'Переработка',31);
	insert into dim_vendors(external_id, name, parent_id) values (119,'"Айвенго"',31);
	insert into dim_vendors(external_id, name, parent_id) values (120,'ИП Лятифов',31);
	insert into dim_vendors(external_id, name, parent_id) values (121,'ИП Усачев',31);
	insert into dim_vendors(external_id, name, parent_id) values (122,'Риконт',31);
	insert into dim_vendors(external_id, name, parent_id) values (123,'Лидер Мука',31);
	insert into dim_vendors(external_id, name, parent_id) values (124,'ООО "Индустрия"',31);
	insert into dim_vendors(external_id, name, parent_id) values (125,'Пивной мир',31);
	insert into dim_vendors(external_id, name, parent_id) values (126,'ООО "Балтбир"',31);
	insert into dim_vendors(external_id, name, parent_id) values (127,'Деликатес',31);
	insert into dim_vendors(external_id, name, parent_id) values (128,'Футурум',31);
	insert into dim_vendors(external_id, name, parent_id) values (129,'ЗПВ',31);
	insert into dim_vendors(external_id, name, parent_id) values (130,'ООО Торгсервис Кеги',31);
	insert into dim_vendors(external_id, name, parent_id) values (131,'ООО "Экспресс"',31);
	insert into dim_vendors(external_id, name, parent_id) values (132,'Гастроном',31);
	insert into dim_vendors(external_id, name, parent_id) values (133,'Выравнивание остатка',31);
	insert into dim_vendors(external_id, name, parent_id) values (134,'ИП Пыткин Э.А.',31);
	insert into dim_vendors(external_id, name, parent_id) values (196,'Конвертация Barnet',31);
	insert into dim_vendors(external_id, name, parent_id) values (197,'ИП Бельских А.Б.',31);
	insert into dim_vendors(external_id, name, parent_id) values (198,'ООО Партнер',31);
	insert into dim_vendors(external_id, name, parent_id) values (199,'ООО Торгсервис Иркутск',31);
	insert into dim_vendors(external_id, name, parent_id) values (200,'ООО "Элит Трейд"',31);
	insert into dim_vendors(external_id, name, parent_id) values (201,'ZEN  19',31);


	-- Товары
	delete from dim_products;
	insert into dim_products(external_id, code, name) values (4337,'1204073','Бананы');
	insert into dim_products(external_id, code, name) values (4338,'1640465','Киви');
	insert into dim_products(external_id, code, name) values (4339,'8042558','Лимоны');
	insert into dim_products(external_id, code, name) values (4340,'8984333','Капуста');
	insert into dim_products(external_id, code, name) values (4341,'7054405','Лук репчатый');
	insert into dim_products(external_id, code, name) values (4342,'3802444','Морковь');
	insert into dim_products(external_id, code, name) values (4343,'2118438','Огурец');
	insert into dim_products(external_id, code, name) values (4344,'7006552','Перец болгарский');
	insert into dim_products(external_id, code, name) values (4345,'1747804','Помидоры');
	insert into dim_products(external_id, code, name) values (4346,'8460383','Чеснок свежий');
	insert into dim_products(external_id, code, name) values (4347,'283836','Картофель');
	insert into dim_products(external_id, code, name) values (4348,'6633198','Ананас кус.');
	insert into dim_products(external_id, code, name) values (4349,'1196043','Джем');
	insert into dim_products(external_id, code, name) values (4350,'35425','Клубника');
	insert into dim_products(external_id, code, name) values (4351,'3361756','Персик');
	insert into dim_products(external_id, code, name) values (4352,'4356031','Кукуруза');
	insert into dim_products(external_id, code, name) values (4353,'7358337','Перец Халапеньо');
	insert into dim_products(external_id, code, name) values (4354,'3618497','Огурцы маринованные');
	insert into dim_products(external_id, code, name) values (4355,'5286475','Маслины без кости');
	insert into dim_products(external_id, code, name) values (4356,'1669088','Шампиньоны рез.');
	insert into dim_products(external_id, code, name) values (4357,'6382248','Опята маринованые');
	insert into dim_products(external_id, code, name) values (4358,'6692734','Фасоль красная');
	insert into dim_products(external_id, code, name) values (4359,'6767384','Шпроты в масле');
	insert into dim_products(external_id, code, name) values (4360,'9123848','Морской коктейль');
	insert into dim_products(external_id, code, name) values (4361,'8382862','Креветки');
	insert into dim_products(external_id, code, name) values (4362,'6594869','Мидии очищен.');
	insert into dim_products(external_id, code, name) values (4363,'8465893','Крабовые палочки');
	insert into dim_products(external_id, code, name) values (4364,'3142350','Филе горбуши');
	insert into dim_products(external_id, code, name) values (4365,'8851029','Ветчина');
	insert into dim_products(external_id, code, name) values (4366,'2046527','Пепперони');
	insert into dim_products(external_id, code, name) values (4367,'2629782','Карбонад');
	insert into dim_products(external_id, code, name) values (4368,'1137721','Грудинка (Бекон)');
	insert into dim_products(external_id, code, name) values (4369,'5134303','Сосиски молочные в/с с/о');
	insert into dim_products(external_id, code, name) values (4370,'8998805','Сосиски молочные 1 сорт');
	insert into dim_products(external_id, code, name) values (4371,'8851942','Сардельки');
	insert into dim_products(external_id, code, name) values (4372,'3404932','Колбаски охотничьи');
	insert into dim_products(external_id, code, name) values (4373,'3689765','Голень куриная маринов.');
	insert into dim_products(external_id, code, name) values (4374,'8295254','Шашлык куриный маринов.');
	insert into dim_products(external_id, code, name) values (4375,'5564472','Крылья куриные маринов.');
	insert into dim_products(external_id, code, name) values (4376,'8439627','Филе куриное маринов.');
	insert into dim_products(external_id, code, name) values (4377,'2493638','Фарш домашний с/м');
	insert into dim_products(external_id, code, name) values (4378,'959947','Котлета с/г с/м для гамбургеров');
	insert into dim_products(external_id, code, name) values (4379,'6998823','Картофель фри');
	insert into dim_products(external_id, code, name) values (4380,'1561668','Картофель дольки');
	insert into dim_products(external_id, code, name) values (4381,'4083231','Булочка для гамбургера 100мм');
	insert into dim_products(external_id, code, name) values (4382,'8725423','Соус Хайнц чесночный');
	insert into dim_products(external_id, code, name) values (4383,'5801451','Соус Хайнц томатный');
	insert into dim_products(external_id, code, name) values (4384,'5032142','Нагетсы куриные с/м');
	insert into dim_products(external_id, code, name) values (4385,'9816268','Лепешка мексиканская');
	insert into dim_products(external_id, code, name) values (4386,'6279474','Тесто слоеное с/м');



	-------- 2. Продажа товара

	-- типы оплаты
	insert into dim_payment_types(external_id, name) values (211,'Наличные');
    insert into dim_payment_types(external_id, name) values (212,'USD');
    insert into dim_payment_types(external_id, name) values (213,'Мастер карта');
    insert into dim_payment_types(external_id, name) values (214,'Карта клиента');
    insert into dim_payment_types(external_id, name) values (216,'Безнал');
    insert into dim_payment_types(external_id, name) values (217,'AMEX');
    insert into dim_payment_types(external_id, name) values (218,'Сдача');
    insert into dim_payment_types(external_id, name) values (220,'Талон');
    insert into dim_payment_types(external_id, name) values (226,'Безнал');
    insert into dim_payment_types(external_id, name) values (227,'Корректировка');
    insert into dim_payment_types(external_id, name) values (250,'Безнал');
    insert into dim_payment_types(external_id, name) values (251,'GIFT CARD');
    insert into dim_payment_types(external_id, name) values (261,'Интернет магазин');
    insert into dim_payment_types(external_id, name) values (263,'PRE-MASTER');
    insert into dim_payment_types(external_id, name) values (264,'PRE-AMEX');
    insert into dim_payment_types(external_id, name) values (266,'PRE-VISA');

	-------- 3. Работа персонала

	-- сотрудники
	delete from dim_personnel;
	insert into dim_personnel(external_id, name) values (897,'Администратор Barnet');
	insert into dim_personnel(external_id, name) values (898,'Безик Татьяна');
	insert into dim_personnel(external_id, name) values (899,'Шипицына Ольга');
	insert into dim_personnel(external_id, name) values (900,'Пакалюк Мария');
	insert into dim_personnel(external_id, name) values (901,'Скубало Кристина');
	insert into dim_personnel(external_id, name) values (902,'Кустикова Татьяна');
	insert into dim_personnel(external_id, name) values (903,'Нагорная Анна');
	insert into dim_personnel(external_id, name) values (904,'Кафе 1 Касса 1');
	insert into dim_personnel(external_id, name) values (905,'Кафе 2 Касса 2');
	insert into dim_personnel(external_id, name) values (906,'Доставка Доставка');
	insert into dim_personnel(external_id, name) values (907,'Услуги гостиниц Услуги гостиниц');
	insert into dim_personnel(external_id, name) values (969,'Кушавина Алена');
	insert into dim_personnel(external_id, name) values (970,'Макаренко Татьяна');
	insert into dim_personnel(external_id, name) values (971,'Васильева Валентина');
	insert into dim_personnel(external_id, name) values (972,'Черная Наталья');
	insert into dim_personnel(external_id, name) values (973,'Никулин Александр');
	insert into dim_personnel(external_id, name) values (974,'Быстрова Татьяна');
	insert into dim_personnel(external_id, name) values (975,'Берг Яна');
	insert into dim_personnel(external_id, name) values (976,'Черная Карина');
	insert into dim_personnel(external_id, name) values (977,'Семенова Алина');
	insert into dim_personnel(external_id, name) values (978,'Шведова Анастасия');
	insert into dim_personnel(external_id, name) values (979,'Пионова Мария');
	insert into dim_personnel(external_id, name) values (980,'Болгарова Ксения');
	insert into dim_personnel(external_id, name) values (981,'Смирнова Ирина');
	insert into dim_personnel(external_id, name) values (982,'Шевченко Елена');
	insert into dim_personnel(external_id, name) values (983,'Чернобай Юлия');
	insert into dim_personnel(external_id, name) values (984,'Ражавикин Андрей');
	insert into dim_personnel(external_id, name) values (985,'Майборский Антон');
	insert into dim_personnel(external_id, name) values (986,'Англичанова Анастасия');
	insert into dim_personnel(external_id, name) values (987,'Семенова Алина');
	insert into dim_personnel(external_id, name) values (988,'Медведева Валерия');
	insert into dim_personnel(external_id, name) values (989,'Кульпинская Ирина');
	insert into dim_personnel(external_id, name) values (990,'Горбатенко Кристина');
	insert into dim_personnel(external_id, name) values (991,'Шибаева Елена');
	insert into dim_personnel(external_id, name) values (992,'Крицкая Алена');
	insert into dim_personnel(external_id, name) values (993,'Черных Дмитрий');
	insert into dim_personnel(external_id, name) values (994,'Модина Александра');
	insert into dim_personnel(external_id, name) values (995,'Плотникова Александра');
	insert into dim_personnel(external_id, name) values (996,'Кротова Наталья');
	insert into dim_personnel(external_id, name) values (997,'Пьянкова Злата');
	insert into dim_personnel(external_id, name) values (998,'Безик Татьяна');
	insert into dim_personnel(external_id, name) values (999,'Станиславская Александра');
	insert into dim_personnel(external_id, name) values (1000,'Свешникова Дарья');
	insert into dim_personnel(external_id, name) values (1001,'Писарева Вероника');
	insert into dim_personnel(external_id, name) values (1002,'Губанова Анастасия');
	insert into dim_personnel(external_id, name) values (1003,'Баженова Диана');
	insert into dim_personnel(external_id, name) values (1004,'Емельянов Максим');
	insert into dim_personnel(external_id, name) values (1005,'Пимкин Денис');
	insert into dim_personnel(external_id, name) values (1006,'Смолина Вероника');
	insert into dim_personnel(external_id, name) values (1007,'Гострик Ольга');


	-------- 4. Остатки

	-- склады
	delete from dim_storages;
	insert into dim_storages(external_id, name) values (41,'Склад');


	-- типы складских операций
	delete from dim_storage_operation_types;
	insert into dim_storage_operation_types(external_id, name, factor) values (1,'Поступление',1);
	insert into dim_storage_operation_types(external_id, name, factor) values (2,'Списание',-1);
	insert into dim_storage_operation_types(external_id, name, factor) values (3,'Инвентаризация',1);
	insert into dim_storage_operation_types(external_id, name, factor) values (4,'Перемещение',1);
	insert into dim_storage_operation_types(external_id, name, factor) values (5,'Возврат',1);


	-- причины списания
	delete from dim_write_off_reasons;
	insert into dim_write_off_reasons(external_id, name, parent_id) values (156,'',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (180,'',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (126,'ZEN 19',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (134,'ZEN 33',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (27,'Банкет Солдатовых',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (103,'Внесение в кассу',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (100,'Выдача из кассы',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (64,'Дигустация',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (23,'На приготовление обедов',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (141,'Отходы',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (26,'Переработка',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (1,'Порча продукта',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (7,'Сотрудникам по заработную плату',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (173,'Срок годности',null);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (22,'Отходы производства',1);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (139,'Алентьева (Миронова) Лида',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (121,'Берг Яна',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (206,'Бычинская Кристина',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (38,'Васильева Валентина',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (198,'Дьяченко Тоня',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (16,'Запорожская Е.В',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (138,'КУРЬЕР',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (122,'Лукьянов В.В.',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (132,'Лукьянова Анастасия ',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (154,'Морозова Анна',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (164,'Попова Галина',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (208,'Путина Екатерина',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (193,'Смирнова Наталья',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (157,'Тхагапсова ТВ',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (207,'Чирикова Елизавета',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (205,'Яременко Софья',7);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (107,'Арендные',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (101,'Выдача аванса',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (102,'Выдача з/п',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (113,'З/п курьерам',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (114,'Корректировка',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (108,'На ресепшн',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (111,'Поставщики',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (115,'Прочее',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (110,'Размен касса 2',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (112,'Размен курьерам',100);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (105,'Арендные',103);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (109,'Барка',103);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (116,'Корректировка',103);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (136,'Предоплата за банкет',103);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (117,'Прочее',103);
	insert into dim_write_off_reasons(external_id, name, parent_id) values (104,'Размен',103);

end
$$;
