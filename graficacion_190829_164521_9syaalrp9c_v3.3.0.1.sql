-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: database    Database: craft
-- ------------------------------------------------------
-- Server version	10.4.7-MariaDB-1:10.4.7+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `craft_assetindexdata`
--

DROP TABLE IF EXISTS `craft_assetindexdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT 0,
  `completed` tinyint(1) DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `craft_assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assets`
--

DROP TABLE IF EXISTS `craft_assets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `deletedWithVolume` tinyint(1) DEFAULT NULL,
  `keptFile` tinyint(1) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assets_filename_folderId_idx` (`filename`,`folderId`),
  KEY `craft_assets_folderId_idx` (`folderId`),
  KEY `craft_assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransformindex`
--

DROP TABLE IF EXISTS `craft_assettransformindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT 0,
  `inProgress` tinyint(1) NOT NULL DEFAULT 0,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_assettransforms`
--

DROP TABLE IF EXISTS `craft_assettransforms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `interlace` enum('none','line','plane','partition') NOT NULL DEFAULT 'none',
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categories`
--

DROP TABLE IF EXISTS `craft_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_idx` (`groupId`),
  KEY `craft_categories_parentId_fk` (`parentId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups`
--

DROP TABLE IF EXISTS `craft_categorygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categorygroups_name_idx` (`name`),
  KEY `craft_categorygroups_handle_idx` (`handle`),
  KEY `craft_categorygroups_structureId_idx` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_categorygroups_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_categorygroups_sites`
--

DROP TABLE IF EXISTS `craft_categorygroups_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `craft_categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_content`
--

DROP TABLE IF EXISTS `craft_content`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_content_siteId_idx` (`siteId`),
  KEY `craft_content_title_idx` (`title`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_craftidtokens`
--

DROP TABLE IF EXISTS `craft_craftidtokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_craftidtokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `accessToken` text NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_craftidtokens_userId_fk` (`userId`),
  CONSTRAINT `craft_craftidtokens_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_deprecationerrors`
--

DROP TABLE IF EXISTS `craft_deprecationerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_drafts`
--

DROP TABLE IF EXISTS `craft_drafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_drafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) DEFAULT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_drafts_sourceId_fk` (`sourceId`),
  KEY `craft_drafts_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_drafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_drafts_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elementindexsettings`
--

DROP TABLE IF EXISTS `craft_elementindexsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements`
--

DROP TABLE IF EXISTS `craft_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `revisionId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `archived` tinyint(1) NOT NULL DEFAULT 0,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  KEY `craft_elements_draftId_fk` (`draftId`),
  KEY `craft_elements_revisionId_fk` (`revisionId`),
  CONSTRAINT `craft_elements_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_drafts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_elements_revisionId_fk` FOREIGN KEY (`revisionId`) REFERENCES `craft_revisions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_elements_sites`
--

DROP TABLE IF EXISTS `craft_elements_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `craft_elements_sites_siteId_idx` (`siteId`),
  KEY `craft_elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `craft_elements_sites_enabled_idx` (`enabled`),
  KEY `craft_elements_sites_uri_siteId_idx` (`uri`,`siteId`),
  CONSTRAINT `craft_elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entries`
--

DROP TABLE IF EXISTS `craft_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `deletedWithEntryType` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_idx` (`authorId`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_parentId_fk` (`parentId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_entries` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafterrors`
--

DROP TABLE IF EXISTS `craft_entrydrafterrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafterrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `draftId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafterrors_draftId_fk` (`draftId`),
  CONSTRAINT `craft_entrydrafterrors_draftId_fk` FOREIGN KEY (`draftId`) REFERENCES `craft_entrydrafts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrydrafts`
--

DROP TABLE IF EXISTS `craft_entrydrafts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_sectionId_idx` (`sectionId`),
  KEY `craft_entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entrydrafts_siteId_idx` (`siteId`),
  KEY `craft_entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entrytypes`
--

DROP TABLE IF EXISTS `craft_entrytypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT 1,
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrytypes_name_sectionId_idx` (`name`,`sectionId`),
  KEY `craft_entrytypes_handle_sectionId_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_idx` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_entrytypes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversionerrors`
--

DROP TABLE IF EXISTS `craft_entryversionerrors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversionerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `versionId` int(11) DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_entryversionerrors_versionId_fk` (`versionId`),
  CONSTRAINT `craft_entryversionerrors_versionId_fk` FOREIGN KEY (`versionId`) REFERENCES `craft_entryversions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_entryversions`
--

DROP TABLE IF EXISTS `craft_entryversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text DEFAULT NULL,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_sectionId_idx` (`sectionId`),
  KEY `craft_entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `craft_entryversions_siteId_idx` (`siteId`),
  KEY `craft_entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldgroups`
--

DROP TABLE IF EXISTS `craft_fieldgroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayoutfields`
--

DROP TABLE IF EXISTS `craft_fieldlayoutfields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouts`
--

DROP TABLE IF EXISTS `craft_fieldlayouts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fieldlayouttabs`
--

DROP TABLE IF EXISTS `craft_fieldlayouttabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_fields`
--

DROP TABLE IF EXISTS `craft_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text DEFAULT NULL,
  `searchable` tinyint(1) NOT NULL DEFAULT 1,
  `translationMethod` varchar(255) NOT NULL DEFAULT 'none',
  `translationKeyFormat` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `settings` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_groupId_idx` (`groupId`),
  KEY `craft_fields_context_idx` (`context`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_globalsets`
--

DROP TABLE IF EXISTS `craft_globalsets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_globalsets_name_idx` (`name`),
  KEY `craft_globalsets_handle_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_gqlschemas`
--

DROP TABLE IF EXISTS `craft_gqlschemas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_gqlschemas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `accessToken` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `expiryDate` datetime DEFAULT NULL,
  `lastUsed` datetime DEFAULT NULL,
  `scope` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_gqlschemas_accessToken_unq_idx` (`accessToken`),
  UNIQUE KEY `craft_gqlschemas_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_info`
--

DROP TABLE IF EXISTS `craft_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `maintenance` tinyint(1) NOT NULL DEFAULT 0,
  `config` mediumtext DEFAULT NULL,
  `configMap` mediumtext DEFAULT NULL,
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocks`
--

DROP TABLE IF EXISTS `craft_matrixblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `deletedWithOwner` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_matrixblocktypes`
--

DROP TABLE IF EXISTS `craft_matrixblocktypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_migrations`
--

DROP TABLE IF EXISTS `craft_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_migrations_pluginId_idx` (`pluginId`),
  KEY `craft_migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=159 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_plugins`
--

DROP TABLE IF EXISTS `craft_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','astray','unknown') NOT NULL DEFAULT 'unknown',
  `licensedEdition` varchar(255) DEFAULT NULL,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_queue`
--

DROP TABLE IF EXISTS `craft_queue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_queue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` longblob NOT NULL,
  `description` text DEFAULT NULL,
  `timePushed` int(11) NOT NULL,
  `ttr` int(11) NOT NULL,
  `delay` int(11) NOT NULL DEFAULT 0,
  `priority` int(11) unsigned NOT NULL DEFAULT 1024,
  `dateReserved` datetime DEFAULT NULL,
  `timeUpdated` int(11) DEFAULT NULL,
  `progress` smallint(6) NOT NULL DEFAULT 0,
  `progressLabel` varchar(255) DEFAULT NULL,
  `attempt` int(11) DEFAULT NULL,
  `fail` tinyint(1) DEFAULT 0,
  `dateFailed` datetime DEFAULT NULL,
  `error` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_queue_fail_timeUpdated_timePushed_idx` (`fail`,`timeUpdated`,`timePushed`),
  KEY `craft_queue_fail_timeUpdated_delay_idx` (`fail`,`timeUpdated`,`delay`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_relations`
--

DROP TABLE IF EXISTS `craft_relations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `craft_relations_sourceId_idx` (`sourceId`),
  KEY `craft_relations_targetId_idx` (`targetId`),
  KEY `craft_relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_resourcepaths`
--

DROP TABLE IF EXISTS `craft_resourcepaths`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_resourcepaths` (
  `hash` varchar(255) NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_revisions`
--

DROP TABLE IF EXISTS `craft_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_revisions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sourceId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `num` int(11) NOT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_revisions_sourceId_num_unq_idx` (`sourceId`,`num`),
  KEY `craft_revisions_creatorId_fk` (`creatorId`),
  CONSTRAINT `craft_revisions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_revisions_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_searchindex`
--

DROP TABLE IF EXISTS `craft_searchindex`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections`
--

DROP TABLE IF EXISTS `craft_sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT 0,
  `propagationMethod` varchar(255) NOT NULL DEFAULT 'all',
  `previewTargets` text DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sections_handle_idx` (`handle`),
  KEY `craft_sections_name_idx` (`name`),
  KEY `craft_sections_structureId_idx` (`structureId`),
  KEY `craft_sections_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sections_sites`
--

DROP TABLE IF EXISTS `craft_sections_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `uriFormat` text DEFAULT NULL,
  `template` varchar(500) DEFAULT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `craft_sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `craft_sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sequences`
--

DROP TABLE IF EXISTS `craft_sequences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sequences` (
  `name` varchar(255) NOT NULL,
  `next` int(11) unsigned NOT NULL DEFAULT 1,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sessions`
--

DROP TABLE IF EXISTS `craft_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_idx` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_shunnedmessages`
--

DROP TABLE IF EXISTS `craft_shunnedmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sitegroups`
--

DROP TABLE IF EXISTS `craft_sitegroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sitegroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sitegroups_name_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_sites`
--

DROP TABLE IF EXISTS `craft_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 0,
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sites_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_sites_handle_idx` (`handle`),
  KEY `craft_sites_sortOrder_idx` (`sortOrder`),
  KEY `craft_sites_groupId_fk` (`groupId`),
  CONSTRAINT `craft_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_sitegroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structureelements`
--

DROP TABLE IF EXISTS `craft_structureelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_structures`
--

DROP TABLE IF EXISTS `craft_structures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_structures_dateDeleted_idx` (`dateDeleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_systemmessages`
--

DROP TABLE IF EXISTS `craft_systemmessages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `craft_systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_taggroups`
--

DROP TABLE IF EXISTS `craft_taggroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_taggroups_name_idx` (`name`),
  KEY `craft_taggroups_handle_idx` (`handle`),
  KEY `craft_taggroups_dateDeleted_idx` (`dateDeleted`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tags`
--

DROP TABLE IF EXISTS `craft_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `deletedWithGroup` tinyint(1) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecacheelements`
--

DROP TABLE IF EXISTS `craft_templatecacheelements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecachequeries`
--

DROP TABLE IF EXISTS `craft_templatecachequeries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `craft_templatecachequeries_type_idx` (`type`),
  CONSTRAINT `craft_templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_templatecaches`
--

DROP TABLE IF EXISTS `craft_templatecaches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_path_idx` (`cacheKey`,`siteId`,`expiryDate`,`path`),
  KEY `craft_templatecaches_cacheKey_siteId_expiryDate_idx` (`cacheKey`,`siteId`,`expiryDate`),
  KEY `craft_templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `craft_templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `craft_sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_tokens`
--

DROP TABLE IF EXISTS `craft_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text DEFAULT NULL,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups`
--

DROP TABLE IF EXISTS `craft_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_usergroups_users`
--

DROP TABLE IF EXISTS `craft_usergroups_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions`
--

DROP TABLE IF EXISTS `craft_userpermissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

DROP TABLE IF EXISTS `craft_userpermissions_usergroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpermissions_users`
--

DROP TABLE IF EXISTS `craft_userpermissions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_userpreferences`
--

DROP TABLE IF EXISTS `craft_userpreferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text DEFAULT NULL,
  PRIMARY KEY (`userId`),
  CONSTRAINT `craft_userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_users`
--

DROP TABLE IF EXISTS `craft_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT 0,
  `locked` tinyint(1) NOT NULL DEFAULT 0,
  `suspended` tinyint(1) NOT NULL DEFAULT 0,
  `pending` tinyint(1) NOT NULL DEFAULT 0,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(3) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `hasDashboard` tinyint(1) NOT NULL DEFAULT 0,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT 0,
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_email_idx` (`email`),
  KEY `craft_users_username_idx` (`username`),
  KEY `craft_users_photoId_fk` (`photoId`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `craft_assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumefolders`
--

DROP TABLE IF EXISTS `craft_volumefolders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `craft_volumefolders_parentId_idx` (`parentId`),
  KEY `craft_volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `craft_volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `craft_volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_volumes`
--

DROP TABLE IF EXISTS `craft_volumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT 1,
  `url` varchar(255) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `dateDeleted` datetime DEFAULT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_volumes_name_idx` (`name`),
  KEY `craft_volumes_handle_idx` (`handle`),
  KEY `craft_volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `craft_volumes_dateDeleted_idx` (`dateDeleted`),
  CONSTRAINT `craft_volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `craft_widgets`
--

DROP TABLE IF EXISTS `craft_widgets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(3) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_idx` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-29 16:45:21
-- MySQL dump 10.17  Distrib 10.3.15-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: database    Database: craft
-- ------------------------------------------------------
-- Server version	10.4.7-MariaDB-1:10.4.7+maria~bionic

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `craft_assets`
--

LOCK TABLES `craft_assets` WRITE;
/*!40000 ALTER TABLE `craft_assets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_assets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_categorygroups_sites`
--

LOCK TABLES `craft_categorygroups_sites` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_sites` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_content` VALUES (1,1,1,NULL,'2019-08-29 15:34:40','2019-08-29 15:34:40','1a20628c-ac25-4bc0-9d4b-41af83b3bab8'),(3,3,1,'SPA: Single Page Application','2019-08-29 16:05:52','2019-08-29 16:05:52','7dbe0baf-6bbd-4cb2-aaf9-3b2f9d107a8c'),(4,4,1,'SPA: Single Page Application','2019-08-29 16:05:52','2019-08-29 16:05:52','01a7f281-f869-476e-bdfe-b1d515afa0f0'),(5,5,1,'Contacto','2019-08-29 16:12:55','2019-08-29 16:12:56','33eda97b-08c5-40ad-a756-92713b1de43c'),(6,6,1,'Contacto','2019-08-29 16:12:55','2019-08-29 16:12:55','6ea26b92-0ceb-45e5-8c7e-7b7755aac70d'),(7,7,1,'Entrada de Prueba','2019-08-29 16:23:14','2019-08-29 16:23:34','6ba0a47c-26b3-4f59-8331-cc15e92e3aa0');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_craftidtokens`
--

LOCK TABLES `craft_craftidtokens` WRITE;
/*!40000 ALTER TABLE `craft_craftidtokens` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_craftidtokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_drafts`
--

LOCK TABLES `craft_drafts` WRITE;
/*!40000 ALTER TABLE `craft_drafts` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_drafts` VALUES (2,NULL,1,'First draft','hola esto es una prueba');
/*!40000 ALTER TABLE `craft_drafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements` VALUES (1,NULL,NULL,NULL,'craft\\elements\\User',1,0,'2019-08-29 15:34:40','2019-08-29 15:34:40',NULL,'f3fe58fc-f3af-4fb3-a67c-46d4dadd19a1'),(3,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-08-29 16:04:38','2019-08-29 16:05:52',NULL,'ee8b1d73-a2e8-4916-bfca-7bb43d51e3e2'),(4,NULL,1,NULL,'craft\\elements\\Entry',1,0,'2019-08-29 16:05:52','2019-08-29 16:05:52',NULL,'c1c66aa8-9707-4c72-bad7-6748bcfbfa39'),(5,NULL,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-08-29 16:12:55','2019-08-29 16:12:55',NULL,'f98dc535-3c60-4731-8549-9e351012be0e'),(6,NULL,2,NULL,'craft\\elements\\Entry',1,0,'2019-08-29 16:12:55','2019-08-29 16:12:55',NULL,'c764891e-8ee1-4696-9e0f-2b1046213cf7'),(7,2,NULL,NULL,'craft\\elements\\Entry',1,0,'2019-08-29 16:23:14','2019-08-29 16:23:34',NULL,'836854be-02a1-425c-82cd-1d63d183d637');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_elements_sites`
--

LOCK TABLES `craft_elements_sites` WRITE;
/*!40000 ALTER TABLE `craft_elements_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_elements_sites` VALUES (1,1,1,NULL,NULL,1,'2019-08-29 15:34:40','2019-08-29 15:34:40','3ad42299-43ad-4d20-922d-868fac245df3'),(3,3,1,'spa-single-page-application','blog/spa-single-page-application',1,'2019-08-29 16:05:52','2019-08-29 16:05:52','04ff370a-93cc-451e-9834-7888c5f3ad95'),(4,4,1,'spa-single-page-application','blog/spa-single-page-application',1,'2019-08-29 16:05:52','2019-08-29 16:05:52','5615272f-9a4c-402e-bd57-0f21a07d4e30'),(5,5,1,'contacto','__home__',1,'2019-08-29 16:12:55','2019-08-29 16:12:55','70f4ee34-424e-4cba-b1d0-9f67df9030ed'),(6,6,1,'contacto','__home__',1,'2019-08-29 16:12:55','2019-08-29 16:12:55','84451af3-8ac8-44d2-8b25-ee2178e859e4'),(7,7,1,'entrada-de-prueba','blog/__temp_p03w6cOVs7qyKzBYBpO34tnwQROuGwEZXtBZ',1,'2019-08-29 16:23:14','2019-08-29 16:23:25','e5dd1cc7-d3f0-4020-a66d-7c0c03e16f9e');
/*!40000 ALTER TABLE `craft_elements_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entries` VALUES (3,1,NULL,1,1,'2019-08-29 16:04:00',NULL,NULL,'2019-08-29 16:05:52','2019-08-29 16:05:52','90136c0c-98c7-4120-bae8-355a0f57edc1'),(4,1,NULL,1,1,'2019-08-29 16:04:00',NULL,NULL,'2019-08-29 16:05:52','2019-08-29 16:05:52','97cafd8a-5866-4d59-88dd-b8e0ca4a3485'),(5,2,NULL,2,NULL,'2019-08-29 16:12:00',NULL,NULL,'2019-08-29 16:12:55','2019-08-29 16:12:55','dad22025-6c9e-4e1e-8eb3-14d89323fda7'),(6,2,NULL,2,NULL,'2019-08-29 16:12:00',NULL,NULL,'2019-08-29 16:12:55','2019-08-29 16:12:55','d8299ad6-6891-454a-9569-293985f7a4ad'),(7,1,NULL,1,1,'2019-08-29 16:23:00',NULL,NULL,'2019-08-29 16:23:14','2019-08-29 16:23:14','33c2807f-ea25-4594-97fe-454a9735c7cf');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafterrors`
--

LOCK TABLES `craft_entrydrafterrors` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafterrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafterrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_entrytypes` VALUES (1,1,NULL,'Blog','blog',1,'Título',NULL,1,'2019-08-29 16:04:19','2019-08-29 16:04:19',NULL,'01ab59c0-5073-4719-89e6-f8387ba9f6c0'),(2,2,NULL,'Contacto','contacto',0,NULL,'{section.name|raw}',1,'2019-08-29 16:12:55','2019-08-29 16:12:55',NULL,'9adf5666-3a70-48c0-959f-97afabd84924');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversionerrors`
--

LOCK TABLES `craft_entryversionerrors` WRITE;
/*!40000 ALTER TABLE `craft_entryversionerrors` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entryversionerrors` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_fieldgroups` VALUES (1,'Common','2019-08-29 15:34:40','2019-08-29 15:34:40','231f77ea-4e95-403c-b766-6436e643879f');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_gqlschemas`
--

LOCK TABLES `craft_gqlschemas` WRITE;
/*!40000 ALTER TABLE `craft_gqlschemas` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_gqlschemas` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_info` VALUES (1,'3.3.0.1','3.3.3',0,'{\"fieldGroups\":{\"231f77ea-4e95-403c-b766-6436e643879f\":{\"name\":\"Common\"}},\"siteGroups\":{\"c4129556-27de-4dc1-8ea8-c07c07e7f841\":{\"name\":\"Graficacion\"}},\"sites\":{\"1da55505-c3a3-42ea-bf9c-3b5e660379fe\":{\"baseUrl\":\"$DEFAULT_SITE_URL\",\"handle\":\"default\",\"hasUrls\":true,\"language\":\"es\",\"name\":\"Graficacion\",\"primary\":true,\"siteGroup\":\"c4129556-27de-4dc1-8ea8-c07c07e7f841\",\"sortOrder\":1}},\"email\":{\"fromEmail\":\"sahory.maila@gmail.com\",\"fromName\":\"Graficacion\",\"template\":null,\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Gmail\",\"transportSettings\":{\"username\":\"sahory.maila\",\"password\":\"SahoryMaila16\",\"timeout\":\"10\"}},\"system\":{\"edition\":\"solo\",\"name\":\"Graficacion\",\"live\":true,\"schemaVersion\":\"3.3.3\",\"timeZone\":\"America/Los_Angeles\"},\"users\":{\"requireEmailVerification\":true,\"allowPublicRegistration\":false,\"defaultGroup\":null,\"photoVolumeUid\":null,\"photoSubpath\":\"\"},\"dateModified\":1567096915,\"sections\":{\"2fbc17cc-8acd-4ad7-86b0-415e581a31b7\":{\"name\":\"Blog\",\"handle\":\"blog\",\"type\":\"channel\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"1da55505-c3a3-42ea-bf9c-3b5e660379fe\":{\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"blog/{slug}\",\"template\":\"\"}},\"entryTypes\":{\"01ab59c0-5073-4719-89e6-f8387ba9f6c0\":{\"name\":\"Blog\",\"handle\":\"blog\",\"hasTitleField\":true,\"titleLabel\":\"Título\",\"titleFormat\":null,\"sortOrder\":1}}},\"02a3019f-311a-49be-bddf-eff2702e5ece\":{\"name\":\"Contacto\",\"handle\":\"contacto\",\"type\":\"single\",\"enableVersioning\":true,\"propagationMethod\":\"all\",\"siteSettings\":{\"1da55505-c3a3-42ea-bf9c-3b5e660379fe\":{\"enabledByDefault\":true,\"hasUrls\":true,\"uriFormat\":\"__home__\",\"template\":\"\"}},\"entryTypes\":{\"9adf5666-3a70-48c0-959f-97afabd84924\":{\"name\":\"Contacto\",\"handle\":\"contacto\",\"hasTitleField\":false,\"titleLabel\":null,\"titleFormat\":\"{section.name|raw}\",\"sortOrder\":1}}}},\"plugins\":{\"redactor\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"2.3.0\"},\"contact-form\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\",\"settings\":{\"toEmail\":\"sahory.maila@gmail.com\",\"prependSender\":\"Hola esto es una prueba\",\"prependSubject\":\"New message from Graficacion\",\"allowAttachments\":\"\",\"successFlashMessage\":\"Su mensaje ha sido enviado\"}},\"ckeditor\":{\"edition\":\"standard\",\"enabled\":true,\"schemaVersion\":\"1.0.0\"}}}','[]','a12A0tiCg0f9','2019-08-29 15:34:40','2019-08-29 15:50:23','e2640c06-aca6-4b16-b7fe-f4624727eedd');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_migrations` VALUES (1,NULL,'app','Install','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9d8a57ae-6d2d-4235-9cde-993d7a952cae'),(2,NULL,'app','m150403_183908_migrations_table_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','45b3ecc1-ca6e-4a97-ad42-0a58370f3dcd'),(3,NULL,'app','m150403_184247_plugins_table_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d6dd25e8-9aa6-49fc-8342-299173bc495c'),(4,NULL,'app','m150403_184533_field_version','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','790b3317-81cb-4966-82e5-2cca9b8d1f67'),(5,NULL,'app','m150403_184729_type_columns','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','55f7e793-ca9d-4481-ad86-1fd8023405a8'),(6,NULL,'app','m150403_185142_volumes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','7637a5a7-03ee-4317-9d5d-e809f3f0275d'),(7,NULL,'app','m150428_231346_userpreferences','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','2ddd9cca-c296-48c3-8531-6c242fc07b62'),(8,NULL,'app','m150519_150900_fieldversion_conversion','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','ec640e0e-7681-45c7-bbc5-54ca2a7f7086'),(9,NULL,'app','m150617_213829_update_email_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','f21f2049-ad5d-4282-b698-bcd698677a08'),(10,NULL,'app','m150721_124739_templatecachequeries','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','aeab4abe-35f9-4c9e-97f0-7417c4092cf7'),(11,NULL,'app','m150724_140822_adjust_quality_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fef9ecc7-30d9-4e04-8f5a-52ad11e487c7'),(12,NULL,'app','m150815_133521_last_login_attempt_ip','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','7328d158-afdf-4f01-8de0-746302515d33'),(13,NULL,'app','m151002_095935_volume_cache_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','5f380c61-02c9-49bb-8fbb-7955ed3dd444'),(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','bf677c04-5af2-4f20-9225-d6a5cb55d4c0'),(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','f2908d00-fbf8-40b1-b838-c87c85177a1c'),(16,NULL,'app','m151209_000000_move_logo','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1b921897-a41e-4ed9-88bd-1dfc38aadc21'),(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fde84648-7e24-4411-bc9a-ba6f9b4e730b'),(18,NULL,'app','m151215_000000_rename_asset_permissions','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','676e495f-d5b1-4813-a6d6-56e31d0cae7e'),(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','4472d81e-963a-400e-afa7-26e013d26b06'),(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9a8d61b3-6c04-467e-a7e4-a8faab1711ca'),(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','21b4bf24-2faa-403e-9881-c5ae43100123'),(22,NULL,'app','m160727_194637_column_cleanup','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1745b2cd-271a-4b0c-bc60-542767d6609e'),(23,NULL,'app','m160804_110002_userphotos_to_assets','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','15a467c3-da2f-485b-9e70-eb89df36bd44'),(24,NULL,'app','m160807_144858_sites','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d3948ab7-e6ad-4d9e-ae87-203e3c2d7762'),(25,NULL,'app','m160829_000000_pending_user_content_cleanup','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','edba6f33-5be0-4329-95cf-a1cde281af01'),(26,NULL,'app','m160830_000000_asset_index_uri_increase','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e17ae58f-f89f-47c6-9c7e-8b4e50eddddd'),(27,NULL,'app','m160912_230520_require_entry_type_id','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','88fec1fc-22d0-4e67-bfee-ddf0b509e431'),(28,NULL,'app','m160913_134730_require_matrix_block_type_id','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','6d649275-7780-4192-8d0c-38c5b9d0804a'),(29,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1aa67e93-959d-4c69-8b57-a61972eed07d'),(30,NULL,'app','m160920_231045_usergroup_handle_title_unique','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','6925d070-e56a-4f60-bb8e-770bfca5c3a3'),(31,NULL,'app','m160925_113941_route_uri_parts','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','94e7b1bc-d9be-4cde-af54-b012efb0a8d0'),(32,NULL,'app','m161006_205918_schemaVersion_not_null','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','0030031f-d015-4b04-87ff-b196685e00e9'),(33,NULL,'app','m161007_130653_update_email_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','4b26dde5-1c9e-46a7-877c-ca187e24564e'),(34,NULL,'app','m161013_175052_newParentId','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','332fc178-d063-4dd8-b1e0-81a7b0c3e020'),(35,NULL,'app','m161021_102916_fix_recent_entries_widgets','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','837d97c9-4a59-4ffe-a583-af71a41f66d8'),(36,NULL,'app','m161021_182140_rename_get_help_widget','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b88368f6-efb8-4fae-acd0-c488ef6553bf'),(37,NULL,'app','m161025_000000_fix_char_columns','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','19344c04-8489-4a38-be18-8774f2c28585'),(38,NULL,'app','m161029_124145_email_message_languages','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','84f6b79e-822c-45b4-b3be-f4072192b0eb'),(39,NULL,'app','m161108_000000_new_version_format','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','15370313-a4b5-46fd-9c8d-c7559da7790d'),(40,NULL,'app','m161109_000000_index_shuffle','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b02097ee-5aa2-4bd7-9c0b-7352ad7f20f3'),(41,NULL,'app','m161122_185500_no_craft_app','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','4579e7aa-9f6c-4dfb-aa64-81b580baec42'),(42,NULL,'app','m161125_150752_clear_urlmanager_cache','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d0ba9104-cf9e-4b75-8f57-419e52b13646'),(43,NULL,'app','m161220_000000_volumes_hasurl_notnull','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','692bff6d-492b-4b5a-92b8-27ed8a1d9a78'),(44,NULL,'app','m170114_161144_udates_permission','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','10b172e1-97e3-4c37-82ae-ee3ff09961be'),(45,NULL,'app','m170120_000000_schema_cleanup','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','79bace26-c461-45c9-ba89-c5c016161e48'),(46,NULL,'app','m170126_000000_assets_focal_point','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9ebf716b-5198-42f9-a1bc-92d0b4acdd9a'),(47,NULL,'app','m170206_142126_system_name','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','8aac6688-f6d4-4c5b-b715-3f74eb5919a0'),(48,NULL,'app','m170217_044740_category_branch_limits','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fbc118be-4cb3-40e7-b115-7ff5e6239d75'),(49,NULL,'app','m170217_120224_asset_indexing_columns','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e95f3c3f-1bb2-4605-b202-d51366719e21'),(50,NULL,'app','m170223_224012_plain_text_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','0bdb3a39-c910-4eeb-80ff-4c45a2602b0b'),(51,NULL,'app','m170227_120814_focal_point_percentage','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','cfa0fddd-72b1-4b8b-a43f-b613a65d589a'),(52,NULL,'app','m170228_171113_system_messages','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9d1c9c4f-9cd2-49b4-9e71-667dcb093415'),(53,NULL,'app','m170303_140500_asset_field_source_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','29d06d19-d902-48be-b221-53882c4c5021'),(54,NULL,'app','m170306_150500_asset_temporary_uploads','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','0ea92c1d-955b-4f22-89cd-b14faafb1cb3'),(55,NULL,'app','m170523_190652_element_field_layout_ids','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','57eea02c-3740-4bd9-93ad-8822728faa34'),(56,NULL,'app','m170612_000000_route_index_shuffle','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','bb978319-445d-400e-84cb-8d24337c11db'),(57,NULL,'app','m170621_195237_format_plugin_handles','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1df104b5-b7a4-4b02-93cc-1e093e6fcc98'),(58,NULL,'app','m170630_161027_deprecation_line_nullable','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','c93d262e-3657-4a10-a3c6-50c4df0af5b8'),(59,NULL,'app','m170630_161028_deprecation_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','28d60f14-b86b-4e2d-858f-313403fd57e8'),(60,NULL,'app','m170703_181539_plugins_table_tweaks','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','a6c6a0d7-96d0-4eae-84f2-c2e1e354b9f0'),(61,NULL,'app','m170704_134916_sites_tables','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fcdffe0e-fa6f-4f5b-832b-dffb7ecce172'),(62,NULL,'app','m170706_183216_rename_sequences','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','18cb27ed-e440-4ce6-b92c-93d739c701eb'),(63,NULL,'app','m170707_094758_delete_compiled_traits','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9cb17e6f-7585-4ade-9631-41888812e947'),(64,NULL,'app','m170731_190138_drop_asset_packagist','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','a54f2044-c017-460a-a160-f6207f0a4226'),(65,NULL,'app','m170810_201318_create_queue_table','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','84c16fef-1c9a-405b-b86c-49c133db9d5c'),(66,NULL,'app','m170816_133741_delete_compiled_behaviors','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','2fc1d6d1-3c18-42b1-a3a2-c1d1a0436bb5'),(67,NULL,'app','m170903_192801_longblob_for_queue_jobs','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e551e547-3618-4596-ae59-c9544bae41f5'),(68,NULL,'app','m170914_204621_asset_cache_shuffle','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','82447123-bf32-47e5-99af-d3e17305bc83'),(69,NULL,'app','m171011_214115_site_groups','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','3133f713-2b3f-4f14-8397-5b20a5580214'),(70,NULL,'app','m171012_151440_primary_site','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e65a5752-3e96-45fe-bc56-26c1ff673923'),(71,NULL,'app','m171013_142500_transform_interlace','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','a00de697-36dd-4e4a-930b-9da2ce82d7be'),(72,NULL,'app','m171016_092553_drop_position_select','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','cefb571d-554f-4d39-a752-7bcaafb9a64d'),(73,NULL,'app','m171016_221244_less_strict_translation_method','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b70a9d80-70e4-47cf-adb8-84cda7dd6a78'),(74,NULL,'app','m171107_000000_assign_group_permissions','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','80210612-75d4-4b6e-b157-5102eac2a19b'),(75,NULL,'app','m171117_000001_templatecache_index_tune','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9929cc13-7b69-4bd6-bf7c-da0d5ba9680c'),(76,NULL,'app','m171126_105927_disabled_plugins','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b63b3ad1-ff7d-4605-aae6-46276450b65c'),(77,NULL,'app','m171130_214407_craftidtokens_table','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','4158af89-a906-4331-b60f-63fff4c32cf5'),(78,NULL,'app','m171202_004225_update_email_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','0415605b-75ce-4fa7-8b89-8090e73e0d59'),(79,NULL,'app','m171204_000001_templatecache_index_tune_deux','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','2f03e571-b9c5-42ab-8b2d-1c05491bc44b'),(80,NULL,'app','m171205_130908_remove_craftidtokens_refreshtoken_column','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','f22d233c-ce13-495d-88a9-9ab58bc47f02'),(81,NULL,'app','m171218_143135_longtext_query_column','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','dbf72611-502d-4381-b082-8df207cf5bc4'),(82,NULL,'app','m171231_055546_environment_variables_to_aliases','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','85186de5-f940-4cff-926a-ab8d3d571bb2'),(83,NULL,'app','m180113_153740_drop_users_archived_column','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','72f538cf-6b9b-426b-b484-f5e7d014c990'),(84,NULL,'app','m180122_213433_propagate_entries_setting','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','13a92afb-52e4-4e9f-9ec4-aa3cf986ed96'),(85,NULL,'app','m180124_230459_fix_propagate_entries_values','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','f6dc1464-21a3-4a31-beb5-17b6b8128e13'),(86,NULL,'app','m180128_235202_set_tag_slugs','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','60418a43-6797-4698-9ad8-d5a717230cfd'),(87,NULL,'app','m180202_185551_fix_focal_points','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','322060f6-5e55-406a-a399-e948cc69bfa7'),(88,NULL,'app','m180217_172123_tiny_ints','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','443456e5-f0d1-4e96-a368-befe294b6eec'),(89,NULL,'app','m180321_233505_small_ints','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fa491385-38f9-4925-b4f4-6d154531c5ba'),(90,NULL,'app','m180328_115523_new_license_key_statuses','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','a63f58a1-675f-43ff-b249-72f586dfb9b6'),(91,NULL,'app','m180404_182320_edition_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','4c045d71-619e-434e-82bc-9d894d9fcd91'),(92,NULL,'app','m180411_102218_fix_db_routes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','51c20013-7918-4f0a-83a8-a0559b0a429a'),(93,NULL,'app','m180416_205628_resourcepaths_table','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','62c83c18-fbd8-4e92-869c-2c119185e68c'),(94,NULL,'app','m180418_205713_widget_cleanup','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e2d397ce-882e-4c04-bb80-16be3ff52a89'),(95,NULL,'app','m180425_203349_searchable_fields','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d6749068-9e5e-47d0-ac39-020af3015d19'),(96,NULL,'app','m180516_153000_uids_in_field_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','eee6ad55-76c0-4aa3-bf53-7cf97e33da66'),(97,NULL,'app','m180517_173000_user_photo_volume_to_uid','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','c1741a4a-03f5-499f-9d9f-dd8adc306a3d'),(98,NULL,'app','m180518_173000_permissions_to_uid','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b72166b8-5408-4e9c-8387-1388a8a7cca9'),(99,NULL,'app','m180520_173000_matrix_context_to_uids','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d3718f8f-6735-4db9-a7c4-1567872afaff'),(100,NULL,'app','m180521_173000_initial_yml_and_snapshot','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1e5285d9-2968-4b4a-a4b6-124e5b960566'),(101,NULL,'app','m180731_162030_soft_delete_sites','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','2cd34d61-0623-41e8-a21d-83a8382c96be'),(102,NULL,'app','m180810_214427_soft_delete_field_layouts','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','621ab6f8-7086-4222-ba69-e3e488ec7bef'),(103,NULL,'app','m180810_214439_soft_delete_elements','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','93ff12ef-36e1-4e1b-87d6-b8b5dc22b159'),(104,NULL,'app','m180824_193422_case_sensitivity_fixes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9ad20f51-4339-41a6-a267-450418f8e1c6'),(105,NULL,'app','m180901_151639_fix_matrixcontent_tables','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','629af061-b2fe-470c-9bfd-405878385735'),(106,NULL,'app','m180904_112109_permission_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','530304bb-4038-4e93-8ddf-423ba26c517f'),(107,NULL,'app','m180910_142030_soft_delete_sitegroups','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','c8acf8f7-a53a-465d-babf-930b2a043e6a'),(108,NULL,'app','m181011_160000_soft_delete_asset_support','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','81122f0c-ee0c-4154-88d3-74570d6957bd'),(109,NULL,'app','m181016_183648_set_default_user_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','7aeebaf6-9599-498c-ab94-a68d2a617949'),(110,NULL,'app','m181017_225222_system_config_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','02508f97-2251-4dd0-adc6-6a941d1a0934'),(111,NULL,'app','m181018_222343_drop_userpermissions_from_config','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','72598ea6-fb6d-4bb6-a144-b945942d62f7'),(112,NULL,'app','m181029_130000_add_transforms_routes_to_config','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','edadf3d3-34d9-4088-b242-878acdad9db3'),(113,NULL,'app','m181112_203955_sequences_table','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','86ab9d2c-16a7-4b3b-adcc-01cf4f5ab57d'),(114,NULL,'app','m181121_001712_cleanup_field_configs','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b751d3ab-eb6e-40e5-9e67-e3248e613aa5'),(115,NULL,'app','m181128_193942_fix_project_config','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b86a0118-abbf-4a64-8fac-8f9abec91462'),(116,NULL,'app','m181130_143040_fix_schema_version','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fe38732d-aa5f-4593-bb88-be2eb74ab8a8'),(117,NULL,'app','m181211_143040_fix_entry_type_uids','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','ef9efe35-c08b-403f-ab4b-0e11b20877c7'),(118,NULL,'app','m181213_102500_config_map_aliases','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','c83fb489-c65e-4413-aa09-e88ba15b12fd'),(119,NULL,'app','m181217_153000_fix_structure_uids','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e28014df-d6e9-4bfd-97a3-2c3a6fcfea8f'),(120,NULL,'app','m190104_152725_store_licensed_plugin_editions','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','cb149a5b-9479-4af0-be89-01850c96f1d4'),(121,NULL,'app','m190108_110000_cleanup_project_config','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','c878dc72-c55d-4f5e-85bb-08cd737d98ef'),(122,NULL,'app','m190108_113000_asset_field_setting_change','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e06a9ad6-3b86-4d2a-8460-8e9bf9a11e1a'),(123,NULL,'app','m190109_172845_fix_colspan','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','39e845d3-c37c-4f12-b3af-66bf76ee4c1f'),(124,NULL,'app','m190110_150000_prune_nonexisting_sites','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','e7fb325a-b10b-471d-9a61-cb6d62da8f4a'),(125,NULL,'app','m190110_214819_soft_delete_volumes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','8bdc1966-fbd9-4c92-90ce-cc87aac938a7'),(126,NULL,'app','m190112_124737_fix_user_settings','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','80695d72-8f58-4b12-b292-87e25362521d'),(127,NULL,'app','m190112_131225_fix_field_layouts','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','b96856f9-bd4d-43c0-a845-261ba66b427b'),(128,NULL,'app','m190112_201010_more_soft_deletes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','d67fb325-3b1c-416d-b44d-9bcd77db9a2b'),(129,NULL,'app','m190114_143000_more_asset_field_setting_changes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','879139d4-df19-41ba-8f2f-33907085d0b2'),(130,NULL,'app','m190121_120000_rich_text_config_setting','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','66be0791-c928-4d6e-8056-62f83a654be1'),(131,NULL,'app','m190125_191628_fix_email_transport_password','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','7e7cfbc9-baab-4012-8856-8b29c1f90db6'),(132,NULL,'app','m190128_181422_cleanup_volume_folders','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','413eb5a8-c046-4664-8a1d-8ad32fe5f041'),(133,NULL,'app','m190205_140000_fix_asset_soft_delete_index','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','0ba3806c-d122-4e4d-8fe1-57caee5074d7'),(134,NULL,'app','m190208_140000_reset_project_config_mapping','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','9a714613-8ec6-4430-b6c1-d256e78265da'),(135,NULL,'app','m190218_143000_element_index_settings_uid','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fe9f49c1-33da-4a35-b527-cd166d1d646f'),(136,NULL,'app','m190401_223843_drop_old_indexes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','22ce3ba1-afed-4585-83e3-cda3030fa819'),(137,NULL,'app','m190416_014525_drop_unique_global_indexes','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','1fd3e4b3-d4be-41a3-8595-5cbcf2b2d0af'),(138,NULL,'app','m190502_122019_store_default_user_group_uid','2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:41','fac37432-e447-4779-970d-ca6dcf73fbcc'),(139,NULL,'app','m190312_152740_element_revisions','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','468b0b47-6762-4383-931a-dc747978e966'),(140,NULL,'app','m190327_235137_propagation_method','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','face189d-30bc-4171-80ea-c21ca5c32c2e'),(141,NULL,'app','m190417_085010_add_image_editor_permissions','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','41250bea-13f7-40ba-9387-4215ebea26bd'),(142,NULL,'app','m190504_150349_preview_targets','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','5da6f2f1-a47b-4d0e-a988-930e17c94ba0'),(143,NULL,'app','m190516_184711_job_progress_label','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','371e515a-b034-46bb-867c-c01afae07482'),(144,NULL,'app','m190523_190303_optional_revision_creators','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','f3c7ac93-159f-4db1-b76d-ddc27210f045'),(145,NULL,'app','m190529_204501_fix_duplicate_uids','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','281925a3-6809-400f-9318-68e49c1d52dc'),(146,NULL,'app','m190605_223807_unsaved_drafts','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','90a71c74-0b2b-4d1f-b1c0-8dfa4fe38ef5'),(147,NULL,'app','m190607_230042_entry_revision_error_tables','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','1ae67ccb-9ec9-432e-b35e-2e76081c5149'),(148,NULL,'app','m190608_033429_drop_elements_uid_idx','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','9ce957ee-329d-4ae2-9cb6-90df22ff3308'),(149,NULL,'app','m190617_164400_add_gqlschemas_table','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','3f5883f5-3d7c-4a18-8d76-8bf496a15bfa'),(150,NULL,'app','m190624_234204_matrix_propagation_method','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','64b4c6ce-0fef-413f-bc47-1b4514028ab4'),(151,NULL,'app','m190711_153020_drop_snapshots','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','5057202a-130d-4056-ada9-73641265fe7c'),(152,NULL,'app','m190712_195914_no_draft_revisions','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','30aa43c8-c9e0-4255-98f4-b5e021107645'),(153,NULL,'app','m190723_140314_fix_preview_targets_column','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','511a56c1-e641-4e95-b54b-0fd8341d4a2c'),(154,NULL,'app','m190820_003519_flush_compiled_templates','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','f7d26329-9ebd-4ff0-925e-6355b33c57f0'),(155,NULL,'app','m190823_020339_optional_draft_creators','2019-08-29 15:50:59','2019-08-29 15:50:59','2019-08-29 15:50:59','6b0a3d5e-28bf-49a1-b5db-27ed26c25dbe'),(156,1,'plugin','m180430_204710_remove_old_plugins','2019-08-29 16:14:07','2019-08-29 16:14:07','2019-08-29 16:14:07','a26d2eee-a375-4c82-8634-c4b930852842'),(157,1,'plugin','Install','2019-08-29 16:14:07','2019-08-29 16:14:07','2019-08-29 16:14:07','4584862e-c748-40e1-9c1b-7f4ebd66ab63'),(158,1,'plugin','m190225_003922_split_cleanup_html_settings','2019-08-29 16:14:07','2019-08-29 16:14:07','2019-08-29 16:14:07','193196f5-d4a3-4e9a-9a47-0008a1f3bf1a');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_plugins` VALUES (1,'redactor','2.3.3.2','2.3.0','unknown',NULL,'2019-08-29 16:14:07','2019-08-29 16:14:07','2019-08-29 16:42:40','826baa5b-f743-45c0-b25e-f60361fd0b6f'),(2,'contact-form','2.2.5','1.0.0','unknown',NULL,'2019-08-29 16:17:55','2019-08-29 16:17:55','2019-08-29 16:42:40','b0b6f06a-fe84-451f-863e-095457dd1afc'),(3,'ckeditor','1.0.0-beta.2','1.0.0','unknown',NULL,'2019-08-29 16:28:32','2019-08-29 16:28:32','2019-08-29 16:42:40','7c8df338-b7a3-47cf-9212-d3e0abde1c05');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_queue`
--

LOCK TABLES `craft_queue` WRITE;
/*!40000 ALTER TABLE `craft_queue` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_queue` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_resourcepaths`
--

LOCK TABLES `craft_resourcepaths` WRITE;
/*!40000 ALTER TABLE `craft_resourcepaths` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_resourcepaths` VALUES ('12266126','@craft/web/assets/updater/dist'),('15cd7e41','@lib/xregexp'),('1fa13acb','@lib/selectize'),('325de750','@craft/web/assets/installer/dist'),('33056826','@lib/xregexp'),('3362dd45','@lib/xregexp'),('365a8cfb','@craft/web/assets/pluginstore/dist'),('390e99cf','@lib/selectize'),('39692cac','@lib/selectize'),('3f21bc86','@craft/web/assets/cp/dist'),('413b2229','@app/web/assets/fields/dist'),('452e57a2','@lib/fabric'),('4549e2c1','@lib/fabric'),('457a371e','@lib/d3'),('465c0c67','@app/web/assets/dashboard/dist'),('4bdf174f','@lib/picturefill'),('4c7b2b8d','@lib/jquery-touch-events'),('500f36ff','@lib/garnishjs'),('5068839c','@lib/garnishjs'),('533716b1','@lib/fileupload'),('59a1c316','@app/web/assets/updates/dist'),('59c67675','@app/web/assets/updates/dist'),('5f208845','@app/web/assets/dashboard/dist'),('6381f4a6','@lib/fabric'),('63b22179','@lib/d3'),('63d5941a','@lib/d3'),('65d3844c','@craft/web/assets/utilities/dist'),('66face67','@app/web/assets/editentry/dist'),('6ab33dea','@lib/jquery-touch-events'),('6ad48889','@lib/jquery-touch-events'),('6d170128','@lib/picturefill'),('6d70b44b','@lib/picturefill'),('709165e9','@app/web/assets/sites/dist'),('7598b5b5','@lib/fileupload'),('75ff00d6','@lib/fileupload'),('76c72098','@lib/garnishjs'),('79148344','@app/web/assets/dbbackup/dist'),('7f0e6012','@app/web/assets/updates/dist'),('816f5755','@app/web/assets/login/dist'),('8536f748','@app/web/assets/cp/dist'),('8551422b','@app/web/assets/cp/dist'),('905cd6f3','@app/web/assets/updater/dist'),('981c65a6','@app/web/assets/recententries/dist'),('98534710','@lib/jquery-ui'),('987bd0c5','@app/web/assets/recententries/dist'),('9e690f00','@app/web/assets/pluginstore/dist'),('a04255a5','@craft/web/assets/plugins/dist'),('a3fee12f','@app/web/assets/cp/dist'),('a6a627c8','@app/web/assets/updateswidget/dist'),('a8348b09','@app/web/assets/craftsupport/dist'),('a8533e6a','@app/web/assets/craftsupport/dist'),('af8ff1d5','@app/web/assets/updater/dist'),('b0a463a6','@app/web/assets/installer/dist'),('b6f375f7','@app/web/assets/updater/dist'),('be9b5177','@lib/jquery-ui'),('befce414','@lib/jquery-ui'),('bfdaa3ea','@app/web/assets/updateswidget/dist'),('c185a3be','@app/web/assets/utilities/dist'),('c7752bc8','@bower/jquery/dist'),('c90fb771','@app/web/assets/quickpost/dist'),('c9d8530','@lib/timepicker'),('cadd735d','@lib/jquery.payment'),('ce2d965a','@lib/element-resize-detector'),('ce4a2339','@lib/element-resize-detector'),('d6fadcb5','@lib/velocity'),('d9f04934','@lib'),('e1bd3daf','@bower/jquery/dist'),('e1da88cc','@bower/jquery/dist'),('e4034a91','@craft/web/assets/editentry/dist'),('e5368db7','@app/web/assets/feed/dist'),('e72a00ba','@app/web/assets/utilities/dist'),('e8e5803d','@lib/element-resize-detector'),('ea88a4c','@app/web/assets/editsection/dist'),('ec15653a','@lib/jquery.payment'),('ec72d059','@lib/jquery.payment'),('f032cad2','@lib/velocity'),('f0557fb1','@lib/velocity'),('fc4a0995','@app/web/assets/feed/dist'),('fe568498','@app/web/assets/utilities/dist');
/*!40000 ALTER TABLE `craft_resourcepaths` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_revisions`
--

LOCK TABLES `craft_revisions` WRITE;
/*!40000 ALTER TABLE `craft_revisions` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_revisions` VALUES (1,3,1,1,NULL),(2,5,1,1,NULL);
/*!40000 ALTER TABLE `craft_revisions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,1,' sahory '),(1,'firstname',0,1,''),(1,'lastname',0,1,''),(1,'fullname',0,1,''),(1,'email',0,1,' sahory maila gmail com '),(1,'slug',0,1,''),(3,'slug',0,1,' spa single page application '),(3,'title',0,1,' spa single page application '),(5,'slug',0,1,' contacto '),(5,'title',0,1,' contacto ');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections` VALUES (1,NULL,'Blog','blog','channel',1,'all',NULL,'2019-08-29 16:04:19','2019-08-29 16:04:19',NULL,'2fbc17cc-8acd-4ad7-86b0-415e581a31b7'),(2,NULL,'Contacto','contacto','single',1,'all',NULL,'2019-08-29 16:12:55','2019-08-29 16:12:55',NULL,'02a3019f-311a-49be-bddf-eff2702e5ece');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sections_sites`
--

LOCK TABLES `craft_sections_sites` WRITE;
/*!40000 ALTER TABLE `craft_sections_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sections_sites` VALUES (1,1,1,1,'blog/{slug}','',1,'2019-08-29 16:04:19','2019-08-29 16:04:19','afcf48da-96ed-4dcf-9fef-e052c557deb7'),(2,2,1,1,'__home__','',1,'2019-08-29 16:12:55','2019-08-29 16:12:55','f572935c-3333-4320-94d3-c5d2be235c44');
/*!40000 ALTER TABLE `craft_sections_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sequences`
--

LOCK TABLES `craft_sequences` WRITE;
/*!40000 ALTER TABLE `craft_sequences` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_sequences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sitegroups`
--

LOCK TABLES `craft_sitegroups` WRITE;
/*!40000 ALTER TABLE `craft_sitegroups` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sitegroups` VALUES (1,'Graficacion','2019-08-29 15:34:40','2019-08-29 15:34:40',NULL,'c4129556-27de-4dc1-8ea8-c07c07e7f841');
/*!40000 ALTER TABLE `craft_sitegroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_sites`
--

LOCK TABLES `craft_sites` WRITE;
/*!40000 ALTER TABLE `craft_sites` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_sites` VALUES (1,1,1,'Graficacion','default','es',1,'$DEFAULT_SITE_URL',1,'2019-08-29 15:34:40','2019-08-29 15:34:40',NULL,'1da55505-c3a3-42ea-bf9c-3b5e660379fe');
/*!40000 ALTER TABLE `craft_sites` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_systemmessages`
--

LOCK TABLES `craft_systemmessages` WRITE;
/*!40000 ALTER TABLE `craft_systemmessages` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_systemmessages` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_tokens` VALUES (1,'SO95_KZsQHW9XuGU4xjcZWvWpNazBHMi','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":2,\"siteId\":1,\"draftId\":1,\"revisionId\":null}]',NULL,NULL,'2019-08-30 16:05:33','2019-08-29 16:05:33','2019-08-29 16:05:33','03f4d43b-4f65-4fc1-a59c-069db9338cdb'),(2,'0VJ7FD-hpg9FPSgGYeoQaTOMJKebRPyn','[\"preview/preview\",{\"elementType\":\"craft\\\\elements\\\\Entry\",\"sourceId\":7,\"siteId\":1,\"draftId\":2,\"revisionId\":null}]',NULL,NULL,'2019-08-30 16:23:37','2019-08-29 16:23:37','2019-08-29 16:23:37','79e29bc1-bcb7-4bd3-811b-dd049d3144da');
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_userpreferences`
--

LOCK TABLES `craft_userpreferences` WRITE;
/*!40000 ALTER TABLE `craft_userpreferences` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_userpreferences` VALUES (1,'{\"language\":\"es\"}');
/*!40000 ALTER TABLE `craft_userpreferences` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_users` VALUES (1,'Sahory',NULL,NULL,NULL,'sahory.maila@gmail.com','$2y$13$JhcRcM8UbhJNuOU7nRLzTeQqkKpOVCmKzLRm.wAqsT8gmlK2N9WiW',1,0,0,0,'2019-08-29 15:34:41',NULL,NULL,NULL,NULL,NULL,1,NULL,NULL,NULL,0,'2019-08-29 15:34:41','2019-08-29 15:34:41','2019-08-29 15:34:43','b744422d-0b0f-47f5-9b06-7d9caf892cd7');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumefolders`
--

LOCK TABLES `craft_volumefolders` WRITE;
/*!40000 ALTER TABLE `craft_volumefolders` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_volumefolders` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_volumes`
--

LOCK TABLES `craft_volumes` WRITE;
/*!40000 ALTER TABLE `craft_volumes` DISABLE KEYS */;
set autocommit=0;
/*!40000 ALTER TABLE `craft_volumes` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
set autocommit=0;
INSERT INTO `craft_widgets` VALUES (1,1,'craft\\widgets\\RecentEntries',1,NULL,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":\"10\"}',1,'2019-08-29 15:34:43','2019-08-29 15:43:24','099d35d4-01b1-4c19-ab2f-a459a508948c'),(2,1,'craft\\widgets\\CraftSupport',2,NULL,'[]',1,'2019-08-29 15:34:43','2019-08-29 15:34:43','6a1ce0de-61d2-4069-a805-f2e3acb70e3e'),(3,1,'craft\\widgets\\Updates',3,NULL,'[]',1,'2019-08-29 15:34:43','2019-08-29 15:34:43','28164d47-7035-48af-a3a5-a4cd2bc52aa1'),(4,1,'craft\\widgets\\Feed',4,NULL,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2019-08-29 15:34:43','2019-08-29 15:34:43','d31692ed-01db-41eb-976a-e860e7bad4ec'),(5,1,'craft\\widgets\\QuickPost',5,NULL,'{\"section\":\"1\",\"entryType\":\"\",\"fields\":null}',1,'2019-08-29 16:07:14','2019-08-29 16:07:14','77c42455-4a3a-4a86-a2e3-a17fa925945a');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
commit;

--
-- Dumping routines for database 'craft'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-29 16:45:21
