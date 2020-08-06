-- 1. Подсчитайте средний возраст пользователей в таблице users.

SELECT DATE_FORMAT(NOW(), '%Y') - ROUND(AVG(DATE_FORMAT(p.birthday, '%Y')), 2) "Средний возраст" FROM profiles p;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT * FROM profiles p LIMIT 10;

-- SELECT CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday)) AS day, COUNT(*) AS total FROM profiles GROUP BY day ORDER BY total DESC;
-- SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))) AS day, COUNT(*) AS total FROM profiles GROUP BY day ORDER BY total DESC;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day, COUNT(*) AS total FROM profiles GROUP BY day ORDER BY total DESC;

-- 3. Подсчитайте произведение чисел в столбце таблицы.

SELECT * FROM storehouses_products;
SELECT ROUND(EXP(SUM(LN(sp.Value)))) FROM storehouses_products sp WHERE sp.VALUE != 0;