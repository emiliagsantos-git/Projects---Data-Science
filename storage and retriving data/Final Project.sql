/*
Beatriz Santos 20230521
Emar Ribas 20230459
Emília Santos 20230446
Mª Isabel Baêna 20230455
Simão Baptista 20230453
*/

CREATE DATABASE IF NOT EXISTS `musicfy`;
USE `musicfy`;

CREATE TABLE IF NOT EXISTS `user` (
`user_id` INT NOT NULL AUTO_INCREMENT,
`first_name` VARCHAR(20) NOT NULL,
`last_name` VARCHAR(25) NOT NULL,
`password` VARCHAR(40) NOT NULL,
`phone_number` VARCHAR(20) DEFAULT NULL,
`email` VARCHAR(40) NOT NULL,
`birth_date` DATE NOT NULL,
`gender` VARCHAR(10) DEFAULT NULL CHECK (`gender` IN ('male', 'female', NULL)),
`vat` VARCHAR(15) DEFAULT NULL,
`apps_rating` TINYINT DEFAULT NULL CHECK (`apps_rating` BETWEEN 1 AND 5 OR NULL),

`address_id` INT DEFAULT NULL,

PRIMARY KEY (`user_id`)
);

CREATE TABLE IF NOT EXISTS `track`(
`track_id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(70) NOT NULL,
`length` TIME NOT NULL,
`genre` VARCHAR(20) CHECK (`genre` IN ('classic', 'jazz', 'pop', 'rock', 'heavy metal', 'country', 'R&B', 'indie', 'house', 'latino')),

`artist_id` INT DEFAULT NULL,
`album_id` INT DEFAULT NULL,

PRIMARY KEY (`track_id`)
);

CREATE TABLE IF NOT EXISTS `playlist` (
`playlist_id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(50) NOT NULL,

`user_id` INT DEFAULT NULL,

PRIMARY KEY (`playlist_id`)
);

Create Table if not exists `address` (
`address_id` INT NOT NULL AUTO_INCREMENT, 
`street_name` varchar(60) NOT NULL,
`zip_code` varchar(12) NOT NULL,
`city` varchar(30) NOT NULL,

`country_id` INT DEFAULT NULL,

PRIMARY KEY (`address_id`)
);

CREATE TABLE IF NOT EXISTS `payment` (
`date` DATE NOT NULL,
`price` DECIMAL	(5,2) NOT NULL,
`valid_until` DATE NOT NULL,

`user_id` INT NOT NULL,

PRIMARY KEY (`user_id`, `date`)
);

CREATE TABLE IF NOT EXISTS `historic_tracks` (
`time` DATETIME NOT NULL,

`user_id` INT NOT NULL,
`track_id` INT DEFAULT NULL,

PRIMARY KEY (`user_id`, `time`)
);

CREATE TABLE IF NOT EXISTS `track_playlist` (
`track_id` INT NOT NULL,
`playlist_id` INT NOT NULL,

PRIMARY KEY (`track_id`, `playlist_id`)
);

CREATE TABLE IF NOT EXISTS `artist` (
`artist_id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(70) NOT NULL,
`email` VARCHAR (40) NOT NULL,

PRIMARY KEY (`artist_id`)
);

CREATE TABLE IF NOT EXISTS `country` (
`country_id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(30) NOT NULL,
`region` VARCHAR(30) DEFAULT NULL,

PRIMARY KEY (`country_id`)
);

CREATE TABLE IF NOT EXISTS `album` (
`album_id` INT NOT NULL AUTO_INCREMENT,
`name` VARCHAR(40) NOT NULL,
`release_date` DATE NOT NULL,
`number_tracks` TINYINT NOT NULL,

PRIMARY KEY (`album_id`)
);

CREATE TABLE IF NOT EXISTS `log` (
	`id` INT UNSIGNED AUTO_INCREMENT,
	`time` DATETIME,
    `user_name` VARCHAR(255),
    `event` VARCHAR(255),
    `description` VARCHAR(255),
    PRIMARY KEY (`id`)
);

#FOREIGN_KEYS

ALTER TABLE `user`
ADD CONSTRAINT `fk_address_1`
	FOREIGN KEY (`address_id`)
	REFERENCES `address` (`address_id`)
	ON DELETE RESTRICT
	ON UPDATE CASCADE;
    
ALTER TABLE `track`
ADD CONSTRAINT `fk_artist`
	FOREIGN KEY (`artist_id`)
	REFERENCES `artist` (`artist_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    
ADD CONSTRAINT `fk_album`
	FOREIGN KEY (`album_id`)
	REFERENCES `album` (`album_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;
    
ALTER TABLE `playlist`
ADD CONSTRAINT `fk_user_1`
	FOREIGN KEY (`user_id`)
	REFERENCES `user` (`user_id`)  
	ON DELETE CASCADE
	ON UPDATE CASCADE;
    
ALTER TABLE `address`
ADD CONSTRAINT `fk_country`
	FOREIGN KEY (`country_id`)
	REFERENCES `country` (`country_id`)
	ON DELETE RESTRICT
	ON UPDATE CASCADE;
    
ALTER TABLE `payment`
ADD CONSTRAINT `fk_user_2`
	FOREIGN KEY (`user_id`) 
	REFERENCES `user` (`user_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;

ALTER TABLE `historic_tracks`
ADD CONSTRAINT `fk_user_3`
	FOREIGN KEY (`user_id`)
	REFERENCES `user` (`user_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,

ADD CONSTRAINT `fk_track_1`
	FOREIGN KEY (`track_id`)
	REFERENCES `track` (`track_id`)
	ON DELETE NO ACTION
	ON UPDATE CASCADE;
    
ALTER TABLE `track_playlist`
ADD CONSTRAINT `fk_track_2`
	FOREIGN KEY (`track_id`) 
	REFERENCES `track` (`track_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
    
ADD CONSTRAINT `fk_playlist`
	FOREIGN KEY (`playlist_id`) 
	REFERENCES `playlist` (`playlist_id`)
	ON DELETE CASCADE
	ON UPDATE CASCADE;

#INSERTING_DATA

INSERT INTO `country` (`name`, `region`) VALUES
('United States', 'North America'),
('England', 'Europe'),
('Canada', 'North America'),
('Australia', 'Oceania'),
('Japan', 'Asia'),
('Portugal', 'Europe'),
('Angola', 'Africa'),
('Brazil', 'South America')
;

INSERT INTO `address` (`street_name`, `zip_code`, `city`, `country_id`) VALUES
('123 Main St', '12345', 'New York', 1),
('456 Oak St', '67890', 'London', 2),
('789 Maple St', '13579', 'Toronto', 3),
('101 Pine St', '24680', 'Sydney', 4),
('202 Cedar St', '97531', 'Tokyo', 5),
('Rua das Flores', '54321', 'Lisbon', 6),
('Avenida da Liberdade', '98765', 'Luanda', 7),
('Avenida Paulista', '54321', 'Sao Paulo', 8),
('High Street', '13579', 'Vancouver', 3),
('Bourke Street', '24680', 'Melbourne', 4),
('Ginza', '97531', 'Tokyo', 5),
('Rua do Carmo', '12345', 'Lisbon', 6),
('Avenida Boavista', '67890', 'Porto', 6),
('Rua de Santa Catarina', '13579', 'Braga', 6),
('Avenida da Independência', '24680', 'Luanda', 7),
('Rua Comandante Cow Boy', '97531', 'Lubango', 7),
('Copacabana', '54321', 'Rio de Janeiro', 8),
('Rua Augusta', '98765', 'Sao Paulo', 8),
('Avenida Beira-Mar', '24680', 'Fortaleza', 8),
('Praia de Boa Viagem', '97531', 'Recife', 8),
('Rua das Pedras', '54321', 'Búzios', 8),
('Av. Paulista', '98765', 'Sao Paulo',8)
;

INSERT INTO `user` (`first_name`, `last_name`, `password`, `email`, `phone_number`, `birth_date`, `gender`, `address_id`, `vat`, `apps_rating`) VALUES 
('John', 'Doe', 'password123', 'john.doe@email.com', NULL,'1990-01-01', 'male', 8, '17673669', 5),
('Teresa', 'Ribeiro', 'pass_tere', 't.rib@email.com', NULL,'1970-05-7', 'female', 7, '47687809', 4),
('Pedro', 'Ribeiro', '2030192', 'pedro.rib@email.com', '937865446','1973-08-25', 'male', 11, '23543467', 5),
('Jane', 'Smith', 'pass456', 'jane.smith@email.com', NULL,'1995-05-10', NULL, 22, 'PT123456789', 1),
('Sam', 'Johnson', 'pass789', 'sam.johnson@email.com', '456-789-0123', '1985-08-15', 'male', 1, 'PT987654321', 2),
('Emily', 'Johnson', 'pass987', 'emily.davis@email.com', '789-012-3456','1992-03-20', 'female', 3, 'PT567890123', 5),
('Sarah', 'Williams', 'pass123', 'sarah.williams@email.com', NULL,'1988-07-05', 'female', 6, 'PT555555555', NULL),
('Tom', 'Anderson', 'TOMANDRE$="%', 'tom.anderson@email.com','555-123-4567', '1991-12-12', NULL, 18,'PT111111111', NULL),
('Sophie', 'Miller', '"%#Sophie1289!', 'sophie.miller@email.com','777-888-9999','1983-04-25', 'female', 18,'PT222222222', 5),
('Michael', 'Jones', 'michael_1996!', 'michael.jones@email.com','222-333-4444', '1996-09-08', 'male', 20,'PT333333333', 5),
('Emma', 'Davis', 'pass654', 'emma.davis@email.com','333-444-5555', '1990-02-18', NULL, 5,'PT444444444', 4), 
('Matilde', 'Santos', 'matildeSANTOS2003', 'matilde2003@email.com', '967654575', '2003-08-14', 'female', 2,'8537498749289', 2),
('Matilde', 'Carneiro', 'PAsswordjnkkl!', 'matildecarneiro@email.com',NULL, '2007-05-13', 'female', 10, NULL, 4),
('Alex', 'Martinez', 'pass321', 'alex.martinez@email.com', '555-666-7777', '1987-11-30', NULL, 19, NULL, 5),
('Olivia', 'Brown', 'pass234', 'olivia.brown@email.com','999-888-7777', '1993-05-22', 'female', 2, NULL, 3),
('Daniel', 'Rodriguez', 'pass876', 'daniel.rodriguez@email.com', '111-222-3333', '1985-08-02', 'male', 14, '88888888', 2),
('Sophia', 'Garcia', 'pass543', 'sophia.garcia@email.com', '444-555-7777', '1998-01-10', 'female', 16,'99999999', 2),
('Jack', 'Taylor', 'pass012', 'jack.taylor@email.com', '777-666-5555', '1989-09-14', 'male', 15, '23123123', 1),
('Ava', 'Clark', 'pass789',' ava.clark@email.com', '222-111-0000', '1994-04-05', 'female', 1,'234234234', 5),
('Lucas', 'White', 'pass456', 'lucas.white@email.com', '888-777-6666', '1986-12-08', 'male', 20,'345345345', 4),
('Chloe', 'Anderson', 'pass987', 'chloe.anderson@email.com', '333-444-5555', '1992-07-18', 'female', 8, '456456456', 4),
('Benjamin', 'Harris', 'pass654', 'benjamin.harris@email.com','444-555-6666', '1997-03-25', 'male', 13, '567567567', 5)
;

INSERT INTO `payment` (`date`, `price`, `valid_until`, `user_id`) VALUES 
('2023-02-15', 10.99, '2023-03-15', 1),
('2022-07-10', 10.99, '2022-08-10', 2),
('2022-05-22', 10.99, '2022-06-22', 3),
('2021-09-08', 10.99, '2021-10-08', 4),
('2021-03-18', 10.99, '2021-04-18', 5),
('2020-11-05', 10.99, '2020-12-05', 6),
('2020-09-20', 10.99, '2020-10-20', 7),
('2020-06-12', 10.99, '2020-07-12', 8),
('2023-02-15', 10.99, '2023-03-15', 9),
('2022-07-10', 10.99, '2022-08-10', 10),
('2022-05-22', 10.99, '2022-06-22', 11),
('2021-09-08', 10.99, '2021-10-08', 12),
('2021-03-18', 10.99, '2021-04-18', 13),
('2020-11-05', 10.99, '2020-12-05', 14),
('2020-09-20', 10.99, '2020-10-20', 15),
('2020-06-12', 10.99, '2020-07-12', 16),
('2023-02-15', 10.99, '2023-03-15', 17),
('2022-07-10', 10.99, '2022-08-10', 18),
('2022-05-22', 10.99, '2022-06-22', 19),
('2021-09-08', 10.99, '2021-10-08', 20),
('2021-03-18', 10.99, '2021-04-18', 21),
('2020-11-05', 10.99, '2020-12-05', 22),
('2022-10-15', 10.99, '2022-11-15', 1),
('2022-04-05', 10.99, '2022-05-05', 2),
('2021-08-22', 10.99, '2021-09-22', 3),
('2021-01-12', 10.99, '2021-02-12', 4),
('2020-12-03', 10.99, '2021-01-03', 5),
('2020-08-28', 10.99, '2020-09-28', 6),
('2020-07-10', 10.99, '2020-08-10', 7),
('2022-10-15', 10.99, '2022-11-15', 8),
('2022-04-05', 10.99, '2022-05-05', 9),
('2021-08-22', 10.99, '2021-09-22', 10),
('2021-01-12', 10.99, '2021-02-12', 11),
('2020-12-03', 10.99, '2021-01-03', 12),
('2020-08-28', 10.99, '2020-09-28', 13),
('2020-07-10', 10.99, '2020-08-10', 15),
('2022-10-15', 10.99, '2022-11-15', 16),
('2022-04-05', 10.99, '2022-05-05', 17),
('2021-08-22', 10.99, '2021-09-22', 18),
('2021-01-12', 10.99, '2021-02-12', 19),
('2020-12-03', 10.99, '2021-01-03', 20),
('2020-08-28', 10.99, '2020-09-28', 21),
('2020-07-10', 10.99, '2020-08-10', 22)
;

INSERT INTO `artist` (`name`,`email`) VALUES
('Iron Maiden', 'ironmaiden@gmail.com'),
('Ludwig van Beethoven', 'beethoven@outlook.com'),
('Wolfgang Amadeus Mozart', 'mozart@outlook.com'),
('Red Hot Chili Peppers', 'rhcp@gmail.com'),
('Mac Miller', 'mcmil@gmail.com'),
('Rex Orange County', 'roc@gmail.com'),
('Alesso', 'alesso@gmail.com'),
('Frank Sinatra', 'frankie@gmail.com'),
('Taylor Swift', 'taylorswift@gmail.com'),
('Harry Styles', 'harrystyles@gmail.com'),
('Shawn Mendes', 'shawnmendes@gmail.com'),
('John Mayer', 'johnmayer@gmail.com'),
('Rosalía', 'rosalia@gmail.com'),
('Miley Cyrus', 'mileycyrus@gmail.com'),
('Lizzy McAlpine', 'lizzymcalpine@gmail.com'),
('Bad Bunny', 'badbunny@gmail.com'),
('Arctic Monkeys','arcticmonkeys@gmail.com'),
('Beyoncé', 'beyonceg@mail.com'),
('U2', 'u2@gmail.com'),
('Katy Perry', 'katyperry@gmail.com'),
('Ariana Grande', 'arianagrande@gmail.com')
;

INSERT INTO `album` (`name`,`release_date`,`number_tracks`) VALUES
('The Number of the Beast', '1982-03-22',3),
('Californication', '1999-06-08', 3),
('Watching Movies with the Sound Off', '2013-06-18', 2),
('Pony', '2019-10-25', 3),
('Forever', '2015-05-26', 3),
('A Jolly Christmas From Frank Sinatra', '1957-09-01', 3),
('Fine Line', '2019-12-13', 1),
('Harrys House', '2022-05-20', 1),
('1989 ', '2023-10-27', 2),
('Lover', '2019-08-23', 1),
('Favorite Worst Nightmare', '2007-04-20', 2),
('Continuum', '2007-04-20', 2),
('Sob Rock', '2021-07-16', 3),
('Illuminate', '2016-09-23', 1),
('MOTOMAMI +', '2022-09-09', 2),
('Endless Summer Vacation', '2023-03-10', 2),
('five seconds flat', '2022-04-08', 1),
('Un Verano Sin Ti', '2022-04-08', 2),
('Taylor Swift', '2006-10-24', 1),
('RENAISSANCE', '2022-07-29', 3),
('4', '2011-06-24', 2),
('All that you cant leave behind', '2000-10-30', 1),
('Sweetener', '2018-08-17', 2),
('PRISM', '2013-10-18', 1),
('Teenage Dream', '2010-08-24', 1)
;

INSERT INTO `track` (`name`,`length`,`genre`,`artist_id`,`album_id`) VALUES
('Run to the Hills', '00:03:53', 'heavy metal', 1, 1),
('The Number of the Beast', '00:04:50', 'heavy metal', 1, 1),
('Hallowed Be Thy Name', '00:07:12', 'heavy metal', 1, 1),
('Symphony No. 5 in C Minor, OP. 67', '00:07:22', 'classic', 2, NULL),
('Requiem in D Minor, K. 626', '00:03:19', 'classic', 3, NULL),
('Otherside', '00:04:15', 'rock', 4, 2),
('Californication', '00:05:29', 'rock', 4, 2),
('Easily', '00:03:51', 'rock', 4, 2),
('Objects in the Mirror', '00:04:19', 'pop', 5, 3),
('I Am Who Am (Killin Time)', '00:05:01', 'pop', 5, 3),
('10/10', '00:02:26', 'indie', 6, 4),
('Always', '00:03:17', 'indie', 6, 4),
('Face To Face', '00:03:39', 'indie', 6, 4),
('Heroes (we could be)', '00:03:30', 'house', 7, 5),
('If I Lose Myself', '00:03:33', 'house', 7, 5),
('Under Control', '00:03:03', 'house', 7, 5),
('Jingle Bells', '00:02:00', 'jazz', 8, 6),
('Have Yourself A Merry Little Christmas', '00:03:26', 'jazz', 8, 6),
('Mistletoe And Holly', '00:02:16', 'jazz', 8, 6),
('Watermelon Sugar', '00:02:54', 'pop', 10, 7),
('As It Was', '00:02:47', 'pop', 10, 8),
('Is it Over Now?', '00:03:49', 'pop', 9, 9),
('Wildest Dreams', '00:03:40', 'pop', 9, 9),
('Picture To Burn', '00:02:53', 'country', 9, 19),
('Lover', '00:03:41', 'pop', 9, 10),
('Fluorescent Adolescent', '00:02:58', 'rock', 17, 11),
('505', '00:04:14', 'rock', 17, 11),
('Gravity', '00:04:05', 'rock', 12, 12),
('Slow dancing in a Burning Room', '00:04:02', 'rock', 12, 12),
('New Light', '00:03:37', 'rock', 12, 13),
('Wild Blue', '00:04:12', 'rock', 12, 13),
('Last Train Home', '00:03:07', 'rock', 12, 13),
('Mercy', '00:03:29', 'pop', 11, 14),
('LA FAMA', '00:03:08', 'pop', 13, 15),
('MOTOMAMI', '00:01:01', 'pop', 13, 15),
('Flowers', '00:03:21', 'pop', 14, 16),
('Jaded', '00:03:06', 'pop', 14, 16),
('ceilings', '00:03:03', 'pop', 15, 17),
('Tití Me Preguntó', '00:04:04', 'latino', 16, 18),
('Ojitos Lindos', '00:04:18', 'latino', 16, 18),
('BREAK MY SOUL', '00:04:38', 'pop', 18, 20),
('CUFF IT', '00:03:45', 'pop', 18, 20),
('ALIEN SUPERSTAR', '00:03:36', 'pop', 18, 20),
('Love on Top', '00:04:27', 'pop', 18, 21),
('Best Thing I Never Had', '00:04:13', 'pop', 18, 21),
('Beautiful Day','00:04:08', 'pop', 19, 22),
('God is a woman','00:03:18', 'pop', 21, 23),
('no tears left to cry','00:03:26', 'pop', 21, 23),
('Firework','00:03:48', 'pop', 20, 25),
('Roar','00:03:44', 'pop', 20, 24)
;

INSERT INTO `playlist` (`user_id`, `name`) VALUES
(3, 'pop_songs'),
(7, 'classics'),
(11, 'metal_class'),
(7, 'jazzing'),
(20, 'chill_vibes'),
(17, 'workout_hits')
;

INSERT INTO `track_playlist` (`playlist_id`,`track_id`) VALUES
(1, 9),
(1, 10),
(1, 11),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 3),
(4, 18),
(4, 19),
(4, 20),
(5, 44),
(5, 32),
(5, 18),
(5, 25),
(5, 20),
(5, 33),
(5, 24),
(6, 5),
(6, 9),
(6, 4),
(6, 34),
(6, 10),
(6, 50),
(6, 14),
(6, 22),
(6, 30),
(6, 31)
;

INSERT INTO `historic_tracks` (`user_id`, `time`, `track_id`) VALUES
(22, NOW(), 15),
(10, '2023-12-05 21:05:23', 15),
(1, '2022-01-15 08:30:15', 25),
(5, '2022-03-20 14:45:30', 10),
(12, '2022-05-10 18:20:45', 30),
(8, '2022-07-02 12:10:00', 5),
(18, '2022-09-08 09:55:15', 40),
(22, '2022-11-12 17:40:30', 20),
(6, '2023-01-25 21:15:45', 15),
(14, '2023-04-30 10:05:00', 35),
(3, '2023-06-18 16:50:15', 3),
(20, '2023-09-05 13:25:30', 45),
(10, '2022-02-08 07:30:45', 12),
(7, '2022-04-14 16:20:00', 28),
(15, '2022-06-22 11:45:15', 8),
(11, '2022-08-17 20:10:30', 42),
(4, '2022-10-25 14:55:45', 18),
(16, '2022-12-30 09:30:00', 33),
(9, '2023-02-05 19:15:15', 7),
(19, '2023-05-12 08:50:30', 22),
(2, '2023-07-20 15:25:45', 48),
(13, '2023-09-28 12:00:00', 13),
(21, '2023-12-02 18:35:15', 38),
(17, '2022-01-10 22:15:30', 9),
(4, '2022-03-26 14:30:45', 44),
(8, '2022-05-15 10:05:00', 11),
(14, '2022-07-02 19:40:15', 26),
(19, '2022-09-18 08:20:30', 16),
(6, '2022-11-22 16:55:45', 37),
(11, '2023-02-02 21:30:00', 2),
(15, '2023-04-08 11:05:15', 49),
(1, '2023-06-15 17:40:30', 14),
(20, '2023-08-22 09:15:45', 29),
(10, '2023-10-30 14:50:00', 4),
(5, '2023-01-04 20:25:15', 39),
(13, '2023-03-12 12:00:45', 23),
(17, '2023-05-20 18:35:00', 6),
(2, '2023-07-27 08:10:15', 32),
(9, '2023-10-03 15:45:30', 17),
(12, '2023-12-10 11:20:45', 46),
(16, '2022-01-15 07:30:00', 19),
(3, '2022-03-22 16:20:15', 36),
(7, '2022-06-02 10:45:45', 7),
(21, '2022-08-10 18:10:00', 27),
(18, '2022-10-15 08:45:15', 10),
(22, '2022-12-22 15:20:30', 21),
(1, '2023-03-02 21:55:45', 47),
(5, '2023-05-10 11:30:15', 1),
(14, '2023-07-18 17:05:45', 31),
(8, '2023-09-25 08:40:00', 16),
(10, '2023-12-01 15:15:15', 41),
(15, '2022-01-05 20:50:30', 24),
(6, '2022-03-15 09:25:45', 2),
(11, '2022-05-22 15:00:15', 47),
(3, '2022-07-30 20:35:45', 9),
(17, '2022-10-06 09:10:00', 34),
(20, '2022-12-12 14:45:15', 4),
(2, '2023-02-18 20:20:45', 25),
(16, '2023-04-28 09:55:00', 18),
(9, '2023-07-05 16:30:15', 43),
(13, '2023-09-11 11:05:45', 14),
(19, '2023-11-18 17:40:00', 30),
(7, '2022-01-25 21:15:45', 5),
(4, '2022-04-03 10:50:15', 20),
(12, '2022-06-10 16:25:45', 37),
(18, '2022-08-17 08:00:15', 10),
(22, '2022-10-25 14:35:45', 24),
(1, '2023-01-02 20:10:45', 49),
(5, '2023-03-20 09:45:45', 11),
(10, '2023-05-28 15:20:15', 27),
(14, '2023-08-05 20:55:45', 8),
(8, '2023-10-12 11:30:15', 38),
(21, '2023-11-29 08:55:45', 45),
(15, '2022-02-15 14:20:15', 17),
(6, '2022-04-22 09:45:45', 31),
(11, '2022-07-01 16:10:15', 13),
(3, '2022-09-15 18:55:45', 25),
(17, '2022-11-22 10:30:15', 12),
(22, '2023-02-27 15:05:45', 39),
(1, '2023-05-07 11:40:15', 20),
(5, '2023-07-14 08:15:45', 34),
(14, '2023-09-20 14:50:15', 16),
(8, '2023-11-27 20:25:45', 1),
(10, '2022-02-01 09:00:15', 15),
(15, '2022-04-10 15:35:45', 29),
(6, '2022-06-18 07:10:15', 43),
(11, '2022-08-25 13:45:45', 14),
(4, '2022-11-01 19:20:15', 28),
(16, '2023-01-08 10:55:45', 3),
(9, '2023-03-18 16:30:15', 47),
(19, '2023-06-24 21:05:45', 9),
(2, '2023-09-01 11:40:15', 23),
(13, '2023-11-07 17:15:45', 48),
(21, '2022-01-12 20:50:15', 22),
(17, '2022-03-20 08:25:45', 36),
(4, '2022-05-26 15:00:15', 7),
(12, '2022-08-01 21:35:45', 21),
(18, '2022-10-08 11:10:15', 46),
(22, '2022-12-15 17:45:45', 6),
(1, '2023-02-22 09:20:15', 32),
(5, '2023-05-01 15:55:45', 17),
(14, '2023-07-08 20:30:15', 41),
(8, '2023-09-14 10:05:45', 26),
(10, '2023-12-20 16:40:15', 50),
(5, '2022-02-15 14:20:45', 7),
(13, '2022-04-22 09:45:15', 14),
(9, '2022-07-01 16:10:45', 15),
(3, '2022-09-15 18:55:15', 7),
(17, '2022-11-22 10:30:45', 14),
(22, '2023-02-27 15:05:15', 15),
(1, '2023-05-07 11:40:45', 7),
(5, '2023-07-14 08:15:15', 14),
(14, '2023-09-20 14:50:45', 15),
(8, '2023-11-27 20:25:15', 7)
;

#QUERIES

/*QUESTION 1*/

SELECT ht.`time` AS `timeStamp`, concat(u.`first_name`, ' ',u.`last_name`) AS `fullName`, t.`name` AS `trackName`
FROM `historic_tracks` AS ht
JOIN `user` AS u
ON ht.`user_id` = u.`user_id`
JOIN `track` AS t
ON ht.`track_id` = t.`track_id`
WHERE `time` BETWEEN (SELECT MIN(`time`) FROM `historic_tracks`) AND (SELECT MAX(`time`) FROM `historic_tracks`)
ORDER BY `timeStamp` DESC;

/*QUESTION 2*/

SELECT t.`name` AS `trackName`, count(1) AS `numberOfPlays`
FROM `historic_tracks` AS ht
JOIN `track` AS t
ON t.`track_id` = ht.`track_id`
GROUP BY t.`track_id`
ORDER BY `numberOfPlays` DESC
LIMIT 3;

/*QUESTION 3*/

SELECT '2020/01 - 2023/12' AS `periodOfSales`,
SUM(`price`) AS `totalSales`, 
round(SUM(`price`)/4,2) AS `yearlyAverage`, 
round(SUM(`price`)/(4*12),2) AS `monthlyAverage`
FROM `payment`
WHERE `date` BETWEEN '2020-01-01' AND '2023-12-31';

/*QUESTION 4*/

SELECT c.`name` AS `countryName`, COUNT(1) AS `playsPerCountry`
FROM `historic_tracks` AS ht
JOIN `user` AS u
ON ht.`user_id` = u.`user_id`
JOIN `address` AS a
ON u.`address_id` = a.`address_id`
JOIN `country` AS c
ON a.`country_id` = c.`country_id`
GROUP BY c.`country_id`
ORDER BY `playsPerCountry` DESC;

/*QUESTION 5*/

SELECT c.`name` AS `countryName`, round(AVG(u.`apps_rating`),2) AS `averageRating`
FROM `country` AS c
JOIN `address` AS a
ON c.`country_id` = a.`country_id`
JOIN `user` AS u
ON a.`address_id` = u.`address_id`
WHERE u.`apps_rating` IS NOT NULL
GROUP BY c.`country_id`;

#TRIGGERS

/*TRIGGER 1*/
DELIMITER $$

CREATE TRIGGER `on_track_insert` AFTER INSERT
ON `track`
FOR EACH ROW
BEGIN
	INSERT INTO `log` (`time`, `user_name`, `event`, `description`) VALUES
	(NOW(), USER(), 'insert', concat('Track added: ', NEW.`name`));
END $$
    
DELIMITER ;

/*TRIGGER 2*/
DELIMITER $$

CREATE TRIGGER `album_update_track` AFTER INSERT
ON `track`
FOR EACH ROW
BEGIN
	IF new.`album_id` IS NOT NULL THEN
		UPDATE `album`
		SET `number_tracks` = `number_tracks` + 1
		WHERE `album_id` = new.`album_id`;
	END IF;
END $$

DELIMITER ;

SELECT *
FROM `album`
WHERE `album_id` = 3;

INSERT INTO `track` (`name`,`length`,`genre`,`artist_id`,`album_id`) VALUES
('Red Dot Music', '00:06:07', 'pop', 5, 3),
('Watching Movies', '00:03:40', 'pop', 5, 3)
;

SELECT *
FROM `album`
WHERE `album_id` = 3;

#INVOICES

/*INVOICE_HEADER*/
CREATE VIEW `invoice_header` AS
SELECT
	u.`user_id` AS `userID`,
	p.`date` AS `paymentDate`,
    concat(u.`first_name`,' ', u.`last_name`) AS `fullName`,
	p.`price` AS `totalPrice`,
    u.`email` AS `emailUser`,
    u.`phone_number` AS `phoneNumberUser`,
    a.`street_name` AS `streetName`,
    a.`zip_code` AS `zipCode`,
    a.`city` AS `city`,
    c.`name` AS `country`
    FROM `user` AS u
    JOIN `address` AS a
    ON u.`address_id` = a.`address_id`
    JOIN `country` AS c
    ON a.`country_id` = c.`country_id`
    JOIN `payment` AS p
    ON p.`user_id` = u.`user_id`
    ORDER BY p.`date` DESC;

/*INVOICE_DETAILS*/
CREATE VIEW `invoice_details` AS
SELECT
	`user_id` AS `userID`,
    `date` AS `paymentDate`,
    round(`price`*77/100,2) AS `subTotal`,
    '23%' AS `taxRate`,
    round(`price`*23/100,2) AS `tax`,
    `price` AS `totalPrice`,
    `valid_until` AS `validUntil`
    FROM `payment`;
    
SELECT *
FROM `invoice_details`
WHERE `userID` = 20;