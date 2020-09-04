-- получение данных о пользователе по Email
SELECT
  p.FirstName,
  p.LastName,
  g.Name AS 'Gender',
  u.UserName,
  p.Birthday
FROM Profile p
  JOIN User u
    ON p.UserId = u.Id
  JOIN Gender g
    ON p.GenderId = g.Id
WHERE u.Email = 'AuraCrooks@example.com';

SELECT
  u.UserName,
  COUNT(ff.MovieId),
  COUNT(mr.MovieId),
  COUNT(ww.UserId)
FROM User u
  LEFT JOIN FavoriteFilms ff
    ON u.Id = ff.UserId
  LEFT JOIN MovieRating mr
    ON u.Id = mr.UserId
  LEFT JOIN WillWatch ww
    ON u.Id = ww.UserId
GROUP BY u.Id;

