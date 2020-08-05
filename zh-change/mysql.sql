CREATE DATABASE IF NOT EXISTS `oauth` DEFAULT CHARACTER SET = UTF8MB4;
USE `oauth`;

CREATE TABLE IF NOT EXISTS `hydra_client` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id` varchar(255) NOT NULL,
  `client_name` text NOT NULL,
  `client_secret` text NOT NULL,
  `redirect_uris` text NOT NULL,
  `grant_types` text NOT NULL,
  `response_types` text NOT NULL,
  `scope` text NOT NULL,
  `owner` text NOT NULL,
  `policy_uri` text NOT NULL,
  `tos_uri` text NOT NULL,
  `client_uri` text NOT NULL,
  `logo_uri` text NOT NULL,
  `contacts` text NOT NULL,
  `client_secret_expires_at` int(11) NOT NULL DEFAULT '0',
  `sector_identifier_uri` text NOT NULL,
  `jwks` text NOT NULL,
  `jwks_uri` text NOT NULL,
  `request_uris` text NOT NULL,
  `token_endpoint_auth_method` varchar(25) NOT NULL DEFAULT '',
  `request_object_signing_alg` varchar(10) NOT NULL DEFAULT '',
  `userinfo_signed_response_alg` varchar(10) NOT NULL DEFAULT '',
  `subject_type` varchar(15) NOT NULL DEFAULT '',
  `allowed_cors_origins` text NOT NULL,
  `audience` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `frontchannel_logout_uri` text NOT NULL,
  `frontchannel_logout_session_required` tinyint(1) NOT NULL DEFAULT '0',
  `post_logout_redirect_uris` text NOT NULL,
  `backchannel_logout_uri` text NOT NULL,
  `backchannel_logout_session_required` tinyint(1) NOT NULL DEFAULT '0',
  `metadata` text NOT NULL,
  `token_endpoint_auth_signing_alg` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`pk`),
  UNIQUE KEY `hydra_client_idx_id_uq` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE IF NOT EXISTS `hydra_jwk` (
  `pk` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sid` varchar(255) NOT NULL,
  `kid` varchar(255) NOT NULL,
  `version` int(11) NOT NULL DEFAULT '0',
  `keydata` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`pk`),
  UNIQUE KEY `hydra_jwk_idx_id_uq` (`sid`,`kid`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_access` (
  `signature` varchar(255) NOT NULL,
  `request_id` varchar(40) NOT NULL DEFAULT '',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `scope` text NOT NULL,
  `granted_scope` text NOT NULL,
  `form_data` text NOT NULL,
  `session_data` text NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `requested_audience` text NOT NULL,
  `granted_audience` text NOT NULL,
  `challenge_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`signature`),
  UNIQUE KEY `hydra_oauth2_access_request_id_idx` (`request_id`),
  KEY `hydra_oauth2_access_requested_at_idx` (`requested_at`),
  KEY `hydra_oauth2_access_client_id_idx` (`client_id`),
  KEY `hydra_oauth2_access_challenge_id_idx` (`challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_authentication_request` (
  `challenge` varchar(40) NOT NULL,
  `requested_scope` text NOT NULL,
  `verifier` varchar(40) NOT NULL,
  `csrf` varchar(40) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `request_url` text NOT NULL,
  `skip` tinyint(1) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `authenticated_at` timestamp NULL DEFAULT NULL,
  `oidc_context` text NOT NULL,
  `login_session_id` varchar(40),
  `requested_at_audience` text NOT NULL,
  PRIMARY KEY (`challenge`),
  UNIQUE KEY `hydra_oauth2_authentication_request_veri_idx` (`verifier`),
  KEY `hydra_oauth2_authentication_request_cid_idx` (`client_id`),
  KEY `hydra_oauth2_authentication_request_sub_idx` (`subject`),
  KEY `hydra_oauth2_authentication_request_login_session_id_idx` (`login_session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE  IF NOT EXISTS `hydra_oauth2_authentication_request_handled` (
  `challenge` varchar(40) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `remember` tinyint(1) NOT NULL,
  `remember_for` int(11) NOT NULL,
  `error` text NOT NULL,
  `acr` text NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `authenticated_at` timestamp NULL DEFAULT NULL,
  `was_used` tinyint(1) NOT NULL,
  `forced_subject_identifier` varchar(255) DEFAULT '',
  `context` text NOT NULL,
  PRIMARY KEY (`challenge`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_authentication_session` (
  `id` varchar(40) NOT NULL,
  `authenticated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `subject` varchar(255) NOT NULL,
  `remember` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `hydra_oauth2_authentication_session_sub_idx` (`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_code` (
  `signature` varchar(255) NOT NULL,
  `request_id` varchar(40) NOT NULL DEFAULT '',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `scope` text NOT NULL,
  `granted_scope` text NOT NULL,
  `form_data` text NOT NULL,
  `session_data` text NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `requested_audience` text NOT NULL,
  `granted_audience` text NOT NULL,
  `challenge_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`signature`),
  KEY `hydra_oauth2_code_client_id_idx` (`client_id`),
  KEY `hydra_oauth2_code_challenge_id_idx` (`challenge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_consent_request` (
  `challenge` varchar(40) NOT NULL,
  `verifier` varchar(40) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `request_url` text NOT NULL,
  `skip` tinyint(1) NOT NULL,
  `requested_scope` text NOT NULL,
  `csrf` varchar(40) NOT NULL,
  `authenticated_at` timestamp NULL DEFAULT NULL,
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `oidc_context` text NOT NULL,
  `forced_subject_identifier` varchar(255) DEFAULT '',
  `login_session_id` varchar(40),
  `login_challenge` varchar(40),
  `requested_at_audience` text NOT NULL,
  `acr` text NOT NULL,
  `context` text NOT NULL,
  PRIMARY KEY (`challenge`),
  UNIQUE KEY `hydra_oauth2_consent_request_veri_idx` (`verifier`),
  KEY `hydra_oauth2_consent_request_cid_idx` (`client_id`),
  KEY `hydra_oauth2_consent_request_sub_idx` (`subject`),
  KEY `hydra_oauth2_consent_request_login_session_id_idx` (`login_session_id`),
  KEY `hydra_oauth2_consent_request_login_challenge_idx` (`login_challenge`),
  KEY `hydra_oauth2_consent_request_client_id_subject_idx` (`client_id`,`subject`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_consent_request_handled` (
  `challenge` varchar(40) NOT NULL,
  `granted_scope` text NOT NULL,
  `remember` tinyint(1) NOT NULL,
  `remember_for` int(11) NOT NULL,
  `error` text NOT NULL,
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `session_access_token` text NOT NULL,
  `session_id_token` text NOT NULL,
  `authenticated_at` timestamp NULL DEFAULT NULL,
  `was_used` tinyint(1) NOT NULL,
  `granted_at_audience` text NOT NULL,
  `handled_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`challenge`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_jti_blacklist` (
  `signature` varchar(64) NOT NULL,
  `expires_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`signature`),
  KEY `hydra_oauth2_jti_blacklist_expiry` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


CREATE TABLE `hydra_oauth2_logout_request` (
  `challenge` varchar(36) NOT NULL,
  `verifier` varchar(36) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `sid` varchar(36) NOT NULL,
  `client_id` varchar(255) DEFAULT NULL,
  `request_url` text NOT NULL,
  `redir_url` text NOT NULL,
  `was_used` tinyint(1) NOT NULL DEFAULT '0',
  `accepted` tinyint(1) NOT NULL DEFAULT '0',
  `rejected` tinyint(1) NOT NULL DEFAULT '0',
  `rp_initiated` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`challenge`),
  UNIQUE KEY `hydra_oauth2_logout_request_veri_idx` (`verifier`),
  KEY `hydra_oauth2_logout_request_client_id_idx` (`client_id`),
  CONSTRAINT `hydra_oauth2_logout_request_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_obfuscated_authentication_session` (
  `subject` varchar(255) NOT NULL,
  `client_id` varchar(255) NOT NULL,
  `subject_obfuscated` varchar(255) NOT NULL,
  PRIMARY KEY (`subject`,`client_id`),
  UNIQUE KEY `hydra_oauth2_obfuscated_authentication_session_so_idx` (`client_id`,`subject_obfuscated`),
  CONSTRAINT `hydra_oauth2_obfuscated_authentication_session_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_oidc` (
  `signature` varchar(255) NOT NULL,
  `request_id` varchar(40) NOT NULL DEFAULT '',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `scope` text NOT NULL,
  `granted_scope` text NOT NULL,
  `form_data` text NOT NULL,
  `session_data` text NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `requested_audience` text NOT NULL,
  `granted_audience` text NOT NULL,
  `challenge_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`signature`),
  KEY `hydra_oauth2_oidc_client_id_idx` (`client_id`),
  KEY `hydra_oauth2_oidc_challenge_id_idx` (`challenge_id`),
  CONSTRAINT `hydra_oauth2_oidc_challenge_id_fk` FOREIGN KEY (`challenge_id`) REFERENCES `hydra_oauth2_consent_request_handled` (`challenge`) ON DELETE CASCADE,
  CONSTRAINT `hydra_oauth2_oidc_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_pkce` (
  `signature` varchar(255) NOT NULL,
  `request_id` varchar(40) NOT NULL DEFAULT '',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `scope` text NOT NULL,
  `granted_scope` text NOT NULL,
  `form_data` text NOT NULL,
  `session_data` text NOT NULL,
  `subject` varchar(255) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `requested_audience` text NOT NULL,
  `granted_audience` text NOT NULL,
  `challenge_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`signature`),
  KEY `hydra_oauth2_pkce_client_id_idx` (`client_id`),
  KEY `hydra_oauth2_pkce_challenge_id_idx` (`challenge_id`),
  CONSTRAINT `hydra_oauth2_pkce_challenge_id_fk` FOREIGN KEY (`challenge_id`) REFERENCES `hydra_oauth2_consent_request_handled` (`challenge`) ON DELETE CASCADE,
  CONSTRAINT `hydra_oauth2_pkce_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;

CREATE TABLE IF NOT EXISTS `hydra_oauth2_refresh` (
  `signature` varchar(255) NOT NULL,
  `request_id` varchar(40) NOT NULL DEFAULT '',
  `requested_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `client_id` varchar(255) NOT NULL DEFAULT '',
  `scope` text NOT NULL,
  `granted_scope` text NOT NULL,
  `form_data` text NOT NULL,
  `session_data` text NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `requested_audience` text NOT NULL,
  `granted_audience` text NOT NULL,
  `challenge_id` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`signature`),
  UNIQUE KEY `hydra_oauth2_refresh_request_id_idx` (`request_id`),
  KEY `hydra_oauth2_refresh_client_id_idx` (`client_id`),
  KEY `hydra_oauth2_refresh_challenge_id_idx` (`challenge_id`),
  CONSTRAINT `hydra_oauth2_refresh_challenge_id_fk` FOREIGN KEY (`challenge_id`) REFERENCES `hydra_oauth2_consent_request_handled` (`challenge`) ON DELETE CASCADE,
  CONSTRAINT `hydra_oauth2_refresh_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=UTF8MB4;


DROP PROCEDURE IF EXISTS check_index;

DELIMITER // 
CREATE PROCEDURE check_index() 
BEGIN
  DECLARE dbName varchar(256);
  SELECT DATABASE() INTO dbName;
  -- constraints
  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_access' AND CONSTRAINT_NAME= 'hydra_oauth2_access_challenge_id_fk') THEN
    ALTER TABLE `hydra_oauth2_access` ADD CONSTRAINT `hydra_oauth2_access_challenge_id_fk` FOREIGN KEY (`challenge_id`) REFERENCES `hydra_oauth2_consent_request_handled` (`challenge`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_access' AND CONSTRAINT_NAME= 'hydra_oauth2_access_client_id_fk') THEN
    ALTER TABLE `hydra_oauth2_access` ADD CONSTRAINT `hydra_oauth2_access_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_authentication_request' AND CONSTRAINT_NAME= 'hydra_oauth2_authentication_request_client_id_fk') THEN
    ALTER TABLE `hydra_oauth2_authentication_request` ADD CONSTRAINT `hydra_oauth2_authentication_request_client_id_fk` FOREIGN KEY  (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_authentication_request' AND CONSTRAINT_NAME= 'hydra_oauth2_authentication_request_login_session_id_fk') THEN
    ALTER TABLE `hydra_oauth2_authentication_request` ADD CONSTRAINT `hydra_oauth2_authentication_request_login_session_id_fk` FOREIGN KEY (`login_session_id`) REFERENCES `hydra_oauth2_authentication_session` (`id`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_authentication_request_handled' AND CONSTRAINT_NAME= 'hydra_oauth2_authentication_request_handled_challenge_fk') THEN
    ALTER TABLE `hydra_oauth2_authentication_request` ADD CONSTRAINT `hydra_oauth2_authentication_request_handled_challenge_fk` FOREIGN KEY (`challenge`) REFERENCES `hydra_oauth2_authentication_request` (`challenge`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_code' AND CONSTRAINT_NAME= 'hydra_oauth2_code_challenge_id_fk') THEN
    ALTER TABLE `hydra_oauth2_code` ADD  CONSTRAINT `hydra_oauth2_code_challenge_id_fk` FOREIGN KEY (`challenge_id`) REFERENCES `hydra_oauth2_consent_request_handled` (`challenge`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_code' AND CONSTRAINT_NAME= 'hydra_oauth2_code_client_id_fk') THEN
    ALTER TABLE `hydra_oauth2_code` ADD CONSTRAINT `hydra_oauth2_code_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE;
  END IF;


  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_consent_request' AND CONSTRAINT_NAME= 'hydra_oauth2_consent_request_client_id_fk') THEN
    ALTER TABLE `hydra_oauth2_consent_request` ADD CONSTRAINT `hydra_oauth2_consent_request_client_id_fk` FOREIGN KEY (`client_id`) REFERENCES `hydra_client` (`id`) ON DELETE CASCADE;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_consent_request' AND CONSTRAINT_NAME= 'hydra_oauth2_consent_request_login_challenge_fk') THEN
    ALTER TABLE `hydra_oauth2_consent_request` ADD CONSTRAINT `hydra_oauth2_consent_request_login_challenge_fk` FOREIGN KEY (`login_challenge`) REFERENCES `hydra_oauth2_authentication_request` (`challenge`) ON DELETE SET NULL;
  END IF;

  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_consent_request' AND CONSTRAINT_NAME= 'hydra_oauth2_consent_request_login_session_id_fk') THEN
    ALTER TABLE `hydra_oauth2_consent_request` ADD CONSTRAINT `hydra_oauth2_consent_request_login_session_id_fk` FOREIGN KEY (`login_session_id`) REFERENCES `hydra_oauth2_authentication_session` (`id`) ON DELETE SET NULL;
  END IF;


  IF NOT EXISTS(SELECT * FROM information_schema.TABLE_CONSTRAINTS WHERE TABLE_SCHEMA=dbName AND TABLE_NAME = 'hydra_oauth2_consent_request_handled' AND CONSTRAINT_NAME= 'hydra_oauth2_consent_request_handled_challenge_fk') THEN
    ALTER TABLE `hydra_oauth2_consent_request_handled` ADD CONSTRAINT `hydra_oauth2_consent_request_handled_challenge_fk` FOREIGN KEY (`challenge`) REFERENCES `hydra_oauth2_consent_request` (`challenge`) ON DELETE CASCADE;
  END IF;
END;//

DELIMITER ;

-- call and drop----------------------------------------------------
CALL check_index();
DROP PROCEDURE check_index;