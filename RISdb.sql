-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2021 at 09:14 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 7.4.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `risdb`
--

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `order_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `team_id` int(11) DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `modality_id` int(11) NOT NULL,
  `image_id` int(11) DEFAULT NULL,
  `appointment` timestamp NULL DEFAULT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp(),
  `date_completed` date DEFAULT NULL,
  `visit_reason` varchar(150) NOT NULL,
  `imaging_needed` varchar(150) NOT NULL,
  `notes` text DEFAULT NULL,
  `report` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`order_id`, `patient_id`, `team_id`, `status_id`, `modality_id`, `image_id`, `appointment`, `date_added`, `date_completed`, `visit_reason`, `imaging_needed`, `notes`, `report`) VALUES
(1, 3, 1, 3, 2, 3, '2021-03-30 18:45:00', '2021-03-12 19:33:12', NULL, 'broken leg', 'shoot the bones', '', NULL),
(8, 1, 1, 2, 2, NULL, '2021-07-08 19:30:00', '2021-03-12 22:02:12', NULL, 'Broken Bone', 'Left Hand Thumb', '', NULL),
(9, 1, 1, 2, 1, NULL, '2021-03-09 16:00:00', '2021-03-12 22:04:56', NULL, 'Possible concution', 'Brain Scan', 'Imaging is not compleated just set to that status for testing purposes.', NULL),
(12, 1, 1, 4, 2, 1, '2021-03-03 10:30:00', '2021-03-12 22:40:25', '2021-03-12', 'Hurt pride', 'Soul Scan', '', 'Some Report'),
(13, 10, 1, 4, 1, 1, '2021-03-21 18:45:00', '2021-03-12 22:53:05', '2021-03-22', 'Gets light winded', 'Lungs', 'Will die on you be careful.', 'The lungs look healthy. '),
(14, 3, NULL, 1, 1, NULL, NULL, '2021-03-13 04:39:59', NULL, 'Ingesting animal hair', 'Lower intestines', 'I have no notes. ', NULL),
(15, 1, NULL, 1, 3, NULL, NULL, '2021-03-14 18:25:46', NULL, 'Bad Hair', 'Skull', 'asdf', NULL),
(16, 11, NULL, 1, 2, NULL, NULL, '2021-03-17 01:42:11', NULL, 'Broken middle toe', 'Right foot', 'Be careful he has a metal knee and will use it.   ', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `team_id` (`team_id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `modality_id` (`modality_id`),
  ADD KEY `image_id` (`image_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `image_id` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`),
  ADD CONSTRAINT `modality_id` FOREIGN KEY (`modality_id`) REFERENCES `modality` (`modality_id`),
  ADD CONSTRAINT `patient_id` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `status_id` FOREIGN KEY (`status_id`) REFERENCES `status` (`status_id`),
  ADD CONSTRAINT `team_id` FOREIGN KEY (`team_id`) REFERENCES `team` (`team_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
