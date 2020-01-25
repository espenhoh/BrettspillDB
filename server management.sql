USE Brettspill;

SELECT User,Host FROM mysql.user;

SELECT * FROM information_schema.SCHEMATA 
WHERE schema_name = "brettspill";



#For persistering
DROP USER IF EXISTS 'springuser'@'%';
CREATE USER 'springuser'@'%' IDENTIFIED BY 'testPassord';
SET PASSWORD FOR 'springuser'@'%' = PASSWORD('testPassord');
#GRANT DELETE, INSERT, SELECT, UPDATE ON brettspill.* TO 'springuser'@'%';
userGRANT ALL ON brettspill.* TO 'springuser'@'%';
FLUSH PRIVILEGES;
SHOW GRANTS FOR 'springuser'@'%';

#For integrasjonstesting
DROP USER IF EXISTS 'test'@'localhost';
CREATE USER 'test'@'localhost' IDENTIFIED BY 'testPassord';
SET PASSWORD FOR 'test'@'localhost' = PASSWORD('testPassord');



SHOW GRANTS FOR 'brettspill_admin'@'127.0.0.1';

/*

UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = 'localhost';
UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = '127.0.0.1';
FLUSH PRIVILEGES;

DROP USER 'test'@'localhost';
DROP USER ''@'localhost';

GRANT ALL ON *.*
TO 'test'@'localhost'
IDENTIFIED BY 'testPassord';
*/

SHOW COLLATION LIKE 'UTF%';

ALTER DATABASE brettspill COLLATE = 'keybcs2_general_ci';