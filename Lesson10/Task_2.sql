-- 2. Задание на оконные функции
-- Построить запрос, который будет выводить следующие столбцы:
-- имя группы
-- среднее количество пользователей в группах
-- самый молодой пользователь в группе
-- самый старший пользователь в группе
-- общее количество пользователей в группе
-- всего пользователей в системе
-- отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100

SELECT DISTINCT
  c.name AS 'Группа',
  COUNT(cu.user_id) OVER () / COUNT(c.id) OVER () AS 'Среднее',
  FIRST_VALUE(CONCAT(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER w AS 'Младший',
  LAST_VALUE(CONCAT(u.first_name, ' ', u.last_name, ' (', p.birthday, ')')) OVER w AS 'Старший',  
  COUNT(cu.user_id) OVER w AS 'Общее',
  COUNT(u.id) OVER () AS 'Всего',
  COUNT(cu.user_id) OVER w / COUNT(u.id) OVER () * 100 AS 'Отношение'
FROM (users u
  JOIN profiles p
    ON u.id = p.user_id
  LEFT JOIN communities_users cu
    ON u.id = cu.user_id
  LEFT JOIN communities c
    ON cu.community_id = c.id)
WINDOW w AS (PARTITION BY c.id
ORDER BY p.birthday DESC RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING);