/*1. Вивести книги у яких не введена ціна або ціна дорівнює 0*/
SELECT * FROM `book` WHERE price is NULL OR price = 0; 

/*2. Вивести книги у яких введена ціна, але не введений тираж*/
SELECT * FROM `book` WHERE price is NOT NULL AND circulation is NULL; 

/*3. Вивести книги, про дату видання яких нічого не відомо.*/
SELECT * FROM `book` WHERE datee is NULL; 

/*4. Вивести книги, з дня видання яких пройшло не більше року.*/
SELECT * FROM `book` WHERE (CURRENT_DATE - datee)< (1-0-0); 

/*5. Вивести список книг-новинок, відсортованих за зростанням ціни*/
SELECT * FROM `book` WHERE (new = 1) ORDER BY price ASC; 

/*6. Вивести список книг з числом сторінок від 300 до 400, відсортованих в зворотному алфавітному порядку назв*/
SELECT * FROM `book` WHERE (pages>300 AND pages <400) ORDER BY name DESC;

/*7. Вивести список книг з ціною від 20 до 40, відсортованих за спаданням дати*/
SELECT * FROM `book` WHERE (price > 20 AND price < 40) ORDER BY datee DESC;  

/*8. Вивести список книг, відсортованих в алфавітному порядку назв і ціною по спадаючій*/
SELECT * FROM `book` ORDER BY name ASC, price DESC; 

/*9. Вивести книги, у яких ціна однієї сторінки < 10 копійок.*/
SELECT * FROM `book` WHERE (price / pages) < 0.10;

/*10. Вивести значення наступних колонок: число символів в назві, перші 20 символів назви великими літерами*/
SELECT LENGTH(name) AS number FROM `book`;
SELECT UPPER(LEFT(name,20)) AS FIRST_20 FROM `book`;

/*11. Вивести значення наступних колонок: перші 10 і останні 10 символів назви прописними буквами, розділені '...'*/
SELECT CONCAT(LEFT(name, 10), '...', RIGHT(name, 10))  FROM `book`; 

/*12. Вивести значення наступних колонок: назва, дата, день, місяць, рік*/
SELECT name, datee, DAY(datee) AS daydate, MONTH(datee) AS monthdate, YEAR(datee) AS yeardate FROM `book`; 

/*13. Вивести значення наступних колонок: назва, дата, дата в форматі 'dd / mm / yyyy'*/
SELECT name, datee, CONCAT(DAY(datee),'/',MONTH(datee),'/',YEAR(datee)) AS DATE FROM `book`;

/*14. Вивести значення наступних колонок: код, ціна, ціна в грн., ціна в євро, ціна в руб*/
SELECT cod, price, price*29.51 AS UAН, price*0.91 AS EUR, price*105.10 as RUB FROM `book`;

/*15. Вивести значення наступних колонок: код, ціна, ціна в грн. без копійок, ціна без копійок округлена*/
SELECT cod, price, price * 29.51 AS UAН, TRUNCATE(price*29.51,0) AS UAН1, ROUND(price*29.51,0) AS UAН2 FROM `book`; 

/*16. Додати інформацію про нову книгу (всі колонки)*/
INSERT INTO book(number, cod, new, name, price, publisher, pages, format, datee, circulation, topic, category)
VALUES(122, 599, 1, 'Аналітика мережевих структур. Моделювання засобами WinQSB та MSExcel', 8.17, 'Ліра-К', 208, '60x84/16', '2018-03-20', 5000, 'Використання ПК в цілому', 'Інші операційні системи');

/*17. Додати інформацію про нову книгу (колонки обов'язкові для введення)*/
INSERT INTO book(number, cod, name, price, publisher, pages, format, datee, circulation, topic, category)
VALUES(244,2666,'Tools and Weapons',17.69,'Hodder',464,'130x200/16','2021-05-09',400,'IT технології', 'Інші книги');

/*18. Видалити книги, видані до 1990 року*/
DELETE FROM book WHERE YEAR(datee) < 1990; 

/*19. Проставити поточну дату для тих книг, у яких дата видання відсутня*/
UPDATE book SET datee = CURRENT_DATE WHERE datee is NULL;

/*20. Установити ознаку новинка для книг виданих після 2005 року*/
UPDATE book SET new = 1 WHERE YEAR(datee) > 2005;
