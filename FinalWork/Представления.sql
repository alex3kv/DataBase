--
-- Создать представление `view_Profile`
--
DROP VIEW IF EXISTS view_Profile;
CREATE VIEW view_Profile
AS
SELECT
  User.Id,
  User.UserName,
  User.Email,
  Profile.LastName,
  Profile.FirstName,
  Gender.Name AS Gender,
  Profile.Birthday,
  Country.Name AS Country,
  Profile.City
FROM Profile
  INNER JOIN User
    ON Profile.UserId = User.Id
  INNER JOIN Gender
    ON Profile.GenderId = Gender.Id
  INNER JOIN Country
    ON Profile.СountryId = Country.Id;


--
-- Создать представление `view_Movie`
--
DROP VIEW IF EXISTS view_Movie;
CREATE VIEW view_Movie
AS
SELECT
  Movie.Id,
  Movie.Name,
  Movie.NameInternational,
  Movie.Year,
  Genre.Name AS Genre,
  Country.Name AS Country
FROM MovieGenre
  INNER JOIN Movie
    ON MovieGenre.MovieId = Movie.Id
  INNER JOIN MovieCountry
    ON MovieCountry.MovieId = Movie.Id
  INNER JOIN Country
    ON MovieCountry.CountryId = Country.Id
  INNER JOIN Genre
    ON MovieGenre.GenreId = Genre.Id;