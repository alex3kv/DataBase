-- Практическое задание по теме “Оптимизация запросов”

-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs 
-- помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  id bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  created datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'время и дата создания записи',
  entity_type varchar(255) NOT NULL DEFAULT '' COMMENT 'название таблицы',
  entity_id bigint NOT NULL COMMENT 'идентификатор первичного ключа',
  value varchar(255) DEFAULT NULL COMMENT 'содержимое поля name',
  PRIMARY KEY (id)
)
ENGINE = ARCHIVE,
COMMENT = 'Логирование операций вставки';



DELIMITER $$

-- тригер для таблицы users
DROP TRIGGER IF EXISTS users_after_insert$$
CREATE TRIGGER users_after_insert
AFTER INSERT
ON users
FOR EACH ROW
BEGIN
  INSERT INTO logs (entity_type, entity_id, value)
    VALUES ('users', NEW.id, NEW.name);
END
$$

-- тригер для таблицы catalogs
DROP TRIGGER IF EXISTS catalogs_after_insert$$
CREATE TRIGGER catalogs_after_insert
AFTER INSERT
ON catalogs
FOR EACH ROW
BEGIN
  INSERT INTO logs (entity_type, entity_id, value)
    VALUES ('catalogs', NEW.id, NEW.name);
END
$$

-- тригер для таблицы catalogs
DROP TRIGGER IF EXISTS products_after_insert$$
CREATE TRIGGER products_after_insert
AFTER INSERT
ON products
FOR EACH ROW
BEGIN
  INSERT INTO logs (entity_type, entity_id, value)
    VALUES ('products', NEW.id, NEW.name);
END
$$

DELIMITER ;

INSERT INTO users (name, birthday_at)
  VALUES ('Test', '2000-05-14');
INSERT INTO catalogs
  VALUES (NULL, 'Клавиатуры');
INSERT INTO products (name, description, price, catalog_id)
  VALUES ('Intel Core i7-9100', 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.', 12890.00, 1);

SELECT
  *
FROM logs l;

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER $$

DROP PROCEDURE IF EXISTS dowhile$$
CREATE PROCEDURE dowhile ()
BEGIN
  DECLARE v int DEFAULT 0;
  WHILE v < 1000000 DO
    INSERT INTO users (name, birthday_at)
      VALUES (v, current_timestamp);
    SET v = v + 1;
  END WHILE;
END
$$

DELIMITER ;

CALL dowhile();