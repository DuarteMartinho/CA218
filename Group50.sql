-- Group 50
-- Duarte Martinho
-- Liam Molloy

CREATE DATABASE IF NOT EXISTS `project`;
USE project;

-- 
-- 
-- QUESTION 4
-- 
-- 
CREATE TABLE IF NOT EXISTS `customer` (
	`customerID` VARCHAR(10) NOT NULL,
	`customerName` VARCHAR(100) NULL DEFAULT NULL,
	`customerDOB` DATE NULL DEFAULT NULL,
	`customerPhoneNumber` VARCHAR(11) NULL DEFAULT NULL,
	`email` VARCHAR(250) NULL DEFAULT NULL,
	`password` VARCHAR(100) NULL DEFAULT NULL,
	PRIMARY KEY (`customerID`)
);

CREATE TABLE IF NOT EXISTS `staff` (
	`staffID` VARCHAR(20) NOT NULL,
	`staffName` VARCHAR(100) NULL DEFAULT NULL,
	`staffDOB` DATE NULL DEFAULT NULL,
	`staffStartDate` DATE NULL DEFAULT NULL,
	`staffPosition` VARCHAR(100) NULL DEFAULT NULL,
	`staffSalary` INT(11) NULL DEFAULT NULL,
	`staffEmail` VARCHAR(250) NULL DEFAULT NULL,
	`staffPhoneNumber` VARCHAR(15) NULL DEFAULT NULL,
	PRIMARY KEY (`staffID`)
);

CREATE TABLE IF NOT EXISTS `routes` (
	`routeID` VARCHAR(20) NOT NULL,
	`origin` VARCHAR(50) NULL DEFAULT NULL,
	`destination` VARCHAR(50) NULL DEFAULT NULL,
	`flightNumbers` LONGTEXT NULL DEFAULT NULL,
	PRIMARY KEY (`routeID`)
);

CREATE TABLE IF NOT EXISTS `flights` (
	`flightID` VARCHAR(15) NOT NULL,
	`routeID` VARCHAR(20) NULL DEFAULT NULL,
	`flightCapacity` INT(11) NULL DEFAULT '0',
	`flightTicketsSold` INT(11) NULL DEFAULT '0',
	`departureTime` DATETIME NULL DEFAULT NULL,
	`arrivalTime` DATETIME NULL DEFAULT NULL,
	PRIMARY KEY (`flightID`),
	INDEX `routeID` (`routeID`),
	CONSTRAINT `FK_flights_routes` FOREIGN KEY (`routeID`) REFERENCES `project`.`routes` (`routeID`)
);

CREATE TABLE IF NOT EXISTS `tickets` (
	`ticketID` VARCHAR(10) NOT NULL,
	`flightID` VARCHAR(10) NULL DEFAULT NULL,
	`passengerName` VARCHAR(100) NULL DEFAULT NULL,
	`passengerDOB` DATE NULL DEFAULT NULL,
	`passengerSeat` VARCHAR(6) NULL DEFAULT NULL,
	`passengerPassportNumber` VARCHAR(150) NULL DEFAULT NULL,
	`passengerCovidCert` VARCHAR(1) NULL DEFAULT NULL,
	`boardingType` VARCHAR(50) NULL DEFAULT NULL,
	`ticketClass` VARCHAR(50) NULL DEFAULT NULL,
	`extras` VARCHAR(50) NULL DEFAULT NULL,
	PRIMARY KEY (`ticketID`),
	INDEX `flightID` (`flightID`),
	CONSTRAINT `FK_tickets_flights` FOREIGN KEY (`flightID`) REFERENCES `project`.`flights` (`flightID`)
);


CREATE TABLE IF NOT EXISTS `orders` (
	`orderID` VARCHAR(10) NOT NULL,
	`customerID` VARCHAR(50) NULL DEFAULT NULL,
	`orderDateTime` DATETIME NULL DEFAULT NULL,
	`amountPaid` FLOAT NOT NULL DEFAULT '0',
	`creditCardNum` VARCHAR(20) NULL DEFAULT NULL,
	`creditCardExp` VARCHAR(10) NULL DEFAULT NULL,
	`listOfTickets` LONGTEXT NULL DEFAULT NULL,
	`numOfTickets` INT(11) NOT NULL DEFAULT '0',
	PRIMARY KEY (`orderID`),
	INDEX `customerID` (`customerID`),
	CONSTRAINT `FK` FOREIGN KEY (`customerID`) REFERENCES `project`.`customer` (`customerID`)
);

CREATE TABLE IF NOT EXISTS `inflightpurchases` (
	`InFlightID` VARCHAR(20) NOT NULL,
	`ticketID` VARCHAR(20) NULL DEFAULT NULL,
	` itemsPurchased` LONGTEXT NULL DEFAULT NULL,
	`amountPaid` FLOAT NULL DEFAULT NULL,
	PRIMARY KEY (`InFlightID`),
	INDEX `ticketID` (`ticketID`),
	CONSTRAINT `FK_inflightpurchases_tickets` FOREIGN KEY (`ticketID`) REFERENCES `project`.`tickets` (`ticketID`)
);

-- 
-- 
-- QUESTION 5
-- 
-- 
INSERT INTO `customer` VALUES
('CAA0001', 'John Doe', '1997-08-09', '894571234', 'john.doe@gmail.com', 'JohnDoe123'),
('CAA0002', 'Mary Woods', '1978-02-13', '891245754', 'mary.woods@gmail.com', 'MaryW00ds'),
('CAA0003', 'Jen Brooks', '2000-11-11', '871412456', 'jen.brooks@gmail.com', 'Jen@Brooks!');

INSERT INTO `routes` VALUES
('R00001', 'DUBLIN', 'AMSTERDAN', '[FR0043, FR0099]'),
('R00002', 'DUBLIN', 'MANCHESTER', '[FR1100, FR1345, FR1934]'),
('R00003', 'DUBLIN', 'MADRID', '[FR2578]'),
('R00004', 'DUBLIN', 'LISBON', '[FR3152]'),
('R00005', 'DUBLIN', 'EDINBURGH', '[FR3875, FR4578]'),
('R00006', 'DUBLIN', 'BARCELONA', '[FR5478]'),
('R00007', 'DUBLIN', 'PARIS', '[FR7896]');

INSERT INTO `flights` VALUES
('FR0043', 'R00001', 120, 0, '2021-12-11 06:45:00', '2021-12-11 09:15:00'),
('FR0099', 'R00001', 120, 0, '2021-12-11 18:05:00', '2021-12-11 20:35:00'),
('FR1100', 'R00002', 150, 0, '2021-12-11 09:45:00', '2021-12-11 10:45:00'),
('FR1345', 'R00002', 150, 0, '2021-12-11 13:25:00', '2021-12-11 14:25:00'),
('FR1934', 'R00002', 150, 0, '2021-12-11 19:00:00', '2021-12-11 20:00:00'),
('FR2578', 'R00003', 120, 0, '2021-12-11 12:45:00', '2021-12-11 15:00:00'),
('FR3152', 'R00004', 150, 0, '2021-12-11 06:00:00', '2021-12-11 08:20:00'),
('FR3875', 'R00005', 150, 0, '2021-12-11 11:45:00', '2021-12-11 13:30:00'),
('FR4578', 'R00005', 110, 0, '2021-12-11 20:15:00', '2021-12-11 22:00:00'),
('FR5478', 'R00006', 110, 0, '2021-12-11 21:00:00', '2021-12-11 23:45:00'),
('FR7896', 'R00007', 150, 0, '2021-12-11 10:05:00', '2021-12-11 12:35:00');

INSERT INTO `tickets` VALUES
('T0000001A', 'FR1345', 'John Doe', '1997-08-09', '16A', 'A12345678', 'Y', 'Front', 'Priority', ''),
('T0000002A', 'FR1345', 'Brandom Doe', '1996-07-11', '16B', 'B12304566', 'Y', 'Front', 'Priority', ''),
('T0000003A', 'FR1345', 'Zack Doe', '1999-11-04', '16C', 'X17891892', 'Y', 'Front', 'Priority', ''),
('T0000004A', 'FR4578', 'Jen Brooks', '2000-11-11', '08A', 'Z89465486', 'Y', 'Front', 'NotPriority', ''),
('T0000005A', 'FR4578', 'Bradley Brooks', '1999-12-29', '08B', 'G12378925', 'Y', 'Front', 'NotPriority', ''),
('T0000006A', 'FR7896', 'Mary Woods', '1978-02-13', '20B', 'P48964567', 'Y', 'Back', 'Priority', ''),
('T0000007A', 'FR7896', 'Jaylyn Woods', '1977-08-19', '21B', 'Y89475645', 'Y', 'Back', 'Priority', 'Child Trolley'),
('T0000008A', 'FR7896', 'Roxane Woods', '2000-11-16', '20A', 'I45454545', 'Y', 'Back', 'Priority', ''),
('T0000009A', 'FR7896', 'Cierra Woods', '2003-09-06', '21A', 'R84784784', 'Y', 'Back', 'Priority', ''),
('T0000010A', 'FR7896', 'Eden Woods', '20018-01-11', '21C', 'L12344321', 'Y', 'Back', 'Priority', '');

-- ORDER 1
INSERT INTO `orders` VALUES ('OAA0001', 'CAA0001', '2021-12-07 08:50', '689.45', '1234 1234 1234 1234', '06/25', '[T0000001A,T0000002A,T0000003A]', '3');
-- UPDATE TICKETS SOLD IN FLIGHTS TABLE
UPDATE `flights` SET flightTicketsSold = (SELECT flightTicketsSold FROM `flights` WHERE flightID = 'FR1345') + 3 WHERE flightID = 'FR1345';


-- ORDER 2
INSERT INTO `orders` VALUES ('OAA0002', 'CAA0003', '2021-12-07 10:01', '100.00', '0000 0000 0000 0000', '02/24', '[T0000004A,T0000005A]', '2');
-- UPDATE TICKETS SOLD IN FLIGHTS TABLE
UPDATE `flights` SET flightTicketsSold = (SELECT flightTicketsSold FROM `flights` WHERE flightID = 'FR4578') + 2 WHERE flightID = 'FR4578';


-- ORDER 3
INSERT INTO `orders` VALUES ('OAA0003', 'CAA0002', '2021-12-07 11:23', '1500.34', '1212 1212 1212 1212', '09/28', '[T0000006A,T0000007A,T0000008A,T0000009A,T0000010A]', '5');
-- UPDATE TICKETS SOLD IN FLIGHTS TABLE
UPDATE `flights` SET flightTicketsSold = (SELECT flightTicketsSold FROM `flights` WHERE flightID = 'FR7896') + 5 WHERE flightID = 'FR7896';


INSERT INTO `staff` VALUES
('S0001', 'Brittany Nichols', '1994-06-12', '2020-11-01', 'Pilot', '100000', 'BrittanyNichols@gmail.com', '89235689'),
('S0002', 'Perry Walter', '1990-12-01', '2021-01-01', 'Flight Attendant', '60000', 'PerryWalter@gmail.com', '875647891'),
('S0003', 'Jed Mccormick', '1989-01-27', '2018-05-01', 'Surpervisor', '85000', 'JedMccormick@gmail.com', '891456010'),
('S0004', 'Henry Holman', '1991-08-30', '2020-12-15', 'Flight Attendant', '60000', 'HenryHolman@gmail.com', '897819284');

INSERT INTO `inflightpurchases` VALUES
('INF0001', 'T0000007A', '["hotchocolate"]', 2.5),
('INF0002', 'T0000001A', '["water"]', 2),
('INF0003', 'T0000002A', '["peanutes_salted"]', 4),
('INF0004', 'T0000003A', '["coca-cola", "sandwich"]',7);

