
USE `ecommerce`;

CREATE TABLE `images` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`mime` varchar(127) NOT NULL,
	`uri` varchar(255) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `sites` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`domain` varchar(255) NOT NULL,
	`admin_domain` varchar(255) NOT NULL,
	`cookie_domain` varchar(255) NOT NULL,
	`tiny_domain` varchar(255) NOT NULL,
	`logo_image_id` bigint(20) UNSIGNED NOT NULL,
	`icon_image_id` bigint(20) UNSIGNED NOT NULL,
	`invoice_image_id` bigint(20) UNSIGNED NOT NULL,
	`restricted` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `domain` (`domain`,`deleted`),
	KEY `admin_domain` (`admin_domain`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `configs` (
	`site_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`code` varchar(128) NOT NULL,
	`key` varchar(128) NOT NULL,
	`value` text NOT NULL,
	`type` varchar(12) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`site_id`,`code`,`key`),
	KEY `code` (`code`),
	KEY `key` (`key`,`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `crons` (
	`site_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`uri` varchar(255) NOT NULL,
	`minute` varchar(5) NOT NULL DEFAULT '*',
	`hour` varchar(4) NOT NULL DEFAULT '*',
	`day_of_month` varchar(4) NOT NULL DEFAULT '*',
	`month` varchar(4) NOT NULL DEFAULT '*',
	`day_of_week` char(1) NOT NULL DEFAULT '*',
	`status` tinyint(1) NOT NULL DEFAULT 1,
	`last_check_time` datetime NOT NULL,
	`last_run_time` datetime NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`site_id`,`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `extensions` (
	`site_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`type` varchar(32) NOT NULL,
	`code` varchar(64) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`site_id`,`type`,`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `currencies` (
	`code` varchar(3) NOT NULL,
	`name` varchar(64) NOT NULL,
	`symbol_left` varchar(12) NOT NULL,
	`symbol_right` varchar(12) NOT NULL,
	`decimal_place` tinyint(1) NOT NULL,
	`default` tinyint(1) NOT NULL DEFAULT 0,
	`value` decimal(15,8) NOT NULL DEFAULT 1.00000000,
	`value_updated_time` datetime NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`code`),
	KEY `default` (`default`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `currency_to_sites` (
	`currency_code` varchar(3) NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`currency_code`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `languages` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`code` varchar(5) NOT NULL,
	`flag` char(2) NOT NULL,
	`locale` varchar(255) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`length_unit_id` bigint(20) UNSIGNED NOT NULL,
	`weight_unit_id` bigint(20) UNSIGNED NOT NULL,
	`default` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `code` (`code`,`deleted`),
	KEY `default` (`default`,`deleted`),
	KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `language_to_sites` (
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`language_id`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `countries` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(128) NOT NULL,
	`iso_code_2` varchar(2) NOT NULL,
	`iso_code_3` varchar(3) NOT NULL,
	`city_label` varchar(32) NOT NULL,
	`zone_label` varchar(32) NOT NULL,
	`address_format` text NOT NULL,
	`postal_code_required` tinyint(1) NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `name` (`name`,`deleted`),
	KEY `iso_code_2` (`iso_code_2`,`deleted`),
	KEY `iso_code_3` (`iso_code_3`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `zones` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(128) NOT NULL,
	`code` varchar(32) NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `country_id` (`country_id`,`deleted`),
	KEY `name` (`name`,`deleted`),
	FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `geo_zones` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`description` varchar(255) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `country_zone_to_geo_zones` (
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone_id` bigint(20) UNSIGNED NOT NULL,
	`geo_zone_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`country_id`,`zone_id`,`geo_zone_id`),
	KEY `zone_id` (`zone_id`),
	KEY `geo_zone_id_country_id` (`geo_zone_id`,`country_id`),
	FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`geo_zone_id`) REFERENCES `geo_zones`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `geo_zone_postal_codes` (
	`geo_zone_id` bigint(20) UNSIGNED NOT NULL,
	`postal_code` varchar(10) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`geo_zone_id`,`postal_code`),
	KEY `postal_code` (`postal_code`),
	FOREIGN KEY (`geo_zone_id`) REFERENCES `geo_zones`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tax_groups` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`description` varchar(255) NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tax_rates` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`tax_group_id` bigint(20) UNSIGNED NOT NULL,
	`geo_zone_id` bigint(20) UNSIGNED NOT NULL,
	`based` enum('origin','destination') NOT NULL,
	`rate` decimal(15,4) NOT NULL DEFAULT 0.0000,
	`priority` int(11) UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	KEY `geo_zone_id` (`geo_zone_id`),
	KEY `based` (`based`),
	FOREIGN KEY (`tax_group_id`) REFERENCES `tax_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`geo_zone_id`) REFERENCES `geo_zones`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `weight_units` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`default` tinyint(1) NOT NULL DEFAULT 0,
	`value` decimal(15,8) NOT NULL DEFAULT 1.00000000,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `default` (`default`,`deleted`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `weight_unit_descriptions` (
	`weight_unit_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`unit` varchar(4) NOT NULL,
	PRIMARY KEY (`weight_unit_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`weight_unit_id`) REFERENCES `weight_units`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `length_units` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`default` tinyint(1) NOT NULL DEFAULT 0,
	`value` decimal(15,8) NOT NULL DEFAULT 1.00000000,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `default` (`default`,`deleted`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `length_unit_descriptions` (
	`length_unit_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`unit` varchar(4) NOT NULL,
	PRIMARY KEY (`length_unit_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`length_unit_id`) REFERENCES `length_units`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `seo_urls` (
	`key` varchar(64) NOT NULL,
	`value` varchar(255) NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`keyword` varchar(255) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`key`,`value`,`language_id`),
	KEY `key_value` (`key`,`value`,`deleted`),
	KEY `language_id` (`language_id`,`deleted`),
	KEY `keyword_language_id` (`keyword`,`language_id`,`deleted`),
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_payment_terms` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`days` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`early_pay_discount_pct` decimal(7,4) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `days` (`days`,`deleted`),
	KEY `early_pay_discount_pct` (`early_pay_discount_pct`,`deleted`),
	KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_payment_term_descriptions` (
	`customer_payment_term_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`customer_payment_term_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`customer_payment_term_id`) REFERENCES `customer_payment_terms`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_groups` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_minimum` decimal(15,4) NOT NULL DEFAULT 0.0000,
	`customer_payment_term_id` bigint(20) UNSIGNED NOT NULL,
	`tax_exemption_type` enum('non_exempt','government','other','wholesale') NOT NULL DEFAULT 'non_exempt',
	`restricted` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_group_descriptions` (
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`customer_group_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_group_to_sites` (
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`customer_group_id`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`customer_group_id`) REFERENCES `customer_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customers` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`first_name` varchar(64) NOT NULL,
	`last_name` varchar(64) NOT NULL,
	`company` varchar(64) NOT NULL,
	`email` varchar(96) NOT NULL,
	`phone` varchar(32) NOT NULL,
	`customer_address_id` bigint(20) UNSIGNED NOT NULL,
	`password` varchar(255) NOT NULL,
	`sales_rep_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_group_id` (`customer_group_id`,`deleted`),
	KEY `first_name_last_name` (`first_name`,`last_name`,`deleted`),
	KEY `first_name` (`first_name`,`deleted`),
	KEY `last_name` (`last_name`,`deleted`),
	KEY `company` (`company`,`deleted`),
	KEY `email` (`email`,`deleted`),
	KEY `phone` (`phone`,`deleted`),
	KEY `sales_rep_id` (`sales_rep_id`,`deleted`),
	KEY `affiliate_id` (`affiliate_id`,`deleted`),
	KEY `inventory_location_id` (`inventory_location_id`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_contacts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`title` varchar(64) NOT NULL,
	`name` varchar(128) NOT NULL,
	`email` varchar(96) NOT NULL,
	`phone` varchar(32) NOT NULL,
	`order_updates` tinyint(1) NOT NULL DEFAULT 0,
	`shipping_updates` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_id` (`customer_id`,`deleted`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_addresses` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`company` varchar(64) NOT NULL,
	`first_name` varchar(64) NOT NULL,
	`last_name` varchar(64) NOT NULL,
	`address_1` varchar(128) NOT NULL,
	`address_2` varchar(128) NOT NULL,
	`city` varchar(128) NOT NULL,
	`postal_code` varchar(10) NOT NULL,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_id` (`customer_id`,`deleted`),
	KEY `country_id` (`country_id`,`deleted`),
	KEY `zone_id` (`zone_id`,`deleted`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`country_id`) REFERENCES `countries`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`zone_id`) REFERENCES `zones`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_metas` (
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`key` varchar(128) NOT NULL,
	`value` varchar(255) NOT NULL,
	`type` varchar(12) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`customer_id`,`key`),
	KEY `key` (`key`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`notify` tinyint(1) NOT NULL,
	`note` text NOT NULL,
	`pinned` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_id` (`customer_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_ips` (
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`ip` varchar(40) NOT NULL,
	`country_code` char(2) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`customer_id`,`ip`),
	KEY `ip` (`ip`),
	KEY `country_code` (`country_code`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `customer_transactions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`description` text NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_id_created_time` (`customer_id`,`created_time`,`deleted`),
	KEY `order_id_created_time` (`order_id`,`created_time`,`deleted`),
	KEY `user_id_created_time` (`user_id`,`created_time`,`deleted`),
	KEY `currency_code_created_time` (`currency_code`,`created_time`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `commission_groups` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `commission_group_descriptions` (
	`commission_group_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`commission_group_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`commission_group_id`) REFERENCES `commission_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `commission_group_commissions` (
	`commission_group_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`level` smallint(5) UNSIGNED NOT NULL,
	`commission` decimal(5,2) NOT NULL,
	PRIMARY KEY (`commission_group_id`,`site_id`,`level`),
	KEY `site_id_level` (`site_id`,`level`),
	FOREIGN KEY (`commission_group_id`) REFERENCES `commission_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `commission_group_products` (
	`commission_group_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`commission` decimal(5,2) NOT NULL,
	PRIMARY KEY (`commission_group_id`,`site_id`,`product_id`),
	KEY `site_id_product_id` (`site_id`,`product_id`),
	KEY `product_id` (`product_id`),
	FOREIGN KEY (`commission_group_id`) REFERENCES `commission_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_statuses` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`approved` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `approved` (`approved`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_status_descriptions` (
	`affiliate_status_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`affiliate_status_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`affiliate_status_id`) REFERENCES `affiliate_statuses`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_tags` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_tag_descriptions` (
	`affiliate_tag_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`affiliate_tag_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`affiliate_tag_id`) REFERENCES `affiliate_tags`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_ranks` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`rank` tinyint(3) NOT NULL,
	`commission_group_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`store_credit` decimal(15,4) NOT NULL,
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`promo_coupon_id` bigint(20) UNSIGNED NOT NULL,
	`coupon_discount` decimal(15,4) NOT NULL,
	`coupon_limit` tinyint(3) NOT NULL,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `rank` (`rank`,`deleted`),
	KEY `commission_group_id` (`commission_group_id`,`deleted`),
	KEY `customer_group_id` (`customer_group_id`,`deleted`),
	KEY `coupon_id` (`coupon_id`,`deleted`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_rank_descriptions` (
	`affiliate_rank_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`affiliate_rank_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`affiliate_rank_id`) REFERENCES `affiliate_ranks`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliates` (
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`source` varchar(64) NOT NULL,
	`affiliate_status_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_rank_id` bigint(20) UNSIGNED NOT NULL,
	`code` varchar(64) NOT NULL,
	`payout_extension_code` varchar(64) NOT NULL,
	`payout_data` text NOT NULL DEFAULT '',
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`customer_id`),
	KEY `customer_id_created_time` (`customer_id`,`created_time`),
	KEY `parent_id` (`parent_id`),
	KEY `source` (`source`),
	KEY `affiliate_status_id_created_time` (`affiliate_status_id`,`created_time`),
	KEY `affiliate_rank_id_created_time` (`affiliate_rank_id`,`created_time`),
	KEY `code` (`code`),
	KEY `payout_extension_code` (`payout_extension_code`),
	FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_paths` (
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`path_id` bigint(20) UNSIGNED NOT NULL,
	`level` smallint(5) UNSIGNED NOT NULL,
	PRIMARY KEY (`affiliate_id`,`path_id`),
	KEY `path_id` (`path_id`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE,
	FOREIGN KEY (`path_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_metas` (
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`key` varchar(128) NOT NULL,
	`value` varchar(255) NOT NULL,
	`type` varchar(12) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`affiliate_id`,`key`),
	KEY `key` (`key`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`notify` tinyint(1) NOT NULL,
	`note` text NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `affiliate_id` (`affiliate_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_transactions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_payout_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`description` text NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `affiliate_id_created_time` (`affiliate_id`,`created_time`,`deleted`),
	KEY `order_id_affiliate_id_created_time` (`order_id`,`affiliate_id`,`created_time`,`deleted`),
	KEY `order_id_created_time` (`order_id`,`created_time`,`deleted`),
	KEY `user_id_created_time` (`user_id`,`created_time`,`deleted`),
	KEY `affiliate_payout_id_created_time` (`affiliate_payout_id`,`created_time`,`deleted`),
	KEY `currency_code_created_time` (`currency_code`,`created_time`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_payouts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`extension_code` varchar(64) NOT NULL,
	`ext_id` varchar(255) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`status` varchar(64) NOT NULL,
	`complete` tinyint(1) NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `extension_code` (`extension_code`,`created_time`),
	KEY `ext_id` (`ext_id`),
	KEY `currency_code` (`ext_id`,`created_time`),
	KEY `status` (`status`,`created_time`),
	KEY `complete` (`complete`,`created_time`),
	KEY `user_id` (`user_id`,`created_time`),
	KEY `created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_to_tags` (
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_tag_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`affiliate_id`,`affiliate_tag_id`),
	KEY `affiliate_tag_id` (`affiliate_tag_id`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE,
	FOREIGN KEY (`affiliate_tag_id`) REFERENCES `affiliate_tags`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `affiliate_social_media_accounts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`network` varchar(32) NOT NULL,
	`username` varchar(255) NOT NULL,
	`followers` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `network_username` (`network`,`username`),
	KEY `username` (`username`),
	KEY `followers` (`followers`),
	FOREIGN KEY (`affiliate_id`) REFERENCES `affiliates`(`customer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_boxes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`length` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`width` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`height` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`length_unit_id` bigint(20) UNSIGNED NOT NULL,
	`volume` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`min_volume` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`is_duplicable` tinyint(1) NOT NULL DEFAULT 0,
	`flexible` tinyint(1) NOT NULL DEFAULT 0,
	`restricted` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `length_width_height` (`length`,`width`,`height`,`deleted`),
	KEY `width` (`width`,`deleted`),
	KEY `height` (`height`,`deleted`),
	KEY `volume` (`volume`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_locations` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`contact_name` varchar(128) NOT NULL,
	`contact_email` varchar(96) NOT NULL,
	`contact_phone` varchar(32) NOT NULL,
	`address_1` varchar(128) NOT NULL,
	`address_2` varchar(128) NOT NULL,
	`city` varchar(128) NOT NULL,
	`postal_code` varchar(10) NOT NULL,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone_id` bigint(20) UNSIGNED NOT NULL,
	`fulfillment_extension_code` varchar(64) NOT NULL,
	`dispatch_notification_email` varchar(96) NOT NULL,
	`ship_by_date_limit` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`shipping_zones_updated_time` datetime NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `country_id` (`country_id`,`deleted`),
	KEY `zone_id` (`zone_id`,`deleted`),
	KEY `fulfillment_extension_code` (`fulfillment_extension_code`,`deleted`),
	KEY `shipping_zones_updated_time` (`shipping_zones_updated_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_location_metas` (
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`key` varchar(128) NOT NULL,
	`value` varchar(255) NOT NULL,
	`type` varchar(12) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_location_id`,`key`),
	KEY `key` (`key`),
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_location_shipping_zones` (
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`start` char(3) NOT NULL,
	`end` char(3) NOT NULL,
	`zone` tinyint(1) NOT NULL DEFAULT 1,
	PRIMARY KEY (`inventory_location_id`,`start`,`end`),
	KEY `start_end` (`start`,`end`),
	KEY `zone` (`zone`,`inventory_location_id`),
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_location_to_sites` (
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_location_id`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `shipping_methods` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`extension_code` varchar(64) NOT NULL,
	`extension_method` varchar(64) NOT NULL,
	`geo_zone_id` bigint(20) UNSIGNED NOT NULL,
	`min_weight` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`max_weight` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`weight_unit_id` bigint(20) UNSIGNED NOT NULL,
	`min_transit_days` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`max_transit_days` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`handle_po_box` tinyint(1) NOT NULL DEFAULT 0,
	`base_cost` decimal(15,4) NOT NULL DEFAULT 0.0000,
	`free` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id_status` (`site_id`,`status`,`deleted`),
	KEY `extension_code_extension_method` (`extension_code`,`extension_method`,`deleted`),
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `shipping_method_descriptions` (
	`shipping_method_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	`pending_shipment_status` text NOT NULL,
	`dispatched_shipment_status` text NOT NULL,
	`canceled_shipment_status` text NOT NULL,
	`shipped_shipment_status` text NOT NULL,
	`undeliverable_shipment_status` text NOT NULL,
	`delivered_shipment_status` text NOT NULL,
	PRIMARY KEY (`shipping_method_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `shipping_method_to_boxes` (
	`shipping_method_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_box_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`shipping_method_id`,`inventory_box_id`),
	KEY `inventory_box_id` (`inventory_box_id`),
	FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_box_id`) REFERENCES `inventory_boxes`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `shipping_method_to_inventory_locations` (
	`shipping_method_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`shipping_method_id`,`inventory_location_id`),
	KEY `inventory_location_id` (`inventory_location_id`),
	FOREIGN KEY (`shipping_method_id`) REFERENCES `shipping_methods`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `shipping_rates` (
	`extension_code` varchar(64) NOT NULL,
	`method` varchar(64) NOT NULL,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone` tinyint(1) NOT NULL DEFAULT 0,
	`weight` smallint(5) UNSIGNED NOT NULL DEFAULT 0,
	`weight_unit_id` bigint(20) UNSIGNED NOT NULL,
	`cost` decimal(15,4) NOT NULL DEFAULT 0.0000,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`extension_code`,`method`,`country_id`,`zone`,`weight`),
	KEY `country_id_weight` (`country_id`,`zone`,`weight`,`extension_code`,`method`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_items` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`sku` varchar(64) NOT NULL,
	`upc` varchar(13) NOT NULL,
	`cost` decimal(15,4) NOT NULL DEFAULT 0.0000,
	`currency_code` varchar(3) NOT NULL,
	`weight` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`weight_unit_id` bigint(20) UNSIGNED NOT NULL,
	`length` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`width` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`height` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`length_unit_id` bigint(20) UNSIGNED NOT NULL,
	`flexible` tinyint(1) NOT NULL DEFAULT 0,
	`prop65` tinyint(1) NOT NULL DEFAULT 0,
	`geo_zone_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `sku` (`sku`,`deleted`),
	KEY `upc` (`upc`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_upcs` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`upc` varchar(13) NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`upc`),
	KEY `upc` (`upc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_to_boxes` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_box_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`inventory_box_id`),
	KEY `inventory_box_id` (`inventory_box_id`),
	FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_box_id`) REFERENCES `inventory_boxes`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_to_currencies` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`price` decimal(15,4) NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`currency_code`),
	KEY `currency_code` (`currency_code`),
	FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_to_locations` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`qoh` bigint(20) NOT NULL DEFAULT 0,
	`ats` bigint(20) NOT NULL DEFAULT 0,
	`safety` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
	`sku` varchar(64) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`inventory_location_id`),
	KEY `inventory_location_id` (`inventory_location_id`),
	KEY `safety_inventory_location_id` (`safety`,`inventory_location_id`),
	FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_to_site_locations` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`safety` mediumint(8) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`site_id`,`inventory_location_id`),
	KEY `site_id_inventory_location_id` (`site_id`,`inventory_location_id`),
	KEY `inventory_location_id` (`inventory_location_id`),
	KEY `safety_inventory_location_id` (`safety`,`inventory_location_id`),
	FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_location_id`) REFERENCES `inventory_locations`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `inventory_item_stock_snapshots` (
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`qoh` bigint(20) NOT NULL DEFAULT 0,
	`ats` bigint(20) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`inventory_item_id`,`inventory_location_id`,`created_time`),
	KEY `inventory_location_id` (`inventory_location_id`,`created_time`),
	KEY `inventory_item_id` (`inventory_item_id`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_recurrings` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`price_pct` decimal(7,4) NOT NULL,
	`frequency_value` smallint(6) UNSIGNED NOT NULL,
	`frequency_type` enum('day','week','month','year') NOT NULL,
	`cycles` smallint(6) NOT NULL,
	`trial_status` tinyint(1) NOT NULL,
	`trial_price_pct` decimal(7,4) NOT NULL,
	`trial_frequency_value` smallint(6) UNSIGNED NOT NULL,
	`trial_frequency_type` enum('day','week','month','year') NOT NULL,
	`trial_cycles` smallint(6) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_recurring_descriptions` (
	`product_recurring_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`product_recurring_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`product_recurring_id`) REFERENCES `product_recurrings`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_categories` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`parent_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `parent_id` (`parent_id`,`deleted`),
	KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_category_descriptions` (
	`product_category_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	`short_description` text NOT NULL,
	`long_description` text NOT NULL,
	`meta_title` varchar(255) NOT NULL,
	`meta_description` varchar(255) NOT NULL,
	`meta_keyword` varchar(255) NOT NULL,
	PRIMARY KEY (`product_category_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`product_category_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_category_paths` (
	`product_category_id` bigint(20) UNSIGNED NOT NULL,
	`path_id` bigint(20) UNSIGNED NOT NULL,
	`level` smallint(5) UNSIGNED NOT NULL,
	PRIMARY KEY (`product_category_id`,`path_id`),
	KEY `path_id` (`path_id`),
	FOREIGN KEY (`product_category_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`path_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_category_to_sites` (
	`product_category_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`hidden` tinyint(1) NOT NULL DEFAULT 0,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`product_category_id`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`product_category_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `products` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`model` varchar(64) NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`tax_group_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`min` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`max` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`min_shipping` decimal(15,4) NOT NULL,
	`visibility` tinyint(1) NOT NULL DEFAULT 0,
	`discountable` tinyint(1) NOT NULL DEFAULT 1,
	`commissionable` tinyint(1) NOT NULL DEFAULT 1,
	`require_affiliate_coupon` tinyint(1) NOT NULL DEFAULT 0,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 1,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `model` (`model`,`deleted`),
	KEY `tax_group_id` (`tax_group_id`,`deleted`),
	KEY `deleted` (`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_descriptions` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	`meta_title` varchar(255) NOT NULL,
	`meta_description` varchar(255) NOT NULL,
	`meta_keyword` varchar(255) NOT NULL,
	PRIMARY KEY (`product_id`,`language_id`),
	KEY `language_id` (`language_id`),
	KEY `name` (`name`,`language_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_contents` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`content` text NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_id_language_id` (`product_id`,`language_id`,`deleted`),
	KEY `language_id` (`language_id`,`deleted`),
	KEY `name` (`name`,`language_id`,`deleted`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_images` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_id` (`product_id`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_tags` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`tag` varchar(64) NOT NULL,
	PRIMARY KEY (`product_id`,`language_id`,`tag`),
	KEY `language_id_tag` (`language_id`,`tag`),
	KEY `tag` (`tag`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_options` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`type` varchar(32) NOT NULL,
	`required` tinyint(1) NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_id` (`product_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_option_descriptions` (
	`product_option_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`product_option_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`product_option_id`) REFERENCES `product_options`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_option_values` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_option_id` bigint(20) UNSIGNED NOT NULL,
	`mirror_product_option_id` bigint(20) UNSIGNED NOT NULL,
	`meta_data` varchar(255) NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_option_id` (`product_option_id`),
	KEY `mirror_product_option_id` (`product_option_id`),
	FOREIGN KEY (`product_option_id`) REFERENCES `product_options`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_option_value_descriptions` (
	`product_option_value_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	PRIMARY KEY (`product_option_value_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`product_option_value_id`) REFERENCES `product_option_values`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_option_value_images` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_option_value_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_option_value_id` (`product_option_value_id`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`product_option_value_id`) REFERENCES `product_option_values`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_option_value_to_currencies` (
	`product_option_value_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`price` decimal(15,4) NOT NULL,
	PRIMARY KEY (`product_option_value_id`,`currency_code`),
	KEY `currency_code` (`currency_code`),
	FOREIGN KEY (`product_option_value_id`) REFERENCES `product_option_values`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_inventory_items` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`variant` varchar(255) NOT NULL,
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	PRIMARY KEY (`product_id`,`variant`,`inventory_item_id`),
	KEY `inventory_item_id` (`inventory_item_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`inventory_item_id`) REFERENCES `inventory_items`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_discounts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`priority` smallint(5) UNSIGNED NOT NULL,
	`start_date` date NOT NULL DEFAULT '0000-00-00',
	`end_date` date NOT NULL DEFAULT '0000-00-00',
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `cart` (
		`product_id`,
		`site_id`,
		`customer_group_id`,
		`quantity`,
		`start_date`,
		`end_date`,
		`deleted`
	),
	KEY `site_id` (`site_id`,`deleted`),
	KEY `customer_group_id` (`customer_group_id`,`deleted`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_discount_to_currencies` (
	`product_discount_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`price` decimal(15,4) NOT NULL DEFAULT '0.0000',
	PRIMARY KEY (`product_discount_id`,`currency_code`),
	KEY `currency_code` (`currency_code`),
	FOREIGN KEY (`product_discount_id`) REFERENCES `product_discounts`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_specials` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`priority` smallint(5) UNSIGNED NOT NULL,
	`start_date` date NOT NULL DEFAULT '0000-00-00',
	`end_date` date NOT NULL DEFAULT '0000-00-00',
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `cart` (
		`product_id`,
		`site_id`,
		`customer_group_id`,
		`start_date`,
		`end_date`,
		`deleted`
	),
	KEY `site_id` (`site_id`,`deleted`),
	KEY `customer_group_id` (`customer_group_id`,`deleted`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_special_to_product_option_values` (
	`product_special_id` bigint(20) UNSIGNED NOT NULL,
	`product_option_id` bigint(20) UNSIGNED NOT NULL,
	`product_option_value_id` bigint(20) UNSIGNED NOT NULL,
	PRIMARY KEY (`product_special_id`,`product_option_id`),
	KEY `product_option_id_product_option_value_id` (`product_option_id`,`product_option_value_id`),
	KEY `product_option_value_id` (`product_option_value_id`),
	FOREIGN KEY (`product_special_id`) REFERENCES `product_specials`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_option_id`) REFERENCES `product_options`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_special_to_currencies` (
	`product_special_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`price` decimal(15,4) NOT NULL DEFAULT '0.0000',
	PRIMARY KEY (`product_special_id`,`currency_code`),
	KEY `currency_code` (`currency_code`),
	FOREIGN KEY (`product_special_id`) REFERENCES `product_specials`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_reviews` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(64) NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`rating` tinyint(1) NOT NULL,
	`title` varchar(255) NOT NULL,
	`review` text NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_id` (`product_id`,`deleted`,`created_time`),
	KEY `customer_id` (`customer_id`,`deleted`,`created_time`),
	KEY `name` (`name`,`deleted`,`created_time`),
	KEY `order_id` (`order_id`,`deleted`,`created_time`),
	KEY `order_product_id` (`order_product_id`,`deleted`,`created_time`),
	KEY `rating` (`rating`,`deleted`,`created_time`),
	KEY `product_id_status` (`product_id`,`status`,`deleted`,`created_time`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_to_categories` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`product_category_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`product_id`,`product_category_id`),
	KEY `product_category_id` (`product_category_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_category_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_to_currencies` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`price` decimal(15,4) NOT NULL,
	`msrp` decimal(15,4) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`product_id`,`site_id`,`customer_group_id`,`currency_code`),
	KEY `site_id_customer_group_id_currency_code` (`site_id`,`customer_group_id`,`currency_code`),
	KEY `customer_group_id_currency_code` (`customer_group_id`,`currency_code`),
	KEY `currency_code_product_id` (`currency_code`,`product_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`currency_code`) REFERENCES `currencies`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_to_recurrings` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`product_recurring_id` bigint(20) UNSIGNED NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`product_id`,`product_recurring_id`),
	KEY `product_recurring_id` (`product_recurring_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_recurring_id`) REFERENCES `product_recurrings`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_to_sites` (
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`featured` tinyint(1) NOT NULL DEFAULT 0,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`product_id`,`site_id`,`customer_group_id`),
	KEY `site_id_customer_group_id` (`site_id`,`customer_group_id`),
	KEY `customer_group_id_product_id` (`customer_group_id`,`product_id`),
	KEY `site_id_featured_customer_group_id` (`site_id`,`featured`,`customer_group_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `product_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`note` text NOT NULL,
	`pinned` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_id` (`product_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `carts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`session_id` varchar(32) NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`product_options` text NOT NULL,
	`product_recurring_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `customer_id_session_id_product_id_site_id` (`customer_id`,`session_id`,`product_id`,`site_id`),
	KEY `customer_id_site_id_created_time` (`customer_id`,`site_id`,`created_time`),
	KEY `product_id_site_id` (`product_id`,`site_id`),
	KEY `product_recurring_id_site_id` (`product_recurring_id`,`site_id`),
	KEY `created_time_site_id` (`created_time`,`site_id`),
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupons` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(128) NOT NULL,
	`code` varchar(20) NOT NULL,
	`type` char(1) NOT NULL,
	`discount` decimal(15,4) NOT NULL,
	`shipping` tinyint(1) NOT NULL,
	`shipping_price` decimal(15,4) NOT NULL,
	`total` decimal(15,4) NOT NULL,
	`uses_total` int(11) NOT NULL,
	`uses_customer` int(11) NOT NULL,
	`start_date` date NOT NULL,
	`end_date` date NOT NULL,
	`product_type` tinyint(1) NOT NULL DEFAULT 0,
	`product_category_type` tinyint(1) NOT NULL DEFAULT 0,
	`commissionable` tinyint(1) NOT NULL DEFAULT 1,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `code` (`code`,`deleted`),
	KEY `customer_id` (`customer_id`,`deleted`),
	KEY `affiliate_id` (`affiliate_id`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_to_products` (
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`coupon_id`,`product_id`),
	KEY `product_id` (`product_id`),
	FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_to_product_categories` (
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`product_category_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`coupon_id`,`product_category_id`),
	KEY `product_category_id` (`product_category_id`),
	FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_category_id`) REFERENCES `product_categories`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_tiers` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`total` decimal(15,4) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `coupon_id` (`coupon_id`),
	FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_tier_items` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`coupon_tier_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`sort_order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `coupon_tier_id` (`coupon_tier_id`),
	FOREIGN KEY (`coupon_tier_id`) REFERENCES `coupon_tiers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_tier_item_to_products` (
	`coupon_tier_item_id` bigint(20) UNSIGNED NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`sort_order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`coupon_tier_item_id`,`product_id`),
	KEY `product_id` (`product_id`),
	FOREIGN KEY (`coupon_tier_item_id`) REFERENCES `coupon_tier_items`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`product_id`) REFERENCES `products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_to_sites` (
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`discount` decimal(15,4) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`coupon_id`,`site_id`),
	KEY `site_id` (`site_id`),
	FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `coupon_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`note` text NOT NULL,
	`pinned` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `coupon_id` (`coupon_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`coupon_id`) REFERENCES `coupons`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `vouchers` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`code` varchar(255) NOT NULL,
	`extension_code` varchar(64) NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `code` (`code`),
	KEY `extension_code_created_time` (`extension_code`,`created_time`),
	KEY `order_id_created_time` (`order_id`,`created_time`),
	KEY `order_product_id_created_time` (`order_product_id`,`created_time`),
	KEY `created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_statuses` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`modify_products` tinyint(1) NOT NULL DEFAULT 0,
	`deduct_inventory` tinyint(1) NOT NULL DEFAULT 0,
	`allow_fulfillment` tinyint(1) NOT NULL DEFAULT 0,
	`complete_order` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`),
	KEY `modify_products` (`modify_products`,`deleted`),
	KEY `deduct_inventory` (`deduct_inventory`,`deleted`),
	KEY `allow_fulfillment` (`allow_fulfillment`,`deleted`),
	KEY `complete_order` (`complete_order`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_status_descriptions` (
	`order_status_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`order_status_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`order_status_id`) REFERENCES `order_statuses`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_reship_reasons` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`free_shipping` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_reship_reason_descriptions` (
	`order_reship_reason_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`order_reship_reason_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`order_reship_reason_id`) REFERENCES `order_reship_reasons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_transaction_refund_reasons` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_transaction_refund_reason_descriptions` (
	`order_transaction_refund_reason_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`order_transaction_refund_reason_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`order_transaction_refund_reason_id`) REFERENCES `order_transaction_refund_reasons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `orders` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`uuid` char(36) NOT NULL,
	`sales_channel_extension_code` varchar(64) NOT NULL,
	`sales_channel_status` varchar(64) NOT NULL,
	`ext_id` varchar(36) NOT NULL,
	`invoice_prefix` varchar(32) NOT NULL,
	`invoice_num` bigint(20) UNSIGNED NOT NULL,
	`invoice_date` date NOT NULL DEFAULT '0000-00-00',
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`customer_group_id` bigint(20) UNSIGNED NOT NULL,
	`customer_payment_term_id` bigint(20) UNSIGNED NOT NULL,
	`company` varchar(64) NOT NULL,
	`email` varchar(96) NOT NULL,
	`phone` varchar(32) NOT NULL,
	`in_store` tinyint(1) NOT NULL,
	`payment_first_name` varchar(64) NOT NULL,
	`payment_last_name` varchar(64) NOT NULL,
	`payment_company` varchar(64) NOT NULL,
	`payment_address_1` varchar(128) NOT NULL,
	`payment_address_2` varchar(128) NOT NULL,
	`payment_city` varchar(128) NOT NULL,
	`payment_postal_code` varchar(10) NOT NULL,
	`payment_country_id` bigint(20) UNSIGNED NOT NULL,
	`payment_zone_id` bigint(20) UNSIGNED NOT NULL,
	`payment_address_format` text NOT NULL,
	`shipping_first_name` varchar(64) NOT NULL,
	`shipping_last_name` varchar(64) NOT NULL,
	`shipping_company` varchar(64) NOT NULL,
	`shipping_address_1` varchar(128) NOT NULL,
	`shipping_address_2` varchar(128) NOT NULL,
	`shipping_city` varchar(128) NOT NULL,
	`shipping_postal_code` varchar(10) NOT NULL,
	`shipping_country_id` bigint(20) UNSIGNED NOT NULL,
	`shipping_destination_country_id` bigint(20) UNSIGNED NOT NULL,
	`shipping_zone_id` bigint(20) UNSIGNED NOT NULL,
	`shipping_address_format` text NOT NULL,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`ship_by_date` date NOT NULL DEFAULT '0000-00-00',
	`total` decimal(15,4) NOT NULL,
	`id` bigint(20) UNSIGNED NOT NULL,
	`order_status_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`sales_rep_id` bigint(20) UNSIGNED NOT NULL,
	`affiliate_id` bigint(20) UNSIGNED NOT NULL,
	`subid_1` varchar(255) NOT NULL,
	`subid_2` varchar(255) NOT NULL,
	`subid_3` varchar(255) NOT NULL,
	`subid_4` varchar(255) NOT NULL,
	`subid_5` varchar(255) NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`ip` varchar(40) NOT NULL,
	`forwarded_ip` varchar(40) NOT NULL,
	`user_agent` varchar(255) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `uuid` (`uuid`),
	KEY `site_id` (`site_id`),
	KEY `sales_channel_extension_code_sales_channel_status_site_id` (`sales_channel_extension_code`,`sales_channel_status`,`site_id`),
	KEY `ext_id_site_id` (`ext_id`,`site_id`),
	KEY `customer_id_created_time_site_id` (`customer_id`,`created_time`,`site_id`),
	KEY `customer_group_id_created_time_site_id` (`customer_group_id`,`created_time`,`site_id`),
	KEY `company_created_time_site_id` (`company`,`created_time`,`site_id`),
	KEY `email_created_time_site_id` (`email`,`created_time`,`site_id`),
	KEY `phone_created_time_site_id` (`phone`,`created_time`,`site_id`),
	KEY `payment_name_created_time_site_id` (`payment_first_name`,`payment_last_name`,`created_time`,`site_id`),
	KEY `payment_country_id_created_time_site_id` (`payment_country_id`,`created_time`,`site_id`),
	KEY `payment_zone_id_created_time_site_id` (`payment_zone_id`,`created_time`,`site_id`),
	KEY `shipping_country_id_created_time_site_id` (`shipping_country_id`,`created_time`,`site_id`),
	KEY `shipping_destination_country_id_created_time_site_id` (`shipping_destination_country_id`,`created_time`,`site_id`),
	KEY `shipping_zone_id_created_time_site_id` (`shipping_zone_id`,`created_time`,`site_id`),
	KEY `coupon_id_created_time_site_id` (`coupon_id`,`created_time`,`site_id`),
	KEY `order_status_id_created_time_site_id` (`order_status_id`,`created_time`,`site_id`),
	KEY `user_id_created_time_site_id` (`user_id`,`created_time`,`site_id`),
	KEY `sales_rep_id_created_time_site_id` (`sales_rep_id`,`created_time`,`site_id`),
	KEY `affiliate_id_created_time_site_id` (`affiliate_id`,`created_time`,`site_id`),
	KEY `ip_created_time_site_id` (`ip`,`created_time`,`site_id`),
	KEY `created_time_site_id` (`created_time`,`site_id`),
	KEY `invoice_date_customer_payment_term_id_site_id` (`invoice_date`,`customer_payment_term_id`,`site_id`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`order_status_id` bigint(20) UNSIGNED NOT NULL,
	`notify` tinyint(1) NOT NULL,
	`note` text NOT NULL,
	`pinned` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_id_created_time` (`order_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `order_status_id_created_time` (`order_status_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_products` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`ext_id` varchar(36) NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`model` varchar(64) NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`product_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`special_price` decimal(15,4),
	`option_price` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`price` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`total` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`discount` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`tax_group_id` bigint(20) UNSIGNED NOT NULL,
	`commissionable` tinyint(1) NOT NULL DEFAULT 1,
	`is_upsell` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_id` (`order_id`),
	KEY `product_id` (`product_id`),
	KEY `tax_group_id` (`tax_group_id`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_product_to_options` (
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`product_option_id` bigint(20) UNSIGNED NOT NULL,
	`product_option_value_id` bigint(20) UNSIGNED NOT NULL,
	`price` decimal(15,4) NOT NULL,
	`name` varchar(255) NOT NULL,
	`value` text NOT NULL,
	`type` varchar(32) NOT NULL,
	PRIMARY KEY (`order_product_id`,`product_option_id`,`product_option_value_id`),
	FOREIGN KEY (`order_product_id`) REFERENCES `order_products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_product_to_inventory_items` (
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	PRIMARY KEY (`order_product_id`,`inventory_item_id`),
	KEY `inventory_item_id` (`inventory_item_id`),
	FOREIGN KEY (`order_product_id`) REFERENCES `order_products`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_shipments` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`is_reship` tinyint(1) NOT NULL DEFAULT 0,
	`inventory_location_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_box_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`weight` decimal(15,8) NOT NULL DEFAULT 0.00000000,
	`shipping_method_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`tracking_number` varchar(255) NOT NULL DEFAULT '',
	`price` decimal(15,4) NOT NULL,
	`discount` decimal(15,4) NOT NULL,
	`tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`status` enum('pending','dispatched','canceled','shipped','undeliverable','delivered') NOT NULL DEFAULT 'pending',
	`deduct_inventory` tinyint(1) NOT NULL DEFAULT 0,
	`last_track_time` datetime NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_id_status` (`order_id`,`status`),
	KEY `is_reship_created_time` (`is_reship`,`created_time`),
	KEY `inventory_location_id_created_time` (`inventory_location_id`,`created_time`),
	KEY `inventory_box_id_created_time` (`inventory_box_id`,`created_time`),
	KEY `shipping_method_id_created_time` (`shipping_method_id`,`created_time`),
	KEY `tracking_number` (`tracking_number`),
	KEY `status_shipping_method_id_created_time` (`status`,`shipping_method_id`,`created_time`),
	KEY `status_inventory_location_id_created_time` (`status`,`inventory_location_id`,`created_time`),
	KEY `created_time` (`created_time`),
	KEY `status_tracking_number_last_track_time` (`status`,`tracking_number`,`last_track_time`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_shipment_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_shipment_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`status` enum('pending','dispatched','canceled','shipped','transit','undeliverable','delivered'),
	`notify` tinyint(1) NOT NULL,
	`note` text NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_shipment_id_created_time` (`order_shipment_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `status_created_time` (`status`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`order_shipment_id`) REFERENCES `order_shipments`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_shipment_to_inventory_items` (
	`order_shipment_id` bigint(20) UNSIGNED NOT NULL,
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`order_reship_reason_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	PRIMARY KEY (`order_shipment_id`,`order_product_id`,`inventory_item_id`,`order_reship_reason_id`),
	KEY `order_shipment_id_inventory_item_id_order_reship_reason_id` (`order_shipment_id`,`inventory_item_id`,`order_reship_reason_id`),
	KEY `order_product_id_inventory_item_id_order_reship_reason_id` (`order_product_id`,`inventory_item_id`,`order_reship_reason_id`),
	KEY `inventory_item_id_order_reship_reason_id` (`inventory_item_id`,`order_reship_reason_id`),
	KEY `order_reship_reason_id` (`order_reship_reason_id`),
	FOREIGN KEY (`order_shipment_id`) REFERENCES `order_shipments`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_totals` (
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`code` varchar(64) NOT NULL,
	`name` varchar(255) NOT NULL,
	`value` decimal(15,4) NOT NULL,
	`sort_order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	PRIMARY KEY (`order_id`,`code`),
	KEY `code` (`code`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_transactions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`transaction_id` varchar(255) NOT NULL,
	`reference_transaction_id` varchar(255) NOT NULL,
	`authorization_code` varchar(255) NOT NULL,
	`type` enum('sale','auth','refund','void','decline'),
	`order_transaction_refund_reason_id` bigint(20) UNSIGNED NOT NULL,
	`payment_method` varchar(128) NOT NULL,
	`payment_code` varchar(64) NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`meta_data` text NOT NULL,
	`note` text NOT NULL,
	`transaction_date` date NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_id_created_time` (`order_id`,`created_time`),
	KEY `user_id_created_time` (`user_id`,`created_time`),
	KEY `transaction_id` (`transaction_id`),
	KEY `reference_transaction_id` (`reference_transaction_id`),
	KEY `order_transaction_refund_reason_id` (`order_transaction_refund_reason_id`,`created_time`),
	KEY `type` (`type`,`created_time`),
	KEY `payment_method_created_time` (`payment_method`,`created_time`),
	KEY `payment_code_created_time` (`payment_code`,`created_time`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `order_vouchers` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`voucher_id` bigint(20) UNSIGNED NOT NULL,
	`order_transaction_id` bigint(20) UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	KEY `order_id` (`order_id`),
	KEY `voucher_id` (`voucher_id`),
	KEY `order_transaction_id` (`order_transaction_id`),
	FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`voucher_id`) REFERENCES `vouchers`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `subscriptions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`site_name` varchar(255) NOT NULL,
	`site_url` varchar(255) NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`product_id` bigint(20) UNSIGNED NOT NULL,
	`product_name` varchar(255) NOT NULL,
	`product_options` text NOT NULL,
	`product_quantity` mediumint(8) NOT NULL,
	`product_recurring_id` bigint(20) UNSIGNED NOT NULL,
	`recurring_name` varchar(255) NOT NULL,
	`recurring_description` varchar(255) NOT NULL,
	`recurring_price` decimal(15,4) NOT NULL,
	`recurring_frequency` enum('day','week','month','year') NOT NULL,
	`recurring_duration` smallint(6) UNSIGNED NOT NULL,
	`recurring_cycle` smallint(6) UNSIGNED NOT NULL,
	`trial_status` tinyint(1) NOT NULL,
	`trial_price` decimal(15,4) NOT NULL,
	`trial_frequency` enum('day','week','month','year') NOT NULL,
	`trial_duration` smallint(6) UNSIGNED NOT NULL,
	`trial_cycle` smallint(6) UNSIGNED NOT NULL,
	`payment_first_name` varchar(64) NOT NULL,
	`payment_last_name` varchar(64) NOT NULL,
	`payment_company` varchar(64) NOT NULL,
	`payment_address_1` varchar(128) NOT NULL,
	`payment_address_2` varchar(128) NOT NULL,
	`payment_city` varchar(128) NOT NULL,
	`payment_postal_code` varchar(10) NOT NULL,
	`payment_country` varchar(128) NOT NULL,
	`payment_country_id` bigint(20) UNSIGNED NOT NULL,
	`payment_zone` varchar(128) NOT NULL,
	`payment_zone_id` bigint(20) UNSIGNED NOT NULL,
	`payment_address_format` text NOT NULL,
	`payment_method` varchar(128) NOT NULL,
	`payment_code` varchar(64) NOT NULL,
	`shipping_first_name` varchar(64) NOT NULL,
	`shipping_last_name` varchar(64) NOT NULL,
	`shipping_company` varchar(64) NOT NULL,
	`shipping_address_1` varchar(128) NOT NULL,
	`shipping_address_2` varchar(128) NOT NULL,
	`shipping_city` varchar(128) NOT NULL,
	`shipping_postal_code` varchar(10) NOT NULL,
	`shipping_country` varchar(128) NOT NULL,
	`shipping_country_id` bigint(20) UNSIGNED NOT NULL,
	`shipping_zone` varchar(128) NOT NULL,
	`shipping_zone_id` bigint(20) UNSIGNED NOT NULL,
	`shipping_address_format` text NOT NULL,
	`coupon_id` bigint(20) UNSIGNED NOT NULL,
	`coupon_remaining` smallint(6) NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`meta_data` text NOT NULL,
	`next_recurring_date` date NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `product_recurring_id_site_id_created_time` (`product_recurring_id`,`site_id`,`created_time`),
	KEY `customer_id_status_site_id_created_time` (`customer_id`,`status`,`site_id`,`created_time`),
	KEY `payment_country_id_site_id_created_time` (`payment_country_id`,`site_id`,`created_time`),
	KEY `payment_zone_id_site_id_created_time` (`payment_zone_id`,`site_id`,`created_time`),
	KEY `payment_code_site_id_created_time` (`payment_code`,`site_id`,`created_time`),
	KEY `shipping_country_id_site_id_created_time` (`shipping_country_id`,`site_id`,`created_time`),
	KEY `shipping_zone_id_site_id_created_time` (`shipping_zone_id`,`site_id`,`created_time`),
	KEY `coupon_id_site_id_created_time` (`coupon_id`,`site_id`,`created_time`),
	KEY `currency_code_site_id_created_time` (`currency_code`,`site_id`,`created_time`),
	KEY `next_recurring_date_status_site_id` (`next_recurring_date`,`status`,`site_id`),
	KEY `created_time_site_id` (`created_time`,`site_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_actions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`new_refund_eligible` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_action_descriptions` (
	`return_action_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`return_action_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`return_action_id`) REFERENCES `return_actions`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_reasons` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_reason_descriptions` (
	`return_reason_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`return_reason_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`return_reason_id`) REFERENCES `return_reasons`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_statuses` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`reeligible` tinyint(1) NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_status_descriptions` (
	`return_status_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` text NOT NULL,
	PRIMARY KEY (`return_status_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`return_status_id`) REFERENCES `return_statuses`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `returns` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`first_name` varchar(64) NOT NULL,
	`last_name` varchar(64) NOT NULL,
	`email` varchar(96) NOT NULL,
	`phone` varchar(32) NOT NULL,
	`address_1` varchar(128) NOT NULL,
	`address_2` varchar(128) NOT NULL,
	`city` varchar(128) NOT NULL,
	`postal_code` varchar(10) NOT NULL,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone_id` bigint(20) UNSIGNED NOT NULL,
	`return_status_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`,`deleted`),
	KEY `customer_id` (`customer_id`,`deleted`),
	KEY `first_name` (`first_name`,`deleted`),
	KEY `last_name` (`last_name`,`deleted`),
	KEY `email` (`email`,`deleted`),
	KEY `phone` (`phone`,`deleted`),
	KEY `return_status_id` (`return_status_id`,`deleted`),
	KEY `user_id` (`user_id`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_inventory_items` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`return_id` bigint(20) UNSIGNED NOT NULL,
	`inventory_item_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL,
	`order_product_id` bigint(20) UNSIGNED NOT NULL,
	`quantity` mediumint(8) UNSIGNED NOT NULL,
	`return_reason_id` bigint(20) UNSIGNED NOT NULL,
	`return_action_id` bigint(20) UNSIGNED NOT NULL,
	PRIMARY KEY (`id`),
	KEY `return_id` (`return_id`,`inventory_item_id`,`order_id`,`order_product_id`),
	KEY `inventory_item_id` (`inventory_item_id`,`order_id`,`order_product_id`),
	KEY `order_id` (`order_id`,`order_product_id`),
	KEY `order_product_id` (`order_product_id`),
	KEY `return_reason_id` (`return_reason_id`),
	KEY `return_action_id` (`return_action_id`),
	FOREIGN KEY (`return_id`) REFERENCES `returns`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `return_notes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`return_id` bigint(20) UNSIGNED NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`return_status_id` bigint(20) UNSIGNED NOT NULL,
	`notify` tinyint(1) NOT NULL,
	`note` text NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `return_id_created_time` (`return_id`,`created_time`,`deleted`),
	KEY `user_id` (`user_id`,`created_time`,`deleted`),
	KEY `return_status_id_created_time` (`return_status_id`,`created_time`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`return_id`) REFERENCES `returns`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `retail_locations` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(64) NOT NULL,
	`phone_1` varchar(32) NOT NULL,
	`phone_2` varchar(32) NOT NULL,
	`address_1` varchar(128) NOT NULL,
	`address_2` varchar(128) NOT NULL,
	`city` varchar(128) NOT NULL,
	`postal_code` varchar(10) NOT NULL,
	`country_id` bigint(20) UNSIGNED NOT NULL,
	`zone_id` bigint(20) UNSIGNED NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	`location_latitude` decimal(9,6),
	`location_longitude` decimal(9,6),
	PRIMARY KEY (`id`),
	KEY `country_id` (`country_id`,`deleted`),
	KEY `zone_id` (`zone_id`,`deleted`),
	KEY `status` (`status`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_groups` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` varchar(255) NOT NULL,
	`for_site` tinyint(1) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_group_managed_user_groups` (
	`user_group_id` bigint(20) UNSIGNED NOT NULL,
	`managed_user_group_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`user_group_id`,`managed_user_group_id`),
	KEY `managed_user_group_id` (`managed_user_group_id`),
	FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`managed_user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_group_permissions` (
	`user_group_id` bigint(20) UNSIGNED NOT NULL,
	`route` varchar(64) NOT NULL,
	`permission` varchar(48) NOT NULL,
	PRIMARY KEY (`user_group_id`,`route`,`permission`),
	KEY `permission` (`permission`),
	FOREIGN KEY (`user_group_id`) REFERENCES `user_groups`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `users` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`first_name` varchar(64) NOT NULL,
	`last_name` varchar(64) NOT NULL,
	`email` varchar(96) NOT NULL,
	`phone` varchar(32) NOT NULL,
	`user_group_id` bigint(20) UNSIGNED NOT NULL,
	`password` varchar(255) NOT NULL,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `email` (`email`,`deleted`),
	KEY `user_group_id` (`user_group_id`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_factors` (
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`uuid` char(36) NOT NULL,
	`extension_code` varchar(64) NOT NULL,
	`method` varchar(32) NOT NULL,
	`sid` varchar(64) NOT NULL DEFAULT '',
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`user_id`),
	KEY `method_created_time` (`method`,`created_time`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `user_to_sites` (
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`user_group_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`user_id`,`site_id`),
	KEY `site_id` (`site_id`),
	KEY `user_group_id` (`user_group_id`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `sales_reps` (
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`parent_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`commission_group_id` bigint(20) UNSIGNED NOT NULL,
	`payout_extension_code` varchar(64) NOT NULL,
	`payout_data` text NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`user_id`),
	KEY `user_id_created_time` (`user_id`,`created_time`),
	KEY `parent_id` (`parent_id`),
	KEY `commission_group_id_created_time` (`commission_group_id`,`created_time`),
	KEY `payout_extension_code` (`payout_extension_code`),
	FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `sales_rep_paths` (
	`sales_rep_id` bigint(20) UNSIGNED NOT NULL,
	`path_id` bigint(20) UNSIGNED NOT NULL,
	`level` smallint(5) UNSIGNED NOT NULL,
	PRIMARY KEY (`sales_rep_id`,`path_id`),
	KEY `path_id` (`path_id`),
	FOREIGN KEY (`sales_rep_id`) REFERENCES `sales_reps`(`user_id`) ON DELETE CASCADE,
	FOREIGN KEY (`path_id`) REFERENCES `sales_reps`(`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `sales_rep_transactions` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`sales_rep_id` bigint(20) UNSIGNED NOT NULL,
	`order_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`sales_rep_payout_id` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`description` text NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `sales_rep_id_created_time` (`sales_rep_id`,`created_time`,`deleted`),
	KEY `order_id_sales_rep_id_created_time` (`order_id`,`sales_rep_id`,`created_time`,`deleted`),
	KEY `order_id_created_time` (`order_id`,`created_time`,`deleted`),
	KEY `user_id_created_time` (`user_id`,`created_time`,`deleted`),
	KEY `sales_rep_payout_id_created_time` (`sales_rep_payout_id`,`created_time`,`deleted`),
	KEY `currency_code_created_time` (`currency_code`,`created_time`),
	KEY `created_time` (`created_time`,`deleted`),
	FOREIGN KEY (`sales_rep_id`) REFERENCES `sales_reps`(`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `sales_rep_payouts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`extension_code` varchar(64) NOT NULL,
	`ext_id` varchar(255) NOT NULL,
	`amount` decimal(15,4) NOT NULL,
	`currency_code` varchar(3) NOT NULL,
	`currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	`status` varchar(64) NOT NULL,
	`complete` tinyint(1) NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `extension_code` (`extension_code`,`created_time`),
	KEY `ext_id` (`ext_id`),
	KEY `currency_code` (`ext_id`,`created_time`),
	KEY `status` (`status`,`created_time`),
	KEY `complete` (`complete`,`created_time`),
	KEY `user_id` (`user_id`,`created_time`),
	KEY `created_time` (`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `pages` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`parent_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `parent_id` (`parent_id`,`deleted`),
	KEY `deleted` (`deleted`),
	FOREIGN KEY (`site_id`) REFERENCES `sites`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `page_descriptions` (
	`page_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`description` longtext NOT NULL,
	`meta_title` varchar(255) NOT NULL,
	`meta_description` varchar(255) NOT NULL,
	`meta_keyword` varchar(255) NOT NULL,
	PRIMARY KEY (`page_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `page_paths` (
	`page_id` bigint(20) UNSIGNED NOT NULL,
	`path_id` bigint(20) UNSIGNED NOT NULL,
	`level` smallint(5) UNSIGNED NOT NULL,
	PRIMARY KEY (`page_id`,`path_id`),
	KEY `path_id` (`path_id`),
	FOREIGN KEY (`page_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`path_id`) REFERENCES `pages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `layouts` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`route` varchar(64) NOT NULL,
	`name` varchar(255) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id_route` (`site_id`,`route`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `layout_contents` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`layout_id` bigint(20) UNSIGNED NOT NULL,
	`type` varchar(64) NOT NULL,
	`content_id` bigint(20) UNSIGNED NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `layout_id` (`layout_id`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`layout_id`) REFERENCES `layouts`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `banners` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`route` varchar(64) NOT NULL,
	`name` varchar(255) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id_route` (`site_id`,`route`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `banner_images` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`banner_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`small_image_id` bigint(20) UNSIGNED NOT NULL,
	`url` varchar(255) NOT NULL,
	`sort_order` int(11) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `banner_id` (`banner_id`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`banner_id`) REFERENCES `banners`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_product_reviews` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`count` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `created_time` (`created_time`, `deleted`),
	KEY `site_id` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_product_review_descriptions` (
	`content_product_review_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`title` varchar(255)  NOT NULL,
	PRIMARY KEY (`content_product_review_id`, `language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`content_product_review_id`) REFERENCES `content_product_reviews` (`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_markups` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`items_per_row_lg` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`items_per_row_sm` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`scrolling_lg` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
	`scrolling_sm` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
	`status` tinyint(1) NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_markup_items` (
	`id`  bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`content_markup_id` bigint(20) UNSIGNED NOT NULL,
	`markup` text NOT NULL,
	`link` varchar(255) NOT NULL,
	`sort_order` int UNSIGNED NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `content_markup_id` (`content_markup_id`, `deleted`),
	FOREIGN KEY (`content_markup_id`) REFERENCES `content_markups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_090_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_markup_descriptions` (
	`content_markup_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`title` varchar(255) NOT NULL,
	PRIMARY KEY (`content_markup_id`, `language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`content_markup_id`) REFERENCES `content_markups` (`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_images` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`items_per_row_lg` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`items_per_row_sm` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`scrolling_lg` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
	`scrolling_sm` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_image_items` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`content_image_id` bigint(20) UNSIGNED NOT NULL,
	`image_id` bigint(20) UNSIGNED NOT NULL,
	`small_image_id` bigint(20) UNSIGNED NOT NULL,
	`url` varchar(255) NOT NULL,
	`sort_order` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	FOREIGN KEY (`content_image_id`) REFERENCES `content_images` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_image_descriptions` (
	`content_image_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`title` varchar(255) NOT NULL,
	PRIMARY KEY (`content_image_id`, `language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`content_image_id`) REFERENCES `content_images` (`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_products` (
	`id` bigint unsigned  NOT NULL AUTO_INCREMENT,
	`site_id` bigint unsigned  NOT NULL,
	`count` tinyint unsigned NOT NULL,
	`deleted` tinyint(1) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id` (`site_id`, `deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `content_product_descriptions` (
	`content_product_id` bigint unsigned NOT NULL,
	`language_id` bigint unsigned NOT NULL,
	`title` varchar(255) NOT NULL,
	PRIMARY KEY (`content_product_id`, `language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`content_product_id`) REFERENCES `content_products` (`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tiny_urls` (
	`code` char(7) NOT NULL,
	`customer_id` bigint(20) UNSIGNED NOT NULL,
	`name` varchar(255) NOT NULL,
	`url` varchar(255) NOT NULL,
	`clicks` bigint(20) NOT NULL,
	`last_click_time` datetime NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`code`),
	KEY `customer_id` (`customer_id`),
	KEY `name` (`name`)
	KEY `url` (`url`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tiny_url_clicks` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`tiny_url_code` char(7) NOT NULL,
	`tiny_url_weighted_url_id` bigint(20) UNSIGNED NOT NULL,
	`url` varchar(255) NOT NULL,
	`session_id` varchar(32) NOT NULL,
	`ip` varchar(40) NOT NULL,
	`forwarded_ip` varchar(40) NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `tiny_url_code_created_time_session_id` (`tiny_url_code`,`created_time`,`session_id`),
	KEY `tiny_url_weighted_url_id_created_time_session_id` (`tiny_url_weighted_url_id`,`created_time`,`session_id`),
	KEY `url_created_time_session_id` (`url`,`created_time`,`session_id`),
	KEY `session_id` (`session_id`,`created_time`),
	KEY `ip` (`ip`,`created_time`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`tiny_url_code`) REFERENCES `tiny_urls`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `tiny_url_weighted_urls` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`tiny_url_code` char(7) NOT NULL,
	`url` varchar(255) NOT NULL,
	`weight` tinyint(3) UNSIGNED NOT NULL,
	`clicks` bigint(20) NOT NULL,
	`last_click_time` datetime NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `tiny_url_code_weight` (`tiny_url_code`,`weight`),
	KEY `url` (`url`),
	KEY `created_time` (`created_time`),
	FOREIGN KEY (`tiny_url_code`) REFERENCES `tiny_urls`(`code`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `seo_routes` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`site_id` bigint(20) UNSIGNED NOT NULL,
	`route` varchar(64) NOT NULL,
	`deleted` tinyint(1) NOT NULL DEFAULT 0,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `site_id_route` (`site_id`,`route`,`deleted`),
	KEY `created_time` (`created_time`,`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `seo_route_descriptions` (
	`seo_route_id` bigint(20) UNSIGNED NOT NULL,
	`language_id` bigint(20) UNSIGNED NOT NULL,
	`meta_title` varchar(255) NOT NULL,
	`meta_description` varchar(255) NOT NULL,
	`meta_keyword` varchar(255) NOT NULL,
	PRIMARY KEY (`seo_route_id`,`language_id`),
	KEY `language_id` (`language_id`),
	FOREIGN KEY (`seo_route_id`) REFERENCES `seo_routes`(`id`) ON DELETE CASCADE,
	FOREIGN KEY (`language_id`) REFERENCES `languages`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `logs` (
	`id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
	`record_table` varchar(255) NOT NULL,
	`record_id` varchar(255) NOT NULL,
	`report_record_table` varchar(255) NOT NULL,
	`report_record_id` varchar(255) NOT NULL,
	`type` enum('read','write','modify','delete') NOT NULL,
	`sub_type` varchar(255) NOT NULL,
	`log` text NOT NULL,
	`user_id` bigint(20) UNSIGNED NOT NULL,
	`created_time` datetime NOT NULL,
	PRIMARY KEY (`id`),
	KEY `record_table_record_id_created_time` (`record_table`,`record_id`,`created_time`),
	KEY `report_record_table_report_record_id_created_time` (`report_record_table`,`report_record_id`,`created_time`),
	KEY `user_id_created_time` (`user_id`,`created_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;

CREATE TABLE `retail_location_contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `retail_location_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `image_id` bigint(20) unsigned NOT NULL,
  `contents` text NOT NULL,
  `link` varchar(2083) NOT NULL,
  `sort_order` int(10) unsigned NOT NULL DEFAULT '0',
  `deleted` tinyint(1) NOT NULL,
  `created_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

/* TODO */
/*
CREATE TABLE `mail_queue` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `to` varchar(255) NOT NULL,
  `from` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `html` text NOT NULL,
  `text` text NOT NULL,
  `created_time` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;
*/






CREATE TABLE `detailed_order_line_item_report` (
	`id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	`Store` varchar(255) NOT NULL DEFAULT '',
	`Customer Number` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`Customer Company` varchar(255) NOT NULL DEFAULT '',
	`Customer Name` varchar(255) NOT NULL DEFAULT '',
	`Sales Rep` varchar(255) NOT NULL DEFAULT '',
	`Order Year` smallint(4) UNSIGNED NOT NULL DEFAULT 0,
	`Order Month` tinyint(2) UNSIGNED NOT NULL DEFAULT 0,
	`Order Date` varchar(255) NOT NULL DEFAULT '',
	`Order Number` bigint(20) UNSIGNED NOT NULL DEFAULT 0,
	`Shipment Number` varchar(255) NOT NULL DEFAULT '',
	`Order Status` varchar(255) NOT NULL DEFAULT '',
	`Ship Date` date NOT NULL DEFAULT '0000-00-00',
	`Ship Tracking #` varchar(255) NOT NULL DEFAULT '',
	`Product Model` varchar(255) NOT NULL DEFAULT '',
	`Product Name` varchar(255) NOT NULL DEFAULT '',
	`SKU Number` varchar(255) NOT NULL DEFAULT '',
	`SKU Name` varchar(255) NOT NULL DEFAULT '',
	`Coupon Code` varchar(255) NOT NULL DEFAULT '',
	`Qty` mediumint(8) UNSIGNED NOT NULL DEFAULT 1,
	`Rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Qty * Rate` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Line Item Discount` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Line Item Shipping Protection` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Line Item Tax` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Line Item Total` decimal(15,4) NOT NULL DEFAULT '0.0000',
	`Currency Code` varchar(3) NOT NULL,
	`Currency Exchange Rate` decimal(15,8) NOT NULL DEFAULT '1.00000000',
	PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC;