-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Время создания: Апр 08 2022 г., 16:33
-- Версия сервера: 8.0.24
-- Версия PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `bd`
--

-- --------------------------------------------------------

--
-- Структура таблицы `library_database_table`
--

CREATE TABLE `library_database_table` (
  `number` int NOT NULL,
  `code` int NOT NULL,
  `novelty` enum('Yes','No') DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `prise` float(5,2) DEFAULT '0.00',
  `publisher` varchar(30) NOT NULL,
  `pages` int NOT NULL,
  `format` varchar(30) DEFAULT 'Невідомо',
  `date` date DEFAULT NULL,
  `circulation` int NOT NULL,
  `topic` varchar(100) NOT NULL,
  `category` varchar(30) NOT NULL
) ;

--
-- Дамп данных таблицы `library_database_table`
--

INSERT INTO `library_database_table` (`number`, `code`, `novelty`, `name`, `prise`, `publisher`, `pages`, `format`, `date`, `circulation`, `topic`, `category`) VALUES
(203, 44, 'No', 'Відповіді на актуальні запитання щодо OS/2 Warp', 5.00, 'DiaSoft', 352, '60x84/16', '1996-03-20', 5000, 'Операційні системи', 'Інші операційні системи'),
(222, 235, 'No', 'Інформаційні системи і структури даних', 0.00, 'Києво-Могилянська академія', 288, '60x90/16', NULL, 400, 'Використання ПК в цілому', 'Інші книги'),
(191, 860, 'No', 'Операційна система UNIX', 3.50, 'Видавнича група BHV', 395, '84x100/16', '1997-05-05', 5000, 'Операційні системи', 'UNIX'),
(226, 2154, 'Yes', 'Сервер на основі операційної системи FreeBSD 6.1', 0.00, 'Університет \"Україна\"', 216, '60x84/16', '2015-11-03', 500, 'Програмування', 'Інші операційні системи'),
(245, 2662, 'No', 'Організація баз даних та знань', 0.00, 'Вінниця:ВДПУ', 208, '60x90/16', '2001-10-10', 1000, 'Програмування', 'SQL'),
(50, 3851, 'No', 'Захист інформації, та безбека комп\'ютених систем', 26.00, 'DiaSoft', 480, '84x108/16', NULL, 5000, 'Використання ПК в цілому', 'Захист і безпека ПК'),
(58, 3932, 'No', 'Як перетворити перс\r\nональний комп\'ютер на вимірювальний комплекс', 7.65, 'ДМК', 144, '60x88/16', '1999-09-26', 5000, 'Використання ПК в цілому', 'Інші книги'),
(220, 4687, 'No', 'Ефективне використання C++ .50 рекомендацій щодо покращення ваших програм та проектів', 17.60, 'ДМК', 240, '70x100/16', '2000-02-03', 5000, 'Програмування', 'C&C++'),
(59, 4713, 'No', 'Plug-ins. Додаткові програми для музичних програм', 11.41, 'ДМК', 144, '70x100/16', '2000-02-22', 5000, 'Використання ПК в цілому', 'Інші книги'),
(176, 4829, 'No', 'Windows 2000 Proffesional крок за кроком з CD', 27.25, 'Эком', 320, '70x100/16', '2000-04-28', 5000, 'Операційні системи', 'Windows 2000'),
(210, 4982, 'No', 'Мова програмування С. Лекції та вправи', 29.00, 'DiaSoft', 656, '84x108/16', '2000-07-12', 5000, 'Програмування', 'C&C++'),
(8, 4985, 'No', 'Засвой самостійно модернізацію та ремонт ПК за 24 години, 2-ге вид', 18.90, 'Вільямс', 288, '70x100/16', '2000-07-07', 5000, 'Використання ПК в цілому', 'Підручники'),
(2, 5110, 'No', 'Апаратні засоби мультимедіа. Відеосистема РС', 15.51, 'Видавнича група BHV', 400, '70x100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Підручники'),
(31, 5111, 'No', 'Апаратні засоби мультимедіа. Відеосисема PC', 15.51, 'Видавнича група BHV', 400, '70x100/16', '2000-07-24', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
(20, 5127, 'No', 'Автоматизація інженерно-графічних робіт', 11.58, 'Видавнича група BHV', 256, '70x100/16', '2000-06-15', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
(9, 5141, 'No', 'Структури даних та алгоритми', 37.80, 'Вільямс', 384, '70x100/16', '2000-09-29', 5000, 'Використання ПК в цілому', 'Підручники'),
(188, 5170, 'No', 'Linux версії', 24.43, 'ДМК', 346, '70x100/16', '2000-09-29', 5000, 'Операційні системи', 'Linux'),
(206, 5176, 'No', 'Windows ME. Супутник користувача', 12.76, 'Видавнича група BHV', 306, 'Невідомо', '2000-10-10', 5000, 'Операційні системи', 'Інші операційні системи'),
(46, 5199, 'No', 'Залізо IMB 2001', 30.07, 'МикроАрт', 368, '70x100/16', '2000-02-12', 5000, 'Використання ПК в цілому', 'Апаратні засоби ПК'),
(175, 5217, 'No', 'Windows ME. Найновіші версії програм', 16.57, 'Триумф', 320, '70x100/16', '2000-08-25', 5000, 'Операційні системи', 'Windows 2000'),
(209, 5462, 'No', 'Мова програмування С++. Лекції та вправи', 29.00, 'DiaSoft', 656, '84x108/16', '2000-12-12', 5000, 'Програмування', 'C&C++'),
(247, 5641, 'Yes', 'Організація баз даних та знань', 0.00, 'Видавнича група BHV', 384, '70x100/16', '2018-07-25', 5000, 'Програмування', 'SQL'),
(225, 8746, 'Yes', 'Бази даних в інформаційних системах', 0.00, 'Університет \"Україна\"', 418, '60x84/16', '2018-07-25', 100, 'Програмування', 'SQL');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `library_database_table`
--
ALTER TABLE `library_database_table`
  ADD PRIMARY KEY (`code`),
  ADD KEY `number` (`number`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
