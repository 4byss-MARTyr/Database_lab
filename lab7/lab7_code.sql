/*1.Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат.*/
DELIMITER //
CREATE PROCEDURE GetBookData()
BEGIN
    SELECT book.name, price, publisher.name AS publisher_name, format
    FROM book
    JOIN publisher ON book.id_publisher = publisher.id;
END // DELIMITER ;
CALL GetBookData()


/*2. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям*/
DELIMITER //
CREATE PROCEDURE GetBookData2()
BEGIN
    SELECT topic.name topic_name, category.name AS category_name, book.name AS book_name, publisher.name AS publisher_name
    FROM book
    JOIN publisher ON book.id_publisher = publisher.id
    JOIN topic ON book.id_topic = topic.id
    JOIN category ON book.id_category = category.id;
END // DELIMITER ;
CALL GetBookData2()


/*3. Вивести книги видавництва 'BHV', видані після 2000 р*/
DELIMITER //
CREATE PROCEDURE GetBookData3(pub_id INT, year_num INT)
BEGIN
    SELECT * FROM book
    WHERE book.id_publisher = pub_id AND YEAR(datee) > year_num;
END // DELIMITER ;
CALL GetBookData3(1, 2000);


/*4. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій / зростанню кількості сторінок.*/
DELIMITER //
CREATE PROCEDURE GetBookData4()
BEGIN
    SELECT category.name AS category_name, 
    SUM(pages) AS pages_count
    FROM book
    JOIN category ON category.id_category = category_id
    GROUP BY category
    ORDER BY pages_count ;
END // DELIMITER ;
CALL GetBookData4;


/*5. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'*/
DELIMITER //
CREATE PROCEDURE GetBookData5(topic_id INT, category_id INT, OUT COUNT INT)
BEGIN
    SELECT AVG(price) INTO COUNT
	FROM book
	WHERE book.id_topic = topic_id AND book.id_category = category_id ;
END // DELIMITER ;
CALL GetBookData5(1, 6, @count);
SELECT @count AS avgCount;


/*6. Вивести всі дані універсального відношення.*/
DELIMITER //
CREATE PROCEDURE GetBookData6()
BEGIN SELECT
	book.*, publisher.name AS publisher_name, category.name AS category_name, topic.name AS topic_name
    FROM book
    LEFT JOIN publisher ON book.id_publisher = publisher.id
    LEFT JOIN topic ON book.id_topic = topic.id
    LEFT JOIN category ON book.id_category = category.id;
END // DELIMITER ;
CALL GetBookData6;


/*7. Вивести пари книг, що мають однакову кількість сторінок.*/
DELIMITER //
CREATE PROCEDURE GetBookData7()
BEGIN
    SELECT DISTINCT b.name AS 1_book_name, b2.name 2_book_name
    FROM book b
    JOIN book b2 ON b.pages = b2.pages AND b.N != b2.N ;
END // DELIMITER ;
CALL GetBookData7;


/*8. Вивести тріади книг, що мають однакову ціну.*/
DELIMITER //
CREATE PROCEDURE GetBookData8()
BEGIN
    SELECT DISTINCT
    b.name AS 1_book_name, b2.name 2_book_name, b3.name 3_book_name
    FROM book b
    JOIN book b2 ON b.price = b2.price AND b.n != b2.n
    JOIN book b3 ON b.price = b3.price AND b.n != b3.n ;
END // DELIMITER ;
CALL GetBookData8;


/*9. Вивести всі книги категорії 'C ++'*/
DELIMITER //
CREATE PROCEDURE GetBookData9(category_name VARCHAR(255))
BEGIN
    SELECT * FROM book
    WHERE category = (SELECT id FROM category WHERE category.name = category_name) ;
END // DELIMITER ;
CALL GetBookData9('C&C++');


/*10. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок.*/
DELIMITER //
CREATE PROCEDURE GetBookData10(min_pages_count INT)
BEGIN
    SELECT  * FROM publishing
    WHERE ( SELECT MIN(pages) FROM book WHERE book.id_publisher = publisher.id) > min_pages_count ;
END // DELIMITER ;
CALL GetBookData10(400);


/*11. Вивести список категорій за якими більше 3-х книг.*/
DELIMITER //
CREATE PROCEDURE GetBookData11(min_books_count INT)
BEGIN
    SELECT * FROM category
    WHERE ( SELECT COUNT(*) FROM books WHERE book.id_category = category.id) > min_books_count ;
END // DELIMITER ;
CALL GetBookData11(3);


/*12. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва.*/
DELIMITER //
CREATE PROCEDURE GetBookData12(publisher_name VARCHAR(255))
BEGIN
    SELECT * FROM books
    WHERE EXISTS (SELECT * FROM publisher WHERE publisher.name = publisher_name AND book.id_publisher = publisher.id) ;
END // DELIMITER ;
CALL GetBookData12('BHV');


/*13. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва.*/
DELIMITER //
CREATE PROCEDURE GetBookData13(publisher_name VARCHAR(255))
BEGIN
    SELECT * FROM book
    WHERE NOT EXISTS (SELECT * FROM publisher WHERE publisher.name = publisher_name AND book.id_publisher = publisher.id ) AND id_publisher =(SELECT publisher.id FROM publisher WHERE publisher.name = publisher_name) ;
END // DELIMITER ;
CALL GetBookData13('BHV');


/*14. Вивести відсортоване загальний список назв тем і категорій.*/
DELIMITER //
CREATE PROCEDURE GetBookData14()
BEGIN (
        (SELECT * FROM topic )
    UNION
        ( SELECT * FROM category )
       )
    ORDER BY NAME;
END // DELIMITER ;
CALL GetBookData14();


/*15. Вивести відсортований в зворотному порядку загальний список перших слів назв книг і категорій що не повторюються*/
DELIMITER //
CREATE PROCEDURE GetBookData15()
BEGIN
    SELECT DISTINCT NAME FROM (
        (SELECT REGEXP_SUBSTR(TRIM(NAME), '^[^\\s]+') AS NAME FROM book)
	UNION ALL 
        (SELECT REGEXP_SUBSTR(TRIM(NAME), '^[^\\s]+') AS NAME FROM category)) NAMES
	ORDER BY NAME DESC ;
END // DELIMITER ;
CALL GetBookData15();