-- Практическое задание по теме “Хранимые процедуры и функции, триггеры"

-- 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать
--  фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER $$

DROP FUNCTION IF EXISTS hello$$
CREATE FUNCTION hello ()
RETURNS text
DETERMINISTIC
BEGIN
  DECLARE ctime time DEFAULT CURRENT_TIME();

  IF ctime BETWEEN '06:00:00' AND '12:00:00' THEN
    RETURN 'Доброе утро';
  ELSEIF ctime BETWEEN '12:00:00' AND '18:00:00' THEN
    RETURN 'Добрый день';
  ELSEIF ctime BETWEEN '18:00:00' AND '00:00:00' THEN
    RETURN 'Добрый вечер';
  ELSEIF ctime BETWEEN '00:00:00' AND '06:00:00' THEN
    RETURN 'Доброй ночи';
  ELSE
    RETURN 'Интервал не распознан';
  END IF;
END
$$

DELIMITER ;

SELECT
  hello();

-- 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. 
-- Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
-- При попытке присвоить полям NULL-значение необходимо отменить операцию.


DELIMITER $$

DROP TRIGGER IF EXISTS products_insert$$
CREATE TRIGGER products_insert
BEFORE INSERT
ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.desription IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля name и desription одновремнно не могут быть null';
  END IF;
END
$$

DELIMITER ;

DELIMITER $$

DROP TRIGGER IF EXISTS products_update$$
CREATE TRIGGER products_update
BEFORE UPDATE
ON products FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.desription IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля name и desription одновремнно не могут быть null';
  END IF;
END
$$

DELIMITER ;

INSERT INTO products (name, desription, price, catalog_id, created_at, updated_at)
  VALUES (NULL, NULL, 0, 1, NOW(), NOW());

-- 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. Числами Фибоначчи называется последовательность в которой число 
-- равно сумме двух предыдущих чисел. Вызов функции FIBONACCI(10) должен возвращать число 55.