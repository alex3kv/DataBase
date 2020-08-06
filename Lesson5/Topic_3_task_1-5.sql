-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

DESC users;
SELECT * FROM users LIMIT 10;
UPDATE users u SET u.created_at = NOW(), u.updated_at = NOW();

-- 2. Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время 
--    помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.

ALTER TABLE users ADD COLUMN created_at_new DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки';
ALTER TABLE users ADD COLUMN updated_at_new DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки';

UPDATE users u SET u.created_at_new = STR_TO_DATE(u.created_at,'%d.%m.%Y %h:%i'), u.updated_at_new = STR_TO_DATE(u.updated_at,'%d.%m.%Y %h:%i');

ALTER TABLE users DROP COLUMN created_at;
ALTER TABLE users DROP COLUMN updated_at;

ALTER TABLE users RENAME COLUMN created_at_new TO created_at;
ALTER TABLE users RENAME COLUMN updated_at_new TO updated_at;

DESC users;
SELECT * FROM users LIMIT 10;

-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, 
--    если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
--    Однако нулевые запасы должны выводиться в конце, после всех записей.

INSERT INTO storehouses_products (`value`) VALUES (1), (100), (0), (4), (3), (20);
SELECT * FROM storehouses_products ORDER BY Value = 0, Value;


-- 4. Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august)

ALTER TABLE users ADD COLUMN birthday_month varchar(10) DEFAULT 'january' COMMENT 'Месяц рождения';
DESC users;
SELECT * FROM users LIMIT 10;
UPDATE users u SET  u.birthday_month = 'may' WHERE u.id IN (3,8,15,20);
UPDATE users u SET  u.birthday_month = 'august' WHERE u.id IN (5,9,18,24);

SELECT * FROM users u WHERE u.birthday_month IN ('may', 'august');

SELECT *  FROM profiles p  WHERE DATE_FORMAT(p.birthday, '%M') IN ('may', 'august');

-- 5. Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name varchar(255),  
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Каталог товаров';

INSERT INTO catalogs (`name`) VALUES
  ('Процессоры'),
  ('Материнские платы'),
  ('Видеокарты'),
  ('Жесткие диски'),
  ('Оперативная память');

SELECT * FROM catalogs c LIMIT 10;

SELECT * FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);