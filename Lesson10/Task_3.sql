-- 3. (по желанию) Задание на денормализацию
-- Разобраться как построен и работает следующий запрос:
-- Найти 10 пользователей, которые проявляют наименьшую активность
-- в использовании социальной сети.
-- 
-- SELECT users.id,
-- COUNT(DISTINCT messages.id) +
-- COUNT(DISTINCT likes.id) +
-- COUNT(DISTINCT media.id) AS activity
-- FROM users
-- LEFT JOIN messages
-- ON users.id = messages.from_user_id
-- LEFT JOIN likes
-- ON users.id = likes.user_id
-- LEFT JOIN media
-- ON users.id = media.user_id
-- GROUP BY users.id
-- ORDER BY activity
-- LIMIT 10;
-- 
-- Правильно-ли он построен?
-- Какие изменения, включая денормализацию, можно внести в структуру БД
-- чтобы существенно повысить скорость работы этого запроса?

SELECT
  users.id,
  COUNT(DISTINCT messages.id) +
  COUNT(DISTINCT likes.id) +
  COUNT(DISTINCT media.id) AS activity
FROM users
  LEFT JOIN messages
    ON users.id = messages.from_user_id
  LEFT JOIN likes
    ON users.id = likes.user_id
  LEFT JOIN media
    ON users.id = media.user_id
GROUP BY users.id
ORDER BY activity
LIMIT 100;

-- Можно в таблице users завести счетчики сообщений, лайков и медиа, добавить в таблицы messages, likes, media 
-- тригеры на добавление и удаление записи, в момент этих операций обновлять счетчики в таблице users,
-- в итогде запрос будет только к таблице users