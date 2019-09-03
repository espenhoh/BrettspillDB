USE Brettspill;

SELECT User,Host FROM MYSQL.user;

DROP USER IF EXISTS 'brettspill_admin'@'127.0.0.1';
CREATE USER 'brettspill_admin'@'127.0.0.1' IDENTIFIED BY 'brettspill_admin';
#SET PASSWORD FOR 'brettspill_admin'@'Espen-PC' = PASSWORD('brettspill_admin');

#For integrasjonstesting
DROP USER IF EXISTS 'test'@'localhost';
CREATE USER 'test'@'localhost' IDENTIFIED BY 'testPassord';
SET PASSWORD FOR 'test'@'localhost' = PASSWORD('testPassord');

GRANT ALL ON brettspill.* TO 'brettspill_admin'@'127.0.0.1' WITH GRANT OPTION;

SHOW GRANTS FOR 'brettspill_admin'@'127.0.0.1';

/*

UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = 'localhost';
UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = '127.0.0.1';
FLUSH PRIVELIGES;

DROP USER 'test'@'localhost';
DROP USER ''@'localhost';

GRANT ALL ON *.*
TO 'test'@'localhost'
IDENTIFIED BY 'testPassord';
*/

SHOW COLLATION LIKE 'UTF%';

ALTER DATABASE brettspill COLLATE = 'keybcs2_general_ci';