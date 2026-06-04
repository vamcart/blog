SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,   
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1,	'Категория 1',	'Описание категории 1'),
(2,	'Категория 2',	'Описание категории 2');

DROP TABLE IF EXISTS `blogs`;
CREATE TABLE `blogs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `description` text NOT NULL,
  `image` varchar(255) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'Ожидает проверки',
  `edited` int(2) NOT NULL DEFAULT '0',
  `viewed` int(11) NOT NULL DEFAULT '0',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,   
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `blogs` (`id`, `name`, `text`, `description`, `image`, `status`, `edited`, `viewed`) VALUES
(1,	'Статья 1',	'Текст статьи 1',	'Описание статьи 1',	'https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo-shadow.png',	'Активный',	0, 0),
(2,	'Статья 2',	'Текст статьи 2',	'Описание статьи 2',	'https://getbootstrap.com/docs/5.3/assets/brand/bootstrap-logo-shadow.png',	'Неактивный',	1, 0);

DROP TABLE IF EXISTS `blogs_to_categories`;
CREATE TABLE `blogs_to_categories` (
  `blog_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  PRIMARY KEY (`blog_id`, `category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `blogs_to_categories` (`blog_id`, `category_id`) VALUES
(1, 1),
(2, 2);
