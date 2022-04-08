/*Створення бази даних*/
CREATE DATABASE IF NOT EXISTS library_database;

/*Видалення попередньої версії бази даних*/
DROP DATABASE IF EXISTS library_database;

/*Створення таблиці на основі універсального відношення.*/
CREATE TABLE IF NOT EXISTS library_database_table(
	number INT NOT NULL,
    code INT NOT NULL PRIMARY KEY,
    novelty ENUM('Yes', 'No'),
    name VARCHAR(100) NOT NULL,
    prise FLOAT(5,2) DEFAULT '0',
    publisher VARCHAR(30) NOT NULL,
    pages INT NOT NULL,
    format VARCHAR(30) DEFAULT 'Невідомо',
    date DATE DEFAULT NULL,
    circulation INT CHECK (circulation<=5000) NOT NULL,
    topic VARCHAR(100) NOT NULL,
    category VARCHAR(30) NOT NULL
);

/*Створення додаткового індексу*/
CREATE INDEX number ON library_database_table(number);

/*Завантаження даних в таблицю*/
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`) VALUES
	(2, 5110, 'No', 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 'Видавнича група BHV', 400, '70x100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Підручники'),
    (8, 4985, 'No', 'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид', 18.90, 'Вільямс', 288, '70x100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 'Підручники'),
    (9, 5141, 'No', 'Структури даних та алгоритми', 37.80, 'Вільямс', 384, '70x100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 'Підручники'),
    (20, 5127, 'No', 'Автоматизація інженерно-графічних робіт', 11.58, 'Видавнича група BHV', 256, '70x100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
    (31, 5111, 'No', 'Апаратні засоби мультимедіа. Відеосисема PC', 15.51, 'Видавнича група BHV', 400, '70x100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
    (46, 5199, 'No', 'Залізо IMB 2001', 30.07, 'МикроАрт', 368, '70x100/16', '2000-02-12', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `format`, `circulation`, `topic`, `category`) VALUES
	(50, 3851, 'No', 'Захист інформації, та безбека комп\'ютених систем', 26.00, 'DiaSoft', 480, '84x108/16', 5000, 'Використання ПК в цілому', 'Захист і безпека ПК');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`) VALUES 	(58, 3932, 'No', 'Як перетворити перс
ональний комп\'ютер на вимірювальний комплекс', 7.65, 'ДМК', 144, '60x88/16', '1999-09-26', 5000, 'Використання ПК в цілому', 'Інші книги'),
	(59, 4713, 'No', 'Plug-ins. Додаткові програми для музичних програм', 11.41, 'ДМК', 144, '70x100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 'Інші книги'),
    (175, 5217, 'No', 'Windows ME. Найновіші версії програм', 16.57, 'Триумф', 320, '70x100/16', '2000-08-25', 5000, 'Операційні системи', 'Windows 2000'),
    (176, 4829, 'No', 'Windows 2000 Proffesional крок за кроком з CD', 27.25, 'Эком', 320, '70x100/16', '2000-04-28', 5000, 'Операційні системи', 'Windows 2000'),
    (188, 5170, 'No', 'Linux версії', 24.43, 'ДМК', 346, '70x100/16', '2000-09-29', 5000, 'Операційні системи', 'Linux'),
    (191, 860, 'No', 'Операційна система UNIX', 3.50, 'Видавнича група BHV', 395, '84x100/16', '1997-05-05', 5000, 'Операційні системи', 'UNIX'),
    (203, 44, 'No', 'Відповіді на актуальні запитання щодо OS/2 Warp', 5.00, 'DiaSoft', 352, '60x84/16', '1996-03-20', 5000, 'Операційні системи', 'Інші операційні системи');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `date`, `circulation`, `topic`, `category`) VALUES 
	(206, 5176, 'No', 'Windows ME. Супутник користувача', 12.76, 'Видавнича група BHV', 306, '2000-10-10', 5000, 'Операційні системи', 'Інші операційні системи');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`) VALUES 
	(209, 5462, 'No', 'Мова програмування С++. Лекції та вправи', 29.00, 'DiaSoft', 656, '84x108/16', '2000-12-12', 5000, 'Програмування', 'C&C++'),
    (210, 4982, 'No', 'Мова програмування С. Лекції та вправи', 29.00, 'DiaSoft', 656, '84x108/16', '2000-07-12', 5000, 'Програмування', 'C&C++'),
    (220, 4687, 'No', 'Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів', 17.60, 'ДМК', 240, '70x100/16', '2000-02-03', 5000, 'Програмування', 'C&C++');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`, `publisher`, `pages`, `format`,`circulation`, `topic`, `category`) VALUES 
	(222, 235, 'No', 'Інформаційні системи і структури даних', 'Києво-Могилянська академія', 288, '60x90/16', 400, 'Використання ПК в цілому', 'Інші книги');
INSERT INTO `library_database_table`(`number`, `code`, `novelty`, `name`,`publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`) VALUES
	(225, 8746, 'Yes', 'Бази даних в інформаційних системах', 'Університет "Україна"', 418, '60x84/16', '2018-07-25', 100, 'Програмування', 'SQL'),
    (226, 2154, 'Yes', 'Сервер на основі операційної системи FreeBSD 6.1', 'Університет "Україна"', 216, '60x84/16', '2015-11-03', 500, 'Програмування', 'Інші операційні системи'),
    (245, 2662, 'No', 'Організація баз даних та знань', 'Вінниця:ВДПУ', 208, '60x90/16', '2001-10-10', 1000, 'Програмування', 'SQL'),
    (247, 5641, 'Yes', 'Організація баз даних та знань', 'Видавнича група BHV', 384, '70x100/16', '2018-07-25', 5000, 'Програмування', 'SQL');


/*Додавання в таблицю нового текстового поля Autor, розміром 15 символів*/
ALTER TABLE library_database_table ADD Autor VARCHAR(15);

/*Збільшення розміру текстового поля Autor до 20 символів*/
ALTER TABLE library_database_table MODIFY COLUMN Autor VARCHAR(20); 

/*Видалення текстового поля Autor з таблиці*/
ALTER TABLE library_database_table DROP COLUMN Autor; 

/*Зміна порядку сортування індексу і призначення йому унікальності*/
CREATE UNIQUE INDEX library_database_table_marks ON library_database_table (number);
SELECT * FROM library_database_table ORDER BY number DESC;

/*Видалення індексу*/
DROP INDEX library_database_table_marks ON library_database_table;