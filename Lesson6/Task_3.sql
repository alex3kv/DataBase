-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

(SELECT
    'Мужчины' AS 'Пол',
    COUNT(*) AS 'Лайки'
  FROM likes l
  WHERE l.user_id IN (SELECT
      p.user_id
    FROM profiles p
    WHERE p.gender = 'm'))
UNION
(SELECT
    'Женщины' AS 'Пол',
    COUNT(*) AS 'Лайки'
  FROM likes l
  WHERE l.user_id IN (SELECT
      p.user_id
    FROM profiles p
    WHERE p.gender = 'f'));