-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 14, 2021 at 03:52 AM
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
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `label` varchar(50) NOT NULL,
  `path` varchar(150) NOT NULL,
  `user` varchar(50) NOT NULL,
  `date_added` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `modality`
--

CREATE TABLE `modality` (
  `modality_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `modality`
--

INSERT INTO `modality` (`modality_id`, `name`) VALUES
(1, 'CAT Scan'),
(2, 'X-Ray'),
(3, 'MRI');

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
(1, 3, NULL, 1, 2, NULL, NULL, '2021-03-12 19:33:12', NULL, 'broken leg', 'shoot the bones', '', NULL),
(8, 1, NULL, 2, 2, NULL, NULL, '2021-03-12 22:02:12', NULL, 'Broken Bone', 'Left Hand Thumb', '', NULL),
(9, 1, NULL, 3, 1, NULL, NULL, '2021-03-12 22:04:56', NULL, 'Possible concution', 'Brain Scan', 'Imaging is not compleated just set to that status for testing purposes.', NULL),
(12, 1, 1, 4, 2, NULL, '2021-03-12 22:30:00', '2021-03-12 22:40:25', '2021-03-12', 'Hurt pride', 'Soul Scan', '', NULL),
(13, 10, NULL, 1, 1, NULL, NULL, '2021-03-12 22:53:05', NULL, 'Gets light winded', 'Lungs', 'Will die on you be careful.', NULL),
(14, 3, NULL, 1, 1, NULL, NULL, '2021-03-13 04:39:59', NULL, 'Ingesting animal hair', 'Lower intestines', 'I have no notes. ', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) DEFAULT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(150) NOT NULL,
  `birthday` date NOT NULL,
  `phone_number` varchar(32) NOT NULL,
  `has_allergy_asthma` tinyint(1) NOT NULL,
  `has_allergy_xraydye` tinyint(1) NOT NULL,
  `has_allergy_mridye` tinyint(1) NOT NULL,
  `has_allergy_latex` tinyint(1) NOT NULL,
  `notes` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `doctor_id`, `first_name`, `middle_name`, `last_name`, `email`, `birthday`, `phone_number`, `has_allergy_asthma`, `has_allergy_xraydye`, `has_allergy_mridye`, `has_allergy_latex`, `notes`) VALUES
(1, 3, 'James', NULL, 'Nobody', 'nbody@gmail.com', '2020-10-01', '345 341 4151', 0, 1, 0, 0, 'Is a nobody.'),
(3, 4, 'Doug', 'Hurbert', 'Smith', 'smith@gmail.com', '2020-10-01', '345 262 2253', 1, 1, 0, 0, ''),
(5, 4, 'Frank', 'A', 'Snout', 'FSnout@gmail.com', '1998-03-11', '888 359 2423', 1, 1, 1, 1, 'Is always cranky.'),
(6, 3, 'Nathan', 's', 'Alden', 'naalde3055@ung.edu', '2000-09-27', '678 899 9417', 0, 1, 0, 0, ''),
(7, 4, 'Dave', 'V', 'Roarblen', 'DV@gmail.com', '2021-03-01', '323 414 5153', 0, 1, 0, 1, 'Might be a stoner.'),
(8, 3, 'Tom', 'S', 'Nook', 'Tnook@gmail.com', '2021-03-02', '734 226 2623', 0, 0, 1, 1, 'Money lover'),
(9, 3, 'Keven', '', 'Loss', 'Kloss@gmail.com', '2021-03-03', '123 546 6452', 1, 0, 1, 0, 'Is this loss?'),
(10, 3, 'Dan', 'G', 'Heartright', 'Dheart@gmail.com', '2021-02-02', '456 876 5433', 1, 0, 0, 0, 'Cannot breath.');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `name`) VALUES
(1, 'Physician'),
(2, 'Receptionist'),
(3, 'Technician'),
(4, 'Radiologist'),
(5, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `status_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`status_id`, `name`) VALUES
(1, 'Referral Placed'),
(2, 'Checked In'),
(3, 'Imaging Complete'),
(4, 'Analysis Complete'),
(5, 'Archived');

-- --------------------------------------------------------

--
-- Table structure for table `team`
--

CREATE TABLE `team` (
  `team_id` int(11) NOT NULL,
  `technican_id` int(11) NOT NULL,
  `radiologist_id` int(11) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `team`
--

INSERT INTO `team` (`team_id`, `technican_id`, `radiologist_id`, `name`) VALUES
(1, 1, 2, 'testteam');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `first_name` varchar(25) NOT NULL,
  `middle_name` varchar(25) NOT NULL,
  `last_name` varchar(25) NOT NULL,
  `email` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `role_id`, `username`, `password`, `first_name`, `middle_name`, `last_name`, `email`) VALUES
(1, 3, 'tech1', 'shouldbesha256hash', 'Jerry', 'd', 'Marsh', 'Jmarsh@gmail.com'),
(2, 4, 'Radio1', 'shouldbesha256hash', 'Dan', 'Maven', 'Smith', 'DSmith@gmail.com'),
(3, 1, 'doctor1', 'shouldbesha256hash', 'Tom', '', 'Doctor', 'doctor@Gmail.com'),
(4, 1, 'doctor2', 'hash', 'Jane', '', 'Foster', 'JFoster@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `modality`
--
ALTER TABLE `modality`
  ADD PRIMARY KEY (`modality_id`);

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
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`status_id`);

--
-- Indexes for table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`team_id`),
  ADD KEY `radiologist_id` (`radiologist_id`),
  ADD KEY `technican_id` (`technican_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `modality`
--
ALTER TABLE `modality`
  MODIFY `modality_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `team`
--
ALTER TABLE `team`
  MODIFY `team_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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

--
-- Constraints for table `patient`
--
ALTER TABLE `patient`
  ADD CONSTRAINT `doctor_id` FOREIGN KEY (`doctor_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `team`
--
ALTER TABLE `team`
  ADD CONSTRAINT `radiologist_id` FOREIGN KEY (`radiologist_id`) REFERENCES `user` (`user_id`),
  ADD CONSTRAINT `technician_id` FOREIGN KEY (`technican_id`) REFERENCES `user` (`user_id`);

--
-- Constraints for table `user`
--
ALTER TABLE `user`
  ADD CONSTRAINT `role_id` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
