/*Вивести значення наступних колонок: номер, код, новинка, назва, ціна, сторінки*/
SELECT number, cod, new, name, price, pages
FROM `book`;

/*Вивести значення всіх колонок*/
SELECT number, cod, new, name, price, publisher, pages, format, datee, circulation, topic, category
FROM `book`;

/*Вивести значення колонок в наступному порядку: код, назва, новинка, сторінки, ціна, номер */
SELECT cod, name, new, pages, price, number
FROM `book`;

/*Вивести значення всіх колонок 10 перших рядків */
SELECT *
FROM `book` 
LIMIT 10;

/*Вивести значення всіх колонок 10% перших термін*/
SET @a = (SELECT CAST(COUNT(*) / 10 AS UNSIGNED) from `book`);
PREPARE STMT FROM 'SELECT * FROM book LIMIT ?';
EXECUTE STMT USING @a;
SELECT DISTINCT publisher FROM `book`;

/*Вивести значення колонки код без повторення однакових кодів*/
SELECT * 
FROM `book` 
GROUP BY cod;

/*Вивести всі книги новинки*/
SELECT * 
FROM `book`
WHERE new = 1; 

/*Вивести всі книги новинки з ціною від 20 до 30*/
SELECT * 
FROM `book` 
WHERE (new = 1) AND (price > 20 AND price < 30); 

/*Вивести всі книги новинки з ціною менше 20 і більше 30*/
SELECT * 
FROM `book` 
WHERE (new = 1) AND (price < 20 OR price > 30); 

/*Вивести всі книги з кількістю сторінок від 300 до 400 і з ціною більше 20 і менше 30*/
SELECT * 
FROM `book` 
WHERE (300 < pages < 400) AND (price > 20 AND price < 30);

/*Вивести всі книги видані взимку 2000 року*/
SELECT * 
FROM `book`
WHERE datee = '2000-01-01' AND datee '2000-03-01'; 

/*Вивести книги зі значеннями кодів 5110, 5141, 4985, 4241*/
SELECT * FROM `book` 
WHERE cod = 5110
OR    cod = 5141
OR    cod = 4985
OR    cod = 4241;

/*Вивести книги видані в 1999, 2001, 2003, 2005 р*/
SELECT * FROM `book` 
WHERE YEAR(datee) = 1999
OR    YEAR(datee) = 2001
OR    YEAR(datee) = 2003
OR    YEAR(datee) = 2005;

/*Вивести книги назви яких починаються на літери А-К*/
SELECT * 
FROM `book` 
WHERE name LIKE 'А%' OR name LIKE 'К%'; 

/*Вивести книги назви яких починаються на літери "АПП", видані в 2000 році з ціною до 20*/
SELECT * 
FROM `book` 
WHERE name LIKE 'Апп%' AND datee = '2000-01-01' AND datee = '2000-12-31' AND price < 20; 

/*Вивести книги назви яких починаються на літери "АПП", закінчуються на "е", видані в першій половині 2000 року*/
SELECT * 
FROM `book` 
WHERE name LIKE 'Апп%е' AND date = '2000-01-01' AND date = '2000-6-30'; 

/*Вивести книги, в назвах яких є слово Microsoft, але немає слова Windows*/
SELECT * 
FROM `book`
WHERE name LIKE '%Microsoft%' AND NOT name LIKE '%Windows%';

/*Вивести книги, в назвах яких присутня як мінімум одна цифра.*/
SELECT *
FROM `book`
WHERE name REGEXP '[0-9]';

/*Вивести книги, в назвах яких присутні не менше трьох цифр.*/
SELECT *
FROM `book`
WHERE name REGEXP '([0-9].*){3}';

/*Вивести книги, в назвах яких присутній рівно п'ять цифр.*/
SELECT *
FROM `book`
WHERE name REGEXP '([0-9].*){5}' AND name NOT REGEXP '([0-9].*){6}';