## Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.

# переходим в домашнюю директорию
cd ~

# создаем файл .my.cnf
vim .my.cnf

# контент файла
#[client]
#user=alex
#password=123456

# проверяем
cat .my.cnf

#[client]
#user=alex
#password=123456

# вызов клиента БД
mysql

## Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.

# создаем базу данных example
CREATE DATABASE example;

# выбираем базу данных в качестве активной
USE example;

# проверяем выбрана ли нужна БД
\s

# создаем таблицу users
CREATE TABLE users (
  id INT UNSIGNED,
  name VARCHAR(255) COMMENT 'Имя пользователя'
) COMMENT = 'Пользователи';

# выход
\q

## Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.

# создаем дамп БД example в файл example.sql
mysqldump example > example.sql

# вызов клиента БД
mysql

# создаем базу данных sample
CREATE DATABASE sample;

# проверяем создание БД
SHOW DATABASES;

# выход
\q

# разворачиваем содержимое бекапа example.sql в новой БД sample
mysql -p sample < example.sql

## (по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump. Создайте дамп единственной таблицы help_keyword базы данных mysql. Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

# формируем дамп по заданию с расширенными параметрами
mysqldump mysql --tables help_keyword -w '1 limit 100' > mysql_help_keyword_top_100.sql