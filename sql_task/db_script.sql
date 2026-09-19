DROP TABLE IF EXISTS parameters;
DROP TABLE IF EXISTS batches;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS positions;
DROP TABLE IF EXISTS equipment_types;


CREATE TABLE positions
(
    code int PRIMARY KEY,
    name text
);
 
CREATE TABLE equipment_types
(
    code int PRIMARY KEY,
    name text
);
 
CREATE TABLE users
(
    code          int PRIMARY KEY,
    full_name     text,
    position_code int
);
 
CREATE TABLE batches
(
    code                 int PRIMARY KEY,
    name                 text,
    user_code            int,
    equipment_type_code  int
);
 
CREATE TABLE parameters
(
    code       int PRIMARY KEY,
    batch_code int,
    name       text,
    value      text
);


INSERT INTO positions (code, name) VALUES (1, 'Инженер');
INSERT INTO positions (code, name) VALUES (2, 'Техник');
INSERT INTO positions (code, name) VALUES (3, 'Руководитель отдела');
 
INSERT INTO equipment_types (code, name) VALUES (1, 'Сервер');
INSERT INTO equipment_types (code, name) VALUES (2, 'Сетевой коммутатор');
INSERT INTO equipment_types (code, name) VALUES (3, 'Рабочая станция');
 
INSERT INTO users (code, full_name, position_code) VALUES (1, 'Иванов Иван Иванович', 1);
INSERT INTO users (code, full_name, position_code) VALUES (2, 'Петров Пётр Петрович', 2);
INSERT INTO users (code, full_name, position_code) VALUES (3, 'Александров Александр Александрович', 3);
 
INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (1, 'Пачка серверов А', 1, 1);
INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (2, 'Пачка коммутаторов Б', 2, 2);
INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (3, 'Пачка рабочих станций В', 3, 3);
 
INSERT INTO parameters (code, batch_code, name, value) VALUES (1, 1, 'Объём ОЗУ', '64GB');
INSERT INTO parameters (code, batch_code, name, value) VALUES (2, 2, 'Количество портов', '48');
INSERT INTO parameters (code, batch_code, name, value) VALUES (3, 3, 'Диагональ монитора', '24 дюйма');


SELECT
	u.full_name AS employee,	
	p.name AS position,
	b.name AS batche,
	et.name AS equipment_type,
    par.name AS parameter,
    par.value AS parameter_value
FROM users u
JOIN positions p 
	ON p.code = u.position_code 
