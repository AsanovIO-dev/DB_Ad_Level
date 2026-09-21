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
    value      text,
    unit       text
);



INSERT INTO positions (code, name) VALUES (1, 'Метеоролог');
INSERT INTO positions (code, name) VALUES (2, 'Оператор метеопоста');
INSERT INTO positions (code, name) VALUES (3, 'Начальник метеопоста');

INSERT INTO equipment_types (code, name) VALUES (1, 'ДМК (десантный метео комплект)');
INSERT INTO equipment_types (code, name) VALUES (2, 'ВР (ветровое ружьё)');

INSERT INTO users (code, full_name, position_code) VALUES (1, 'Иванов Иван Иванович', 1);
INSERT INTO users (code, full_name, position_code) VALUES (2, 'Петров Пётр Петрович', 2);
INSERT INTO users (code, full_name, position_code) VALUES (3, 'Александров Александр Александрович', 3);

INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (1, 'Пачка замеров №1', 1, 1);
INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (2, 'Пачка замеров №2', 2, 2);
INSERT INTO batches (code, name, user_code, equipment_type_code) VALUES (3, 'Пачка замеров №3', 3, 1);

INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (1, 1, 'Высота метеопоста', '100', 'м');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (2, 1, 'Температура', '25.0', '°C');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (3, 1, 'Давление', '765', 'мм рт. ст.');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (4, 1, 'Направление ветра', '15', 'больш. дел. угломера');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (5, 1, 'Скорость ветра', '6', 'м/с');

INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (6, 2, 'Высота метеопоста', '60', 'м');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (7, 2, 'Температура', '-5.5', '°C');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (8, 2, 'Давление', '743', 'мм рт. ст.');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (9, 2, 'Направление ветра', '07', 'больш. дел. угломера');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (10, 2, 'Дальность сноса пуль', '40', 'м');

INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (11, 3, 'Высота метеопоста', '100', 'м');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (12, 3, 'Температура', '15.0', '°C');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (13, 3, 'Давление', '750', 'мм рт. ст.');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (14, 3, 'Направление ветра', '00', 'больш. дел. угломера');
INSERT INTO parameters (code, batch_code, name, value, unit) VALUES (15, 3, 'Скорость ветра', '0', 'м/с');



SELECT
    u.full_name     AS employee,
    p.name          AS position_name,
    b.name          AS batch_name,
    et.name         AS equipment_type,
    par.name        AS parameter_name,
    par.value       AS parameter_value,
    par.unit        AS parameter_unit
FROM users u
JOIN positions p
    ON p.code = u.position_code
JOIN batches b
    ON b.user_code = u.code
JOIN equipment_types et
    ON et.code = b.equipment_type_code
JOIN parameters par
    ON par.batch_code = b.code
ORDER BY b.code, par.code;
