-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 14, 2025 at 06:35 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ttms`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `booking_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `schedule_id` int(11) DEFAULT NULL,
  `seat_class` varchar(50) DEFAULT NULL,
  `status` enum('Pending','Paid','Cancelled') DEFAULT 'Pending',
  `quantity` int(11) NOT NULL DEFAULT 1,
  `booking_time` datetime DEFAULT current_timestamp(),
  `qty_adult_malaysian` int(11) DEFAULT 0,
  `qty_child_malaysian` int(11) DEFAULT 0,
  `qty_senior_malaysian` int(11) DEFAULT 0,
  `qty_adult_foreigner` int(11) DEFAULT 0,
  `qty_child_foreigner` int(11) DEFAULT 0,
  `qty_senior_foreigner` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`booking_id`, `user_id`, `schedule_id`, `seat_class`, `status`, `quantity`, `booking_time`, `qty_adult_malaysian`, `qty_child_malaysian`, `qty_senior_malaysian`, `qty_adult_foreigner`, `qty_child_foreigner`, `qty_senior_foreigner`) VALUES
(41, 3, 1, 'Economy', 'Pending', 3, '2025-06-13 22:46:15', 1, 2, 0, 0, 0, 0),
(42, 3, 1, 'Economy', 'Pending', 3, '2025-06-13 23:00:30', 1, 1, 0, 1, 0, 0),
(43, 3, 8, 'Business', 'Pending', 1, '2025-06-13 23:09:36', 1, 0, 0, 0, 0, 0),
(44, 3, 1, 'Economy', 'Pending', 1, '2025-06-13 23:12:41', 1, 0, 0, 0, 0, 0),
(45, 3, 1, 'Economy', 'Paid', 3, '2025-06-13 23:14:07', 3, 0, 0, 0, 0, 0),
(46, 11, 9, 'Economy', 'Paid', 1, '2025-06-14 12:11:47', 1, 0, 0, 0, 0, 0),
(47, 11, 7, 'Business', 'Paid', 4, '2025-06-14 16:54:57', 1, 1, 1, 1, 0, 0),
(48, 11, 1, 'Economy', 'Paid', 1, '2025-06-15 00:29:14', 1, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `contact_us`
--

CREATE TABLE `contact_us` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `subject` varchar(150) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contact_us`
--

INSERT INTO `contact_us` (`id`, `name`, `email`, `subject`, `message`, `created_at`) VALUES
(1, 'IDHAM ADHA', 'idham@gmail.com', 'delay', 'delay', '2025-06-13 15:59:16'),
(2, 'Iman', 'khairuliman736@gmail.com', 'delay', 'bas lewat, bawak laju, lintas double line', '2025-06-14 08:56:44');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `booking_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','paid','refunded') DEFAULT 'pending',
  `payment_date` datetime DEFAULT current_timestamp(),
  `payment_method` varchar(50) DEFAULT NULL,
  `method` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `booking_id`, `amount`, `status`, `payment_date`, `payment_method`, `method`) VALUES
(1, 5, 1030.00, 'pending', '2025-05-08 14:06:19', 'Online Banking', NULL),
(2, 6, 1230.00, 'pending', '2025-05-08 14:06:44', 'Credit Card', NULL),
(3, 14, 1030.00, 'pending', '2025-05-08 14:28:18', 'Online Banking', NULL),
(4, 14, 1030.00, 'pending', '2025-05-08 14:28:40', 'Online Banking', NULL),
(5, 14, 1030.00, 'pending', '2025-05-08 14:33:35', 'Online Banking', NULL),
(6, 15, 1034.00, 'pending', '2025-05-08 16:05:04', 'Online Banking', NULL),
(7, 16, 10000.00, 'pending', '2025-05-10 09:58:47', 'Credit Card', NULL),
(8, 18, 1000.00, 'pending', '2025-05-10 13:43:55', 'Credit Card', NULL),
(9, 18, 1000.00, 'pending', '2025-05-10 13:44:00', 'Online Banking', NULL),
(10, 18, 100.00, 'pending', '2025-05-10 13:44:12', 'Credit Card', NULL),
(11, 19, 123.00, 'pending', '2025-05-10 13:53:07', 'Credit Card', NULL),
(12, 19, 123.00, 'pending', '2025-05-10 13:53:15', 'Credit Card', NULL),
(13, 20, 0.00, 'pending', '2025-05-10 13:57:20', 'Credit Card', NULL),
(14, 20, 0.00, 'pending', '2025-05-10 13:57:45', 'Credit Card', NULL),
(15, 21, 0.00, 'pending', '2025-05-10 14:04:51', 'Credit Card', NULL),
(16, 24, 10000.00, 'pending', '2025-05-10 16:58:31', 'Credit Card', NULL),
(17, 24, 0.00, 'pending', '2025-05-10 17:01:38', 'Credit Card', NULL),
(18, 24, 35.00, 'pending', '2025-05-10 17:12:24', 'Credit Card', NULL),
(19, 24, 35.00, 'pending', '2025-05-10 17:12:32', 'Credit Card', NULL),
(20, 24, 35.00, 'pending', '2025-05-10 17:12:36', 'Credit Card', NULL),
(21, 24, 35.00, 'pending', '2025-05-10 17:16:00', 'Credit Card', NULL),
(22, 24, 35.00, 'pending', '2025-05-10 17:16:08', 'Credit Card', NULL),
(23, 24, 35.00, 'pending', '2025-05-10 17:17:37', 'Credit Card', NULL),
(24, 24, 35.00, 'pending', '2025-05-10 17:18:50', 'Online Banking', NULL),
(25, 28, 50.00, 'pending', '2025-05-10 17:25:44', 'Online Banking', NULL),
(26, 29, 35.00, 'pending', '2025-05-11 13:41:49', 'Online Banking', NULL),
(27, 31, 20.00, 'pending', '2025-05-13 15:45:31', 'Credit Card', NULL),
(28, 33, 35.00, 'pending', '2025-06-01 15:43:19', 'Credit Card', NULL),
(29, 34, 35.00, 'pending', '2025-06-12 00:34:53', NULL, 'Credit Card'),
(30, 36, 12.00, 'pending', '2025-06-12 00:42:06', NULL, 'Credit Card'),
(31, 37, 25.00, 'pending', '2025-06-12 00:46:24', NULL, 'Credit Card'),
(32, 37, 25.00, 'pending', '2025-06-12 00:50:22', NULL, 'Credit Card'),
(33, 38, 25.00, 'pending', '2025-06-12 08:50:08', NULL, 'Credit Card'),
(34, 38, 25.00, 'pending', '2025-06-12 08:50:16', NULL, 'Online Banking'),
(35, 38, 25.00, 'pending', '2025-06-12 08:50:23', NULL, 'Digital Wallet'),
(36, 38, 25.00, 'pending', '2025-06-12 08:50:40', NULL, 'Credit Card'),
(37, 41, 75.00, 'pending', '2025-06-13 22:46:33', NULL, 'Credit Card'),
(38, 42, 205.00, 'pending', '2025-06-13 23:01:19', NULL, 'Online Banking'),
(39, 43, 33.00, 'pending', '2025-06-13 23:09:39', NULL, 'Credit Card'),
(40, 44, 76.00, 'paid', '2025-06-13 23:12:47', NULL, 'Digital Wallet'),
(41, 45, 228.00, 'paid', '2025-06-13 23:14:15', NULL, 'Credit Card'),
(42, 46, 57.00, 'paid', '2025-06-14 12:11:53', NULL, 'Online Banking'),
(43, 47, 148.50, 'paid', '2025-06-14 16:55:11', NULL, 'Online Banking'),
(44, 48, 76.00, 'paid', '2025-06-15 00:29:20', NULL, 'Online Banking');

-- --------------------------------------------------------

--
-- Table structure for table `routes`
--

CREATE TABLE `routes` (
  `route_id` int(11) NOT NULL,
  `start_point` varchar(100) DEFAULT NULL,
  `end_point` varchar(100) DEFAULT NULL,
  `price` decimal(6,2) DEFAULT 0.00,
  `price_adult_malaysian` decimal(6,2) DEFAULT NULL,
  `price_child_malaysian` decimal(6,2) DEFAULT NULL,
  `price_senior_malaysian` decimal(6,2) DEFAULT NULL,
  `price_adult_foreigner` decimal(6,2) DEFAULT NULL,
  `price_child_foreigner` decimal(6,2) DEFAULT NULL,
  `price_senior_foreigner` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `routes`
--

INSERT INTO `routes` (`route_id`, `start_point`, `end_point`, `price`, `price_adult_malaysian`, `price_child_malaysian`, `price_senior_malaysian`, `price_adult_foreigner`, `price_child_foreigner`, `price_senior_foreigner`) VALUES
(1, 'Alor Setar', 'Ipoh', 76.00, 76.00, 38.00, 45.00, 91.00, 60.00, 68.00),
(2, 'Alor Setar', 'Kota Bharu', 74.00, 74.00, 37.00, 44.00, 88.00, 59.00, 66.00),
(3, 'Alor Setar', 'Kuala Lumpur', 55.00, 55.00, 27.00, 33.00, 66.00, 44.00, 49.00),
(4, 'Alor Setar', 'Muar', 23.00, 23.00, 11.00, 13.00, 27.00, 18.00, 20.00),
(5, 'Alor Setar', 'Putrajaya', 74.00, 74.00, 37.00, 44.00, 88.00, 59.00, 66.00),
(6, 'Butterworth', 'Cyberjaya', 39.00, 39.00, 19.00, 23.00, 46.00, 31.00, 34.00),
(7, 'Butterworth', 'Kangar', 30.00, 30.00, 15.00, 18.00, 36.00, 24.00, 27.00),
(8, 'Butterworth', 'Kuala Terengganu', 22.00, 22.00, 11.00, 13.00, 26.00, 16.00, 18.00),
(9, 'Butterworth', 'Melaka', 57.00, 57.00, 28.00, 34.00, 68.00, 40.00, 48.00),
(10, 'Butterworth', 'Shah Alam', 23.00, 23.00, 11.00, 13.00, 27.00, 18.00, 20.00),
(11, 'Cyberjaya', 'Georgetown', 27.00, 27.00, 13.00, 16.00, 32.00, 20.00, 22.00),
(12, 'Cyberjaya', 'Ipoh', 38.00, 38.00, 19.00, 23.00, 45.00, 25.00, 32.00),
(13, 'Cyberjaya', 'Johor Bahru', 45.00, 45.00, 22.00, 27.00, 54.00, 29.00, 38.00),
(14, 'Cyberjaya', 'Klang', 43.00, 43.00, 21.00, 25.00, 52.00, 28.00, 35.00),
(15, 'Cyberjaya', 'Kuala Lumpur', 31.00, 31.00, 15.00, 18.00, 37.00, 21.00, 27.00),
(16, 'Georgetown', 'Putrajaya', 54.00, 54.00, 27.00, 32.00, 65.00, 35.00, 45.00),
(17, 'Georgetown', 'Seremban', 70.00, 70.00, 35.00, 42.00, 84.00, 49.00, 59.00),
(18, 'Georgetown', 'Sungai Petani', 60.00, 60.00, 30.00, 36.00, 72.00, 42.00, 54.00),
(19, 'Georgetown', 'Taiping', 23.00, 23.00, 11.00, 13.00, 28.00, 16.00, 20.00),
(20, 'Ipoh', 'Kangar', 38.00, 38.00, 19.00, 23.00, 46.00, 26.00, 32.00),
(21, 'Ipoh', 'Klang', 44.00, 44.00, 22.00, 26.00, 53.00, 29.00, 36.00),
(22, 'Ipoh', 'Kota Bharu', 55.00, 55.00, 27.00, 33.00, 66.00, 33.00, 49.00),
(23, 'Ipoh', 'Melaka', 28.00, 28.00, 14.00, 17.00, 34.00, 20.00, 24.00),
(24, 'Ipoh', 'Muar', 60.00, 60.00, 30.00, 36.00, 72.00, 36.00, 54.00),
(25, 'Johor Bahru', 'Seremban', 32.00, 32.00, 16.00, 19.00, 38.00, 22.00, 27.00),
(26, 'Johor Bahru', 'Shah Alam', 66.00, 66.00, 33.00, 40.00, 79.00, 43.00, 54.00),
(27, 'Johor Bahru', 'Sungai Petani', 39.00, 39.00, 19.00, 23.00, 46.00, 23.00, 32.00),
(28, 'Johor Bahru', 'Taiping', 31.00, 31.00, 15.00, 18.00, 37.00, 19.00, 27.00),
(29, 'Kangar', 'Kuala Terengganu', 49.00, 49.00, 24.00, 29.00, 59.00, 29.00, 43.00),
(30, 'Kangar', 'Kuantan', 41.00, 41.00, 20.00, 24.00, 49.00, 25.00, 34.00),
(31, 'Kangar', 'Melaka', 72.00, 72.00, 36.00, 43.00, 86.00, 45.00, 62.00),
(32, 'Kangar', 'Petaling Jaya', 23.00, 23.00, 11.00, 13.00, 28.00, 13.00, 20.00),
(33, 'Kota Bharu', 'Kuala Lumpur', 62.00, 62.00, 31.00, 37.00, 74.00, 37.00, 52.00),
(34, 'Kota Bharu', 'Kuantan', 55.00, 55.00, 27.00, 33.00, 66.00, 28.00, 49.00),
(35, 'Kota Bharu', 'Putrajaya', 59.00, 59.00, 29.00, 35.00, 70.00, 30.00, 49.00),
(36, 'Kota Bharu', 'Seremban', 64.00, 64.00, 32.00, 38.00, 77.00, 33.00, 53.00),
(37, 'Kuala Lumpur', 'Melaka', 41.00, 41.00, 20.00, 24.00, 49.00, 21.00, 34.00),
(38, 'Kuala Lumpur', 'Muar', 29.00, 29.00, 14.00, 17.00, 34.00, 15.00, 24.00),
(39, 'Kuala Lumpur', 'Petaling Jaya', 21.00, 21.00, 10.00, 13.00, 25.00, 11.00, 19.00),
(40, 'Kuala Lumpur', 'Shah Alam', 26.00, 26.00, 13.00, 15.00, 31.00, 14.00, 23.00),
(41, 'Kuala Terengganu', 'Taiping', 33.00, 33.00, 16.00, 20.00, 39.00, 19.00, 26.00),
(42, 'Kuala Terengganu', 'Putrajaya', 60.00, 60.00, 30.00, 36.00, 72.00, 36.00, 54.00),
(43, 'Kuala Terengganu', 'Cyberjaya', 57.00, 57.00, 28.00, 34.00, 68.00, 34.00, 51.00),
(44, 'Kuantan', 'Seremban', 36.00, 36.00, 18.00, 21.00, 43.00, 21.00, 27.00),
(45, 'Kuantan', 'Melaka', 29.00, 29.00, 14.00, 17.00, 35.00, 17.00, 23.00),
(46, 'Kuantan', 'Kuala Lumpur', 25.00, 25.00, 12.00, 15.00, 30.00, 15.00, 21.00),
(47, 'Melaka', 'Klang', 22.00, 22.00, 11.00, 13.00, 26.00, 13.00, 18.00),
(48, 'Melaka', 'Cyberjaya', 24.00, 24.00, 12.00, 14.00, 28.00, 14.00, 20.00),
(49, 'Melaka', 'Putrajaya', 25.00, 25.00, 12.00, 15.00, 30.00, 15.00, 21.00),
(50, 'Melaka', 'Petaling Jaya', 28.00, 28.00, 14.00, 17.00, 34.00, 17.00, 23.00),
(51, 'Muar', 'Ipoh', 23.00, 23.00, 11.00, 13.00, 28.00, 13.00, 18.00),
(52, 'Muar', 'Taiping', 30.00, 30.00, 15.00, 18.00, 36.00, 18.00, 24.00),
(53, 'Muar', 'Johor Bahru', 27.00, 27.00, 13.00, 16.00, 32.00, 16.00, 22.00),
(54, 'Muar', 'Shah Alam', 32.00, 32.00, 16.00, 19.00, 38.00, 19.00, 26.00),
(55, 'Petaling Jaya', 'Alor Setar', 58.00, 58.00, 29.00, 35.00, 70.00, 29.00, 46.00),
(56, 'Petaling Jaya', 'Georgetown', 45.00, 45.00, 22.00, 27.00, 54.00, 27.00, 35.00),
(57, 'Petaling Jaya', 'Sungai Petani', 38.00, 38.00, 19.00, 23.00, 46.00, 23.00, 30.00),
(58, 'Petaling Jaya', 'Taiping', 35.00, 35.00, 17.00, 21.00, 42.00, 21.00, 28.00),
(59, 'Putrajaya', 'Sungai Petani', 39.00, 39.00, 19.00, 23.00, 47.00, 23.00, 30.00),
(60, 'Putrajaya', 'Seremban', 20.00, 20.00, 10.00, 12.00, 24.00, 12.00, 16.00),
(61, 'Putrajaya', 'Shah Alam', 18.00, 18.00, 9.00, 11.00, 22.00, 11.00, 14.00),
(62, 'Putrajaya', 'Kangar', 60.00, 60.00, 30.00, 36.00, 72.00, 36.00, 48.00),
(63, 'Putrajaya', 'Kota Bharu', 52.00, 52.00, 26.00, 31.00, 62.00, 31.00, 42.00),
(64, 'Putrajaya', 'Melaka', 33.00, 33.00, 16.00, 20.00, 39.00, 19.00, 26.00),
(65, 'Putrajaya', 'Kuala Terengganu', 67.00, 67.00, 33.00, 40.00, 80.00, 40.00, 53.00),
(66, 'Putrajaya', 'Butterworth', 61.00, 61.00, 30.00, 36.00, 73.00, 36.00, 48.00),
(67, 'Putrajaya', 'Kuantan', 44.00, 44.00, 22.00, 26.00, 53.00, 26.00, 36.00),
(68, 'Putrajaya', 'Johor Bahru', 55.00, 55.00, 27.00, 33.00, 66.00, 33.00, 44.00),
(69, 'Putrajaya', 'Kuala Lumpur', 15.00, 15.00, 7.00, 9.00, 18.00, 9.00, 12.00),
(70, 'Putrajaya', 'Ipoh', 25.00, 25.00, 12.00, 15.00, 30.00, 15.00, 20.00),
(71, 'Putrajaya', 'Klang', 19.00, 19.00, 9.00, 11.00, 23.00, 11.00, 14.00),
(72, 'Putrajaya', 'Cyberjaya', 10.00, 10.00, 5.00, 6.00, 12.00, 6.00, 8.00),
(73, 'Putrajaya', 'Petaling Jaya', 17.00, 17.00, 8.00, 10.00, 20.00, 10.00, 13.00),
(74, 'Putrajaya', 'Taiping', 30.00, 30.00, 15.00, 18.00, 36.00, 18.00, 24.00),
(75, 'Putrajaya', 'Georgetown', 47.00, 47.00, 23.00, 28.00, 56.00, 28.00, 36.00),
(76, 'Putrajaya', 'Muar', 29.00, 29.00, 14.00, 17.00, 35.00, 17.00, 23.00),
(77, 'Putrajaya', 'Alor Setar', 54.00, 54.00, 27.00, 32.00, 65.00, 32.00, 43.00),
(78, 'Putrajaya', 'Kangar', 61.00, 61.00, 30.00, 36.00, 73.00, 36.00, 48.00),
(79, 'Putrajaya', 'Sungai Petani', 58.00, 58.00, 29.00, 34.00, 70.00, 34.00, 45.00),
(80, 'Putrajaya', 'Seremban', 16.00, 16.00, 8.00, 10.00, 19.00, 10.00, 12.00),
(586, 'Ipoh', 'Seremban', 0.00, 10.00, 12.00, 14.00, 20.00, 20.00, 40.00);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `schedule_id` int(11) NOT NULL,
  `train_id` int(11) DEFAULT NULL,
  `route_id` int(11) DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`schedule_id`, `train_id`, `route_id`, `departure_time`, `arrival_time`) VALUES
(1, 113, 1, '09:59:00', '12:59:00'),
(2, 103, 2, '11:26:00', '14:26:00'),
(3, 122, 3, '09:11:00', '14:11:00'),
(4, 123, 4, '09:35:00', '13:35:00'),
(5, 129, 5, '08:53:00', '11:53:00'),
(6, 129, 6, '10:59:00', '14:59:00'),
(7, 116, 7, '10:52:00', '14:52:00'),
(8, 122, 8, '12:09:00', '17:09:00'),
(9, 129, 9, '12:49:00', '15:49:00'),
(10, 102, 10, '11:23:00', '15:23:00'),
(11, 123, 11, '12:00:00', '16:00:00'),
(12, 109, 12, '09:01:00', '14:01:00'),
(13, 101, 13, '11:20:00', '14:20:00'),
(14, 115, 14, '11:01:00', '15:01:00'),
(15, 110, 15, '10:20:00', '12:20:00'),
(16, 106, 16, '10:24:00', '15:24:00'),
(17, 114, 17, '08:33:00', '13:33:00'),
(18, 130, 18, '10:46:00', '15:46:00'),
(19, 123, 19, '08:32:00', '12:32:00'),
(20, 104, 20, '09:34:00', '12:34:00'),
(21, 126, 21, '12:27:00', '17:27:00'),
(22, 118, 22, '09:49:00', '13:49:00'),
(23, 109, 23, '11:01:00', '14:01:00'),
(24, 108, 24, '09:45:00', '11:45:00'),
(25, 108, 25, '09:38:00', '13:38:00'),
(26, 112, 26, '08:48:00', '11:48:00'),
(27, 110, 27, '08:56:00', '13:56:00'),
(28, 126, 28, '12:33:00', '14:33:00'),
(29, 112, 29, '09:27:00', '13:27:00'),
(30, 116, 30, '10:35:00', '15:35:00'),
(31, 125, 31, '11:39:00', '14:39:00'),
(32, 104, 32, '08:09:00', '12:09:00'),
(33, 103, 33, '08:20:00', '12:20:00'),
(34, 109, 34, '11:30:00', '16:30:00'),
(35, 122, 35, '12:16:00', '14:16:00'),
(36, 106, 36, '08:13:00', '12:13:00'),
(37, 130, 37, '10:25:00', '13:25:00'),
(38, 107, 38, '09:04:00', '14:04:00'),
(39, 104, 39, '12:08:00', '17:08:00'),
(40, 108, 40, '08:23:00', '13:23:00'),
(41, 109, 41, '08:35:00', '11:35:00'),
(42, 126, 42, '10:33:00', '13:33:00'),
(43, 122, 43, '10:26:00', '12:26:00'),
(44, 123, 44, '08:13:00', '12:13:00'),
(45, 102, 45, '11:43:00', '14:43:00'),
(46, 103, 46, '11:49:00', '16:49:00'),
(47, 118, 47, '08:19:00', '11:19:00'),
(48, 109, 48, '09:17:00', '12:17:00'),
(49, 114, 49, '10:32:00', '12:32:00'),
(50, 102, 50, '10:38:00', '15:38:00'),
(51, 110, 51, '12:41:00', '14:41:00'),
(52, 121, 52, '09:30:00', '14:30:00'),
(53, 119, 53, '10:45:00', '15:45:00'),
(54, 119, 54, '10:29:00', '14:29:00'),
(55, 110, 55, '12:19:00', '14:19:00'),
(56, 110, 56, '10:49:00', '15:49:00'),
(57, 125, 57, '09:49:00', '14:49:00'),
(58, 126, 58, '09:15:00', '13:15:00'),
(59, 102, 59, '11:43:00', '14:43:00'),
(60, 128, 60, '09:27:00', '11:27:00'),
(61, 129, 61, '11:46:00', '14:46:00'),
(62, 122, 62, '12:44:00', '14:44:00'),
(63, 122, 63, '10:40:00', '15:40:00'),
(64, 106, 64, '09:02:00', '11:02:00'),
(65, 127, 65, '11:50:00', '14:50:00'),
(66, 116, 66, '10:42:00', '13:42:00'),
(67, 103, 67, '09:48:00', '12:48:00'),
(68, 127, 68, '10:19:00', '15:19:00'),
(69, 123, 69, '12:22:00', '14:22:00'),
(70, 111, 70, '12:52:00', '15:52:00'),
(71, 117, 71, '10:34:00', '12:34:00'),
(72, 110, 72, '12:30:00', '16:30:00'),
(73, 112, 73, '08:07:00', '12:07:00'),
(74, 102, 74, '08:12:00', '11:12:00'),
(75, 128, 75, '12:19:00', '17:19:00'),
(76, 122, 76, '09:53:00', '11:53:00'),
(77, 120, 77, '12:19:00', '14:19:00'),
(78, 117, 78, '08:32:00', '13:32:00'),
(79, 103, 79, '11:42:00', '15:42:00'),
(80, 103, 80, '10:17:00', '12:17:00');

-- --------------------------------------------------------

--
-- Table structure for table `trains`
--

CREATE TABLE `trains` (
  `train_id` int(11) NOT NULL,
  `train_name` varchar(100) NOT NULL,
  `type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trains`
--

INSERT INTO `trains` (`train_id`, `train_name`, `type`) VALUES
(101, 'Trans Malaysia Express', NULL),
(102, 'KTM Utara', NULL),
(103, 'Sani Express', NULL),
(104, 'Ekspres Rakyat', NULL),
(105, 'Intercity Selatan', NULL),
(106, 'SP South Pacific', NULL),
(107, 'KTM Premier', NULL),
(108, 'Utara Jaya Express', NULL),
(109, 'Ekspres Timur', NULL),
(110, 'Fastline Selatan', NULL),
(111, 'Transcoast', NULL),
(112, 'Pantai Timur Express', NULL),
(113, 'Rapid Laju', NULL),
(114, 'Ekspres Wawasan', NULL),
(115, 'Global Liner', NULL),
(116, 'Mutiara Selatan', NULL),
(117, 'KTM Skyline', NULL),
(118, 'Metro Ekspres', NULL),
(119, 'Utara Laju', NULL),
(120, 'Klang Valley Liner', NULL),
(121, 'Borneo Express', NULL),
(122, 'Ekspres Langkawi', NULL),
(123, 'Putrajaya Link', NULL),
(124, 'Kuala Laju Express', NULL),
(125, 'Selatan Mover', NULL),
(126, 'KTM Nasional', NULL),
(127, 'TransAsia Ekspres', NULL),
(128, 'Rakyat Express', NULL),
(129, 'Perdana Liner', NULL),
(130, 'Duta Express', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `phone` varchar(20) NOT NULL,
  `phone_number` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `full_name`, `role`, `phone`, `phone_number`) VALUES
(3, 'idhamadha', '1234', 'idham@gmail.com', 'Wanidham', 'user', '0134523556', ''),
(5, 'idham123', '13456', 'idham@gmail.com', 'Wanidham', 'user', '0134567897', NULL),
(6, 'idham1', '1234', 'idham@gmail.com', 'Wanidham', 'user', '0134567897', NULL),
(9, 'adha123', 'adha123', 'adha@gmail.com', 'adha', 'user', '0131231234', NULL),
(10, 'wan', 'wan', 'wan@gmail.com', 'wan', 'admin', '0134354566', NULL),
(11, 'adha', 'adha', 'adha@gmail.com', 'adha', 'user', '013223456', NULL),
(12, 'adha1234', 'adha1234', 'adha@gmail.com', 'adha', 'user', '0134567890', NULL),
(15, 'amirah', '1234', 'muhdamir248@gmail.com', 'MUHAMAD AMIR BIN RUSLI', 'user', '01947135357', NULL),
(16, 'iman', 'iman', 'khairuliman736@gmail.com', 'Khairul Iman', 'user', '01111013816', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookings`
--
ALTER TABLE `bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `contact_us`
--
ALTER TABLE `contact_us`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `booking_id` (`booking_id`);

--
-- Indexes for table `routes`
--
ALTER TABLE `routes`
  ADD PRIMARY KEY (`route_id`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`schedule_id`),
  ADD KEY `train_id` (`train_id`),
  ADD KEY `route_id` (`route_id`);

--
-- Indexes for table `trains`
--
ALTER TABLE `trains`
  ADD PRIMARY KEY (`train_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bookings`
--
ALTER TABLE `bookings`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `contact_us`
--
ALTER TABLE `contact_us`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `routes`
--
ALTER TABLE `routes`
  MODIFY `route_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=587;

--
-- AUTO_INCREMENT for table `schedule`
--
ALTER TABLE `schedule`
  MODIFY `schedule_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `trains`
--
ALTER TABLE `trains`
  MODIFY `train_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=133;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`schedule_id`) REFERENCES `schedule` (`schedule_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
