USE Brettspill;

SELECT User,Host FROM MYSQL.user;

CREATE USER 'brettspill_admin'@'%' IDENTIFIED BY 'brettspill_admin';

SET PASSWORD FOR 'brettspill_admin'@'%' = PASSWORD('brettspill_admin');

GRANT ALL ON brettspill.* TO 'brettspill_admin'@'%' WITH GRANT OPTION;

SHOW GRANTS FOR 'brettspill_admin'@'%';

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