-- Определить кто больше поставил лайков (всего) - мужчины или женщины?

-- используй джойны
SELECT
  p.gender AS 'Пол',
  COUNT(*) AS 'Лайки'
FROM likes l
  JOIN profiles p
    ON l.user_id = p.user_id
GROUP BY p.gender
ORDER BY 'Лайки';


-- используя подзапросы и объединение
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