-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
  id int UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  `from` varchar(255) COMMENT 'Город вылета',
  `to` varchar(255) COMMENT 'Город назначения'
);

INSERT INTO flights
  VALUES (NULL, 'moscow', 'omsk'),
  (NULL, 'novgorod', 'kazan'),
  (NULL, 'irkutsk', 'moscow'),
  (NULL, 'omsk', 'irkutsk'),
  (NULL, 'moscow', 'kazan');

DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  label varchar(255) COMMENT 'Ключ города',
  name varchar(255) COMMENT 'Наименование города'
);

INSERT INTO cities
  VALUES ('moscow', 'Москва'),
  ('irkutsk', 'Иркутск'),
  ('novgorod', 'Новгород'),
  ('kazan', 'Казань'),
  ('omsk', 'Омск');


SELECT
  CONCAT(fc.name," (",f.`from`,")") AS 'from',
  CONCAT(tc.name," (",f.`to`,")") AS 'to'  
FROM flights f
  JOIN cities fc
    ON fc.label = f.`from`
  JOIN cities tc
    ON tc.label = f.`to`