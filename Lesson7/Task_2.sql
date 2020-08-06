-- Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name AS 'Товар', c.name AS 'Категория' FROM products p
LEFT JOIN catalogs c ON p.catalog_id = c.id;