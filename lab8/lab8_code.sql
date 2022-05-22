/*Реалізувати набір тригерів, що реалізують такі ділові правила:*/
/*1. Кількість тем може бути в діапазоні від 5 до 10*/
DELIMITER $$
CREATE TRIGGER trig1 BEFORE INSERT ON topic
FOR EACH ROW
    IF (SELECT COUNT(*) FROM topic) > 10
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість більша 10';
    ELSEIF (select count(*) from topic) < 5
    THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Кількість менша за 5';
END IF;
$$ DELIMITER ;


/*2. Новинкою може бути тільки книга видана в поточному році.*/
DELIMITER $$
CREATE TRIGGER trig2 BEFORE INSERT ON book
FOR EACH ROW
IF (book.book_new && YEAR(book.book_dateee) != YEAR(NOW()))
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Новинкою може бути лише книга видана в поточному році';
END IF;
$$ DELIMITER ;


/*3. Книга з кількістю сторінок до 100 не може коштувати більше 10 $, до 200 - 20 $, до 300 - 30 $.*/
DELIMITER $$
CREATE TRIGGER trig3 BEFORE INSERT ON book
FOR EACH ROW
IF (
    (book.book_price > 10 AND book.book_pages < 100) OR
    (book.book_price > 20 AND book.book_pages < 200) OR
    (book.book_price > 30 AND book.book_pages < 300))
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Несумісна ціна та кількість сторінок';
END IF;
$$ DELIMITER ;


/*4. Видавництво "BHV" не випускає книги накладом меншим 5000, а видавництво Diasoft - 10000*/
DELIMITER $$
CREATE TRIGGER trig4 BEFORE INSERT ON book
FOR EACH ROW IF (
    (book.book_id_publisher = 1 AND book.book_circulation < 5000) OR
    (book.book_id_publisher = 5 AND book.book_circulation < 1000))
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Занадто мале значення circulation для вказаного видавництва';
END IF;
$$ DELIMITER ;


/*5. Книги з однаковим кодом повинні мати однакові дані.*/
DELIMITER $$
CREATE TRIGGER trig5 BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    SET @recordsCount = 0;
    SELECT COUNT(*) INTO @recordsCount
    FROM book
    WHERE code = NEW.code AND (
        -- number != NEW.number OR
        is_new != book.book_new OR
        book_name != book.book_name OR
        price != book.book_price OR
        publisher_id != book.book_id_publisher OR
        pages_count != book.book_pages_count OR
        format != book.book_format OR
        datee != book.book_dateee OR
        circulation != book.book_circulation OR
        theme != book.book_id_topic OR
        category != book.book_id_category);

    IF (@recordsCount != 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Книги з однаоквим кодом мають мати однакові дані';
    END IF;
END $$ DELIMITER ;


/*6. При спробі видалення книги видається інформація про кількість видалених рядків. Якщо користувач не "dbo", то видалення забороняється.*/
DELIMITER $$
CREATE TRIGGER trig6 BEFORE DELETE ON book
FOR EACH ROW
BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^\@]+') != 'root') THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Лише користувачу dbo дозволено видаляти книги';
    ELSE
        SET @columnsCount = 0;
        SELECT count(*) INTO @columnsCount FROM information_schema.`COLUMNS`
        WHERE table_name = 'book' AND TABLE_SCHEMA = "labs";
    END IF;
END $$ DELIMITER ;


/*7. Користувач "dbo" не має права змінювати ціну книги.*/
DELIMITER $$
CREATE TRIGGER trig7 BEFORE UPdatee ON book
FOR EACH ROW
BEGIN
    IF (REGEXP_SUBSTR(TRIM(CURRENT_USER()), '^[^\@]+') = 'root' AND book.book_price != book.book_price) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Користувач не має права змінювати ціну книги';
    END IF;
END $$ DELIMITER ;


/*8. Видавництва ДМК і Еком підручники не видають.*/
DELIMITER $$
CREATE TRIGGER trig8 BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF ((book.id_publisher IN (5, 7)) AND book.book_id_category = 1) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказані видавництва не видають підручники';
    END IF;
END $$ DELIMITER ;


/*9. Видавництво не може випустити більше 10 новинок протягом одного місяця поточного року*/
DELIMITER $$
CREATE TRIGGER trig9 BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    SET @publisher_novelties_count = 0;
    SELECT COUNT(*) INTO @publisher_novelties_count
    FROM book
    WHERE book.book_id_publisher = book.book_id_publisher AND book.book_new AND YEAR(NOW()) = YEAR(bookbook_.dateee) AND MONTH(NOW()) = MONTH(book.book_dateee);
    IF (book.new AND @publisher_novelties_count IS NOT NULL AND @publisher_novelties_count > 10) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Видавництво не може видати більше 10 новинок за місяць';
    END IF;
END $$ DELIMITER ;


/*10. Видавництво BHV не випускає книги формату 60х88 / 16.*/
DELIMITER $$
CREATE TRIGGER trig10 BEFORE INSERT ON book
FOR EACH ROW
BEGIN
    IF (book.book_id_publisher = 1 AND book.book_format = 3) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Вказане видавництво не видає кнниги в даному форматі';
    END IF;
END $$ DELIMITER ;