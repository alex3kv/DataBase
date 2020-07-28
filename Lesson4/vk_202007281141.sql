--
-- Скрипт сгенерирован Devart dbForge Studio 2020 for MySQL, Версия 9.0.338.0
-- Домашняя страница продукта: http://www.devart.com/ru/dbforge/mysql/studio
-- Дата скрипта: 28.07.2020 11:41:25
-- Версия сервера: 8.0.20
-- Версия клиента: 4.1
--

-- 
-- Отключение внешних ключей
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Установить режим SQL (SQL mode)
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- 
-- Установка кодировки, с использованием которой клиент будет посылать запросы на сервер
--
SET NAMES 'utf8';

--
-- Установка базы данных по умолчанию
--
USE vk;

--
-- Удалить таблицу `communities`
--
DROP TABLE IF EXISTS communities;

--
-- Удалить таблицу `communities_users`
--
DROP TABLE IF EXISTS communities_users;

--
-- Удалить таблицу `media_types`
--
DROP TABLE IF EXISTS media_types;

--
-- Удалить таблицу `messages`
--
DROP TABLE IF EXISTS messages;

--
-- Удалить таблицу `profiles`
--
DROP TABLE IF EXISTS profiles;

--
-- Удалить таблицу `friendship_history`
--
DROP TABLE IF EXISTS friendship_history;

--
-- Удалить таблицу `friendship`
--
DROP TABLE IF EXISTS friendship;

--
-- Удалить таблицу `friendship_statuses`
--
DROP TABLE IF EXISTS friendship_statuses;

--
-- Удалить таблицу `likes`
--
DROP TABLE IF EXISTS likes;

--
-- Удалить таблицу `media`
--
DROP TABLE IF EXISTS media;

--
-- Удалить таблицу `users`
--
DROP TABLE IF EXISTS users;

--
-- Установка базы данных по умолчанию
--
USE vk;

--
-- Создать таблицу `users`
--
CREATE TABLE users (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  first_name varchar(100) NOT NULL COMMENT 'Имя пользователя',
  last_name varchar(100) NOT NULL COMMENT 'Фамилия пользователя',
  email varchar(100) NOT NULL COMMENT 'Почта',
  phone varchar(100) NOT NULL COMMENT 'Телефон',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 111,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Пользователи';

--
-- Создать индекс `email` для объекта типа таблица `users`
--
ALTER TABLE users
ADD UNIQUE INDEX email (email);

--
-- Создать индекс `phone` для объекта типа таблица `users`
--
ALTER TABLE users
ADD UNIQUE INDEX phone (phone);

--
-- Создать таблицу `media`
--
CREATE TABLE media (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя, который загрузил файл',
  filename varchar(255) NOT NULL COMMENT 'Путь к файлу',
  size int NOT NULL COMMENT 'Размер файла',
  metadata json DEFAULT NULL,
  media_type_id int UNSIGNED NOT NULL COMMENT 'Ссылка на тип контента',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 111,
AVG_ROW_LENGTH = 148,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Медиафайлы';

--
-- Создать ограничение
--
ALTER TABLE media
ADD CONSTRAINT media_chk_1 CHECK (JSON_VALID(`metadata`));

--
-- Создать таблицу `likes`
--
CREATE TABLE likes (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  media_id int UNSIGNED NOT NULL COMMENT 'Ссылка на медиафайл',
  user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Лайки';

--
-- Создать внешний ключ
--
ALTER TABLE likes
ADD CONSTRAINT media_fk FOREIGN KEY (media_id)
REFERENCES media (id);

--
-- Создать внешний ключ
--
ALTER TABLE likes
ADD CONSTRAINT user_fk FOREIGN KEY (user_id)
REFERENCES users (id);

--
-- Создать таблицу `friendship_statuses`
--
CREATE TABLE friendship_statuses (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  name varchar(150) NOT NULL COMMENT 'Название статуса',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 14,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Статусы дружбы';

--
-- Создать индекс `name` для объекта типа таблица `friendship_statuses`
--
ALTER TABLE friendship_statuses
ADD UNIQUE INDEX name (name);

--
-- Создать таблицу `friendship`
--
CREATE TABLE friendship (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на инициатора дружеских отношений',
  friend_id int UNSIGNED NOT NULL COMMENT 'Ссылка на получателя приглашения дружить',
  status_id int UNSIGNED NOT NULL COMMENT 'Ссылка на статус (текущее состояние) отношений',
  requested_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время отправления приглашения дружить',
  confirmed_at datetime DEFAULT NULL COMMENT 'Время подтверждения приглашения',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'Таблица дружбы';

--
-- Создать индекс `user_id` для объекта типа таблица `friendship`
--
ALTER TABLE friendship
ADD UNIQUE INDEX user_id (user_id, friend_id) COMMENT 'Составной первичный ключ';

--
-- Создать таблицу `friendship_history`
--
CREATE TABLE friendship_history (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  friendship_id int UNSIGNED NOT NULL COMMENT 'Ссылка на запись о дружеских отношениях',
  status_id int UNSIGNED NOT NULL COMMENT 'Ссылка на статус отношений',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_0900_ai_ci,
COMMENT = 'История дружбы';

--
-- Создать внешний ключ
--
ALTER TABLE friendship_history
ADD CONSTRAINT friendship_fk FOREIGN KEY (friendship_id)
REFERENCES friendship (id);

--
-- Создать внешний ключ
--
ALTER TABLE friendship_history
ADD CONSTRAINT friendship_history_status_fk FOREIGN KEY (status_id)
REFERENCES friendship_statuses (id);

--
-- Создать таблицу `profiles`
--
CREATE TABLE profiles (
  user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
  gender char(1) NOT NULL COMMENT 'Пол',
  birthday date DEFAULT NULL COMMENT 'Дата рождения',
  photo_id int UNSIGNED DEFAULT NULL COMMENT 'Ссылка на основную фотографию пользователя',
  city varchar(130) DEFAULT NULL COMMENT 'Город проживания',
  country varchar(130) DEFAULT NULL COMMENT 'Страна проживания',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (user_id)
)
ENGINE = INNODB,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Профили';

--
-- Создать таблицу `messages`
--
CREATE TABLE messages (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  from_user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на отправителя сообщения',
  to_user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на получателя сообщения',
  body text NOT NULL COMMENT 'Текст сообщения',
  is_important tinyint DEFAULT NULL COMMENT 'Признак важности',
  is_delivered tinyint DEFAULT NULL COMMENT 'Признак доставки',
  is_modified tinyint DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 101,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Сообщения';

--
-- Создать таблицу `media_types`
--
CREATE TABLE media_types (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор строки',
  name varchar(255) NOT NULL COMMENT 'Название типа',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 4,
AVG_ROW_LENGTH = 1638,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Типы медиафайлов';

--
-- Создать индекс `name` для объекта типа таблица `media_types`
--
ALTER TABLE media_types
ADD UNIQUE INDEX name (name);

--
-- Создать таблицу `communities_users`
--
CREATE TABLE communities_users (
  community_id int UNSIGNED NOT NULL COMMENT 'Ссылка на группу',
  user_id int UNSIGNED NOT NULL COMMENT 'Ссылка на пользователя',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  PRIMARY KEY (community_id, user_id) COMMENT 'Составной первичный ключ'
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 163,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Участники групп, связь между пользователями и группами';

--
-- Создать таблицу `communities`
--
CREATE TABLE communities (
  id int UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Идентификатор сроки',
  name varchar(150) NOT NULL COMMENT 'Название группы',
  created_at datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Время создания строки',
  updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Время обновления строки',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
AUTO_INCREMENT = 111,
AVG_ROW_LENGTH = 2340,
CHARACTER SET utf8,
COLLATE utf8_unicode_ci,
COMMENT = 'Группы';

--
-- Создать индекс `name` для объекта типа таблица `communities`
--
ALTER TABLE communities
ADD UNIQUE INDEX name (name);

-- 
-- Вывод данных для таблицы users
--
INSERT INTO users VALUES
(1, 'Celestine', 'Stark', 'ybahringer@example.org', '390-138-5184x736', '1977-05-31 07:46:28', '1984-05-07 21:46:18'),
(2, 'Clovis', 'Crist', 'xebert@example.net', '02716225136', '1994-01-30 09:30:35', '2009-03-23 07:37:08'),
(3, 'Brandy', 'Bayer', 'bechtelar.garry@example.com', '+78(4)0401792032', '2014-02-04 03:50:49', '2020-07-28 11:33:34'),
(4, 'Kurt', 'Renner', 'lorena05@example.net', '(017)037-8874x3093', '1990-10-14 16:15:17', '2018-02-02 18:09:34'),
(5, 'Lawson', 'Gorczany', 'jazmyn86@example.org', '(819)168-2925', '2006-08-14 05:04:24', '2013-07-24 00:44:24'),
(6, 'Leda', 'Wisozk', 'geoffrey34@example.net', '739-217-1636', '2013-07-15 03:58:40', '2020-07-28 11:33:34'),
(7, 'Lewis', 'Sipes', 'kraig.o''conner@example.org', '(919)481-5760x41716', '2013-11-18 16:09:58', '2020-07-28 11:33:34'),
(8, 'Allene', 'Schmitt', 'oyost@example.org', '1-799-599-0735', '1983-12-25 07:44:34', '2008-12-01 18:22:44'),
(9, 'Carlee', 'Anderson', 'shemar.herzog@example.com', '518-804-1846x489', '1970-05-12 02:45:47', '2007-09-17 04:21:39'),
(10, 'Neal', 'Hegmann', 'jwolf@example.org', '(732)524-6387x86584', '1994-09-05 15:04:13', '2020-07-28 11:33:34'),
(11, 'Lue', 'Gleichner', 'padberg.yazmin@example.com', '895.400.2459', '2019-09-13 01:31:13', '2020-07-28 11:33:34'),
(12, 'Grace', 'Oberbrunner', 'rice.mya@example.net', '(926)965-4361x19932', '2007-04-21 10:44:46', '2020-07-28 11:33:34'),
(13, 'Kaitlyn', 'Hilpert', 'mariane.goldner@example.com', '1-678-145-4567x910', '1995-01-11 22:16:59', '2020-07-28 11:33:34'),
(14, 'Yvette', 'Kris', 'isabel84@example.com', '854.277.1317x49769', '1991-01-06 09:13:24', '2020-07-28 11:33:34'),
(15, 'Bobby', 'Reynolds', 'stamm.lysanne@example.net', '+95(3)6821667075', '1981-09-09 11:54:24', '1981-10-20 06:43:03'),
(16, 'Connor', 'Welch', 'muller.elwin@example.net', '258.733.6564', '2003-02-09 18:54:06', '2012-09-10 00:47:40'),
(17, 'Nikko', 'Weimann', 'aiden23@example.net', '(401)059-0658x7438', '1996-11-17 02:06:29', '1997-07-29 20:20:55'),
(18, 'Maurine', 'Gerhold', 'elaina03@example.net', '(690)982-7862', '1971-03-25 18:45:52', '1998-02-26 00:40:40'),
(19, 'Tobin', 'Sauer', 'jackeline.terry@example.org', '(545)286-4554', '2007-10-21 10:19:03', '2017-10-02 00:46:14'),
(20, 'Caitlyn', 'Spencer', 'rashad63@example.com', '902-674-8108x1482', '2001-12-30 13:46:13', '2020-07-28 11:33:34'),
(21, 'Janae', 'Erdman', 'destini17@example.org', '(036)898-6871', '2014-06-14 18:10:41', '2020-07-28 11:33:34'),
(22, 'Kristina', 'Gulgowski', 'vreichert@example.com', '(512)739-8702x123', '2011-04-24 11:36:31', '2016-02-11 12:36:19'),
(23, 'Casey', 'Feeney', 'kuhn.jake@example.org', '1-697-016-8255', '2002-10-06 22:52:45', '2020-07-28 11:33:34'),
(24, 'Sydni', 'Howell', 'louisa.blanda@example.org', '07175746059', '1999-08-14 09:48:01', '2001-07-22 02:02:08'),
(25, 'Joan', 'Rutherford', 'loraine.rutherford@example.net', '1-839-602-0598x42415', '2006-10-19 09:59:29', '2020-07-28 11:33:34'),
(26, 'Arnoldo', 'Daniel', 'dtrantow@example.org', '(546)771-2272', '2013-06-17 03:25:16', '2020-07-28 11:33:34'),
(27, 'Flavio', 'Cremin', 'fahey.alvis@example.com', '430.433.5653', '2014-12-23 23:06:25', '2020-07-28 11:33:34'),
(28, 'Jacynthe', 'Kling', 'kerluke.ernest@example.com', '(017)408-1994', '1983-11-09 18:30:43', '1993-11-09 01:28:56'),
(29, 'Jazmyn', 'Cronin', 'kozey.christa@example.net', '1-301-579-7440x5187', '1979-07-16 09:51:59', '2002-08-30 07:28:15'),
(30, 'Eddie', 'Bins', 'pacocha.felipa@example.net', '091.381.6849', '1993-07-09 08:36:29', '1998-12-06 14:03:25'),
(31, 'Loyce', 'Hermann', 'javon.anderson@example.com', '(676)874-6755', '2020-05-22 00:07:40', '2020-07-28 11:33:34'),
(32, 'Jalon', 'Beahan', 'xyost@example.org', '642-579-8798', '1983-08-20 10:22:35', '2020-07-28 11:33:34'),
(33, 'Bettye', 'Pollich', 'zackary05@example.net', '027.429.7140x1070', '1990-05-08 21:45:39', '1992-09-21 03:04:21'),
(34, 'Bethany', 'Rutherford', 'funk.ansley@example.com', '1-645-860-5663x5072', '2004-12-03 12:09:17', '2020-07-28 11:33:34'),
(35, 'Miguel', 'Wiegand', 'paige.medhurst@example.com', '1-823-830-5699', '2016-03-31 22:46:55', '2020-07-28 11:33:34'),
(36, 'Wayne', 'Denesik', 'fernser@example.net', '1-920-659-5209x827', '1973-09-23 06:28:32', '2012-12-02 17:36:26'),
(37, 'Randall', 'Hartmann', 'kohler.angelina@example.com', '+64(9)0576221352', '1991-08-09 23:31:10', '1995-08-15 22:46:02'),
(38, 'Elsie', 'Mohr', 'kihn.cary@example.com', '(093)213-5379', '1975-12-05 20:22:29', '2016-12-23 07:34:08'),
(39, 'Shania', 'Green', 'fhuel@example.com', '1-291-204-3049x2714', '1972-07-24 19:24:03', '1977-08-01 11:58:38'),
(40, 'Elise', 'Carter', 'dare.earnestine@example.org', '(581)559-9954x15245', '1970-11-05 22:35:06', '2008-02-04 17:49:32'),
(41, 'Kaitlin', 'Koepp', 'swift.betty@example.com', '1-635-818-6588', '2011-09-19 09:39:04', '2020-07-28 11:33:34'),
(42, 'Nakia', 'Monahan', 'torrance43@example.net', '923-153-9306', '1993-10-20 17:01:05', '2020-07-28 11:33:34'),
(43, 'Leopold', 'Johnson', 'derrick28@example.net', '(970)550-3315x3939', '2013-07-02 12:26:10', '2020-07-28 11:33:34'),
(44, 'Judson', 'Gorczany', 'ashley.rosenbaum@example.net', '724-258-8724x4266', '1988-07-19 20:39:40', '2020-07-28 11:33:34'),
(45, 'Alyson', 'Schuppe', 'sylvan.stokes@example.org', '1-728-235-5210x335', '1985-07-17 22:28:04', '2020-07-28 11:33:34'),
(46, 'General', 'Mueller', 'sdeckow@example.com', '(960)613-2432x822', '1995-01-01 08:45:26', '2020-07-28 11:33:34'),
(47, 'Cecilia', 'Wuckert', 'mann.creola@example.com', '(827)193-0694', '1981-05-15 08:17:31', '1984-02-20 07:38:09'),
(48, 'Caesar', 'Hintz', 'laney10@example.net', '869-277-1224', '1996-10-22 11:32:54', '2020-07-28 11:33:34'),
(49, 'Matt', 'Keebler', 'orval63@example.com', '666-153-5342x5514', '1994-08-10 00:40:31', '2020-07-28 11:33:34'),
(50, 'Horace', 'Roob', 'naomi62@example.com', '(281)457-0454', '1978-09-04 09:49:47', '2000-11-29 21:32:20'),
(51, 'Camilla', 'Schoen', 'autumn.hintz@example.org', '845.503.4163x6068', '2007-12-20 11:52:00', '2020-07-28 11:33:34'),
(52, 'Candace', 'Kuhic', 'xullrich@example.com', '1-127-071-3596', '2014-11-11 22:06:28', '2020-07-28 11:33:34'),
(53, 'Jerod', 'Smitham', 'elda.dickinson@example.net', '1-583-175-2352x910', '2019-03-19 04:38:08', '2020-07-28 11:33:34'),
(54, 'Elody', 'Harvey', 'schaefer.tanya@example.org', '551.635.8441x26618', '2017-02-07 21:55:53', '2020-07-28 11:33:34'),
(55, 'Janet', 'Shields', 'dturner@example.org', '(969)979-8703x54255', '1989-10-31 12:48:50', '2017-02-06 13:18:54'),
(56, 'Adolf', 'Stroman', 'jaden.kohler@example.net', '973.736.0419x736', '1976-09-28 03:32:58', '2020-07-28 11:33:34'),
(57, 'Aniya', 'Boehm', 'cartwright.emmanuelle@example.net', '1-741-435-8643x5302', '2013-10-02 19:53:17', '2020-07-28 11:33:34'),
(58, 'Nellie', 'Rowe', 'gisselle31@example.org', '03381829523', '1991-05-17 23:18:35', '1992-06-22 11:16:35'),
(59, 'Deonte', 'Corwin', 'asha10@example.com', '(681)640-3403', '1973-06-26 23:08:46', '1996-04-17 01:32:44'),
(60, 'Cristobal', 'Kihn', 'morar.derek@example.org', '1-740-184-2948', '2018-06-20 12:02:16', '2020-07-28 11:33:34'),
(61, 'Caleigh', 'Lehner', 'sbayer@example.org', '763.670.0529x4337', '1974-11-04 08:07:48', '1988-10-12 10:54:23'),
(62, 'Samanta', 'White', 'schaden.lura@example.org', '+43(4)3666529924', '1991-10-16 08:38:50', '2020-07-28 11:33:34'),
(63, 'Jefferey', 'Kilback', 'dmertz@example.org', '02169133020', '1978-11-05 13:42:31', '2000-08-20 05:07:39'),
(64, 'Kay', 'Lang', 'rowe.brigitte@example.org', '1-775-612-8744x3702', '1977-08-02 20:15:12', '2002-05-30 12:29:48'),
(65, 'Marilou', 'Bartoletti', 'sydni72@example.org', '852.251.9595x0096', '2016-12-16 11:19:38', '2020-07-28 11:33:34'),
(66, 'Kamille', 'Heaney', 'adan.grant@example.net', '(311)634-0768', '2009-12-22 23:58:28', '2020-07-28 11:33:34'),
(67, 'Maxwell', 'Swift', 'ikemmer@example.com', '1-378-379-1018', '1983-04-03 12:24:12', '1986-09-18 01:12:20'),
(68, 'Destinee', 'Wiza', 'courtney.fay@example.org', '319.424.8901', '1991-02-26 05:56:36', '2020-07-28 11:33:34'),
(69, 'Sharon', 'Kautzer', 'golda.gaylord@example.net', '672.895.7807x154', '1974-01-25 12:13:57', '1975-07-14 10:58:23'),
(70, 'Maybelle', 'Gibson', 'presley92@example.net', '658.068.4648x1479', '1992-05-04 01:10:42', '2020-07-28 11:33:34'),
(71, 'Hector', 'Konopelski', 'aiden.cummings@example.net', '06175768663', '1993-09-15 10:21:18', '2006-11-20 19:38:53'),
(72, 'Milo', 'Brakus', 'alexane64@example.com', '525.997.1651x6184', '2015-02-04 03:34:55', '2015-11-27 01:07:44'),
(73, 'Mona', 'Lind', 'satterfield.hilda@example.com', '181-335-6434x448', '2001-03-05 05:07:56', '2020-07-28 11:33:34'),
(74, 'Katheryn', 'Roob', 'weimann.sharon@example.org', '308-555-1162x5184', '1993-10-27 23:58:03', '1995-07-23 18:29:59'),
(75, 'Percival', 'Harris', 'stark.keshaun@example.com', '242.435.6352x20177', '1975-12-16 02:17:11', '2016-03-26 23:40:28'),
(76, 'Mylene', 'Oberbrunner', 'berniece.huels@example.org', '(520)761-4436x71712', '1994-10-09 20:58:18', '2020-07-28 11:33:34'),
(77, 'Lacy', 'Hettinger', 'balistreri.treva@example.org', '992.018.4439', '2001-04-01 11:07:44', '2020-07-28 11:33:34'),
(78, 'Judd', 'Funk', 'hammes.malika@example.com', '1-253-769-3128x698', '2007-08-11 13:43:12', '2020-07-28 11:33:34'),
(79, 'Meredith', 'Lockman', 'vfeest@example.org', '1-856-631-4132', '2017-08-12 10:55:19', '2020-07-28 11:33:34'),
(80, 'Halie', 'Nolan', 'fdoyle@example.org', '(823)644-5746x0655', '1999-11-23 22:45:54', '2008-12-20 09:22:11'),
(81, 'Joshuah', 'Altenwerth', 'keith89@example.net', '071-959-0821x79879', '1999-04-05 05:17:21', '2020-07-28 11:33:34'),
(82, 'Katherine', 'Gutkowski', 'qwolff@example.net', '692.297.6568x033', '1976-08-04 02:44:42', '2020-07-28 11:33:34'),
(83, 'Ara', 'Hagenes', 'beer.itzel@example.org', '371-920-7232x88023', '1986-04-15 09:48:12', '2020-07-28 11:33:34'),
(84, 'Mercedes', 'Watsica', 'cstreich@example.net', '652.136.4291', '1972-06-05 06:02:22', '2005-01-16 00:13:06'),
(85, 'Ricardo', 'Gleichner', 'agreen@example.com', '+23(6)9053568180', '1985-08-02 22:31:37', '2020-07-28 11:33:34'),
(86, 'Moises', 'Nader', 'hyatt.jeffry@example.com', '1-972-218-9965', '2014-04-08 18:55:48', '2020-07-28 11:33:34'),
(87, 'Nicklaus', 'Herzog', 'xfeest@example.net', '(697)199-6730x12963', '1975-07-15 08:59:03', '2015-07-02 06:30:20'),
(88, 'Deshaun', 'Nicolas', 'shields.anabelle@example.net', '1-986-687-6631x042', '1991-07-18 23:15:03', '2017-01-27 13:09:34'),
(89, 'Annetta', 'Marvin', 'joseph60@example.com', '(788)709-3397x9112', '1974-05-29 09:38:40', '2011-11-16 07:05:38'),
(90, 'Taya', 'Gerhold', 'jmaggio@example.com', '06042875049', '1971-05-19 21:48:10', '2020-07-28 11:33:34'),
(91, 'Lavinia', 'Hintz', 'aracely71@example.net', '1-625-742-7196x0836', '1974-07-07 05:13:20', '1991-03-31 23:15:38'),
(92, 'Bobbie', 'Funk', 'allan.mcglynn@example.org', '(303)454-9944', '1982-10-03 23:57:36', '1995-04-26 22:29:30'),
(93, 'Alf', 'Wilkinson', 'ukuphal@example.com', '(182)733-5584x410', '2004-03-06 05:33:39', '2020-07-28 11:33:34'),
(94, 'Vida', 'Hansen', 'ldoyle@example.com', '806-980-6942', '2003-01-13 23:14:11', '2020-07-28 11:33:34'),
(95, 'Carroll', 'Schuppe', 'mikayla.vonrueden@example.org', '05627581696', '1977-03-01 21:30:17', '2004-09-04 16:59:44'),
(96, 'Eric', 'Will', 'eva.leffler@example.net', '1-596-465-8965', '2017-11-12 20:21:41', '2020-07-28 11:33:34'),
(97, 'Vincenzo', 'Russel', 'frederic15@example.com', '(545)034-4485', '2015-08-04 05:42:09', '2020-07-28 11:33:34'),
(98, 'Forest', 'Lockman', 'barrows.pascale@example.net', '(740)624-9479x81971', '1992-07-04 02:12:51', '2020-07-28 11:33:34'),
(99, 'Garnet', 'Douglas', 'ernest89@example.com', '388-790-5556x11192', '1972-01-09 19:16:29', '1990-09-09 21:35:37'),
(100, 'Juwan', 'Larson', 'schinner.weldon@example.com', '1-079-471-0642x135', '1984-03-23 21:34:23', '2018-10-28 23:51:23'),
(101, 'Chelsey', 'Koch', 'sonia.wilderman@example.net', '1-247-878-5655', '2006-02-16 06:31:06', '2020-07-28 11:33:34'),
(102, 'Moshe', 'Stanton', 'isipes@example.com', '1-099-876-1950', '1999-11-24 21:20:07', '2020-07-28 11:33:34'),
(103, 'Kelsie', 'Mertz', 'darryl56@example.org', '07936651560', '2012-10-10 20:16:17', '2020-07-28 11:33:34'),
(104, 'Kathryne', 'Fisher', 'stokes.coy@example.net', '1-792-108-9585', '2012-10-22 07:27:21', '2020-07-28 11:33:34'),
(105, 'Anya', 'Tillman', 'leanne68@example.com', '1-857-031-0380x057', '1971-09-06 04:08:55', '2012-10-29 07:53:23'),
(106, 'Madilyn', 'Rice', 'hyatt.vickie@example.net', '1-294-581-7272x1556', '1983-10-30 06:46:56', '1998-07-05 10:26:19'),
(107, 'Jettie', 'Runte', 'bwyman@example.com', '380.893.1547x068', '1993-11-03 09:55:23', '2013-04-16 13:10:00'),
(108, 'Bobby', 'Wilderman', 'della.rath@example.org', '1-658-350-1700x49318', '2004-11-12 17:50:31', '2020-07-28 11:33:34'),
(109, 'Brionna', 'Boehm', 'myrtice.mohr@example.com', '519-544-8051', '2013-04-05 07:34:36', '2020-07-28 11:33:34'),
(110, 'Garnet', 'Streich', 'johnston.sydnee@example.net', '850-461-0391x51620', '1980-08-07 19:10:57', '1992-04-16 03:00:19');

-- 
-- Вывод данных для таблицы media
--
INSERT INTO media VALUES
(1, 83, 'https://dropbox/vk/odit.mpeg', 4752, '{"owner": "Ara Hagenes"}', 2, '1999-01-28 21:35:27', '2020-07-28 11:39:05'),
(2, 24, 'https://dropbox/vk/adipisci.jpeg', 814457, '{"owner": "Sydni Howell"}', 3, '1992-11-02 09:58:25', '2020-07-28 11:39:05'),
(3, 71, 'https://dropbox/vk/voluptate.mpeg', 361102037, '{"owner": "Hector Konopelski"}', 2, '1974-11-16 15:02:53', '2020-07-28 11:39:05'),
(4, 81, 'https://dropbox/vk/asperiores.jpeg', 4811, '{"owner": "Joshuah Altenwerth"}', 2, '1970-05-20 09:19:37', '2020-07-28 11:39:05'),
(5, 92, 'https://dropbox/vk/ut.jpeg', 960604, '{"owner": "Bobbie Funk"}', 2, '2005-04-10 19:40:50', '2020-07-28 11:39:05'),
(6, 19, 'https://dropbox/vk/deserunt.png', 349649, '{"owner": "Tobin Sauer"}', 2, '1979-08-27 23:59:52', '2020-07-28 11:39:05'),
(7, 15, 'https://dropbox/vk/eligendi.jpeg', 63928655, '{"owner": "Bobby Reynolds"}', 3, '1983-01-20 14:27:19', '2020-07-28 11:39:05'),
(8, 19, 'https://dropbox/vk/ducimus.jpeg', 856436, '{"owner": "Tobin Sauer"}', 2, '1980-03-30 01:16:05', '2020-07-28 11:39:05'),
(9, 48, 'https://dropbox/vk/cumque.mpeg', 726266, '{"owner": "Caesar Hintz"}', 3, '1998-07-03 23:25:44', '2020-07-28 11:39:05'),
(10, 83, 'https://dropbox/vk/qui.avi', 223230, '{"owner": "Ara Hagenes"}', 3, '1993-09-09 15:28:36', '2020-07-28 11:39:05'),
(11, 72, 'https://dropbox/vk/minus.mpeg', 76763917, '{"owner": "Milo Brakus"}', 2, '1978-12-01 13:57:14', '2020-07-28 11:39:05'),
(12, 8, 'https://dropbox/vk/reprehenderit.mpeg', 536845, '{"owner": "Allene Schmitt"}', 3, '1997-09-08 03:43:05', '2020-07-28 11:39:05'),
(13, 25, 'https://dropbox/vk/eum.jpeg', 806701094, '{"owner": "Joan Rutherford"}', 1, '1996-09-02 13:22:27', '2020-07-28 11:39:05'),
(14, 1, 'https://dropbox/vk/inventore.png', 40454, '{"owner": "Celestine Stark"}', 2, '1974-03-28 07:02:03', '2020-07-28 11:39:05'),
(15, 28, 'https://dropbox/vk/praesentium.mpeg', 64154899, '{"owner": "Jacynthe Kling"}', 3, '2011-03-18 10:41:27', '2020-07-28 11:39:05'),
(16, 39, 'https://dropbox/vk/porro.jpeg', 2140, '{"owner": "Shania Green"}', 1, '1982-09-20 09:14:44', '2020-07-28 11:39:05'),
(17, 11, 'https://dropbox/vk/laborum.mpeg', 5072, '{"owner": "Lue Gleichner"}', 3, '2020-03-29 17:07:33', '2020-07-28 11:39:05'),
(18, 35, 'https://dropbox/vk/quia.png', 454539, '{"owner": "Miguel Wiegand"}', 2, '1989-03-13 00:00:56', '2020-07-28 11:39:05'),
(19, 41, 'https://dropbox/vk/veniam.avi', 866719, '{"owner": "Kaitlin Koepp"}', 1, '1990-11-29 19:48:00', '2020-07-28 11:39:05'),
(20, 99, 'https://dropbox/vk/voluptatem.jpeg', 44283499, '{"owner": "Garnet Douglas"}', 3, '2000-12-03 16:37:57', '2020-07-28 11:39:05'),
(21, 72, 'https://dropbox/vk/facere.png', 964293, '{"owner": "Milo Brakus"}', 2, '1990-06-22 00:23:23', '2020-07-28 11:39:05'),
(22, 62, 'https://dropbox/vk/nulla.mpeg', 2628, '{"owner": "Samanta White"}', 1, '1998-06-07 22:47:26', '2020-07-28 11:39:05'),
(23, 94, 'https://dropbox/vk/sint.mpeg', 1004537, '{"owner": "Vida Hansen"}', 1, '2008-07-25 20:29:51', '2020-07-28 11:39:05'),
(24, 82, 'https://dropbox/vk/eaque.png', 81322, '{"owner": "Katherine Gutkowski"}', 2, '1989-01-28 00:01:19', '2020-07-28 11:39:05'),
(25, 31, 'https://dropbox/vk/vitae.mpeg', 3596584, '{"owner": "Loyce Hermann"}', 2, '2019-04-28 00:53:37', '2020-07-28 11:39:05'),
(26, 6, 'https://dropbox/vk/consequatur.avi', 4108, '{"owner": "Leda Wisozk"}', 3, '1982-10-22 19:04:06', '2020-07-28 11:39:05'),
(27, 36, 'https://dropbox/vk/voluptatem.jpeg', 402148, '{"owner": "Wayne Denesik"}', 3, '2001-05-29 17:46:56', '2020-07-28 11:39:05'),
(28, 61, 'https://dropbox/vk/consectetur.mpeg', 74204672, '{"owner": "Caleigh Lehner"}', 2, '2012-08-07 07:35:49', '2020-07-28 11:39:05'),
(29, 96, 'https://dropbox/vk/id.png', 23726, '{"owner": "Eric Will"}', 3, '1994-04-29 07:10:25', '2020-07-28 11:39:05'),
(30, 97, 'https://dropbox/vk/quia.jpeg', 987128, '{"owner": "Vincenzo Russel"}', 1, '2002-01-08 11:06:57', '2020-07-28 11:39:05'),
(31, 97, 'https://dropbox/vk/qui.jpeg', 719199, '{"owner": "Vincenzo Russel"}', 3, '2008-12-27 19:58:08', '2020-07-28 11:39:05'),
(32, 95, 'https://dropbox/vk/distinctio.mpeg', 66418, '{"owner": "Carroll Schuppe"}', 2, '2012-07-13 02:02:30', '2020-07-28 11:39:05'),
(33, 84, 'https://dropbox/vk/id.mpeg', 3423, '{"owner": "Mercedes Watsica"}', 1, '2019-03-19 12:16:55', '2020-07-28 11:39:05'),
(34, 32, 'https://dropbox/vk/beatae.png', 369951, '{"owner": "Jalon Beahan"}', 3, '1998-10-07 12:10:00', '2020-07-28 11:39:05'),
(35, 11, 'https://dropbox/vk/eligendi.jpeg', 31893, '{"owner": "Lue Gleichner"}', 1, '1974-06-19 17:24:41', '2020-07-28 11:39:05'),
(36, 55, 'https://dropbox/vk/voluptas.jpeg', 849758, '{"owner": "Janet Shields"}', 1, '1994-12-07 07:11:56', '2020-07-28 11:39:05'),
(37, 41, 'https://dropbox/vk/error.avi', 2892, '{"owner": "Kaitlin Koepp"}', 3, '1972-06-11 20:00:38', '2020-07-28 11:39:05'),
(38, 41, 'https://dropbox/vk/est.jpeg', 84907, '{"owner": "Kaitlin Koepp"}', 3, '1998-07-27 19:41:41', '2020-07-28 11:39:05'),
(39, 81, 'https://dropbox/vk/vel.mpeg', 208521518, '{"owner": "Joshuah Altenwerth"}', 2, '1973-06-01 23:11:19', '2020-07-28 11:39:05'),
(40, 82, 'https://dropbox/vk/ad.avi', 56198, '{"owner": "Katherine Gutkowski"}', 1, '2010-12-30 01:44:01', '2020-07-28 11:39:05'),
(41, 65, 'https://dropbox/vk/pariatur.jpeg', 368966867, '{"owner": "Marilou Bartoletti"}', 2, '1996-12-16 12:51:48', '2020-07-28 11:39:05'),
(42, 79, 'https://dropbox/vk/consequatur.png', 10309951, '{"owner": "Meredith Lockman"}', 2, '1975-02-11 02:51:20', '2020-07-28 11:39:05'),
(43, 98, 'https://dropbox/vk/et.avi', 8420, '{"owner": "Forest Lockman"}', 1, '1973-02-06 00:57:27', '2020-07-28 11:39:05'),
(44, 54, 'https://dropbox/vk/est.png', 536948771, '{"owner": "Elody Harvey"}', 2, '2012-10-15 05:38:00', '2020-07-28 11:39:05'),
(45, 77, 'https://dropbox/vk/ratione.avi', 3080, '{"owner": "Lacy Hettinger"}', 1, '2000-11-05 01:56:54', '2020-07-28 11:39:05'),
(46, 21, 'https://dropbox/vk/voluptatibus.png', 624611, '{"owner": "Janae Erdman"}', 3, '2016-05-08 14:48:41', '2020-07-28 11:39:05'),
(47, 75, 'https://dropbox/vk/magni.png', 88264, '{"owner": "Percival Harris"}', 2, '1993-05-20 02:27:48', '2020-07-28 11:39:05'),
(48, 10, 'https://dropbox/vk/non.jpeg', 3767, '{"owner": "Neal Hegmann"}', 2, '2008-11-12 22:57:11', '2020-07-28 11:39:05'),
(49, 25, 'https://dropbox/vk/eligendi.png', 955458, '{"owner": "Joan Rutherford"}', 2, '1988-05-09 17:50:21', '2020-07-28 11:39:05'),
(50, 96, 'https://dropbox/vk/dolore.png', 54642, '{"owner": "Eric Will"}', 3, '2005-03-21 01:02:01', '2020-07-28 11:39:05'),
(51, 5, 'https://dropbox/vk/eveniet.png', 2033222, '{"owner": "Lawson Gorczany"}', 1, '1997-05-14 06:38:51', '2020-07-28 11:39:05'),
(52, 34, 'https://dropbox/vk/quas.avi', 893457, '{"owner": "Bethany Rutherford"}', 1, '1975-07-17 19:07:07', '2020-07-28 11:39:05'),
(53, 54, 'https://dropbox/vk/iste.mpeg', 590910, '{"owner": "Elody Harvey"}', 2, '1970-05-18 02:48:24', '2020-07-28 11:39:05'),
(54, 69, 'https://dropbox/vk/cupiditate.png', 264182, '{"owner": "Sharon Kautzer"}', 2, '1992-07-18 23:45:45', '2020-07-28 11:39:05'),
(55, 82, 'https://dropbox/vk/nostrum.jpeg', 26696, '{"owner": "Katherine Gutkowski"}', 1, '1992-06-28 18:26:20', '2020-07-28 11:39:05'),
(56, 1, 'https://dropbox/vk/dolor.png', 598547325, '{"owner": "Celestine Stark"}', 1, '1982-03-18 04:58:27', '2020-07-28 11:39:05'),
(57, 61, 'https://dropbox/vk/ipsa.png', 11538, '{"owner": "Caleigh Lehner"}', 2, '1981-06-07 03:35:08', '2020-07-28 11:39:05'),
(58, 1, 'https://dropbox/vk/dolores.mpeg', 538182, '{"owner": "Celestine Stark"}', 3, '2017-07-13 04:55:13', '2020-07-28 11:39:05'),
(59, 23, 'https://dropbox/vk/a.mpeg', 888362, '{"owner": "Casey Feeney"}', 2, '1987-07-13 15:55:10', '2020-07-28 11:39:05'),
(60, 11, 'https://dropbox/vk/asperiores.jpeg', 105680905, '{"owner": "Lue Gleichner"}', 1, '1997-12-29 11:43:38', '2020-07-28 11:39:05'),
(61, 84, 'https://dropbox/vk/sequi.avi', 39024, '{"owner": "Mercedes Watsica"}', 3, '2008-03-01 19:50:19', '2020-07-28 11:39:05'),
(62, 88, 'https://dropbox/vk/ut.jpeg', 817265, '{"owner": "Deshaun Nicolas"}', 1, '1998-12-28 00:31:30', '2020-07-28 11:39:05'),
(63, 87, 'https://dropbox/vk/corrupti.png', 50737699, '{"owner": "Nicklaus Herzog"}', 3, '1976-10-02 23:06:01', '2020-07-28 11:39:05'),
(64, 68, 'https://dropbox/vk/ipsum.jpeg', 68146, '{"owner": "Destinee Wiza"}', 2, '2013-09-04 10:51:51', '2020-07-28 11:39:05'),
(65, 82, 'https://dropbox/vk/molestiae.avi', 411238, '{"owner": "Katherine Gutkowski"}', 1, '1987-02-28 18:48:57', '2020-07-28 11:39:05'),
(66, 2, 'https://dropbox/vk/tempora.mpeg', 932795697, '{"owner": "Clovis Crist"}', 2, '2001-09-12 01:07:49', '2020-07-28 11:39:05'),
(67, 67, 'https://dropbox/vk/quia.mpeg', 594396, '{"owner": "Maxwell Swift"}', 1, '2016-02-28 23:36:16', '2020-07-28 11:39:05'),
(68, 26, 'https://dropbox/vk/ut.mpeg', 476383969, '{"owner": "Arnoldo Daniel"}', 3, '2010-02-11 18:53:38', '2020-07-28 11:39:05'),
(69, 28, 'https://dropbox/vk/accusamus.mpeg', 586312503, '{"owner": "Jacynthe Kling"}', 1, '1996-09-01 12:31:54', '2020-07-28 11:39:05'),
(70, 63, 'https://dropbox/vk/et.avi', 728266, '{"owner": "Jefferey Kilback"}', 2, '1971-01-19 23:01:44', '2020-07-28 11:39:05'),
(71, 30, 'https://dropbox/vk/quibusdam.avi', 3736, '{"owner": "Eddie Bins"}', 3, '1976-02-18 23:36:15', '2020-07-28 11:39:05'),
(72, 62, 'https://dropbox/vk/eum.mpeg', 358390, '{"owner": "Samanta White"}', 3, '2001-06-08 05:41:22', '2020-07-28 11:39:05'),
(73, 18, 'https://dropbox/vk/reiciendis.png', 848142, '{"owner": "Maurine Gerhold"}', 3, '2004-12-07 03:05:23', '2020-07-28 11:39:05'),
(74, 2, 'https://dropbox/vk/ut.mpeg', 603890031, '{"owner": "Clovis Crist"}', 3, '1971-09-03 04:22:47', '2020-07-28 11:39:05'),
(75, 57, 'https://dropbox/vk/omnis.mpeg', 9758, '{"owner": "Aniya Boehm"}', 2, '1971-08-17 20:37:09', '2020-07-28 11:39:05'),
(76, 79, 'https://dropbox/vk/sint.jpeg', 45915, '{"owner": "Meredith Lockman"}', 2, '2015-05-25 22:05:44', '2020-07-28 11:39:05'),
(77, 22, 'https://dropbox/vk/est.avi', 34722978, '{"owner": "Kristina Gulgowski"}', 2, '2009-05-22 03:53:09', '2020-07-28 11:39:05'),
(78, 75, 'https://dropbox/vk/sit.avi', 399982563, '{"owner": "Percival Harris"}', 2, '1976-04-18 17:01:17', '2020-07-28 11:39:05'),
(79, 8, 'https://dropbox/vk/enim.avi', 313439, '{"owner": "Allene Schmitt"}', 1, '1981-08-02 16:35:36', '2020-07-28 11:39:05'),
(80, 13, 'https://dropbox/vk/molestiae.png', 675148, '{"owner": "Kaitlyn Hilpert"}', 1, '1987-07-16 14:50:52', '2020-07-28 11:39:05'),
(81, 43, 'https://dropbox/vk/neque.mpeg', 5681, '{"owner": "Leopold Johnson"}', 3, '1981-12-22 11:30:13', '2020-07-28 11:39:05'),
(82, 74, 'https://dropbox/vk/voluptatibus.mpeg', 94882069, '{"owner": "Katheryn Roob"}', 1, '1977-06-25 16:00:47', '2020-07-28 11:39:05'),
(83, 39, 'https://dropbox/vk/accusamus.mpeg', 227997, '{"owner": "Shania Green"}', 2, '2013-08-22 17:14:42', '2020-07-28 11:39:05'),
(84, 75, 'https://dropbox/vk/quia.mpeg', 104542, '{"owner": "Percival Harris"}', 1, '2016-01-09 17:57:34', '2020-07-28 11:39:05'),
(85, 54, 'https://dropbox/vk/non.png', 828718, '{"owner": "Elody Harvey"}', 1, '1974-07-30 02:52:18', '2020-07-28 11:39:05'),
(86, 48, 'https://dropbox/vk/harum.avi', 316517825, '{"owner": "Caesar Hintz"}', 2, '1974-07-06 08:17:58', '2020-07-28 11:39:05'),
(87, 77, 'https://dropbox/vk/maxime.jpeg', 819964, '{"owner": "Lacy Hettinger"}', 3, '2017-01-06 18:56:16', '2020-07-28 11:39:05'),
(88, 42, 'https://dropbox/vk/voluptatem.mpeg', 1923, '{"owner": "Nakia Monahan"}', 2, '1975-07-14 15:00:38', '2020-07-28 11:39:05'),
(89, 76, 'https://dropbox/vk/odio.avi', 208904878, '{"owner": "Mylene Oberbrunner"}', 1, '1980-12-08 15:22:27', '2020-07-28 11:39:05'),
(90, 55, 'https://dropbox/vk/voluptates.png', 603669, '{"owner": "Janet Shields"}', 3, '1991-06-21 00:49:30', '2020-07-28 11:39:05'),
(91, 44, 'https://dropbox/vk/ipsam.avi', 82048, '{"owner": "Judson Gorczany"}', 3, '1997-12-21 12:29:57', '2020-07-28 11:39:05'),
(92, 56, 'https://dropbox/vk/error.avi', 548453, '{"owner": "Adolf Stroman"}', 3, '2014-04-16 16:42:37', '2020-07-28 11:39:05'),
(93, 48, 'https://dropbox/vk/voluptates.png', 33832, '{"owner": "Caesar Hintz"}', 1, '1995-12-24 08:57:09', '2020-07-28 11:39:05'),
(94, 70, 'https://dropbox/vk/fuga.jpeg', 73040364, '{"owner": "Maybelle Gibson"}', 3, '1985-10-03 01:05:54', '2020-07-28 11:39:05'),
(95, 6, 'https://dropbox/vk/vel.mpeg', 83374, '{"owner": "Leda Wisozk"}', 1, '2016-11-06 19:29:23', '2020-07-28 11:39:05'),
(96, 19, 'https://dropbox/vk/neque.mpeg', 921259, '{"owner": "Tobin Sauer"}', 3, '2006-08-12 11:59:01', '2020-07-28 11:39:05'),
(97, 79, 'https://dropbox/vk/molestiae.avi', 91590497, '{"owner": "Meredith Lockman"}', 1, '1972-01-18 21:22:57', '2020-07-28 11:39:05'),
(98, 35, 'https://dropbox/vk/qui.png', 950937, '{"owner": "Miguel Wiegand"}', 2, '1989-09-01 21:55:22', '2020-07-28 11:39:05'),
(99, 38, 'https://dropbox/vk/quis.jpeg', 63681, '{"owner": "Elsie Mohr"}', 2, '2005-06-20 15:15:39', '2020-07-28 11:39:05'),
(100, 84, 'https://dropbox/vk/velit.avi', 980907, '{"owner": "Mercedes Watsica"}', 3, '2012-08-11 05:18:43', '2020-07-28 11:39:05'),
(101, 8, 'https://dropbox/vk/dicta.mpeg', 41725, '{"owner": "Allene Schmitt"}', 2, '2009-07-27 18:56:21', '2020-07-28 11:39:05'),
(102, 84, 'https://dropbox/vk/dolorem.png', 69363, '{"owner": "Mercedes Watsica"}', 3, '2007-01-29 08:51:14', '2020-07-28 11:39:05'),
(103, 97, 'https://dropbox/vk/suscipit.jpeg', 255904, '{"owner": "Vincenzo Russel"}', 3, '1993-11-10 08:04:04', '2020-07-28 11:39:05'),
(104, 31, 'https://dropbox/vk/sit.mpeg', 1864, '{"owner": "Loyce Hermann"}', 1, '1985-07-31 17:52:58', '2020-07-28 11:39:05'),
(105, 66, 'https://dropbox/vk/accusamus.jpeg', 8381, '{"owner": "Kamille Heaney"}', 3, '2000-03-18 20:37:29', '2020-07-28 11:39:05'),
(106, 34, 'https://dropbox/vk/quia.png', 484837, '{"owner": "Bethany Rutherford"}', 2, '2001-11-01 11:02:53', '2020-07-28 11:39:05'),
(107, 74, 'https://dropbox/vk/quia.avi', 77589895, '{"owner": "Katheryn Roob"}', 2, '2004-08-18 17:56:32', '2020-07-28 11:39:05'),
(108, 67, 'https://dropbox/vk/facilis.png', 144346, '{"owner": "Maxwell Swift"}', 3, '1974-03-16 11:48:38', '2020-07-28 11:39:05'),
(109, 14, 'https://dropbox/vk/a.mpeg', 944018, '{"owner": "Yvette Kris"}', 1, '2005-07-14 17:29:55', '2020-07-28 11:39:05'),
(110, 68, 'https://dropbox/vk/voluptatem.mpeg', 37277640, '{"owner": "Destinee Wiza"}', 3, '1992-07-09 19:55:05', '2020-07-28 11:39:05');

-- 
-- Вывод данных для таблицы friendship_statuses
--
INSERT INTO friendship_statuses VALUES
(1, 'pariatur', '1977-03-18 01:27:42', '2011-08-22 08:32:57'),
(2, 'quam', '2011-03-31 12:21:18', '2020-03-05 12:22:57'),
(3, 'iusto', '1994-04-02 11:44:27', '1992-08-07 21:15:32'),
(4, 'sapiente', '2010-09-17 07:22:02', '1978-07-09 22:11:24'),
(5, 'ipsum', '1988-09-23 22:32:15', '1970-06-10 23:47:54'),
(6, 'accusamus', '1983-12-04 10:35:56', '1971-03-17 20:20:50'),
(7, 'reprehenderit', '1988-08-23 11:21:05', '1996-06-17 02:13:02'),
(8, 'soluta', '2017-04-04 12:09:24', '2015-07-04 12:12:05'),
(9, 'natus', '1987-02-17 23:57:20', '2000-09-19 09:54:09'),
(10, 'illum', '2002-12-16 17:17:59', '1984-12-18 14:54:45'),
(11, 'Requested', '2020-07-28 11:40:21', '2020-07-28 11:40:21'),
(12, 'Confirmed', '2020-07-28 11:40:21', '2020-07-28 11:40:21'),
(13, 'Rejected', '2020-07-28 11:40:21', '2020-07-28 11:40:21');

-- 
-- Вывод данных для таблицы friendship
--
-- Таблица vk.friendship не содержит данных

-- 
-- Вывод данных для таблицы profiles
--
INSERT INTO profiles VALUES
(1, 'f', '1998-10-01', 98, 'Stammton', 'Germany', '2020-07-28 11:34:02'),
(2, 'm', '2017-09-24', 54, 'Miguelborough', 'Russian Federation', '2020-07-28 11:34:02'),
(3, 'f', '1981-09-03', 79, 'Samarafurt', 'Germany', '2020-07-28 11:34:02'),
(4, 'f', '1986-01-29', 29, 'Port Britneychester', 'Belarus', '2020-07-28 11:34:02'),
(5, 'f', '1970-08-17', 8, 'Hellerchester', 'Russian Federation', '2020-07-28 11:34:02'),
(6, 'f', '2003-05-11', 53, 'East Vella', 'Russian Federation', '2020-07-28 11:34:02'),
(7, 'm', '1986-10-31', 38, 'New Carolyn', 'Russian Federation', '2020-07-28 11:34:02'),
(8, 'f', '2008-03-07', 34, 'South Johannport', 'Germany', '2020-07-28 11:34:02'),
(9, 'f', '1982-06-18', 55, 'Lake Eduardo', 'Belarus', '2020-07-28 11:34:02'),
(10, 'm', '1981-02-03', 74, 'Faystad', 'Germany', '2020-07-28 11:34:02'),
(11, 'f', '1993-08-09', 3, 'New Flavieton', 'Belarus', '2020-07-28 11:34:02'),
(12, 'm', '2012-06-30', 92, 'Chelseyhaven', 'Germany', '2020-07-28 11:34:02'),
(13, 'f', '2006-06-02', 49, 'New Jeffereyhaven', 'Belarus', '2020-07-28 11:34:02'),
(14, 'm', '1981-08-02', 72, 'New Carrollchester', 'Germany', '2020-07-28 11:34:02'),
(15, 'm', '1977-10-14', 10, 'Rueckerfurt', 'Germany', '2020-07-28 11:34:02'),
(16, 'm', '1978-06-07', 33, 'Anikaville', 'Germany', '2020-07-28 11:34:02'),
(17, 'f', '1997-03-05', 34, 'Port Joshua', 'Belarus', '2020-07-28 11:34:02'),
(18, 'm', '2018-09-23', 73, 'Wuckerthaven', 'Russian Federation', '2020-07-28 11:34:02'),
(19, 'f', '1979-01-02', 62, 'Breitenbergborough', 'Belarus', '2020-07-28 11:34:02'),
(20, 'm', '2004-09-16', 88, 'West Maudville', 'Belarus', '2020-07-28 11:34:02'),
(21, 'm', '2002-11-16', 56, 'South Mateo', 'Germany', '2020-07-28 11:34:02'),
(22, 'm', '2016-09-21', 17, 'Port Weston', 'Germany', '2020-07-28 11:34:02'),
(23, 'f', '2006-05-23', 14, 'Odiemouth', 'Germany', '2020-07-28 11:34:02'),
(24, 'f', '1973-06-15', 18, 'West Antwon', 'Belarus', '2020-07-28 11:34:02'),
(25, 'm', '2006-10-10', 48, 'Purdyton', 'Russian Federation', '2020-07-28 11:34:02'),
(26, 'f', '2015-04-15', 87, 'New Sharonmouth', 'Belarus', '2020-07-28 11:34:02'),
(27, 'f', '2019-05-26', 91, 'East Juliaborough', 'Germany', '2020-07-28 11:34:02'),
(28, 'm', '2010-06-01', 94, 'West Wilbertfurt', 'Belarus', '2020-07-28 11:34:02'),
(29, 'm', '2000-11-29', 94, 'Strosinmouth', 'Germany', '2020-07-28 11:34:02'),
(30, 'm', '1975-08-02', 90, 'Wittingmouth', 'Germany', '2020-07-28 11:34:02'),
(31, 'f', '1975-08-14', 66, 'Quitzonside', 'Germany', '2020-07-28 11:34:02'),
(32, 'f', '1983-09-13', 60, 'Damionside', 'Belarus', '2020-07-28 11:34:02'),
(33, 'm', '2018-05-22', 2, 'New Jerome', 'Russian Federation', '2020-07-28 11:34:02'),
(34, 'f', '2014-12-29', 27, 'Schoenport', 'Belarus', '2020-07-28 11:34:02'),
(35, 'm', '2019-01-25', 32, 'Lake Reesefort', 'Germany', '2020-07-28 11:34:02'),
(36, 'f', '1975-05-12', 76, 'West Martina', 'Germany', '2020-07-28 11:34:02'),
(37, 'm', '1982-02-01', 82, 'McCluremouth', 'Germany', '2020-07-28 11:34:02'),
(38, 'f', '1970-01-13', 84, 'Port Estella', 'Russian Federation', '2020-07-28 11:34:02'),
(39, 'f', '1994-09-15', 73, 'Boscochester', 'Belarus', '2020-07-28 11:34:02'),
(40, 'm', '2011-04-12', 12, 'Aliyahburgh', 'Belarus', '2020-07-28 11:34:02'),
(41, 'f', '1983-12-02', 40, 'South Opalton', 'Germany', '2020-07-28 11:34:02'),
(42, 'f', '2013-05-10', 62, 'South Lurlinefort', 'Russian Federation', '2020-07-28 11:34:02'),
(43, 'f', '1996-06-29', 93, 'Bobbiebury', 'Russian Federation', '2020-07-28 11:34:02'),
(44, 'f', '1975-12-03', 75, 'North June', 'Russian Federation', '2020-07-28 11:34:02'),
(45, 'f', '1986-03-15', 97, 'Port Georgiannaside', 'Germany', '2020-07-28 11:34:02'),
(46, 'm', '2018-04-18', 58, 'Jerdeton', 'Germany', '2020-07-28 11:34:02'),
(47, 'm', '1990-11-21', 98, 'North Bethfurt', 'Germany', '2020-07-28 11:34:02'),
(48, 'm', '1971-12-14', 17, 'South Marcellaborough', 'Germany', '2020-07-28 11:34:02'),
(49, 'm', '2018-05-10', 89, 'New Christiana', 'Russian Federation', '2020-07-28 11:34:02'),
(50, 'f', '2016-08-28', 96, 'Lake Lauryn', 'Germany', '2020-07-28 11:34:02'),
(51, 'm', '1993-12-10', 10, 'Fletatown', 'Germany', '2020-07-28 11:34:02'),
(52, 'f', '1997-12-27', 61, 'Port Blaisefurt', 'Belarus', '2020-07-28 11:34:02'),
(53, 'f', '1988-05-27', 74, 'West Jenniehaven', 'Russian Federation', '2020-07-28 11:34:02'),
(54, 'f', '1989-06-05', 86, 'Lake Turnertown', 'Russian Federation', '2020-07-28 11:34:02'),
(55, 'm', '1990-10-18', 7, 'Port Genesisland', 'Russian Federation', '2020-07-28 11:34:02'),
(56, 'm', '2014-01-04', 78, 'Wolfton', 'Russian Federation', '2020-07-28 11:34:02'),
(57, 'm', '2018-09-12', 67, 'Lake Emile', 'Belarus', '2020-07-28 11:34:02'),
(58, 'm', '2010-10-19', 1, 'Lexiton', 'Russian Federation', '2020-07-28 11:34:02'),
(59, 'f', '2015-07-22', 5, 'South Ramonburgh', 'Belarus', '2020-07-28 11:34:02'),
(60, 'm', '1997-11-16', 20, 'Coryport', 'Germany', '2020-07-28 11:34:02'),
(61, 'f', '1973-10-21', 83, 'Port Myles', 'Germany', '2020-07-28 11:34:02'),
(62, 'm', '1995-07-10', 57, 'West Brigitteshire', 'Belarus', '2020-07-28 11:34:02'),
(63, 'm', '1984-12-27', 33, 'New Albinside', 'Germany', '2020-07-28 11:34:02'),
(64, 'm', '1979-09-01', 96, 'Lake Leanne', 'Germany', '2020-07-28 11:34:02'),
(65, 'f', '2015-03-27', 77, 'West Willowview', 'Germany', '2020-07-28 11:34:02'),
(66, 'f', '2006-11-11', 100, 'Lurlineshire', 'Belarus', '2020-07-28 11:34:02'),
(67, 'f', '2004-08-05', 68, 'East Ardith', 'Belarus', '2020-07-28 11:34:02'),
(68, 'm', '1972-02-02', 41, 'South Clydeshire', 'Belarus', '2020-07-28 11:34:02'),
(69, 'm', '1986-02-25', 97, 'Lake Dustyville', 'Russian Federation', '2020-07-28 11:34:02'),
(70, 'm', '1983-08-09', 64, 'Waylonview', 'Germany', '2020-07-28 11:34:02'),
(71, 'f', '1983-11-05', 29, 'Gunnarland', 'Germany', '2020-07-28 11:34:02'),
(72, 'm', '1999-05-05', 53, 'Lake Cristian', 'Belarus', '2020-07-28 11:34:02'),
(73, 'm', '1991-08-16', 76, 'East Karson', 'Germany', '2020-07-28 11:34:02'),
(74, 'f', '2016-06-27', 20, 'Orlobury', 'Belarus', '2020-07-28 11:34:02'),
(75, 'f', '1974-08-17', 73, 'Marksland', 'Germany', '2020-07-28 11:34:02'),
(76, 'f', '1979-12-05', 6, 'Port Mayeland', 'Russian Federation', '2020-07-28 11:34:02'),
(77, 'f', '2007-09-19', 8, 'Julianamouth', 'Germany', '2020-07-28 11:34:02'),
(78, 'f', '1972-09-06', 21, 'Lake Friedastad', 'Germany', '2020-07-28 11:34:02'),
(79, 'f', '1979-02-03', 81, 'West Bentonstad', 'Belarus', '2020-07-28 11:34:02'),
(80, 'm', '1976-11-22', 41, 'Schuppeside', 'Russian Federation', '2020-07-28 11:34:02'),
(81, 'm', '2018-10-13', 63, 'New Princessfurt', 'Russian Federation', '2020-07-28 11:34:02'),
(82, 'f', '2009-01-21', 90, 'Jaskolskiport', 'Germany', '2020-07-28 11:34:02'),
(83, 'f', '1995-08-19', 59, 'Bretshire', 'Germany', '2020-07-28 11:34:02'),
(84, 'm', '1982-12-23', 26, 'North Natbury', 'Russian Federation', '2020-07-28 11:34:02'),
(85, 'f', '1996-11-08', 51, 'Abelville', 'Russian Federation', '2020-07-28 11:34:02'),
(86, 'f', '1972-04-20', 78, 'Lake Bennyburgh', 'Belarus', '2020-07-28 11:34:02'),
(87, 'm', '2000-04-03', 36, 'Pricefort', 'Belarus', '2020-07-28 11:34:02'),
(88, 'f', '2015-12-05', 46, 'Jadonhaven', 'Russian Federation', '2020-07-28 11:34:02'),
(89, 'm', '1974-02-06', 21, 'New Avachester', 'Germany', '2020-07-28 11:34:02'),
(90, 'f', '2006-12-28', 67, 'Kingshire', 'Belarus', '2020-07-28 11:34:02'),
(91, 'f', '2012-09-27', 72, 'Batzville', 'Germany', '2020-07-28 11:34:02'),
(92, 'f', '1974-02-21', 56, 'Stammborough', 'Russian Federation', '2020-07-28 11:34:02'),
(93, 'f', '2018-01-01', 66, 'East Tressietown', 'Russian Federation', '2020-07-28 11:34:02'),
(94, 'm', '1987-07-27', 62, 'O''Reillyborough', 'Russian Federation', '2020-07-28 11:34:02'),
(95, 'm', '2008-03-07', 11, 'Port Dovieberg', 'Germany', '2020-07-28 11:34:02'),
(96, 'f', '1971-08-01', 69, 'South Brettside', 'Russian Federation', '2020-07-28 11:34:02'),
(97, 'm', '2010-07-08', 12, 'North Tianastad', 'Russian Federation', '2020-07-28 11:34:02'),
(98, 'm', '1981-05-01', 53, 'West Albertohaven', 'Russian Federation', '2020-07-28 11:34:02'),
(99, 'f', '2001-09-06', 27, 'West Austynberg', 'Belarus', '2020-07-28 11:34:02'),
(100, 'f', '1990-08-14', 78, 'Lake Mina', 'Russian Federation', '2020-07-28 11:34:02'),
(101, 'f', '1981-11-22', 6, 'East Dalton', 'Russian Federation', '2020-07-28 11:34:02'),
(102, 'm', '1981-02-26', 98, 'Port Jamarbury', 'Germany', '2020-07-28 11:34:02'),
(103, 'm', '2007-08-28', 69, 'Babytown', 'Russian Federation', '2020-07-28 11:34:02'),
(104, 'f', '1975-09-30', 50, 'Torpbury', 'Russian Federation', '2020-07-28 11:34:02'),
(105, 'f', '1982-02-26', 41, 'Auermouth', 'Russian Federation', '2020-07-28 11:34:02'),
(106, 'f', '1994-09-21', 58, 'New Arnoldoville', 'Belarus', '2020-07-28 11:34:02'),
(107, 'm', '2005-08-12', 65, 'Lake Florine', 'Belarus', '2020-07-28 11:34:02'),
(108, 'f', '1979-12-04', 50, 'Port Neomaside', 'Belarus', '2020-07-28 11:34:02'),
(109, 'm', '1991-06-05', 56, 'East Letitia', 'Belarus', '2020-07-28 11:34:02'),
(110, 'm', '2017-02-05', 27, 'North Cordellshire', 'Russian Federation', '2020-07-28 11:34:02');

-- 
-- Вывод данных для таблицы messages
--
INSERT INTO messages VALUES
(1, 32, 63, 'Minus deserunt et quidem ut. Ut impedit veniam dolorum ea voluptatem suscipit deleniti. Vel soluta rerum est quod adipisci.', 1, 0, NULL, '2002-03-03 21:18:13', '2020-07-28 11:35:09'),
(2, 18, 3, 'Ea esse totam tempora voluptas quae quia. Eius corrupti eos dolor aut natus. Qui excepturi iste dolor libero quis.', 1, 0, NULL, '1993-10-12 21:31:34', '2020-07-28 11:35:09'),
(3, 58, 80, 'Consectetur et soluta minus perspiciatis. Labore eveniet eveniet omnis numquam fugit pariatur.', 0, 1, NULL, '2017-09-03 04:15:57', '2020-07-28 11:35:09'),
(4, 24, 83, 'Laboriosam explicabo ut et et voluptates sint. Vitae minima illum earum et. Officia blanditiis recusandae nostrum odit. Animi quaerat doloribus deserunt non.', 0, 0, NULL, '1977-06-19 11:15:43', '2020-07-28 11:35:09'),
(5, 42, 60, 'Aut sint rem vel laudantium eligendi quia possimus. Omnis sunt neque hic reprehenderit molestias. Repellat praesentium tempore voluptatem blanditiis est iste sit expedita. Vitae et quo maiores voluptatum nihil.', 0, 1, NULL, '1987-09-21 05:29:42', '2020-07-28 11:35:09'),
(6, 75, 94, 'Assumenda molestiae sapiente esse ut. Reiciendis in blanditiis veritatis ipsum ratione maxime odit non. Fugiat dolorum quam dignissimos rerum.', 0, 1, NULL, '1994-01-13 14:51:00', '2020-07-28 11:35:09'),
(7, 43, 33, 'Nihil earum consequatur voluptatem tempora. Amet ea voluptatem saepe vero et eius et. Nulla est nulla laudantium rerum dolorem veniam aliquam ratione. Asperiores repudiandae et officiis consequatur aut voluptatem incidunt.', 1, 0, NULL, '2006-06-04 06:39:49', '2020-07-28 11:35:09'),
(8, 36, 80, 'Fuga consequuntur et nam ratione beatae. Dolor ab temporibus praesentium. Ad facere qui voluptates sequi asperiores perspiciatis ipsa. In autem veritatis dolorem velit molestiae facilis.', 1, 1, NULL, '1976-07-21 02:49:05', '2020-07-28 11:35:09'),
(9, 91, 14, 'Officiis rerum soluta et qui quos. Debitis qui sint harum. Numquam ullam autem vel quisquam. Aut fugiat aut nesciunt rem voluptas possimus occaecati.', 0, 0, NULL, '2005-03-19 20:08:44', '2020-07-28 11:35:09'),
(10, 98, 48, 'Autem veniam natus quisquam numquam molestiae. Quaerat voluptatem minus nostrum placeat atque iure minima. Consequatur exercitationem commodi ullam unde neque molestiae odio. Deserunt animi aut nostrum porro qui autem.', 0, 0, NULL, '2017-12-18 15:41:36', '2020-07-28 11:35:09'),
(11, 44, 77, 'Consequuntur natus dolor eos repellat soluta aliquam unde. Illo facilis veniam sit voluptate consectetur nobis. Rerum sit voluptas facilis omnis aperiam provident recusandae.', 1, 1, NULL, '1989-07-22 03:48:29', '2020-07-28 11:35:09'),
(12, 51, 24, 'Ab sit qui dolorem eos incidunt. Dignissimos perferendis voluptatibus sequi. Ratione facere officia aperiam delectus.', 1, 0, NULL, '1980-11-13 07:54:29', '2020-07-28 11:35:09'),
(13, 67, 61, 'Enim nobis voluptas nulla voluptas repudiandae eum quaerat. Laboriosam recusandae accusantium rem nobis voluptatem. Repudiandae est est soluta. Inventore dolor fugiat molestiae optio et sint.', 1, 0, NULL, '1993-11-03 18:59:21', '2020-07-28 11:35:09'),
(14, 4, 38, 'Autem voluptatum quas consectetur. Est quasi sint non reiciendis laudantium optio rerum. Et tenetur ratione sed qui incidunt.', 1, 1, NULL, '2012-05-09 14:56:54', '2020-07-28 11:35:09'),
(15, 75, 60, 'Minus quia aut velit perferendis. Dolores dolor ea quia suscipit omnis omnis ut. Et explicabo vitae qui libero. Explicabo dolor tenetur ea iure nostrum similique.', 0, 1, NULL, '2019-05-19 16:10:06', '2020-07-28 11:35:09'),
(16, 74, 89, 'Aspernatur repudiandae eius sit sed. Sit ex qui blanditiis aliquid. Alias blanditiis eum aut ratione voluptas velit eos. Ratione consequatur quis excepturi libero.', 1, 0, NULL, '2006-06-13 20:20:43', '2020-07-28 11:35:09'),
(17, 24, 54, 'Architecto officiis voluptas dolorem et sint corrupti aperiam. Consequuntur aut illum modi voluptatem. Repellat aut quasi quia est quas vitae.', 0, 1, NULL, '2014-04-09 07:47:31', '2020-07-28 11:35:09'),
(18, 96, 18, 'Quaerat voluptas deleniti nobis. Possimus quaerat et suscipit alias totam facilis tempora.', 0, 1, NULL, '1972-10-25 09:20:20', '2020-07-28 11:35:09'),
(19, 1, 52, 'Eveniet id fugiat vel et voluptate molestias. Asperiores hic doloremque mollitia quas.', 0, 1, NULL, '1986-11-07 09:30:29', '2020-07-28 11:35:09'),
(20, 57, 29, 'Incidunt aut vero voluptates quo labore labore ut. Nam voluptate adipisci aut omnis dicta. Consequatur laborum qui ducimus sint error alias maxime. Omnis nam quia qui ducimus.', 1, 0, NULL, '2017-01-03 12:44:26', '2020-07-28 11:35:09'),
(21, 74, 83, 'Qui et eligendi voluptatem doloremque omnis aut ullam dolorem. Optio architecto dicta dignissimos aut tempore repudiandae soluta. Consectetur dolore fuga consequatur aut est sapiente. Nihil magnam voluptatem aut eligendi accusamus neque.', 0, 1, NULL, '2012-02-06 06:15:40', '2020-07-28 11:35:09'),
(22, 91, 7, 'Ut commodi quos rerum voluptatem rerum. Officia et cupiditate alias similique perferendis facere possimus. Doloribus tempore voluptatem reprehenderit repellat. Omnis cum at ullam optio voluptates.', 1, 0, NULL, '2003-08-09 16:40:57', '2020-07-28 11:35:09'),
(23, 62, 88, 'Autem rerum optio qui doloremque aut. Exercitationem aliquam est similique minus qui. Delectus est mollitia suscipit est consequatur quidem.', 0, 1, NULL, '2007-06-15 08:48:32', '2020-07-28 11:35:09'),
(24, 52, 98, 'Aut fugiat aliquam quibusdam iste. Quis porro odit sit porro voluptas sint. Eum ad ut nulla laboriosam omnis. Pariatur in fuga qui harum voluptatem.', 1, 0, NULL, '1988-12-20 16:38:28', '2020-07-28 11:35:09'),
(25, 32, 65, 'Aliquid voluptate voluptatem repellat voluptatum ut. Occaecati debitis et cumque soluta modi molestiae suscipit. Deserunt eum dolores voluptatem.', 1, 1, NULL, '1982-11-15 02:38:03', '2020-07-28 11:35:09'),
(26, 30, 54, 'Sit ea facilis eaque voluptatem eos. Voluptatibus voluptatibus recusandae vel et et et possimus. Pariatur tempora facere tempore ducimus omnis laboriosam sapiente. Delectus optio delectus sapiente voluptate est hic.', 1, 0, NULL, '1988-07-25 16:41:26', '2020-07-28 11:35:09'),
(27, 80, 37, 'Cumque rerum id iusto veritatis. Quaerat at dignissimos velit in. Excepturi odio sed voluptatem animi eligendi fugit.', 1, 0, NULL, '1995-12-11 11:32:59', '2020-07-28 11:35:09'),
(28, 45, 14, 'Officiis animi qui exercitationem necessitatibus aperiam quisquam sed aut. Voluptatem nostrum esse quod nobis quaerat.', 1, 0, NULL, '1978-06-06 00:53:21', '2020-07-28 11:35:09'),
(29, 32, 19, 'Vel non distinctio eos sit dolor et aliquid. Velit quisquam non quae sed et rerum. Quia numquam doloremque facilis deleniti fugiat et.', 0, 0, NULL, '1982-02-02 22:22:30', '2020-07-28 11:35:09'),
(30, 99, 38, 'Placeat nemo illo ut non. Quos dolores fugiat corrupti possimus suscipit dolorem dolorem. Non quis autem deleniti eos officiis. Eius asperiores expedita sed ipsam iusto ut quia.', 0, 1, NULL, '1985-10-18 10:26:11', '2020-07-28 11:35:09'),
(31, 91, 41, 'Perspiciatis autem error deleniti. Architecto eum consequatur repellendus cum et sint. Eum esse qui asperiores impedit occaecati magnam quaerat officiis.', 0, 0, NULL, '1992-10-28 07:12:53', '2020-07-28 11:35:09'),
(32, 33, 40, 'Dolore tempore velit eveniet ut non molestiae autem. Quo neque consequatur quo quo perferendis quo dolorem. Iure et voluptate qui qui in nisi magni. Molestiae eos eos ut autem maiores. Provident perferendis laboriosam at distinctio explicabo ea voluptas.', 1, 0, NULL, '2015-02-28 13:47:55', '2020-07-28 11:35:09'),
(33, 100, 81, 'Quo molestias rerum tempora voluptatibus non aliquam. Quis explicabo est dicta ea et. Sit architecto earum doloribus.', 0, 0, NULL, '2017-12-18 20:16:37', '2020-07-28 11:35:09'),
(34, 6, 84, 'Aperiam maxime maiores quia laboriosam. Eligendi ipsa perspiciatis et rerum. Quia libero fugiat assumenda. Ipsa ipsa sapiente facere dolor. In qui laudantium quaerat et rem harum.', 1, 1, NULL, '1982-08-22 06:04:29', '2020-07-28 11:35:09'),
(35, 2, 56, 'Ut sint non dignissimos expedita voluptatem minima pariatur. Provident eveniet voluptatibus voluptas in animi eveniet iure. Aspernatur hic corrupti itaque ut saepe vero.', 0, 1, NULL, '1994-09-12 14:31:44', '2020-07-28 11:35:09'),
(36, 74, 2, 'Vel nihil aut reprehenderit aut rerum laudantium illum. Sint pariatur molestiae voluptatibus quas aperiam dolor dolorem dolorem. Temporibus cupiditate ea rerum sunt earum.', 1, 1, NULL, '1974-01-15 13:18:39', '2020-07-28 11:35:09'),
(37, 88, 32, 'Magni optio est recusandae qui aut distinctio. Sequi explicabo beatae qui est beatae. Incidunt ab mollitia reprehenderit fugit et soluta. Architecto consequuntur blanditiis consequatur dolores ratione assumenda dolores. Nostrum repellat cum consectetur quibusdam.', 0, 0, NULL, '1971-06-15 04:51:21', '2020-07-28 11:35:09'),
(38, 95, 81, 'Natus voluptatibus dolorem sunt molestiae vitae consequatur ipsum. Ipsam omnis aut et iure nesciunt ut. Sit commodi et aut at at. Iste reiciendis nostrum saepe a quia est voluptatibus.', 1, 0, NULL, '1982-07-05 23:00:33', '2020-07-28 11:35:09'),
(39, 19, 52, 'Aut ut harum quisquam similique eos recusandae earum. Accusamus suscipit voluptates aliquid molestiae beatae explicabo. Velit assumenda voluptatem quasi sed ad. Quis ipsam autem et voluptas provident molestiae ad.', 0, 0, NULL, '1970-08-25 16:33:16', '2020-07-28 11:35:09'),
(40, 2, 53, 'Odit et quia dignissimos impedit. Itaque sequi temporibus itaque quia reiciendis. Quasi nostrum beatae quia. Dolorem quaerat voluptate minima quasi.', 1, 1, NULL, '2014-09-23 02:18:18', '2020-07-28 11:35:09'),
(41, 57, 26, 'Asperiores autem eveniet non natus a aspernatur. Quo ea doloribus omnis dolorem debitis. Laudantium praesentium incidunt qui nisi maiores est.', 1, 0, NULL, '1997-03-13 10:29:53', '2020-07-28 11:35:09'),
(42, 57, 10, 'Cupiditate quia sit nostrum rerum laboriosam repellat. Id amet vero tempora omnis facilis. Placeat molestiae sed debitis fuga. In qui tenetur repudiandae vero similique nobis debitis.', 1, 0, NULL, '1976-09-05 06:28:50', '2020-07-28 11:35:09'),
(43, 77, 54, 'Sint et quo ut saepe voluptatum. Doloribus quam ab repellendus fugit voluptatem et. Asperiores est quisquam esse molestias qui. Numquam vel et quo mollitia.', 1, 0, NULL, '2000-12-31 07:35:16', '2020-07-28 11:35:09'),
(44, 39, 31, 'Aut deserunt quae eligendi provident. Eveniet nulla voluptatem molestias ut dignissimos. Dolore delectus architecto autem aut. Nulla eius ut possimus id voluptas eaque minima iure.', 1, 1, NULL, '1999-05-01 02:08:06', '2020-07-28 11:35:09'),
(45, 37, 92, 'Magnam natus quia et iste excepturi rerum. Nobis et facilis itaque. Beatae inventore fuga nesciunt nihil.', 0, 1, NULL, '1986-01-27 08:37:39', '2020-07-28 11:35:09'),
(46, 49, 67, 'Odit itaque hic qui dolores perferendis ratione. Rerum qui incidunt totam. Dolores laboriosam deserunt dolorem consequatur qui et. Ea quia doloremque consectetur consequatur et nihil hic.', 0, 1, NULL, '1979-11-16 20:32:27', '2020-07-28 11:35:09'),
(47, 88, 39, 'Et occaecati enim repellat non temporibus. Quo molestiae sequi libero fuga provident quasi. Velit sed iste sed maxime sit enim qui. A quia non voluptatem voluptatum.', 1, 1, NULL, '1998-12-04 10:52:58', '2020-07-28 11:35:09'),
(48, 32, 43, 'Tenetur odit laudantium quae rem aspernatur qui. Et et sapiente delectus itaque et enim ullam. Et cum quae voluptatem vel quisquam non.', 1, 0, NULL, '2015-11-03 21:07:25', '2020-07-28 11:35:09'),
(49, 19, 65, 'Vitae vel omnis soluta et illo asperiores est. In est fuga vero minima et voluptatem nulla. Cum atque corporis et quaerat eum facilis consequatur. Enim omnis voluptate enim aspernatur qui repudiandae nihil.', 0, 1, NULL, '1971-08-12 10:00:05', '2020-07-28 11:35:09'),
(50, 68, 42, 'Laborum sit pariatur alias occaecati veritatis id cumque. Qui molestiae architecto blanditiis et eos. Ea magni unde enim autem. Voluptatibus mollitia asperiores doloribus in.', 1, 0, NULL, '2016-11-30 11:36:27', '2020-07-28 11:35:09'),
(51, 6, 4, 'Placeat voluptas quasi sed quo dolor id cum. Animi quod eum excepturi voluptatibus totam officia ad. Sed voluptatem recusandae sunt quos. Et consequatur unde sapiente non tenetur. Illum mollitia esse sint aperiam rem cumque eos qui.', 1, 1, NULL, '2003-05-20 13:35:04', '2020-07-28 11:35:09'),
(52, 1, 93, 'Quisquam tempora rerum sed ab ex error itaque. Minima velit voluptatum aut. Exercitationem necessitatibus sed illum repellat. Alias omnis et odit vero qui et omnis.', 1, 0, NULL, '2007-03-27 06:03:24', '2020-07-28 11:35:09'),
(53, 61, 24, 'Vel aut et nesciunt. Fugit enim quo beatae qui voluptatem doloremque modi. Autem sit sit dolor possimus voluptatem. Nemo accusantium dolor ut eos.', 0, 1, NULL, '1998-07-18 22:08:09', '2020-07-28 11:35:09'),
(54, 39, 21, 'Quia omnis beatae est suscipit est. Labore vel asperiores ratione autem voluptatum qui ea. Quam in voluptatum consequatur magni ratione enim. Nesciunt qui aut cupiditate enim sint quia.', 1, 0, NULL, '1973-07-23 22:12:33', '2020-07-28 11:35:09'),
(55, 90, 83, 'Cumque omnis error qui. Id aut odit non reprehenderit et. Sed illum ut sed molestiae soluta. Pariatur voluptatibus odio est et nihil quidem.', 1, 1, NULL, '2013-01-16 17:09:36', '2020-07-28 11:35:09'),
(56, 47, 83, 'Quia occaecati ad voluptate. Ea asperiores dolorem error aperiam sunt. Est ut commodi et eaque nisi sapiente illo.', 1, 1, NULL, '2016-01-04 14:26:39', '2020-07-28 11:35:09'),
(57, 74, 22, 'Aliquam enim incidunt cum voluptas quisquam. Pariatur velit magni repudiandae eaque optio. Aperiam a voluptate harum voluptates corrupti quos. Cupiditate eos ipsa quia et. Ullam aut et excepturi qui in.', 1, 1, NULL, '1973-01-13 06:57:06', '2020-07-28 11:35:09'),
(58, 85, 59, 'Quod nemo facere temporibus perspiciatis. Dolorum qui facilis sit quos similique voluptates aut. Esse quidem consequuntur eligendi et in. Earum cumque nobis cumque architecto vero. Rerum voluptatem dignissimos vel magnam et nobis ea.', 1, 1, NULL, '1992-07-08 21:59:57', '2020-07-28 11:35:09'),
(59, 40, 23, 'Magni expedita et aut exercitationem. Voluptas fuga facere eligendi tempora voluptatem eum reiciendis. Fugiat accusantium aspernatur asperiores quae et. Sunt dolor veritatis voluptatum quasi.', 1, 1, NULL, '2002-07-09 05:54:02', '2020-07-28 11:35:09'),
(60, 95, 5, 'Perferendis perspiciatis consequuntur eum. Ipsum voluptatum non cum harum. Eaque dolorum qui perspiciatis consequatur molestiae numquam. Distinctio voluptatem sunt cum et ipsam facilis cum.', 1, 0, NULL, '2008-08-05 21:16:12', '2020-07-28 11:35:09'),
(61, 40, 85, 'Et illum excepturi vel aliquam est veritatis. Dolorem sit autem ad earum hic eos. Nihil doloremque architecto sunt laboriosam debitis quod molestiae.', 1, 0, NULL, '1990-03-18 07:03:06', '2020-07-28 11:35:09'),
(62, 3, 59, 'Quisquam et sed ut ipsam odio. At quo fugiat neque laudantium voluptas tenetur aspernatur alias. Quo non ratione sed nam.', 0, 1, NULL, '2015-05-19 19:09:43', '2020-07-28 11:35:09'),
(63, 85, 49, 'Culpa perspiciatis quo at nulla itaque voluptates ut quo. Consequatur omnis velit occaecati voluptas quo enim nobis. Et magnam nihil cumque ex quis et perspiciatis debitis. Et molestiae quia perferendis odit.', 1, 0, NULL, '1989-04-04 22:00:06', '2020-07-28 11:35:09'),
(64, 88, 92, 'Quibusdam voluptate est ullam debitis sint rerum cupiditate. Vel quod consequuntur quod quae voluptatem impedit. Iusto quo sit eos rerum eos soluta cum. Saepe recusandae totam facilis qui delectus sint adipisci.', 1, 0, NULL, '2019-09-14 17:03:20', '2020-07-28 11:35:09'),
(65, 96, 3, 'Fugiat eius blanditiis sit sint. Quis eveniet dicta sit rerum. Quam itaque et commodi atque saepe consequatur repudiandae. Incidunt praesentium quia molestiae facere odio velit est modi.', 1, 0, NULL, '1976-04-10 17:59:36', '2020-07-28 11:35:09'),
(66, 28, 30, 'Placeat vero eum quis maiores sed. Voluptatum quae velit quia minima illo. Ut cumque ipsum et delectus et.', 0, 0, NULL, '2016-08-26 08:06:03', '2020-07-28 11:35:09'),
(67, 67, 45, 'Eum cumque quis officiis minima. Quae voluptas rerum et non. In harum delectus alias aut culpa. Vel dolor accusamus sint et.', 1, 1, NULL, '2000-04-18 00:48:20', '2020-07-28 11:35:09'),
(68, 23, 78, 'Repellat voluptates est labore reprehenderit et. Esse ipsam vel aut aut porro. Ea sit optio nam eos.', 1, 1, NULL, '1989-07-12 03:24:57', '2020-07-28 11:35:09'),
(69, 19, 64, 'Fugiat quo ut nobis et quos delectus dolorem consectetur. Soluta inventore commodi consequatur labore qui modi. Mollitia explicabo inventore mollitia.', 0, 0, NULL, '2010-05-13 13:05:56', '2020-07-28 11:35:09'),
(70, 62, 17, 'Inventore eos quod ea. Quia aut laboriosam est quos sint. Esse architecto amet rem ut iure explicabo odit. Velit minus modi voluptatem modi sequi necessitatibus.', 0, 1, NULL, '2017-02-08 16:23:09', '2020-07-28 11:35:09'),
(71, 97, 36, 'Aspernatur autem non earum magni qui. Ut sit reprehenderit hic sit consequatur asperiores libero. Officiis magnam eum nihil magni.', 1, 1, NULL, '1989-01-18 16:27:27', '2020-07-28 11:35:09'),
(72, 88, 31, 'Ut maxime aliquam veniam perspiciatis illo ullam. Non sed velit aperiam quam. Nesciunt voluptatem esse omnis iste in assumenda. Quia minus est rerum aut.', 0, 1, NULL, '2005-01-31 07:17:05', '2020-07-28 11:35:09'),
(73, 91, 62, 'Qui eaque est odio ipsa. Dolorem sunt eligendi dignissimos facere. Enim commodi accusamus iste. Fugit corrupti praesentium consequuntur dignissimos aliquid vel itaque dolorum.', 1, 0, NULL, '1991-12-28 21:25:11', '2020-07-28 11:35:09'),
(74, 37, 97, 'Distinctio et est quis atque voluptas mollitia. Architecto itaque est officia sit enim nemo. Repellat quisquam fugiat sunt dolor vero. Excepturi quod sed ut cumque.', 1, 0, NULL, '1983-04-26 05:30:34', '2020-07-28 11:35:09'),
(75, 75, 84, 'Tempore et laudantium recusandae id. Autem optio aut aut tempora minus. Aut consectetur fuga voluptates molestiae aperiam ab tempore harum.', 1, 0, NULL, '2017-08-01 16:35:00', '2020-07-28 11:35:09'),
(76, 95, 21, 'Quam dolor accusantium aliquam ea rerum cum. Consequuntur soluta laudantium molestiae quae. Voluptatibus doloribus quod reiciendis.', 1, 1, NULL, '1991-01-20 10:51:04', '2020-07-28 11:35:09'),
(77, 19, 32, 'Tempora provident nisi dolores saepe autem temporibus quam. Officia doloribus illo dolor et est qui quod. Laudantium sint vitae consequuntur necessitatibus fugit et.', 1, 0, NULL, '1976-12-31 12:08:57', '2020-07-28 11:35:09'),
(78, 2, 12, 'Sint expedita soluta magnam similique quos repellat ducimus. Exercitationem alias corporis quae corrupti asperiores magni amet tenetur. Voluptates sed maxime voluptatem laudantium occaecati quod quia perferendis. Cupiditate sed rerum ut est sunt.', 1, 1, NULL, '1973-04-27 20:51:06', '2020-07-28 11:35:09'),
(79, 55, 39, 'Voluptas fugiat iste ullam esse. Deserunt sed fugit modi eius dolorem. Doloremque incidunt repellendus praesentium placeat et aut. Non dolor dolore veniam cupiditate qui temporibus. Ex vero dignissimos est consequuntur.', 1, 1, NULL, '1971-10-04 12:50:08', '2020-07-28 11:35:09'),
(80, 30, 34, 'Asperiores inventore in accusantium. Repudiandae voluptates ullam numquam qui. Eveniet nobis labore ipsum quaerat voluptas nam.', 1, 0, NULL, '2000-08-28 17:47:33', '2020-07-28 11:35:09'),
(81, 76, 81, 'Corporis ratione ratione quod officiis temporibus. Ut quaerat eum aliquid nisi. Quae nam neque deserunt.', 0, 0, NULL, '2019-11-19 08:04:03', '2020-07-28 11:35:09'),
(82, 74, 26, 'Aliquam est deleniti ut necessitatibus id temporibus. Laboriosam sit incidunt quod tenetur perspiciatis numquam fuga. Accusamus quisquam voluptas id deserunt. Dolorem dolore alias aut adipisci temporibus.', 1, 0, NULL, '1992-08-20 05:59:44', '2020-07-28 11:35:09'),
(83, 10, 71, 'Itaque facere reprehenderit eaque ut quam vero ut. Veniam doloremque numquam nam in. Perferendis culpa in est quis. Sit id quo iure.', 1, 0, NULL, '1990-05-30 07:30:39', '2020-07-28 11:35:09'),
(84, 23, 4, 'Natus odit inventore nesciunt doloremque consequuntur earum aut. Voluptates et consequatur eaque et. Cum eaque voluptatum similique iure.', 1, 1, NULL, '1977-04-08 18:41:46', '2020-07-28 11:35:09'),
(85, 51, 39, 'Et iste iste dolorem non officiis et voluptates reiciendis. Rerum hic accusantium esse quia.', 1, 0, NULL, '2007-03-27 18:53:43', '2020-07-28 11:35:09'),
(86, 44, 2, 'Suscipit voluptatem ut architecto facilis vel. Ex ab placeat sequi facere tempore quod. Recusandae veniam harum quidem voluptates reiciendis.', 1, 1, NULL, '1991-04-08 11:39:48', '2020-07-28 11:35:09'),
(87, 79, 89, 'Exercitationem quis libero consequatur reiciendis. Facere reprehenderit quas quisquam qui. Occaecati nesciunt pariatur facere iusto qui fugiat.', 1, 0, NULL, '1974-02-15 06:33:52', '2020-07-28 11:35:09'),
(88, 8, 71, 'Deserunt dignissimos totam iste rem occaecati hic non. Quia repellat qui impedit dolorum sit voluptas. Beatae ducimus occaecati et ut non quam sit nesciunt. Et eaque odio modi labore vitae occaecati temporibus.', 1, 1, NULL, '1970-04-20 09:35:43', '2020-07-28 11:35:09'),
(89, 32, 47, 'Et consequatur dolor ut voluptatem dolores dolorum aperiam. Provident quis facilis rerum sed optio iste. Unde temporibus unde atque fuga vero dicta. Qui consequatur illum iste minima voluptate.', 0, 1, NULL, '1991-06-12 14:04:57', '2020-07-28 11:35:09'),
(90, 39, 52, 'Natus quia ab explicabo possimus voluptas porro. Placeat aut debitis quidem. Et eum sapiente repellat est quaerat rerum.', 0, 0, NULL, '1991-06-19 17:29:13', '2020-07-28 11:35:09'),
(91, 43, 58, 'Ad officia consequuntur nisi nobis. Et consectetur deleniti amet quas non. At porro vitae dolore quo voluptatem ut explicabo. Est aspernatur incidunt quasi ut placeat eius dicta pariatur.', 1, 0, NULL, '2013-07-30 09:20:50', '2020-07-28 11:35:09'),
(92, 61, 31, 'Earum praesentium suscipit soluta. Error molestias aperiam tenetur culpa sint. Fuga voluptas explicabo recusandae dolore. Ut reiciendis minus accusamus ipsum quasi eveniet.', 0, 1, NULL, '1980-09-12 13:57:28', '2020-07-28 11:35:09'),
(93, 72, 67, 'Quam harum sed amet unde. Ut repellat reiciendis hic esse reprehenderit nulla nihil. Rerum ea animi explicabo veniam dolores incidunt ad sint. Ea provident error veniam expedita.', 1, 1, NULL, '2003-08-21 16:48:35', '2020-07-28 11:35:09'),
(94, 18, 90, 'Numquam nihil natus cumque dolor tempora nisi earum. Dolores dolor et et et aut sed facere. Consequatur alias repudiandae dolor molestias illo doloremque. Quasi minima neque facilis illum consequatur.', 1, 1, NULL, '1983-09-19 02:39:31', '2020-07-28 11:35:09'),
(95, 95, 4, 'Libero reprehenderit quia adipisci magni. Qui cupiditate esse qui nesciunt. Blanditiis maxime excepturi reiciendis praesentium consequuntur qui architecto.', 0, 1, NULL, '2011-06-06 11:21:54', '2020-07-28 11:35:09'),
(96, 34, 57, 'Eos harum voluptas ut rerum aut eos et. Harum explicabo placeat harum hic quia. Dolore odit illum laudantium non.', 1, 0, NULL, '2000-12-12 18:15:05', '2020-07-28 11:35:09'),
(97, 84, 46, 'Labore ut et magnam beatae amet repudiandae. Deserunt id nihil perspiciatis sed iste minus architecto perferendis. Rerum dolore dolores harum eveniet nisi qui libero.', 0, 0, NULL, '2007-06-15 02:55:06', '2020-07-28 11:35:09'),
(98, 79, 56, 'Est laborum commodi quod. Numquam quia architecto itaque voluptas. Dolorum exercitationem rem consequatur error. At eligendi voluptas possimus adipisci.', 0, 0, NULL, '2010-06-24 16:56:36', '2020-07-28 11:35:09'),
(99, 42, 43, 'Pariatur alias error enim. Necessitatibus non aut et error dolores dolor eligendi. Molestiae eligendi omnis dolore eveniet non consequatur. Alias est eum consequuntur et tenetur quia nesciunt.', 1, 1, NULL, '1972-11-10 23:49:46', '2020-07-28 11:35:09'),
(100, 86, 4, 'Eveniet minus est impedit quis. Quos facilis reiciendis cum accusantium illo. Illum est quam illo voluptatibus sit autem non repellat. Temporibus fugiat sit perspiciatis.', 1, 1, NULL, '2006-02-28 03:00:03', '2020-07-28 11:35:09');

-- 
-- Вывод данных для таблицы media_types
--
INSERT INTO media_types VALUES
(1, 'photo', '2020-07-28 11:36:15'),
(2, 'video', '2020-07-28 11:36:15'),
(3, 'audio', '2020-07-28 11:36:15');

-- 
-- Вывод данных для таблицы likes
--
-- Таблица vk.likes не содержит данных

-- 
-- Вывод данных для таблицы friendship_history
--
-- Таблица vk.friendship_history не содержит данных

-- 
-- Вывод данных для таблицы communities_users
--
INSERT INTO communities_users VALUES
(1, 5, '1980-08-28 13:47:29'),
(1, 42, '1987-07-19 11:36:08'),
(1, 53, '1971-05-27 07:57:58'),
(1, 65, '1999-05-21 18:19:08'),
(1, 98, '1980-09-18 20:46:34'),
(1, 99, '1975-08-30 11:38:33'),
(2, 30, '1997-02-07 16:28:55'),
(2, 52, '1970-12-30 12:17:39'),
(2, 76, '1991-02-22 09:56:00'),
(2, 82, '1999-02-11 01:24:42'),
(3, 15, '1971-08-13 05:01:08'),
(3, 20, '2015-07-10 09:26:27'),
(3, 58, '2011-03-29 20:29:39'),
(3, 67, '1980-07-13 14:54:51'),
(3, 68, '1987-07-22 03:25:19'),
(3, 69, '2009-05-04 02:16:09'),
(3, 84, '2018-09-24 03:45:55'),
(3, 86, '1997-07-26 16:42:49'),
(3, 100, '1975-01-22 20:13:44'),
(4, 59, '2000-08-15 06:53:47'),
(4, 95, '2008-07-31 08:50:44'),
(5, 38, '1994-09-28 22:37:18'),
(6, 1, '2005-02-21 11:55:24'),
(6, 13, '1999-11-30 14:53:33'),
(6, 26, '1971-12-30 08:08:11'),
(6, 71, '1984-12-18 04:07:06'),
(6, 80, '1986-11-15 18:29:11'),
(6, 83, '1989-05-12 14:43:15'),
(7, 16, '2000-12-02 03:22:54'),
(7, 17, '1994-03-19 11:53:46'),
(7, 56, '2003-01-28 15:36:38'),
(7, 70, '2010-09-18 01:00:24'),
(7, 88, '1985-09-16 17:10:06'),
(8, 62, '1971-10-27 06:23:56'),
(8, 72, '1993-10-27 02:55:09'),
(8, 79, '1993-01-18 13:31:53'),
(8, 81, '2004-01-22 06:38:11'),
(8, 92, '1985-11-14 23:42:18'),
(9, 14, '2007-09-20 14:53:09'),
(9, 32, '1998-04-21 00:36:27'),
(9, 33, '1982-07-11 10:26:34'),
(9, 36, '2010-04-04 16:03:58'),
(9, 64, '1992-11-05 18:05:08'),
(9, 96, '2007-02-04 20:13:06'),
(10, 39, '2017-06-01 07:26:09'),
(10, 50, '1998-08-28 23:33:35'),
(10, 51, '2013-03-21 08:51:49'),
(10, 60, '2003-06-08 01:54:23'),
(11, 2, '1978-10-06 10:56:31'),
(11, 9, '2010-09-30 09:10:00'),
(11, 24, '2016-03-30 12:40:42'),
(11, 31, '2009-03-14 03:29:42'),
(11, 47, '1982-11-08 08:03:07'),
(11, 87, '1995-04-14 09:41:53'),
(12, 25, '1986-07-20 23:39:49'),
(12, 46, '1975-05-10 07:12:07'),
(12, 49, '2020-07-21 11:17:00'),
(12, 75, '1979-08-03 00:01:36'),
(12, 77, '2000-02-24 14:27:30'),
(13, 28, '1998-06-27 17:49:33'),
(13, 40, '1987-11-07 15:39:10'),
(13, 91, '1980-07-29 02:38:50'),
(14, 10, '1996-03-13 03:41:31'),
(14, 12, '1986-08-29 07:32:46'),
(14, 19, '1996-04-02 07:02:57'),
(14, 21, '1974-02-19 19:07:19'),
(14, 23, '1996-03-06 10:11:10'),
(14, 27, '1975-07-03 09:57:24'),
(14, 85, '1988-11-01 05:05:17'),
(14, 97, '1995-07-12 20:45:13'),
(15, 4, '2018-03-30 10:50:44'),
(15, 11, '1978-10-14 13:50:51'),
(15, 18, '2020-07-20 08:30:27'),
(15, 61, '2012-08-05 20:12:45'),
(15, 63, '2020-06-26 23:51:26'),
(16, 7, '1985-01-19 10:17:57'),
(16, 34, '2017-03-01 18:46:00'),
(16, 35, '1990-10-06 20:36:40'),
(16, 41, '2018-11-28 21:16:32'),
(16, 43, '1971-10-09 10:31:11'),
(17, 44, '2002-12-18 18:55:21'),
(17, 45, '2011-10-11 08:45:03'),
(17, 48, '1973-12-27 15:34:51'),
(17, 54, '1975-06-23 19:01:25'),
(17, 57, '1987-04-11 07:31:09'),
(17, 66, '1986-04-13 01:54:20'),
(17, 78, '1983-06-24 19:55:28'),
(17, 94, '2013-05-27 09:13:36'),
(18, 3, '2016-08-12 05:39:09'),
(19, 22, '1996-12-16 23:09:35'),
(19, 37, '1971-02-18 02:47:15'),
(19, 55, '1976-12-22 22:03:58'),
(19, 74, '1980-06-25 11:29:08'),
(19, 90, '2009-12-30 23:25:22'),
(20, 6, '2014-05-27 05:08:43'),
(20, 8, '2000-01-25 07:47:40'),
(20, 29, '1999-08-04 05:30:43'),
(20, 73, '1993-05-19 10:55:27'),
(20, 89, '1997-06-10 22:35:11'),
(20, 93, '2007-04-19 11:41:32');

-- 
-- Вывод данных для таблицы communities
--
INSERT INTO communities VALUES
(1, 'officia', '2008-07-23 07:10:48', '1992-11-09 01:20:07'),
(2, 'quidem', '2016-08-29 16:06:21', '1999-05-06 20:54:56'),
(3, 'vel', '2018-06-12 16:25:17', '1987-10-06 14:44:30'),
(4, 'deserunt', '2018-06-22 11:33:04', '1978-12-14 01:02:00'),
(5, 'molestias', '2006-07-16 18:38:17', '2001-05-08 17:58:13'),
(6, 'non', '1986-12-08 15:18:53', '1977-01-19 06:57:31'),
(7, 'est', '1986-01-26 11:35:24', '2007-10-26 16:21:10'),
(8, 'sit', '2014-01-25 20:04:47', '1985-12-07 01:16:32'),
(9, 'quae', '1991-12-11 22:03:45', '2003-11-20 09:17:23'),
(10, 'qui', '2004-12-05 16:08:20', '1985-02-27 10:38:21'),
(11, 'veniam', '2016-03-04 17:43:11', '1983-02-04 05:02:21'),
(12, 'ex', '2017-03-11 08:39:29', '1973-06-17 01:12:29'),
(13, 'quasi', '1974-01-14 13:03:19', '2018-07-15 01:04:27'),
(14, 'ducimus', '1989-05-16 22:04:02', '1981-11-15 19:01:52'),
(15, 'aut', '1971-04-03 17:00:37', '2010-10-17 23:29:15'),
(16, 'nesciunt', '1998-05-09 23:49:03', '1980-06-27 21:18:32'),
(17, 'at', '1974-02-10 14:25:04', '2012-09-15 18:16:13'),
(18, 'amet', '1992-05-01 13:23:47', '2018-03-12 10:27:19'),
(19, 'ipsum', '2015-03-19 20:37:51', '2004-01-21 06:33:49'),
(20, 'nihil', '2019-11-17 16:03:58', '1975-02-05 00:34:47');

-- 
-- Восстановить предыдущий режим SQL (SQL mode)
--
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Включение внешних ключей
-- 
/*!40014 SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS */;