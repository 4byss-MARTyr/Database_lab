/*1. Вивести значення наступних колонок: назва книги, ціна, назва видавництва. Використовувати внутрішнє з'єднання, застосовуючи where.*/
SELECT
    book.name,
    book.price,
    publisher.name AS publisher_name
FROM
    book,
    publisher
WHERE
    book.id_publisher = publisher.id;


/*2. Вивести значення наступних колонок: назва книги, назва категорії. Використовувати внутрішнє з'єднання, застосовуючи inner join.*/
SELECT
    book.name,
    publisher.name AS publisher_name
FROM book
INNER JOIN publisher ON book.id_publisher = publisher.id;


/*3. Вивести значення наступних колонок: назва книги, ціна, назва видавництва, формат*/
SELECT
    book.name,
    book.price,
    publisher.name AS publisher_name,
    book.format AS FORMAT
FROM
    book
JOIN publisher ON book.id_publisher = publisher.id;


/*4. Вивести значення наступних колонок: тема, категорія, назва книги, назва видавництва. Фільтр по темам і категоріям.*/
SELECT
    book.name,
    publisher.name AS publisher_name,
    topic.name AS theme,
    category.name AS category
FROM
    book
JOIN publisher ON book.id_publisher = publisher.id
JOIN topic ON book.id_topic = topic.id
JOIN category ON book.id_category = category.id
ORDER BY
    book.id_topic ASC,
    category.name ASC;


/*5. Вивести книги видавництва 'BHV', видані після 2000 р*/
SELECT * FROM book
WHERE id_publisher = 1 AND YEAR(datee) > 2000;


/*6. Вивести загальну кількість сторінок по кожній назві категорії. Фільтр по спадаючій кількості сторінок.*/
SELECT
    category.name AS category,
    SUM(pages) AS pages_count
FROM book
JOIN category ON book.id_category = category.id
GROUP BY category
ORDER BY pages_count DESC;


/*7. Вивести середню вартість книг по темі 'Використання ПК' і категорії 'Linux'.*/
SELECT AVG(price)
FROM book
WHERE book.id_topic = 1 AND book.id_category = 4;


/*8. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи where.*/
SELECT
    book.*,
    publisher.name AS publisher_name,
    category.name AS book_category,
    topic.name AS book_topic
FROM
    book,
    publisher,
    category,
    topic
WHERE
    book.id_publisher = publisher.id AND book.id_category = category.id AND book.id_topic = topic.id;


/*9. Вивести всі дані універсального відношення. Використовувати внутрішнє з'єднання, застосовуючи inner join.*/
SELECT
    book.*,
    publisher.name AS publisher_name,
    category.name AS book_category,
    topic.name AS book_topic
FROM book
INNER JOIN publisher ON book.id_publisher = publisher.id
INNER JOIN category ON book.id_category = category.id
INNER JOIN topic ON book.id_topic = category.id;


/*10. Вивести всі дані універсального відношення. Використовувати зовнішнє з'єднання, застосовуючи left join / rigth join.*/
SELECT
    book.*,
    publisher.name AS publisher_name,
    category.name AS book_category,
    topic.name AS book_topic
FROM book
LEFT JOIN publisher ON book.id_publisher = publisher.id
LEFT JOIN category ON book.id_category = category.id
LEFT JOIN topic ON book.id_topic = category.id;
SELECT
    book.*,
    publisher.name AS publisher_name,
    category.name AS book_category,
    topic.name AS book_topic
FROM book
RIGHT JOIN publisher ON book.id_publisher = publisher.id
RIGHT JOIN category ON book.id_category = category.id
RIGHT JOIN topic ON book.id_topic = category.id;


/*11. Вивести пари книг, що мають однакову кількість сторінок. Використовувати само об’єднання і аліаси (self join).*/
SELECT A.name AS name1, B.name AS name2, A.pages
FROM book A, book B
WHERE A.N <> B.N
AND A.pages = B.pages
ORDER BY A.pages;


/*12. Вивести тріади книг, що мають однакову ціну. Використовувати самооб'єднання і аліаси (self join).*/
SELECT A.name AS name1, B.name AS name2, C.name AS name3, A.price
FROM book A, book B, book C
WHERE A.N <> B.N <> C.N
AND A.price = B.price = C.price
ORDER BY A.price;


/*13. Вивести всі книги категорії 'C ++'. Використовувати підзапити (subquery).*/
SELECT *
FROM book
WHERE id_category =(SELECT id FROM category WHERE category.name = 'C&C++');


/*14. Вивести книги видавництва 'BHV', видані після 2000 р Використовувати підзапити (subquery).*/
SELECT *
FROM book
WHERE id_category =(SELECT id FROM category WHERE category.name = 'BHV') AND YEAR(datee) > 2000;


/*15. Вивести список видавництв, у яких розмір книг перевищує 400 сторінок. Використовувати пов'язані підзапити (correlated subquery).*/
SELECT *
FROM publisher
WHERE (SELECT MIN(pages) FROM book WHERE books.id_publisher = publisher.id) >= 400;


/*16. Вивести список категорій в яких більше 3-х книг. Використовувати пов'язані підзапити (correlated subquery).*/
SELECT *
FROM category
WHERE(SELECT COUNT(*) FROM book WHERE book.id_category = category.id) > 3


/*17. Вивести список книг видавництва 'BHV', якщо в списку є хоча б одна книга цього видавництва. Використовувати exists*/
SELECT *
FROM book
WHERE EXISTS(SELECT * FROM publisher WHERE publisher.name = 'BHV' AND books.id_publisher = publisher.id);


/*18. Вивести список книг видавництва 'BHV', якщо в списку немає жодної книги цього видавництва. Використовувати not exists.*/
SELECT *
FROM book
WHERE NOT EXISTS
    (SELECT * FROM publisher WHERE publisher.name = 'BHVг' AND books.id_publisher = publisher.id) 
    AND id_publisher =(SELECT publisher.id FROM publisher WHERE publisher.name = 'BHV');


/*19. Вивести відсортований загальний список назв тем і категорій. Використовувати union.*/
SELECT * FROM topic 
UNION SELECT *
FROM category ORDER BY NAME;
