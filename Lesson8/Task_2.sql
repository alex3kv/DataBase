﻿-- Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей)

-- используем JOIN

-- выводим таблицу для наглядности
SELECT
  u.id,
  CONCAT(u.first_name, ' ', u.last_name) AS username,
  p.birthday,
  p.gender,
  p.city,
  p.country,
  --   l.id lid,
  --   l.target_id,
  --   l.target_type_id
  COUNT(l.id) AS count
FROM users u
  JOIN profiles p
    ON u.id = p.user_id
  LEFT JOIN likes l
    ON l.target_id = u.id
    AND l.target_type_id = (SELECT
        tt.id
      FROM target_types tt
      WHERE tt.name = 'users' LIMIT 1)
GROUP BY u.id
ORDER BY p.birthday DESC
LIMIT 10;

-- оставляем только данные по лайкам
SELECT
  COUNT(l.id) AS count
FROM users u
  JOIN profiles p
    ON u.id = p.user_id
  LEFT JOIN likes l
    ON l.target_id = u.id
    AND l.target_type_id = (SELECT
        tt.id
      FROM target_types tt
      WHERE tt.name = 'users' LIMIT 1)
GROUP BY u.id
ORDER BY p.birthday DESC
LIMIT 10;

-- конечный вариант запроса суммирующий лайки
SELECT
  SUM(r.count) AS `Всего лайков`
FROM (SELECT
    COUNT(l.id) AS count
  FROM users u
    JOIN profiles p
      ON u.id = p.user_id
    LEFT JOIN likes l
      ON l.target_id = u.id
      AND l.target_type_id = (SELECT
          tt.id
        FROM target_types tt
        WHERE tt.name = 'users' LIMIT 1)
  GROUP BY u.id
  ORDER BY p.birthday DESC
  LIMIT 10) r;

-- используя подзапросы и объединение

-- выводим таблицу для наглядности
SELECT
  (SELECT
      CONCAT(u.first_name, ' ', u.last_name)
    FROM users u
    WHERE id = p.user_id) AS username,
  p.birthday,
  p.gender,
  p.city,
  p.country,
  (SELECT
      COUNT(*)
    FROM likes l
    WHERE l.target_id = p.user_id
    AND l.target_type_id = (SELECT
        tt.id
      FROM target_types tt
      WHERE tt.name = 'users' LIMIT 1)) AS count
FROM profiles p
ORDER BY p.birthday DESC LIMIT 10;

-- оставляем только данные по лайкам
SELECT
  (SELECT
      COUNT(*)
    FROM likes l
    WHERE l.target_id = p.user_id
    AND l.target_type_id = (SELECT
        tt.id
      FROM target_types tt
      WHERE tt.name = 'users' LIMIT 1)) AS count
FROM profiles p
ORDER BY p.birthday DESC LIMIT 10;

-- конечный вариант запроса суммирующий лайки
SELECT
  SUM(r.count) AS `Всего лайков`
FROM (SELECT
    (SELECT
        COUNT(*)
      FROM likes l
      WHERE l.target_id = p.user_id
      AND l.target_type_id = (SELECT
          tt.id
        FROM target_types tt
        WHERE tt.name = 'users' LIMIT 1)) AS count
  FROM profiles p
  ORDER BY p.birthday DESC LIMIT 10) r;



