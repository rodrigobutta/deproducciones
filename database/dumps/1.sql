-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.14 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5174
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for table deproducciones.activities
CREATE TABLE IF NOT EXISTS `activities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` int(10) unsigned NOT NULL,
  `subject_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_agent` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `country` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `activities_subject_id_index` (`subject_id`),
  KEY `activities_subject_type_index` (`subject_type`),
  KEY `activities_user_id_index` (`user_id`),
  KEY `activities_user_agent_index` (`user_agent`),
  KEY `activities_country_index` (`country`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.activities: 8 rows
/*!40000 ALTER TABLE `activities` DISABLE KEYS */;
INSERT INTO `activities` (`id`, `subject_id`, `subject_type`, `name`, `user_id`, `ip_address`, `user_agent`, `created_at`, `updated_at`, `country`) VALUES
	(1, 4, 'App\\Category', 'created_category', 1, '1', '1', '2017-06-28 19:55:31', '2017-06-28 19:55:31', 'argentina'),
	(2, 1, 'App\\Submission', 'created_submission', 1, '1', '1', '2017-06-28 20:39:53', '2017-06-28 20:39:53', 'argentina'),
	(3, 2, 'App\\User', 'created_user', 2, '1', '1', '2017-06-28 21:06:13', '2017-06-28 21:06:13', 'argentina'),
	(4, 2, 'App\\Submission', 'created_submission', 1, '1', '1', '2017-06-29 13:06:08', '2017-06-29 13:06:08', 'argentina'),
	(5, 3, 'App\\User', 'created_user', 3, '1', '1', '2017-06-29 20:04:01', '2017-06-29 20:04:01', 'argentina'),
	(6, 3, 'App\\Submission', 'created_submission', 2, '1', '1', '2017-06-29 21:01:39', '2017-06-29 21:01:39', 'argentina'),
	(7, 4, 'App\\Submission', 'created_submission', 2, '1', '1', '2017-06-30 01:09:22', '2017-06-30 01:09:22', 'argentina'),
	(8, 5, 'App\\Submission', 'created_submission', 1, '1', '1', '2017-06-30 01:37:08', '2017-06-30 01:37:08', 'argentina');
/*!40000 ALTER TABLE `activities` ENABLE KEYS */;

-- Dumping structure for table deproducciones.announcements
CREATE TABLE IF NOT EXISTS `announcements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `active_until` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `announcements_category_name_index` (`category_name`),
  KEY `announcements_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.announcements: 1 rows
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
INSERT INTO `announcements` (`id`, `category_name`, `user_id`, `title`, `body`, `active_until`, `created_at`, `updated_at`) VALUES
	(1, 'home', 1, 'Prueba anuncio n1', 'anuncio 11111 jkalsdjas kldjak sdjaslk djaskld jaslkd jaskld jaskl', '2017-07-02 15:07:10', '2017-06-29 15:07:10', '2017-06-29 15:07:10');
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;

-- Dumping structure for table deproducciones.appointedd_users
CREATE TABLE IF NOT EXISTS `appointedd_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `appointed_as` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `appointedd_users_user_id_index` (`user_id`),
  KEY `appointedd_users_appointed_as_index` (`appointed_as`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.appointedd_users: 1 rows
/*!40000 ALTER TABLE `appointedd_users` DISABLE KEYS */;
INSERT INTO `appointedd_users` (`id`, `user_id`, `appointed_as`, `created_at`, `updated_at`) VALUES
	(1, 1, 'administrator', NULL, NULL);
/*!40000 ALTER TABLE `appointedd_users` ENABLE KEYS */;

-- Dumping structure for table deproducciones.bans
CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `unban_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bans_user_id_index` (`user_id`),
  KEY `bans_category_index` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.bans: 0 rows
/*!40000 ALTER TABLE `bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `bans` ENABLE KEYS */;

-- Dumping structure for table deproducciones.blocked_domains
CREATE TABLE IF NOT EXISTS `blocked_domains` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `domain` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `blocked_domains_domain_index` (`domain`),
  KEY `blocked_domains_category_index` (`category`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.blocked_domains: 0 rows
/*!40000 ALTER TABLE `blocked_domains` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocked_domains` ENABLE KEYS */;

-- Dumping structure for table deproducciones.bookmarks
CREATE TABLE IF NOT EXISTS `bookmarks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `bookmarkable_id` int(10) unsigned NOT NULL,
  `bookmarkable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bookmarks_user_id_bookmarkable_id_bookmarkable_type_unique` (`user_id`,`bookmarkable_id`,`bookmarkable_type`),
  KEY `bookmarks_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.bookmarks: 2 rows
/*!40000 ALTER TABLE `bookmarks` DISABLE KEYS */;
INSERT INTO `bookmarks` (`id`, `user_id`, `bookmarkable_id`, `bookmarkable_type`, `created_at`, `updated_at`) VALUES
	(1, 2, 2, 'App\\Submission', '2017-06-29 21:16:24', '2017-06-29 21:16:24'),
	(2, 2, 4, 'App\\Category', '2017-06-29 21:16:32', '2017-06-29 21:16:32');
/*!40000 ALTER TABLE `bookmarks` ENABLE KEYS */;

-- Dumping structure for table deproducciones.categories
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `nsfw` tinyint(1) NOT NULL DEFAULT '0',
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Dark',
  `avatar` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '/public/imgs/channel-avatar.png',
  `public` tinyint(1) NOT NULL DEFAULT '1',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `subscribers` int(11) NOT NULL DEFAULT '1',
  `settings` json NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categories_name_unique` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.categories: 4 rows
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` (`id`, `name`, `language`, `description`, `nsfw`, `color`, `avatar`, `public`, `active`, `subscribers`, `settings`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 'producciones', 'en', 'texto de prueba de producciones', 0, 'Dark', '/public/imgs/channel-avatar.png', 1, 1, 1, 'null', NULL, '2017-06-28 19:44:16', '2017-06-28 19:44:16'),
	(2, 'canal1', 'en', 'texto de prueba de producciones', 0, 'Dark', '/public/imgs/channel-avatar.png', 1, 1, 2, 'null', NULL, '2017-06-28 19:51:13', '2017-06-28 19:51:13'),
	(3, 'canal2', 'en', 'asd sad sada sda', 0, 'Dark', '/public/imgs/channel-avatar.png', 1, 1, 1, 'null', NULL, '2017-06-28 19:53:09', '2017-06-28 19:53:09'),
	(4, 'canal3', 'en', 'prueba del country', 1, 'Dark', 'http://beta.egoagencydev.com/tmp/categories/avatars/1498680705XqrF2fD.png', 1, 1, 2, 'null', NULL, '2017-06-28 19:55:31', '2017-06-30 01:20:11');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;

-- Dumping structure for table deproducciones.category_forbidden_names
CREATE TABLE IF NOT EXISTS `category_forbidden_names` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.category_forbidden_names: 0 rows
/*!40000 ALTER TABLE `category_forbidden_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `category_forbidden_names` ENABLE KEYS */;

-- Dumping structure for table deproducciones.comments
CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` int(10) unsigned NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `category_id` int(10) unsigned NOT NULL,
  `level` int(11) NOT NULL DEFAULT '0',
  `rate` double(8,2) NOT NULL,
  `upvotes` int(11) NOT NULL DEFAULT '1',
  `downvotes` int(11) NOT NULL DEFAULT '0',
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `comments_submission_id_index` (`submission_id`),
  KEY `comments_user_id_index` (`user_id`),
  KEY `comments_parent_id_index` (`parent_id`),
  KEY `comments_category_id_index` (`category_id`),
  KEY `comments_rate_index` (`rate`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.comments: 0 rows
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;

-- Dumping structure for table deproducciones.comment_downvotes
CREATE TABLE IF NOT EXISTS `comment_downvotes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`comment_id`),
  KEY `comment_downvotes_ip_address_index` (`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.comment_downvotes: 0 rows
/*!40000 ALTER TABLE `comment_downvotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_downvotes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.comment_upvotes
CREATE TABLE IF NOT EXISTS `comment_upvotes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`comment_id`),
  KEY `comment_upvotes_ip_address_index` (`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.comment_upvotes: 0 rows
/*!40000 ALTER TABLE `comment_upvotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_upvotes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.comment_votes
CREATE TABLE IF NOT EXISTS `comment_votes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `comment_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'upvote',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`comment_id`,`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.comment_votes: 0 rows
/*!40000 ALTER TABLE `comment_votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment_votes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.conversations
CREATE TABLE IF NOT EXISTS `conversations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `contact_id` int(10) unsigned NOT NULL,
  `message_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `conversations_user_id_index` (`user_id`),
  KEY `conversations_contact_id_index` (`contact_id`),
  KEY `conversations_message_id_index` (`message_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.conversations: 4 rows
/*!40000 ALTER TABLE `conversations` DISABLE KEYS */;
INSERT INTO `conversations` (`id`, `user_id`, `contact_id`, `message_id`, `created_at`, `updated_at`) VALUES
	(1, 2, 1, 1, '2017-06-28 21:07:26', '2017-06-28 21:07:26'),
	(2, 1, 2, 1, '2017-06-28 21:07:26', '2017-06-28 21:07:26'),
	(3, 1, 2, 2, '2017-06-28 21:09:57', '2017-06-28 21:09:57'),
	(4, 2, 1, 2, '2017-06-28 21:09:57', '2017-06-28 21:09:57');
/*!40000 ALTER TABLE `conversations` ENABLE KEYS */;

-- Dumping structure for table deproducciones.feedbacks
CREATE TABLE IF NOT EXISTS `feedbacks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedbacks_subject_index` (`subject`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.feedbacks: 0 rows
/*!40000 ALTER TABLE `feedbacks` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedbacks` ENABLE KEYS */;

-- Dumping structure for table deproducciones.helps
CREATE TABLE IF NOT EXISTS `helps` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `index` int(11) NOT NULL DEFAULT '1',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.helps: 0 rows
/*!40000 ALTER TABLE `helps` DISABLE KEYS */;
/*!40000 ALTER TABLE `helps` ENABLE KEYS */;

-- Dumping structure for table deproducciones.hidden_users
CREATE TABLE IF NOT EXISTS `hidden_users` (
  `user_id` int(10) unsigned NOT NULL,
  `blocked_user_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`blocked_user_id`),
  KEY `hidden_users_user_id_index` (`user_id`),
  KEY `hidden_users_blocked_user_id_index` (`blocked_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.hidden_users: 0 rows
/*!40000 ALTER TABLE `hidden_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `hidden_users` ENABLE KEYS */;

-- Dumping structure for table deproducciones.hides
CREATE TABLE IF NOT EXISTS `hides` (
  `user_id` int(10) unsigned NOT NULL,
  `submission_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`submission_id`),
  KEY `hides_user_id_index` (`user_id`),
  KEY `hides_submission_id_index` (`submission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.hides: 0 rows
/*!40000 ALTER TABLE `hides` DISABLE KEYS */;
/*!40000 ALTER TABLE `hides` ENABLE KEYS */;

-- Dumping structure for table deproducciones.invites
CREATE TABLE IF NOT EXISTS `invites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `invitation` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sent` tinyint(1) NOT NULL DEFAULT '0',
  `claimed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invites_email_unique` (`email`),
  KEY `invites_invitation_index` (`invitation`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.invites: 0 rows
/*!40000 ALTER TABLE `invites` DISABLE KEYS */;
/*!40000 ALTER TABLE `invites` ENABLE KEYS */;

-- Dumping structure for table deproducciones.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.jobs: 11 rows
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
	(1, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Mail\\\\SendQueuedMailable","command":"O:34:\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\":1:{s:11:\\"\\u0000*\\u0000mailable\\";O:23:\\"App\\\\Mail\\\\WelcomeToVoten\\":17:{s:8:\\"username\\";s:6:\\"rbutta\\";s:4:\\"from\\";a:0:{}s:2:\\"to\\";a:1:{i:0;a:2:{s:4:\\"name\\";N;s:7:\\"address\\";s:16:\\"rbutta@gmail.com\\";}}s:2:\\"cc\\";a:0:{}s:3:\\"bcc\\";a:0:{}s:7:\\"replyTo\\";a:0:{}s:7:\\"subject\\";N;s:11:\\"\\u0000*\\u0000markdown\\";N;s:4:\\"view\\";N;s:8:\\"textView\\";N;s:8:\\"viewData\\";a:0:{}s:11:\\"attachments\\";a:0:{}s:14:\\"rawAttachments\\";a:0:{}s:9:\\"callbacks\\";a:0:{}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}}"}}', 0, NULL, 1498683973, 1498683973),
	(2, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:25:\\"App\\\\Events\\\\MessageCreated\\":4:{s:7:\\"message\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":2:{s:5:\\"class\\";s:11:\\"App\\\\Message\\";s:2:\\"id\\";i:1;}s:10:\\"contact_id\\";i:2;s:7:\\"user_id\\";i:1;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684046, 1498684046),
	(3, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:27:\\"App\\\\Events\\\\ConversationRead\\":3:{s:10:\\"contact_id\\";i:2;s:7:\\"user_id\\";i:1;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684072, 1498684072),
	(4, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:27:\\"App\\\\Events\\\\ConversationRead\\":3:{s:10:\\"contact_id\\";i:1;s:7:\\"user_id\\";N;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684127, 1498684127),
	(5, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:22:\\"App\\\\Events\\\\MessageRead\\":4:{s:10:\\"message_id\\";i:1;s:10:\\"contact_id\\";i:1;s:7:\\"user_id\\";i:2;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684128, 1498684128),
	(6, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:27:\\"App\\\\Events\\\\ConversationRead\\":3:{s:10:\\"contact_id\\";i:1;s:7:\\"user_id\\";i:2;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684194, 1498684194),
	(7, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:25:\\"App\\\\Events\\\\MessageCreated\\":4:{s:7:\\"message\\";O:45:\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\":2:{s:5:\\"class\\";s:11:\\"App\\\\Message\\";s:2:\\"id\\";i:2;}s:10:\\"contact_id\\";i:1;s:7:\\"user_id\\";i:2;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498684197, 1498684197),
	(8, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:27:\\"App\\\\Events\\\\ConversationRead\\":3:{s:10:\\"contact_id\\";i:2;s:7:\\"user_id\\";N;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498685061, 1498685061),
	(9, 'default', '{"job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Broadcasting\\\\BroadcastEvent","command":"O:38:\\"Illuminate\\\\Broadcasting\\\\BroadcastEvent\\":4:{s:8:\\"\\u0000*\\u0000event\\";O:22:\\"App\\\\Events\\\\MessageRead\\":4:{s:10:\\"message_id\\";i:2;s:10:\\"contact_id\\";i:2;s:7:\\"user_id\\";i:1;s:6:\\"socket\\";N;}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}"}}', 0, NULL, 1498685062, 1498685062),
	(10, 'default', '{"displayName":"App\\\\Mail\\\\WelcomeToVoten","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Mail\\\\SendQueuedMailable","command":"O:34:\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\":3:{s:8:\\"mailable\\";O:23:\\"App\\\\Mail\\\\WelcomeToVoten\\":17:{s:8:\\"username\\";s:13:\\"rodrigo.butta\\";s:4:\\"from\\";a:0:{}s:2:\\"to\\";a:1:{i:0;a:2:{s:4:\\"name\\";N;s:7:\\"address\\";s:30:\\"rodrigo.butta@egoargentina.com\\";}}s:2:\\"cc\\";a:0:{}s:3:\\"bcc\\";a:0:{}s:7:\\"replyTo\\";a:0:{}s:7:\\"subject\\";N;s:11:\\"\\u0000*\\u0000markdown\\";N;s:4:\\"view\\";N;s:8:\\"textView\\";N;s:8:\\"viewData\\";a:0:{}s:11:\\"attachments\\";a:0:{}s:14:\\"rawAttachments\\";a:0:{}s:9:\\"callbacks\\";a:0:{}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;}"}}', 0, NULL, 1498766641, 1498766641),
	(11, 'default', '{"displayName":"App\\\\Mail\\\\NewRegistration","job":"Illuminate\\\\Queue\\\\CallQueuedHandler@call","maxTries":null,"timeout":null,"data":{"commandName":"Illuminate\\\\Mail\\\\SendQueuedMailable","command":"O:34:\\"Illuminate\\\\Mail\\\\SendQueuedMailable\\":3:{s:8:\\"mailable\\";O:24:\\"App\\\\Mail\\\\NewRegistration\\":17:{s:8:\\"username\\";s:13:\\"rodrigo.butta\\";s:4:\\"from\\";a:0:{}s:2:\\"to\\";a:1:{i:0;a:2:{s:4:\\"name\\";N;s:7:\\"address\\";s:16:\\"rbutta@gmail.com\\";}}s:2:\\"cc\\";a:0:{}s:3:\\"bcc\\";a:0:{}s:7:\\"replyTo\\";a:0:{}s:7:\\"subject\\";N;s:11:\\"\\u0000*\\u0000markdown\\";N;s:4:\\"view\\";N;s:8:\\"textView\\";N;s:8:\\"viewData\\";a:0:{}s:11:\\"attachments\\";a:0:{}s:14:\\"rawAttachments\\";a:0:{}s:9:\\"callbacks\\";a:0:{}s:10:\\"connection\\";N;s:5:\\"queue\\";N;s:5:\\"delay\\";N;}s:5:\\"tries\\";N;s:7:\\"timeout\\";N;}"}}', 0, NULL, 1498766641, 1498766641);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table deproducciones.messages
CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(10) unsigned NOT NULL,
  `data` json NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `messages_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.messages: 2 rows
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` (`id`, `user_id`, `data`, `read_at`, `created_at`, `updated_at`) VALUES
	(1, 2, '{"text": "mensajito 11111"}', '2017-06-28 21:24:34', '2017-06-28 21:07:26', '2017-06-28 21:24:34'),
	(2, 1, '{"text": "respuesta de admin"}', '2017-06-28 21:24:34', '2017-06-28 21:09:57', '2017-06-28 21:24:34');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;

-- Dumping structure for table deproducciones.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=43 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.migrations: 42 rows
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_000000_create_users_table', 1),
	(2, '2014_10_12_100000_create_password_resets_table', 1),
	(3, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
	(4, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
	(5, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
	(6, '2016_06_01_000004_create_oauth_clients_table', 1),
	(7, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
	(8, '2016_06_12_220459_create_submissions_table', 1),
	(9, '2016_06_12_220510_create_categories_table', 1),
	(10, '2016_06_12_222617_create_comments_table', 1),
	(11, '2016_06_15_204843_create_reports_table', 1),
	(12, '2016_06_15_205217_create_messages_table', 1),
	(13, '2016_06_18_001401_create_rules_table', 1),
	(14, '2016_07_13_151329_create_subscriptions_table', 1),
	(15, '2016_08_14_150643_create_hides_table', 1),
	(16, '2016_08_16_190902_create_votes_table', 1),
	(17, '2016_09_11_072517_create_activities_table', 1),
	(18, '2016_09_27_172157_create_blocked_domains_table', 1),
	(19, '2016_10_03_153000_create_feedbacks_table', 1),
	(20, '2016_10_03_184216_create_comment_votes_table', 1),
	(21, '2016_10_06_140449_create_photos_table', 1),
	(22, '2016_10_09_083746_create_invites_table', 1),
	(23, '2016_10_18_180051_create_bookmarks_table', 1),
	(24, '2016_10_29_102054_create_notifications_table', 1),
	(25, '2016_11_01_120729_create_roles_table', 1),
	(26, '2016_11_05_225236_create_conversations_table', 1),
	(27, '2016_11_11_145602_create_hidden_users_table', 1),
	(28, '2016_12_29_012509_create_jobs_table', 1),
	(29, '2017_01_01_131313_create_bans_table', 1),
	(30, '2017_01_06_155731_create_helps_table', 1),
	(31, '2017_01_07_003759_create_category_forbidden_names_table', 1),
	(32, '2017_01_07_005836_create_user_forbidden_names_table', 1),
	(33, '2017_02_03_131259_create_submission_upvotes_table', 1),
	(34, '2017_02_03_133219_create_submission_downvotes_table', 1),
	(35, '2017_02_09_165425_create_comment_upvotes_table', 1),
	(36, '2017_02_09_165437_create_comment_downvotes_table', 1),
	(37, '2017_02_24_155915_create_suggesteds_table', 1),
	(38, '2017_03_02_141038_create_appointedd_users_table', 1),
	(39, '2017_05_18_134111_passportInstall', 1),
	(40, '2017_06_15_150444_add_country_column_to_activies_table', 1),
	(41, '2017_06_17_190709_create_announcements_table', 1),
	(42, '2017_06_19_082446_create_seen_announcements_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table deproducciones.notifications
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` char(36) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notifiable_id` int(10) unsigned NOT NULL,
  `notifiable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_id_notifiable_type_index` (`notifiable_id`,`notifiable_type`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.notifications: 0 rows
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;

-- Dumping structure for table deproducciones.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.oauth_access_tokens: 0 rows
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table deproducciones.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.oauth_auth_codes: 0 rows
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.oauth_clients: 4 rows
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Voten Personal Access Client', 'MtPpQK25JTxpkF93JqtLbb0v9NC58qmbJcMf0nnq', 'http://localhost', 1, 0, 0, '2017-06-27 23:12:25', '2017-06-27 23:12:25'),
	(2, NULL, 'Voten Password Grant Client', 'Vke3nqKuQ7JT025lV8V9kq8VmeTyx2No63gPEx40', 'http://localhost', 0, 1, 0, '2017-06-27 23:12:25', '2017-06-27 23:12:25'),
	(3, NULL, 'Voten Personal Access Client', 'jxERq8PSk8s9I72O5vMvnXmlvjYf9giP8hVnhn5U', 'http://localhost', 1, 0, 0, '2017-06-28 17:27:59', '2017-06-28 17:27:59'),
	(4, NULL, 'Voten Password Grant Client', 'eb2QeA7NVt07VMOAvflLZadog02aOqzborajXRvB', 'http://localhost', 0, 1, 0, '2017-06-28 17:27:59', '2017-06-28 17:27:59');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table deproducciones.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.oauth_personal_access_clients: 2 rows
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2017-06-27 23:12:25', '2017-06-27 23:12:25'),
	(2, 3, '2017-06-28 17:27:59', '2017-06-28 17:27:59');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table deproducciones.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.oauth_refresh_tokens: 0 rows
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table deproducciones.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL,
  KEY `password_resets_email_index` (`email`),
  KEY `password_resets_token_index` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.password_resets: 0 rows
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Dumping structure for table deproducciones.photos
CREATE TABLE IF NOT EXISTS `photos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` int(10) unsigned DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `thumbnail_path` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `photos_submission_id_index` (`submission_id`),
  KEY `photos_user_id_index` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.photos: 7 rows
/*!40000 ALTER TABLE `photos` DISABLE KEYS */;
INSERT INTO `photos` (`id`, `submission_id`, `user_id`, `path`, `thumbnail_path`, `created_at`, `updated_at`) VALUES
	(1, 3, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498770042xbUaTVN.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498770057khGp3rp.jpg', '2017-06-29 21:01:14', '2017-06-29 21:01:14'),
	(2, 3, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498770052hHI7h3r.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/14987700622T0TA8N.jpg', '2017-06-29 21:01:19', '2017-06-29 21:01:19'),
	(3, 4, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498784908YRoCxBs.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/14987849177jsxZce.jpg', '2017-06-30 01:08:45', '2017-06-30 01:08:45'),
	(4, 4, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498784909hjI6q3X.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498784918cI2jU9A.jpg', '2017-06-30 01:08:47', '2017-06-30 01:08:47'),
	(5, 4, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498784925aglWKzV.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498784934oMrnQjl.jpg', '2017-06-30 01:09:02', '2017-06-30 01:09:02'),
	(6, 4, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498784927IxiJLIs.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498784936bSDMBoc.jpg', '2017-06-30 01:09:03', '2017-06-30 01:09:03'),
	(7, 4, 2, 'http://beta.egoagencydev.com/tmp/submissions/img/1498784942lomeLW3.jpg', 'http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498784951Nc0pUHZ.jpg', '2017-06-30 01:09:19', '2017-06-30 01:09:19');
/*!40000 ALTER TABLE `photos` ENABLE KEYS */;

-- Dumping structure for table deproducciones.professions
CREATE TABLE IF NOT EXISTS `professions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` json NOT NULL,
  `resubmit_id` int(10) unsigned DEFAULT NULL,
  `nsfw` tinyint(1) NOT NULL DEFAULT '0',
  `approved_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `submissions_resubmit_id_index` (`resubmit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Dumping data for table deproducciones.professions: 5 rows
/*!40000 ALTER TABLE `professions` DISABLE KEYS */;
INSERT INTO `professions` (`id`, `slug`, `title`, `type`, `data`, `resubmit_id`, `nsfw`, `approved_at`, `deleted_at`, `created_at`, `updated_at`) VALUES
	(1, 'fotografo', 'Forografo', '1', '{}', NULL, 0, NULL, NULL, NULL, NULL),
	(2, 'modelo', 'Modelo', '1', '{}', NULL, 0, NULL, NULL, NULL, NULL),
	(3, 'maquillador', 'Maquillador', '1', '{}', NULL, 0, NULL, NULL, NULL, NULL),
	(4, 'peinador', 'Peinador', '1', '{}', NULL, 0, NULL, NULL, NULL, NULL),
	(5, 'vestuarista', 'Vestuarista', '1', '{}', NULL, 0, NULL, NULL, NULL, NULL);
/*!40000 ALTER TABLE `professions` ENABLE KEYS */;

-- Dumping structure for table deproducciones.reports
CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned DEFAULT NULL,
  `reportable_id` int(10) unsigned NOT NULL,
  `reportable_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reports_category_id_index` (`category_id`),
  KEY `reports_reportable_id_index` (`reportable_id`),
  KEY `reports_reportable_type_index` (`reportable_type`),
  KEY `reports_subject_index` (`subject`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.reports: 0 rows
/*!40000 ALTER TABLE `reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `reports` ENABLE KEYS */;

-- Dumping structure for table deproducciones.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `user_id` int(10) unsigned NOT NULL,
  `role` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`role`,`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.roles: 1 rows
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`user_id`, `role`, `category_id`) VALUES
	(1, 'administrator', 4);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table deproducciones.rules
CREATE TABLE IF NOT EXISTS `rules` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` text COLLATE utf8_unicode_ci NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rules_category_id_index` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.rules: 0 rows
/*!40000 ALTER TABLE `rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `rules` ENABLE KEYS */;

-- Dumping structure for table deproducciones.seen_announcements
CREATE TABLE IF NOT EXISTS `seen_announcements` (
  `user_id` int(10) unsigned NOT NULL,
  `announcement_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`announcement_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.seen_announcements: 1 rows
/*!40000 ALTER TABLE `seen_announcements` DISABLE KEYS */;
INSERT INTO `seen_announcements` (`user_id`, `announcement_id`) VALUES
	(2, 1);
/*!40000 ALTER TABLE `seen_announcements` ENABLE KEYS */;

-- Dumping structure for table deproducciones.submissions
CREATE TABLE IF NOT EXISTS `submissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` json NOT NULL,
  `category_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `resubmit_id` int(10) unsigned DEFAULT NULL,
  `nsfw` tinyint(1) NOT NULL DEFAULT '0',
  `approved_at` timestamp NULL DEFAULT NULL,
  `user_id` int(10) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `rate` double(8,2) NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `upvotes` int(11) NOT NULL DEFAULT '1',
  `downvotes` int(11) NOT NULL DEFAULT '0',
  `comments_number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `submissions_resubmit_id_index` (`resubmit_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.submissions: 5 rows
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
INSERT INTO `submissions` (`id`, `slug`, `title`, `type`, `data`, `category_name`, `resubmit_id`, `nsfw`, `approved_at`, `user_id`, `deleted_at`, `created_at`, `updated_at`, `rate`, `category_id`, `upvotes`, `downvotes`, `comments_number`) VALUES
	(1, 'post-en-canal-1', 'post en canal 1', 'link', '{"img": null, "url": "http://amex.localhost.com/gastronomia/pani", "type": "link", "embed": null, "title": "post en canal 1", "domain": "amex.localhost.com", "thumbnail": null, "description": null, "providerName": null, "publishedTime": null}', '', NULL, 0, NULL, 1, NULL, '2017-06-28 20:39:53', '2017-06-28 20:39:53', 1.00, 2, 1, 0, 0),
	(2, 'segundo-post-en-canal-1', 'segundo post en canal 1', 'link', '{"img": "https://cdn.voten.co/submissions/link/14987415675UDtU4N.jpg", "url": "http://www.rodrigobutta.com", "type": "link", "embed": null, "title": "Rodrigo Butta - Rodrigo Butta", "domain": "rodrigobutta.com", "thumbnail": "https://cdn.voten.co/submissions/link/thumbs/14987415685KRLMbx.jpg", "description": "descfipcion de la pagina lasldslaldlasldslslasla", "providerName": "rodrigobutta", "publishedTime": null}', '', NULL, 0, NULL, 1, NULL, '2017-06-29 13:06:08', '2017-06-29 13:06:08', 1.00, 2, 1, 0, 0),
	(3, 'prueba-de-post-con-fotos', 'prueba de post con fotos', 'img', '{"path": "http://beta.egoagencydev.com/tmp/submissions/img/1498770042xbUaTVN.jpg", "album": true, "thumbnail_path": "http://beta.egoagencydev.com/tmp/submissions/img/thumbs/1498770057khGp3rp.jpg"}', '', NULL, 0, NULL, 2, NULL, '2017-06-29 21:01:39', '2017-06-29 21:01:39', 1.00, 4, 1, 0, 0),
	(4, 'prueba-de-galeria-de-fotos', 'Prueba de galería de fotos', 'img', '{"path": "http://beta.egoagencydev.com/tmp/submissions/img/1498784908YRoCxBs.jpg", "album": true, "thumbnail_path": "http://beta.egoagencydev.com/tmp/submissions/img/thumbs/14987849177jsxZce.jpg"}', '', NULL, 1, NULL, 2, NULL, '2017-06-30 01:09:22', '2017-06-30 01:10:37', 1.00, 2, 1, 0, 0),
	(5, 'prueba-post-de-texto', 'prueba post de texto', 'text', '{"text": "**Contributing**\\n\\nThank you for considering contributing to the Voten. To encourage active collaboration, Voten strongly encourages pull requests, not just bug reports. If you have an idea(and not the code for it) you may contact us either with the info@voten.co email address or submit it to /c/votendev channel.\\n\\n**Coding Style**\\n\\nVoten follows the PSR-2 coding standard and the PSR-4 autoloading standard. Voten also uses StyleCI for automatically merging any style fixes. So you don\'t have to worry about your code style much.\\n\\nSoftware Stack\\n\\nVoten is a Laravel application that runs on the following software:\\n\\n-Ubuntu 16.04.2 LTS\\n-Nginx 1.10+\\n-MySQL 5.7+ (to use mariaDB, you must modify json type migration columns to blob)\\n-PHP 7.1+\\n-Redis 3.0+\\n-Git 2.8.4+"}', '', NULL, 0, NULL, 1, NULL, '2017-06-30 01:37:08', '2017-06-30 01:37:08', 1.00, 2, 1, 0, 0);
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;

-- Dumping structure for table deproducciones.submission_downvotes
CREATE TABLE IF NOT EXISTS `submission_downvotes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `submission_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`submission_id`),
  KEY `submission_downvotes_ip_address_index` (`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.submission_downvotes: 0 rows
/*!40000 ALTER TABLE `submission_downvotes` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_downvotes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.submission_upvotes
CREATE TABLE IF NOT EXISTS `submission_upvotes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `submission_id` int(10) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`submission_id`),
  KEY `submission_upvotes_ip_address_index` (`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.submission_upvotes: 5 rows
/*!40000 ALTER TABLE `submission_upvotes` DISABLE KEYS */;
INSERT INTO `submission_upvotes` (`user_id`, `ip_address`, `submission_id`, `created_at`, `updated_at`) VALUES
	(1, '1', 1, '2017-06-28 21:05:12', '2017-06-28 21:05:12'),
	(1, '1', 2, '2017-06-29 13:06:08', '2017-06-29 13:06:08'),
	(2, '1', 3, '2017-06-29 21:02:02', '2017-06-29 21:02:02'),
	(2, '1', 4, '2017-06-30 01:09:22', '2017-06-30 01:09:22'),
	(1, '1', 5, '2017-06-30 01:37:08', '2017-06-30 01:37:08');
/*!40000 ALTER TABLE `submission_upvotes` ENABLE KEYS */;

-- Dumping structure for table deproducciones.subscriptions
CREATE TABLE IF NOT EXISTS `subscriptions` (
  `user_id` int(10) unsigned NOT NULL,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`category_id`),
  KEY `subscriptions_user_id_index` (`user_id`),
  KEY `subscriptions_category_id_index` (`category_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.subscriptions: 4 rows
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
INSERT INTO `subscriptions` (`user_id`, `category_id`) VALUES
	(1, 2),
	(1, 4),
	(2, 2),
	(2, 4);
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;

-- Dumping structure for table deproducciones.suggesteds
CREATE TABLE IF NOT EXISTS `suggesteds` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int(10) unsigned NOT NULL,
  `group` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `language` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'en',
  `z_index` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `suggesteds_category_id_index` (`category_id`),
  KEY `suggesteds_group_index` (`group`),
  KEY `suggesteds_language_index` (`language`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.suggesteds: 0 rows
/*!40000 ALTER TABLE `suggesteds` DISABLE KEYS */;
/*!40000 ALTER TABLE `suggesteds` ENABLE KEYS */;

-- Dumping structure for table deproducciones.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `website` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `avatar` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '/public/imgs/default-avatar.png',
  `color` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'Dark',
  `bio` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `confirmed` tinyint(1) NOT NULL DEFAULT '0',
  `email` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` json NOT NULL,
  `info` json DEFAULT NULL,
  `verified` tinyint(1) NOT NULL DEFAULT '0',
  `submission_karma` int(11) NOT NULL DEFAULT '0',
  `comment_karma` int(11) NOT NULL DEFAULT '0',
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unique` (`username`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.users: 3 rows
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `name`, `website`, `location`, `avatar`, `color`, `bio`, `active`, `confirmed`, `email`, `settings`, `info`, `verified`, `submission_karma`, `comment_karma`, `password`, `deleted_at`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'admin', 'admin', NULL, NULL, '/public/imgs/default-avatar.png', 'Dark', NULL, 1, 1, 'admin@admin.com', '{"font": "Lato", "nsfw": true, "nsfw_media": true, "sidebar_color": "Gray", "notify_comments_replied": true, "notify_submissions_replied": true, "exclude_upvoted_submissions": false, "exclude_downvoted_submissions": true}', '{"twitter": null, "website": null}', 1, 0, 0, '$2y$10$O46fnlNfuY9oDpaS/gJkZuUiCw6UYiJIQDFFowHvbqIp4oGsykvDy', NULL, 'uZDHwsWtqWR4tafalxO4ONt1WzkHtknPAf6PjGoBSmT95g0sltrqXFn4W38p', '2017-06-27 23:22:37', '2017-06-30 01:21:01'),
	(2, 'rbutta', 'Rodrigo Butta alias gmail', NULL, NULL, 'http://beta.egoagencydev.com/tmp/users/avatars/1498790543cASMW8w.png', 'Orange', NULL, 1, 0, 'rbutta@gmail.com', '{"font": "Lato", "nsfw": true, "nsfw_media": true, "sidebar_color": "Gray", "notify_comments_replied": true, "notify_submissions_replied": true, "exclude_upvoted_submissions": false, "exclude_downvoted_submissions": false}', '{"twitter": null, "website": null}', 0, 0, 0, '$2y$10$zgXSlHrpV21SrjuZihvH4uh01E8iyje9vsMtwfzU.5ayQkfleHgc6', NULL, 'iteh14LTeGPrPjnuWKT5OeGM6gaOdo1VNCP4Wb11HheMWdJ4X2HRTvTY6ot8', '2017-06-28 21:06:13', '2017-06-30 02:42:43'),
	(3, 'rodrigo.butta', 'Rodrigo Butta', NULL, NULL, 'http://beta.egoagencydev.com/tmp/users/avatars/1498766629BzzMSCx.jpg', 'Dark', NULL, 1, 1, 'rodrigo.butta@egoargentina.com', '{"font": "Lato", "nsfw": false, "nsfw_media": false, "sidebar_color": "Gray", "notify_comments_replied": true, "notify_submissions_replied": true, "exclude_upvoted_submissions": false, "exclude_downvoted_submissions": true}', '{"twitter": null, "website": null}', 0, 0, 0, '$2y$10$ZzAB3FIiXMkK9UvKQmQek.S9akrQMCfKsxDtH0gTZzN.MQtXXAba.', NULL, 'rwHuH3U2I2GijDIOs1QH1iyS3K4TjRp7V29xxS6QzReeccRkyjvpq7RyqbQL', '2017-06-29 20:04:01', '2017-06-29 20:04:01');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table deproducciones.user_forbidden_names
CREATE TABLE IF NOT EXISTS `user_forbidden_names` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.user_forbidden_names: 0 rows
/*!40000 ALTER TABLE `user_forbidden_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_forbidden_names` ENABLE KEYS */;

-- Dumping structure for table deproducciones.user_professions
CREATE TABLE IF NOT EXISTS `user_professions` (
  `user_id` int(10) unsigned NOT NULL,
  `profession_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`user_id`,`profession_id`),
  KEY `subscriptions_user_id_index` (`user_id`),
  KEY `subscriptions_category_id_index` (`profession_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=FIXED;

-- Dumping data for table deproducciones.user_professions: 3 rows
/*!40000 ALTER TABLE `user_professions` DISABLE KEYS */;
INSERT INTO `user_professions` (`user_id`, `profession_id`) VALUES
	(1, 1),
	(1, 3),
	(2, 1),
	(2, 2),
	(3, 1);
/*!40000 ALTER TABLE `user_professions` ENABLE KEYS */;

-- Dumping structure for table deproducciones.votes
CREATE TABLE IF NOT EXISTS `votes` (
  `user_id` int(10) unsigned NOT NULL,
  `ip_address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `submission_id` int(10) unsigned NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'upvote',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`,`submission_id`,`ip_address`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Dumping data for table deproducciones.votes: 0 rows
/*!40000 ALTER TABLE `votes` DISABLE KEYS */;
/*!40000 ALTER TABLE `votes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
