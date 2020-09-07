DELIMITER $$

--
-- Создать процедуру `NumMovie`
--
DROP PROCEDURE IF EXISTS NumMovie$$
CREATE PROCEDURE NumMovie(OUT total INT)
BEGIN
  SELECT COUNT(*) INTO total FROM Movie m;
END
$$

--
-- Создать триггер `Movie_Insert`
--
DROP TRIGGER IF EXISTS Movie_Insert$$
CREATE TRIGGER Movie_Insert
BEFORE INSERT
ON Movie
FOR EACH ROW
BEGIN
  IF NEW.Name IS NULL
    AND NEW.NameInternational IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля Name и NameInternational одновремнно не могут быть null';
  END IF;
END
$$

--
-- Создать триггер `Movie_Update`
--
DROP TRIGGER IF EXISTS Movie_Update$$
CREATE TRIGGER Movie_Update
BEFORE UPDATE
ON Movie
FOR EACH ROW
BEGIN
  IF NEW.Name IS NULL
    AND NEW.NameInternational IS NULL THEN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Поля Name и NameInternational одновремнно не могут быть null';
  END IF;
END
$$

DELIMITER ;