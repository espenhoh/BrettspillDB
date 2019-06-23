USE Brettspill;

SELECT User,Host FROM MYSQL.user;

#UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = 'localhost';
#UPDATE mysql.USER SET PASSWORD=PASSWORD('new_pwd') WHERE USER = 'root' and HOST = '127.0.0.1';
#FLUSH PRIVELIGES;

DROP USER 'test'@'localhost';
#DROP USER ''@'localhost';

#CREATE USER IF NOT EXISTS test@localhost IDENTIFIED BY 'testPassord';
#CREATE OR REPLACE USER test@localhost IDENTIFIED BY 'testPassord';

GRANT ALL ON *.*
TO 'test'@'localhost'
IDENTIFIED BY 'testPassord';"