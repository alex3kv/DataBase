-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

-- первый вариант группируем каждый тип активности по пользователю потом суммируем объединенные рузультаты
SELECT
  r.user_id, 
  (SELECT CONCAT(u.first_name, ' ', u.last_name) FROM users u WHERE u.id = r.user_id) AS fullname,
  r.count AS count  
FROM (
  SELECT un.user_id, SUM(un.count) AS count FROM (
    (SELECT l.user_id AS user_id, COUNT(l.id) AS count FROM likes l GROUP BY user_id)
      UNION ALL
    (SELECT m.from_user_id AS user_id, COUNT(m.id) AS count FROM messages m GROUP BY user_id)
      UNION ALL
    (SELECT cu.user_id AS user_id, COUNT(cu.user_id) AS count FROM communities_users cu GROUP BY user_id)
      UNION ALL
    (SELECT f.user_id AS user_id, COUNT(f.id) AS count FROM friendship f GROUP BY user_id)
      UNION ALL
    (SELECT p.user_id AS user_id, COUNT(p.id) AS count FROM posts p GROUP BY user_id)
      UNION ALL
    (SELECT m.user_id AS user_id, COUNT(m.id) AS count FROM media m GROUP BY user_id)
  ) un GROUP BY un.user_id
) r ORDER BY r.count LIMIT 10;


-- второй вариант каждой активности устанавливаем вес в 1 затем объединяем все выборки у суммируем веса, запрос выглядит наглядней, плюс можно увеличивать вес для каждого типа активности
SELECT
  r.user_id, 
  (SELECT CONCAT(u.first_name, ' ', u.last_name) FROM users u WHERE u.id = r.user_id) AS fullname,
  r.count AS count  
FROM (
  SELECT un.user_id, SUM(un.count) AS count FROM (
    (SELECT l.user_id AS user_id, 1 AS count FROM likes l)
      UNION ALL
    (SELECT m.from_user_id AS user_id, 1 AS count FROM messages m)
      UNION ALL
    (SELECT cu.user_id AS user_id, 1 AS count FROM communities_users cu)
      UNION ALL
    (SELECT f.user_id AS user_id, 1 AS count FROM friendship f)
      UNION ALL
    (SELECT p.user_id AS user_id, 1 AS count FROM posts p)
      UNION ALL
    (SELECT m.user_id AS user_id, 1 AS count FROM media m)
  ) un GROUP BY un.user_id
) r ORDER BY r.count LIMIT 10;

-- какой их них оптимальней будет выполняться?