--
-- Создать таблицу `Gender`
--
DROP TABLE IF EXISTS Gender;
CREATE TABLE Gender (
  Id int UNSIGNED NOT NULL AUTO_INCREMENT,
  Name varchar(50) DEFAULT NULL,
  PRIMARY KEY (Id)
)
ENGINE = INNODB;

--
-- Создать таблицу `Genre`
--
DROP TABLE IF EXISTS Genre;
CREATE TABLE Genre (
  Id int UNSIGNED NOT NULL AUTO_INCREMENT,
  Name varchar(50) DEFAULT NULL,
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id)
)
ENGINE = INNODB;

--
-- Создать таблицу `Country`
--
DROP TABLE IF EXISTS Country;
CREATE TABLE Country (
  Id int UNSIGNED NOT NULL AUTO_INCREMENT,
  Name varchar(50) DEFAULT NULL,
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id)
)
ENGINE = INNODB;

--
-- Создать таблицу `User`
--
DROP TABLE IF EXISTS User;
CREATE TABLE User (
  Id int UNSIGNED NOT NULL AUTO_INCREMENT,
  UserName varchar(255) NOT NULL DEFAULT '',
  Email varchar(255) NOT NULL DEFAULT '',
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id)
)
ENGINE = INNODB,
COMMENT = 'Пользователь';

--
-- Создать таблицу `Profile`
--
DROP TABLE IF EXISTS Profile;
CREATE TABLE Profile (
  UserId int UNSIGNED NOT NULL,
  FirstName varchar(255) NOT NULL DEFAULT '',
  LastName varchar(255) NOT NULL DEFAULT '',
  GenderId int UNSIGNED NOT NULL,
  Birthday date DEFAULT NULL,
  СountryId int UNSIGNED NOT NULL,
  City varchar(130) NOT NULL DEFAULT '',
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
)
ENGINE = INNODB,
COMMENT = 'Профиль';

--
-- Создать внешний ключ
--
ALTER TABLE Profile
ADD CONSTRAINT FK_Profile_Country_Id FOREIGN KEY (СountryId)
REFERENCES Country (Id);

--
-- Создать внешний ключ
--
ALTER TABLE Profile
ADD CONSTRAINT FK_Profile_Gender_Id FOREIGN KEY (GenderId)
REFERENCES Gender (Id);

--
-- Создать внешний ключ
--
ALTER TABLE Profile
ADD CONSTRAINT FK_Profile_User_Id FOREIGN KEY (UserId)
REFERENCES User (Id) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Создать таблицу `Movie`
--
DROP TABLE IF EXISTS Movie;
CREATE TABLE Movie (
  Id int UNSIGNED NOT NULL AUTO_INCREMENT,
  Name tinytext DEFAULT NULL,
  NameInternational tinytext DEFAULT NULL,
  Year int UNSIGNED DEFAULT NULL,
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (Id)
)
ENGINE = INNODB;

--
-- Создать таблицу `WillWatch`
--
DROP TABLE IF EXISTS WillWatch;
CREATE TABLE WillWatch (
  UserId int UNSIGNED NOT NULL,
  MovieId int UNSIGNED NOT NULL,
  Created datetime DEFAULT (NOW()),
  PRIMARY KEY (UserId, MovieId)
)
ENGINE = INNODB,
COMMENT = 'Буду смотреть';

--
-- Создать внешний ключ
--
ALTER TABLE WillWatch
ADD CONSTRAINT FK_UserMovie_Movie_Id FOREIGN KEY (MovieId)
REFERENCES Movie (Id);

--
-- Создать внешний ключ
--
ALTER TABLE WillWatch
ADD CONSTRAINT FK_UserMovie_User_Id FOREIGN KEY (UserId)
REFERENCES User (Id);

--
-- Создать таблицу `MovieRating`
--
DROP TABLE IF EXISTS MovieRating;
CREATE TABLE MovieRating (
  UserId int UNSIGNED NOT NULL,
  MovieId int UNSIGNED NOT NULL,
  Value tinyint NOT NULL DEFAULT 0,
  Created datetime DEFAULT (NOW()),
  Updated datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (UserId, MovieId)
)
ENGINE = INNODB,
COMMENT = 'Оценка пользователя';

--
-- Создать внешний ключ
--
ALTER TABLE MovieRating
ADD CONSTRAINT FK_MovieRating_Movie_Id FOREIGN KEY (MovieId)
REFERENCES Movie (Id);

--
-- Создать внешний ключ
--
ALTER TABLE MovieRating
ADD CONSTRAINT FK_MovieRating_User_Id FOREIGN KEY (UserId)
REFERENCES User (Id);

--
-- Создать таблицу `MovieGenre`
--
DROP TABLE IF EXISTS MovieGenre;
CREATE TABLE MovieGenre (
  MovieId int UNSIGNED NOT NULL,
  GenreId int UNSIGNED NOT NULL,
  Created datetime DEFAULT (NOW()),
  PRIMARY KEY (MovieId, GenreId)
)
ENGINE = INNODB;

--
-- Создать внешний ключ
--
ALTER TABLE MovieGenre
ADD CONSTRAINT FK_MovieGenre_Genre_Id FOREIGN KEY (GenreId)
REFERENCES Genre (Id);

--
-- Создать внешний ключ
--
ALTER TABLE MovieGenre
ADD CONSTRAINT FK_MovieGenre_Movie_Id FOREIGN KEY (MovieId)
REFERENCES Movie (Id);

--
-- Создать таблицу `MovieCountry`
--
DROP TABLE IF EXISTS MovieCountry;
CREATE TABLE MovieCountry (
  MovieId int UNSIGNED NOT NULL,
  CountryId int UNSIGNED NOT NULL,
  Created datetime DEFAULT (NOW()),
  PRIMARY KEY (MovieId, CountryId)
)
ENGINE = INNODB;

--
-- Создать внешний ключ
--
ALTER TABLE MovieCountry
ADD CONSTRAINT FK_MovieCountry_Country_Id FOREIGN KEY (CountryId)
REFERENCES Country (Id);

--
-- Создать внешний ключ
--
ALTER TABLE MovieCountry
ADD CONSTRAINT FK_MovieCountry_Movie_Id FOREIGN KEY (MovieId)
REFERENCES Movie (Id);

--
-- Создать таблицу `FavoriteFilms`
--
DROP TABLE IF EXISTS FavoriteFilms;
CREATE TABLE FavoriteFilms (
  UserId int UNSIGNED NOT NULL,
  MovieId int UNSIGNED NOT NULL,
  Created datetime DEFAULT (NOW()),
  PRIMARY KEY (UserId, MovieId)
)
ENGINE = INNODB,
COMMENT = 'Любимые фильмы';

--
-- Создать внешний ключ
--
ALTER TABLE FavoriteFilms
ADD CONSTRAINT FK_FavoriteFilms_Movie_Id FOREIGN KEY (MovieId)
REFERENCES Movie (Id);

--
-- Создать внешний ключ
--
ALTER TABLE FavoriteFilms
ADD CONSTRAINT FK_FavoriteFilms_User_Id FOREIGN KEY (UserId)
REFERENCES User (Id);

--
-- Создать индекс `UK_User_UserName` для объекта типа таблица `User`
--
ALTER TABLE User 
  ADD UNIQUE INDEX UK_User_UserName(UserName);

--
-- Создать индекс `UK_User_Email` для объекта типа таблица `User`
--
ALTER TABLE User 
  ADD UNIQUE INDEX UK_User_Email(Email);

--
-- Создать индекс `IDX_Profile_FirstName` для объекта типа таблица `Profile`
--
ALTER TABLE Profile 
  ADD INDEX IDX_Profile_FirstName(FirstName);

--
-- Создать индекс `IDX_Profile_LastName` для объекта типа таблица `Profile`
--
ALTER TABLE Profile 
  ADD INDEX IDX_Profile_LastName(LastName);

--
-- Создать индекс `IDX_Profile_Birthday` для объекта типа таблица `Profile`
--
ALTER TABLE Profile 
  ADD INDEX IDX_Profile_Birthday(Birthday);