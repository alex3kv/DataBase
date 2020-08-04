-- Таблица лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  target_id INT UNSIGNED NOT NULL,
  target_type_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);
-- Создать и заполнить таблицы лайков и постов.

-- Таблица типов лайков
DROP TABLE IF EXISTS target_types;
CREATE TABLE target_types (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO target_types (name) VALUES 
  ('messages'),
  ('users'),
  ('media'),
  ('posts');

-- Заполняем лайки
INSERT INTO likes 
  SELECT 
    id, 
    FLOOR(1 + (RAND() * 100)), 
    FLOOR(1 + (RAND() * 100)),
    FLOOR(1 + (RAND() * 4)),
    CURRENT_TIMESTAMP 
  FROM messages;

-- Проверим
SELECT * FROM likes LIMIT 10;

-- Создадим таблицу постов
CREATE TABLE posts (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  community_id INT UNSIGNED,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  is_public BOOLEAN DEFAULT TRUE,
  is_archived BOOLEAN DEFAULT FALSE,
  views_counter INT UNSIGNED DEFAULT 0,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Заполняем таблицу постов
INSERT INTO posts VALUES ('1','37','4','Qui eveniet aut quis voluptatem accusamus.','Et voluptates tenetur libero aut similique ut non. Non fugiat et consectetur. Quos reiciendis illo aut non ullam. Illum dolore architecto autem eius.','78','1','0','997106675','1983-09-24 11:25:26','1981-03-14 06:49:06'),
('2','89','19','Sit consequuntur ad itaque inventore.','Deleniti assumenda dolore cum sequi cum et modi. Et voluptas omnis beatae voluptate. Quis excepturi officiis repellendus consequatur hic ut.','66','0','0','42966','2004-03-18 10:20:04','1990-12-21 12:31:31'),
('3','51','16','Maiores iste nemo laborum optio.','Natus atque labore in consequatur non qui architecto. Sint sunt praesentium iure vero ea porro itaque. A placeat dolores illum atque dolorum. Placeat error aliquam minus voluptas aut et.','54','1','1','756301','1990-08-20 22:02:00','1982-12-16 17:56:06'),
('4','93','7','Aut quam rerum dolore modi sapiente modi consectetur.','Delectus in magnam perferendis. Tempora magni velit dolor fugiat. Magnam ut molestiae animi consectetur aut iste vitae. Aperiam qui velit ut quas.','70','0','0','64146','1971-07-04 22:07:11','1982-08-23 16:59:16'),
('5','32','14','Et accusamus nemo accusamus sequi culpa.','Est a quae tenetur odit consequatur. Expedita unde aut recusandae eveniet officia qui pariatur. Ut eum numquam necessitatibus consequatur et corrupti.','49','1','0','25180095','1999-01-03 07:52:35','1984-05-26 05:40:53'),
('6','51','16','Ut possimus facere nihil et sapiente.','Id aut voluptatem perspiciatis sed sed enim quisquam aut. Quia dolores et quos animi enim. Et aliquam quisquam est. Libero laudantium voluptatum quisquam.','59','0','1','122461','1997-05-17 02:27:26','1974-01-28 15:56:14'),
('7','92','13','Earum aut quae tenetur ipsam qui et nihil.','Et et dolor quidem quasi. Porro unde aspernatur voluptas assumenda illo asperiores.','55','0','0','756','2005-06-29 21:29:32','1993-05-12 19:13:54'),
('8','11','19','Voluptatem libero iste qui eum qui.','Dolores asperiores quia velit neque harum dolorem. Accusantium quas odit fugit. Atque tempora omnis tenetur ut pariatur. Quia itaque est quis quisquam.','36','1','0','0','2002-04-07 03:16:21','1979-04-20 11:01:39'),
('9','42','14','Labore minima harum eum vel adipisci quod quo.','Nemo voluptatibus qui enim nam ut omnis minus consectetur. Sit recusandae nisi in quae et tempora sit earum. Iusto minima rerum nostrum quis.','94','0','1','0','1991-02-18 18:40:37','2008-01-02 09:16:29'),
('10','32','16','Laudantium aspernatur eos fugiat ea sit repudiandae aut.','Ut qui enim commodi necessitatibus dolorem quis. Ea modi atque dolor impedit ducimus. Ullam ex in suscipit rerum.','31','1','0','857','2009-03-17 05:05:16','2015-01-12 06:50:20'),
('11','99','2','Consequatur iure deleniti aut enim odio eum autem reiciendis.','Voluptatem et odit incidunt at labore est eius. Non illum nihil fugit quia. Natus eius quod voluptatem consequatur recusandae qui eaque.','20','0','0','37417','1987-08-03 19:39:12','2008-08-24 07:10:40'),
('12','29','15','Rerum aliquid magnam molestiae nisi saepe.','Vero a officia quaerat quis. Maxime nostrum modi dolore commodi. Temporibus veritatis rerum vitae repellendus.','72','1','0','194017','1972-04-21 02:59:59','1984-02-03 11:49:53'),
('13','65','1','Sed qui libero consequatur earum consectetur qui.','Est enim sit ab reprehenderit culpa laborum quidem aut. Vel est sed dolorum est molestias. Deserunt unde culpa eum quia sequi.','73','1','0','264203','2003-09-25 19:02:04','1997-09-10 00:12:30'),
('14','41','15','Ullam non soluta et sint et.','Porro velit nulla at vel eum. Cumque sit mollitia sapiente laudantium nesciunt. Nemo dolores enim accusamus natus explicabo unde corporis. Accusantium ut esse labore iste occaecati.','86','0','0','23','2012-02-05 11:57:13','2004-02-08 17:08:25'),
('15','20','5','Odio illum expedita aut consequatur.','Aut et voluptatem veniam. Vel quibusdam sed iste minima velit necessitatibus. Itaque facilis possimus rerum qui facilis natus dicta corrupti.','28','0','1','3979005','1989-11-17 13:47:55','1982-12-07 10:43:51'),
('16','10','11','Aperiam iure reiciendis sequi voluptatibus nihil sunt porro.','Architecto enim quibusdam unde exercitationem sit adipisci rem. Explicabo et commodi fuga soluta. Est quas debitis unde qui omnis est provident. Rerum accusamus aspernatur praesentium provident.','38','1','1','484554943','1978-12-18 00:40:49','2014-07-02 23:03:13'),
('17','49','8','Ad ea est omnis sapiente.','Debitis quaerat nulla ratione beatae dolorum fugiat. Et et distinctio quasi officiis nulla. Beatae pariatur veritatis ea eius totam. Quo quos commodi sit quaerat non quo qui ab. Cumque qui inventore vitae dolor nesciunt dolore.','76','0','1','50','2013-01-12 13:56:04','2016-11-11 10:22:50'),
('18','2','9','Voluptas quo officia consequatur deleniti et dolor.','Et omnis illo quibusdam et quia. Temporibus a sequi iure autem et. In atque doloremque et est ex facere. Ratione deserunt rem ipsam voluptas.','87','1','0','189817','1976-09-11 08:52:20','1985-11-12 16:10:24'),
('19','16','9','Ea autem voluptatibus qui natus.','Ut molestiae consequatur voluptatibus est. At consequatur impedit debitis rerum est nihil. Et totam quo nostrum. Culpa dolores at ut reprehenderit sed.','77','1','0','189864','1990-04-15 01:54:30','1991-10-04 21:51:22'),
('20','14','8','Veniam ut amet ut in.','Soluta vero ut odio enim consequuntur. Aut illo ea nulla debitis libero. Est est quis magnam sunt esse.','27','0','0','6491586','2011-07-14 18:21:45','1975-11-19 14:42:26'),
('21','21','11','Rerum quasi quo fugit quibusdam velit rerum non.','Maxime optio sed reiciendis. Consequatur eum asperiores sapiente vel et magni. Suscipit inventore beatae dolorem quia non incidunt.','13','1','0','489','1985-05-17 09:05:51','2007-11-23 07:15:35'),
('22','33','2','Molestiae est eum aut quaerat voluptas.','Sint non ut consequatur minus. Dolorum est porro illum enim delectus. Ut minus eos reiciendis nesciunt.','99','0','0','0','2014-02-10 01:36:44','1996-04-03 05:58:42'),
('23','17','17','Autem quis vel quam sed qui fuga fuga.','Autem ratione perspiciatis saepe itaque numquam. Id explicabo ex quo accusantium. Quibusdam quia excepturi minus harum nemo aut optio.','8','0','1','439699','1996-03-15 10:41:35','2007-11-04 09:03:46'),
('24','100','5','Error magni molestiae quis doloremque architecto.','Dolor reprehenderit asperiores quo alias non. Quos rerum nihil laborum. Voluptatem recusandae fugiat sunt eligendi. Sint dolorem quaerat fugit magnam consequatur.','78','0','1','0','1994-10-11 02:56:11','1995-02-05 03:10:30'),
('25','63','9','Fugiat non aut facilis est.','Officiis porro aut cupiditate quod accusantium enim sint beatae. Dolor dolorum quas necessitatibus sit voluptates et. Quod quas eius et.','2','1','1','80','2019-09-26 13:52:28','2013-10-14 22:15:56'),
('26','100','10','Eius qui ea deserunt sed.','Aperiam fugit illum consequatur qui aut cupiditate. In quisquam in qui est quae voluptate quasi. Sed commodi ut nostrum est quae id nulla. Quo quo aut illo aperiam consequatur et ipsam recusandae.','32','1','1','37301','2003-07-21 20:01:21','2007-12-29 07:29:48'),
('27','67','12','Et reiciendis doloremque perferendis necessitatibus fugit.','Saepe quaerat quam voluptas deleniti. Reprehenderit veritatis vitae quia temporibus quaerat. Eligendi rerum dolorem quo temporibus accusamus nam sapiente.','90','0','1','7769888','2006-11-26 22:53:19','2019-09-18 21:15:32'),
('28','61','9','Veritatis saepe magni error explicabo sint eos qui.','Illo libero voluptas odio minima et fuga. Non vel et nobis iure quis ea. Nemo quam et harum omnis ut. Perferendis assumenda quasi provident minima et dolor at repellendus.','32','0','0','979062417','1982-06-18 20:50:48','1975-01-31 00:17:06'),
('29','9','8','Accusamus blanditiis id quasi culpa accusamus velit.','Et sint accusantium animi. Accusantium minus veritatis praesentium sint. Et enim hic voluptatem aut deserunt excepturi cum. Suscipit sint excepturi enim dolores.','20','0','1','82218472','2003-06-27 04:48:38','2012-01-17 11:07:35'),
('30','90','4','Quo assumenda qui consequatur vel.','Et provident officiis beatae rem ea. Culpa non dolore architecto assumenda vel et eaque qui. Qui provident quidem reprehenderit repudiandae molestias doloribus veniam.','85','0','1','2784','2017-06-09 07:27:58','1971-09-24 01:23:13'),
('31','13','12','Qui vel tempore neque voluptas voluptatem.','Sit ducimus pariatur quaerat perferendis qui. Et quod quisquam aspernatur id voluptatem sint. Voluptates qui temporibus quaerat beatae facere est eos. Aut et vero provident at beatae.','73','0','0','65','2008-09-05 02:07:24','2007-09-02 11:11:31'),
('32','22','19','Et saepe recusandae natus laborum facilis quas magni.','Quo delectus ullam et aspernatur quaerat eligendi unde. Sint corrupti et quia. Deleniti voluptates atque rerum ducimus fuga. Officia saepe velit maxime recusandae quibusdam commodi excepturi.','16','1','1','0','2013-05-22 04:54:59','1997-10-28 08:02:08'),
('33','24','11','Atque rerum laborum rem eveniet nihil quis odit libero.','Dolorem consequatur maiores dignissimos. Vitae et totam unde. Sed nulla asperiores rerum mollitia.','60','1','0','9411459','2020-03-20 19:53:29','1986-12-21 19:55:54'),
('34','35','16','Consequatur quisquam et ipsam explicabo animi.','Velit enim officiis provident. Unde sunt nisi dolorem velit sunt. Nesciunt ullam minus quis incidunt alias recusandae molestiae aut. Laudantium exercitationem voluptas illo provident autem.','9','1','0','597','2009-01-07 00:13:45','2016-12-27 06:44:21'),
('35','44','7','Voluptatum pariatur officiis est perspiciatis excepturi.','Quibusdam neque nostrum autem dolorum est pariatur sed. Ut aliquid dolore est temporibus. Quod dolores non voluptatem voluptatem. Cumque dolores quasi adipisci voluptatem voluptatem fugit. Illum voluptas et architecto assumenda animi quos est.','46','1','1','9523012','1989-07-20 07:48:33','1974-11-03 03:15:02'),
('36','67','3','Accusantium amet quia eaque repudiandae adipisci.','Quis et nulla velit neque dolore eos qui. Velit nemo enim corporis nostrum. Dolor qui nihil dolor vel. Id quod autem cumque cupiditate minima laboriosam.','73','1','1','78349525','2000-06-25 11:32:44','1993-07-31 13:46:27'),
('37','88','4','Quo ut sapiente odit earum rem voluptatem.','Magni tenetur quasi culpa ut suscipit. Ea commodi earum quasi id consectetur qui in minus. Eveniet quibusdam consequuntur sunt autem. Molestiae sint ut dolore qui.','20','1','1','1','2002-03-27 04:59:39','1979-12-24 01:01:51'),
('38','29','9','Consectetur natus autem ea architecto architecto.','Excepturi ut nisi laboriosam unde at. Dolor officiis nam molestiae vel. Tempore autem et suscipit sunt. Eveniet vitae et est pariatur suscipit aut.','97','0','0','324','1986-02-10 11:31:18','2019-11-05 19:19:14'),
('39','48','17','Animi ut et enim delectus voluptatem est.','Illum quas dolores ipsam animi quod voluptatibus eveniet. Nihil molestiae temporibus animi. Sequi explicabo temporibus quam ut asperiores possimus qui architecto.','87','1','0','937077','2019-02-24 20:23:50','1988-03-21 04:05:35'),
('40','77','16','Reprehenderit omnis qui enim rerum nobis assumenda quia voluptatem.','Dolores voluptate quo facilis commodi optio quo cum dicta. Ut sequi incidunt rerum ut nihil explicabo occaecati. Doloribus facere unde est. Aut rerum tempora recusandae nihil quisquam velit sit.','63','0','1','8','2006-10-22 08:22:54','1989-04-14 02:44:23'),
('41','94','3','Quod inventore omnis neque eligendi libero nisi cum distinctio.','Qui dignissimos asperiores amet voluptates est et. Et commodi consequatur consectetur aperiam earum voluptates quia in. Eveniet aperiam dolorem quia blanditiis vero.','33','1','0','25535062','1985-07-06 09:30:08','1976-01-21 14:02:22'),
('42','26','16','Explicabo molestiae cupiditate voluptas nesciunt sit atque mollitia.','Debitis eum alias nobis odit qui est. Non dignissimos repellat quam et. In adipisci velit ut dolore temporibus. Dolor reiciendis ut maxime iusto architecto.','77','1','1','5849916','1985-11-26 22:55:44','1987-11-23 21:31:05'),
('43','89','20','Consequuntur et et et doloribus.','Libero quis vitae sequi et perspiciatis. Dolor quisquam provident repudiandae aut rerum modi. Quis fugiat eos dolorem dolores officia facere. Qui velit illo magnam dolore dolorem.','41','0','0','189218','1988-11-13 15:44:43','1972-09-06 07:27:38'),
('44','95','14','Et repellat deleniti iusto mollitia qui.','Cum rerum modi est deleniti eaque eum voluptas. Architecto ut consequuntur quia voluptatem aut et aliquid. Commodi voluptatem eum accusamus architecto rem et. Voluptatem debitis laborum nemo vero exercitationem quos qui iusto.','42','1','0','6692689','2005-05-14 08:25:37','1983-03-05 20:06:57'),
('45','27','20','Sed in aut fugit ea rerum ut.','Libero enim corporis sapiente perferendis quaerat ducimus quia. Vitae nemo illo et ratione cum. Pariatur voluptatem sit nesciunt consequatur reprehenderit. Quas rerum enim suscipit nobis totam corrupti et.','100','0','0','176148','2002-11-12 07:31:01','1997-09-14 13:48:22'),
('46','75','4','Aut distinctio quo beatae inventore quia.','Voluptatem itaque nobis atque modi sequi. Officia qui ducimus eum soluta et. Similique voluptas est non pariatur. Ullam praesentium alias dolor.','97','0','0','98939110','2004-06-10 14:59:32','2015-09-03 06:34:26'),
('47','21','5','Eius incidunt ad vero necessitatibus praesentium quia neque.','Et dicta aspernatur officiis sint aut veniam. Voluptas libero sit vero dignissimos sint eius facere. Earum optio non blanditiis quia porro.','13','0','1','0','1993-11-25 12:13:44','1994-05-31 07:45:41'),
('48','55','18','Cum nam impedit facilis quod repellat.','Ut illo qui error dolore esse ad. Magnam ut sapiente sunt sint accusamus. Error dolor rem culpa autem natus tenetur reiciendis. Est vitae deserunt dolores.','25','0','0','8','1982-06-13 19:35:41','2016-06-21 10:52:19'),
('49','45','20','Maxime iure quia modi consequatur perferendis et.','Cumque maiores officia vel nemo est vitae. Consequatur quod accusamus ad quidem voluptatibus. Voluptatibus sint sit commodi repudiandae ea porro suscipit. Soluta iste voluptatem sunt sit earum et.','81','0','1','3','2018-01-15 07:10:15','1980-06-02 17:08:57'),
('50','28','14','Aut distinctio sunt molestiae architecto ex autem.','Enim fuga est dolores accusantium amet eos. Illum rerum voluptatem qui eum aliquid. Dignissimos perferendis placeat officia quia iusto nihil. Dolor iusto illum animi aliquam ratione.','1','0','0','56921107','1985-02-25 11:56:09','2016-03-03 03:59:11'),
('51','2','15','Quisquam perspiciatis aut ut debitis.','Voluptatum est mollitia provident rerum soluta officiis. Recusandae ex qui repellat. Porro autem quae rerum reprehenderit et.','70','0','1','9','1984-02-21 19:30:42','1977-12-14 13:36:57'),
('52','12','2','Culpa perferendis occaecati labore illo qui aperiam soluta.','Dolorem eos facilis explicabo aut. Excepturi odit aspernatur consequatur nesciunt. Cum voluptatem qui eum delectus sint. Animi aspernatur omnis quia a.','67','1','0','998053','2006-09-27 05:18:26','1970-06-08 14:45:33'),
('53','15','16','Ea exercitationem similique eius deserunt iusto quia.','Ut libero aut ab dignissimos fugit iste cumque. Neque voluptatem eligendi id est sunt. Iste et in eveniet animi omnis. Soluta reiciendis similique ad laudantium possimus vel.','67','0','0','2','2010-06-19 23:09:50','1997-04-04 20:10:26'),
('54','10','17','Repellendus commodi et eligendi alias nam numquam est.','Placeat consequuntur eligendi esse quisquam. Provident omnis et aut aliquam laborum. Et et alias et velit. Provident odit provident illo veritatis non aliquid reprehenderit eligendi.','10','0','0','7748','1983-12-18 02:39:09','1993-04-12 01:01:54'),
('55','40','17','Nihil repellat placeat at nemo voluptate vitae.','Et magnam omnis earum et illo. Aut non minima vitae autem blanditiis repellendus ut. Non nisi aut temporibus magni minus. Neque est officia sint qui. Enim consequatur sit suscipit animi.','69','0','1','58408','1999-12-22 22:12:19','2003-10-20 00:06:16'),
('56','2','5','Sapiente consequatur dolorem excepturi quia quos consequatur consequuntur recusandae.','Eligendi illo repellendus sit ullam nam distinctio. Autem voluptatum ex officia numquam. Vel sapiente tempore nemo aut officia provident. Omnis aut iusto explicabo voluptas qui consequatur qui.','16','1','1','1783852','1981-01-09 02:33:15','1982-03-05 08:55:39'),
('57','54','17','Laboriosam enim rerum vel amet voluptatem libero porro.','Dolorum dolores velit unde officiis et inventore. Voluptas explicabo voluptate enim hic nostrum qui consequuntur.','97','0','1','5','1980-10-15 15:34:50','1987-03-03 03:17:12'),
('58','90','16','Modi ut in rerum cupiditate id ducimus.','Ut quaerat est velit aperiam. Voluptatem fugiat quidem labore consequuntur voluptatem quia. Est corporis velit repellat autem possimus distinctio ab. Dolore est dolorem quae eveniet et unde velit.','93','0','1','0','2006-11-21 20:50:50','1991-10-24 08:15:38'),
('59','48','15','Accusamus praesentium voluptatem qui explicabo cum sequi deserunt.','Rerum sed voluptatem aut voluptas et molestiae est vel. Non vel officia non vitae voluptas. Eos facere ut nobis dolores. Aut quia illum voluptatem quas.','94','0','1','97745','2012-12-20 02:12:12','2009-01-15 22:04:10'),
('60','47','14','Eum eligendi quos voluptas.','Accusamus nulla et voluptatem et delectus. Est aspernatur dolorem nobis occaecati nesciunt. Beatae quia eos veniam et. Magni quidem quidem necessitatibus aut explicabo occaecati est. Optio aliquid ut magni perferendis ut aut est ea.','28','0','0','300','1983-02-27 03:28:15','2005-01-28 10:58:45'),
('61','27','18','Quia repudiandae voluptatem alias vel suscipit.','Omnis omnis atque soluta illo aliquid. Quia provident eos placeat aspernatur iusto. Quia autem ex animi assumenda voluptas aut. Delectus earum rerum nisi ut inventore.','13','1','1','75','1993-02-08 04:41:44','2014-02-05 02:46:18'),
('62','29','15','Voluptates quia id recusandae sunt.','Cupiditate rerum dolorem fugit. Ea consequuntur eum rerum tempora inventore voluptas quia. Nihil quas voluptatem laudantium recusandae.','81','0','0','0','1993-10-16 02:58:35','2003-06-15 10:44:33'),
('63','47','16','Repudiandae aut quae nesciunt eos similique.','Vel iusto adipisci occaecati earum similique. Ipsa praesentium vitae officia sapiente expedita blanditiis. Quia est repellendus placeat sapiente omnis corrupti quis nesciunt.','73','0','1','46791432','2006-06-09 18:45:28','1996-10-04 10:32:35'),
('64','29','19','Nisi qui odit suscipit necessitatibus aspernatur et dolorum.','Quia est harum quidem fuga. Aut voluptas quod iste quas. Animi sapiente nostrum sunt. Officiis ea vel quo illum magni odio. Voluptas necessitatibus deserunt expedita maiores praesentium dicta voluptatibus.','41','1','1','64357401','1974-08-31 23:13:25','2017-11-28 12:44:41'),
('65','68','4','Eius enim voluptates eum necessitatibus amet amet ipsum.','Eius sint provident reiciendis. Labore maiores ullam illum minus voluptatem. Aut beatae expedita vel id.','76','1','0','500229','2002-12-04 15:36:32','1989-03-31 11:58:54'),
('66','37','7','Necessitatibus at provident sunt facere.','Id nobis nesciunt eum eius sapiente fugiat. Consequatur maxime quidem dolores nobis corrupti soluta. Autem aut aut quia in sed rerum adipisci. Sit beatae et ut nam aut perferendis quas. Libero possimus rerum qui alias quis nostrum.','87','1','0','770','1973-06-11 07:37:26','1976-07-16 06:54:42'),
('67','63','10','Labore dolores nihil temporibus.','Nihil aut ipsa voluptas qui dignissimos perferendis. Exercitationem dolores repudiandae quia distinctio placeat tempora consequatur pariatur. Et et aut velit. Delectus rerum explicabo quidem voluptatem sed itaque ullam. Ipsam nemo est et voluptatum tempore praesentium qui sunt.','18','0','1','4614573','2004-11-29 13:23:42','1996-02-28 08:36:34'),
('68','95','4','Nemo voluptas et repudiandae aut ratione.','Est enim ipsum quo et repellat voluptatem. Quam quam itaque nobis illo et culpa. Qui sit ducimus harum voluptatem voluptates aut.','36','0','1','44730490','2018-11-17 01:48:03','1976-11-02 01:57:43'),
('69','68','11','At praesentium quae distinctio et.','Ipsum sint ea et aspernatur in. Maxime tempore eos et numquam dolores. Fuga aperiam dignissimos aspernatur dolore repudiandae nihil ut.','44','1','0','1','1992-02-01 08:20:44','1983-12-16 22:06:58'),
('70','87','2','Totam occaecati voluptate harum ea ut aspernatur.','Quia sequi quod eveniet ea et ratione qui illum. Reiciendis voluptatem aut et voluptatem. Quam dolores numquam et.','87','0','1','20','1978-02-17 16:28:06','2016-03-16 18:43:11'),
('71','40','14','Accusantium possimus laboriosam omnis laudantium laboriosam.','Fugiat quis sint dolor voluptas cum voluptas expedita. Praesentium dolor harum repudiandae expedita.','43','1','0','803309796','1972-08-18 04:39:57','2007-03-10 06:28:06'),
('72','53','6','Quia cum sit quis a.','Doloribus rerum qui quaerat modi ea maiores quaerat porro. Ducimus sapiente est et voluptas. Eum quae autem ipsa eligendi distinctio est consequatur rerum.','76','1','0','1979','1994-09-26 05:16:09','1987-01-22 04:41:21'),
('73','1','2','Laboriosam in et exercitationem ex.','Tempore necessitatibus qui et. Voluptatum corporis minus adipisci atque minus temporibus rerum. Saepe perferendis et repellat qui.','73','0','1','393','2012-04-02 07:27:47','1997-12-28 21:30:25'),
('74','91','4','Enim iusto accusamus voluptas adipisci distinctio.','Hic consequatur est eveniet molestiae quam ullam ipsam unde. Possimus inventore blanditiis sequi quos. Et sunt mollitia eius saepe.','40','0','0','76289252','1988-07-16 16:31:18','1995-07-15 07:04:52'),
('75','96','16','Aut suscipit accusantium ipsum deleniti eum quos.','Sed enim officia et. Et quia dolorum sed non velit ut. Quaerat est autem temporibus. Culpa vitae est tempora aut.','60','1','0','30976','2006-04-19 18:23:22','1999-12-06 18:02:21'),
('76','80','7','Illo ut exercitationem ipsum et optio.','Facilis quis quia quidem quisquam. Omnis aut deleniti asperiores. Qui aut rerum laborum sit et. Illum quia consequuntur beatae et magni in rerum provident.','40','1','0','2196996','2014-07-07 23:07:00','1986-08-30 08:18:12'),
('77','50','9','Dolor suscipit maxime animi corporis quia.','Quae dicta aliquid aliquid dignissimos. At recusandae quia et rerum est molestias pariatur omnis. Ut et debitis ad alias. Debitis nihil recusandae et necessitatibus incidunt molestiae.','42','1','1','83704334','2009-06-12 23:53:03','1979-01-13 21:19:49'),
('78','5','13','Aliquam nostrum dolorum quasi molestiae sit.','Assumenda perferendis et aut eum amet. Recusandae provident qui tenetur soluta error dolores. Deserunt est quibusdam nisi dolore. Voluptatem autem omnis nisi voluptas laborum dolorem.','39','0','0','40','2010-12-21 16:04:28','1996-06-16 18:37:28'),
('79','71','16','Vel autem numquam recusandae eligendi voluptatibus non sit.','Vel corporis dicta quidem aliquam vero sunt rerum nisi. Eius nam corporis debitis dolor voluptatem. In impedit dolore autem delectus omnis.','36','1','1','9433','1975-04-04 12:07:39','1983-12-01 02:08:24'),
('80','22','7','Fugit iusto voluptas qui placeat sapiente.','Iusto commodi ullam ut aut. In voluptatem beatae modi et sunt quam nisi. Eos quod ratione aut qui aliquam. Laborum dolorem odit eos quis officiis ad quis.','68','0','1','885813','1977-02-23 08:12:48','2005-08-09 17:38:25'),
('81','6','20','Voluptatem a necessitatibus iure sit repellat.','Porro illum quis consequatur et est exercitationem. Voluptas facilis itaque est voluptatem et nemo totam. Aut sed odio voluptates aut suscipit repellendus.','50','0','1','0','1977-10-01 19:56:00','1986-05-31 22:32:34'),
('82','25','1','Deserunt ut dolorem eaque omnis voluptatem iusto corporis.','Nihil autem maxime facere. Soluta dolorum inventore quaerat nemo mollitia unde.','7','0','0','0','1973-12-13 09:05:59','2012-04-01 08:22:53'),
('83','15','13','Dolores rem voluptas itaque doloribus beatae est.','Voluptate aliquid voluptatibus labore aut. Ex ab non ipsum officiis porro minus exercitationem. Magnam et et hic quia porro temporibus neque.','81','0','0','7581','2012-04-26 09:43:23','1981-02-01 19:40:33'),
('84','100','11','Cum non quisquam illum saepe quos laudantium.','Et occaecati id rem. Accusantium sunt enim praesentium enim in recusandae officia magnam. Aut iusto ut dolore culpa odio quis.','52','1','0','9086690','2016-04-22 05:01:25','1989-09-08 04:52:07'),
('85','50','16','Aut vero sed sapiente molestiae.','Ex quod quia ab velit cum dolorem et. Officia ipsam rerum corporis voluptas. At similique vel aut vel et similique cum.','84','0','0','193570771','2001-03-06 16:06:29','1988-04-11 09:10:23'),
('86','5','19','Quia sed omnis dolores maxime iste nesciunt.','Et ratione animi et qui. Amet sapiente et quas velit adipisci soluta. Consequatur odit sunt quo quos. Voluptatem nemo qui cum et praesentium et.','47','0','0','570487','1990-04-05 00:08:29','1975-03-15 07:10:11'),
('87','87','13','Consequatur sunt sit aut.','Sit adipisci qui sunt minus fuga accusamus sed. Provident debitis ipsum tempora. Voluptas iste sit commodi totam ea.','74','0','0','205','1973-05-03 06:10:33','1988-10-30 10:39:15'),
('88','90','6','Voluptate assumenda voluptatem qui dolor sapiente.','Voluptas rem nesciunt eum. Adipisci sint autem quibusdam ut voluptates et. Ut nulla sint soluta ad. Libero labore consequatur cumque voluptas cum.','6','1','1','11371751','1975-07-17 13:30:51','2010-09-22 08:40:39'),
('89','2','12','Est nulla nihil doloribus dolor ut.','Architecto adipisci omnis voluptas nihil ex vel vero. Blanditiis enim consequatur doloremque blanditiis. Non deleniti adipisci non velit doloremque omnis.','66','0','0','0','1982-06-21 15:36:04','2000-10-15 13:30:32'),
('90','17','9','Temporibus aut ducimus non quia.','Sed tempora ut occaecati vero corporis aperiam. Voluptas id est nihil. Saepe praesentium quasi sed itaque. Repellendus accusamus quis in voluptatem ut et.','71','1','1','63770','2001-12-30 02:28:58','1974-01-02 11:58:37'),
('91','55','12','Aliquid corporis quo fuga consectetur perferendis.','Facilis numquam tenetur reiciendis aspernatur aliquam velit. Corrupti ipsam possimus voluptatem ut vel ea. Consequatur laboriosam placeat fugiat. Asperiores libero incidunt vitae voluptatum voluptatum ea aut.','68','0','0','82294','2016-11-01 07:29:22','2015-11-16 07:56:15'),
('92','4','11','Et quo inventore placeat voluptatem nostrum sed.','Ipsam expedita id nihil ut similique quod illum. Rem officia iure dolores velit nemo voluptas dolor voluptatem. Omnis et quia aut eaque blanditiis nobis neque fugiat. Aliquid doloremque voluptatem consequatur fugiat.','32','0','0','504782814','1994-11-01 05:53:57','1992-07-16 15:43:40'),
('93','25','14','Iure non minus voluptatum fugiat ut.','Eveniet iusto velit hic est officiis neque. Quo et delectus laudantium fugiat vitae sed. Iure officiis dolor velit nesciunt eius autem nobis.','62','1','1','4','1992-11-20 17:36:48','1991-09-20 19:13:53'),
('94','3','13','Ad assumenda ut veritatis id aut veritatis.','Est sed harum facere doloremque nobis reiciendis vero delectus. Placeat impedit perspiciatis doloremque quidem quia provident velit. Error quia et laborum qui veritatis et laudantium.','32','0','1','751776','1976-01-24 15:08:51','2020-07-12 10:38:03'),
('95','15','17','Totam laborum deleniti dolorem commodi cupiditate.','Enim est ullam est. Fuga ut eaque rerum. Quas ut non odit quasi hic voluptas facere. Deserunt quisquam perferendis quis perferendis aspernatur maxime iusto amet.','22','0','0','36766490','2018-01-07 23:16:49','1982-05-05 18:59:59'),
('96','34','1','Fugiat ipsum praesentium voluptate quidem.','Quaerat quidem sunt ea. Aliquid mollitia est et. Quia quidem ipsam et sequi animi.','24','1','0','5190','2000-08-27 16:27:29','2019-02-11 11:22:34'),
('97','35','20','Facilis qui est possimus natus nemo ut.','Quis corrupti et temporibus excepturi ullam. Et id est ut voluptas. Perspiciatis quis quasi repellendus amet aut amet. Voluptatem nobis minus inventore sunt. Magni omnis dolorem cupiditate deserunt aut.','59','0','1','47676','2017-06-04 15:55:15','1984-07-17 08:16:17'),
('98','22','9','Sed perferendis iste beatae provident architecto eius est nulla.','Dolor nemo est blanditiis accusantium accusantium placeat. Odit culpa qui sit quis aperiam. Temporibus eum sed architecto et fugiat facere. Dolor expedita et fugiat repudiandae dolores officiis.','25','0','0','63','1980-05-11 13:29:36','2007-03-21 20:23:00'),
('99','100','13','Rerum consequuntur aut illum esse in in est.','Quidem libero laborum voluptas corrupti. Veniam inventore enim rerum cumque porro ut tempora. Atque illo velit et minus odit atque illo. Consequatur quis officiis placeat enim ipsam quae quasi.','66','0','1','68703114','2020-07-05 04:25:27','1977-01-09 12:23:19'),
('100','10','11','Quo perspiciatis aut adipisci maxime.','Vitae id voluptas et voluptate. Dolorem nam ut vel et architecto. Enim iure consequatur quasi magnam non commodi exercitationem. Rerum eaque ab fuga tempore aperiam.','91','0','0','12','1978-09-28 15:21:38','1997-04-21 21:25:06'); 

