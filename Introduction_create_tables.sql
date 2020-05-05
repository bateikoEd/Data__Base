DROP DATABASE ukr_zaliznitca;
CREATE DATABASE ukr_zaliznitca;
USE ukr_zaliznitca;

ALTER DATABASE ukr_zaliznitca CHARACTER SET utf8 COLLATE utf8_unicode_ci;

CREATE TABLE ranges (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE departments (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE stations (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE delays (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE types_journey (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE types_train (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE routs (id INT AUTO_INCREMENT PRIMARY KEY,
		start_station_id INT NOT NULL,
        end_station_id INT NOT NULL);
        
CREATE TABLE employees (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
		full_name CHAR(255) NOT NULL, 
        rang_id INT NOT NULL,
		department_id INT NOT NULL, 
        team_id INT, 
        count_of_children INT,
        sex ENUM('Чоловік', 'Жінка', 'Не визначився', 'інше') NOT NULL, 
        salary INT NOT NULL, 
        overview BOOL NOT NULL, 
        age INT NOT NULL,
        experiance INT NOT NULL,
        FOREIGN KEY (rang_id) REFERENCES ranges(id),
        FOREIGN KEY (department_id)  REFERENCES departments(id));
        
CREATE TABLE locomotives (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL , 
		count_of_completed_routes INT NOT NULL, 
        main_station_id INT NOT NULL,
        current_station_id INT NOT NULL,
        arival_time DATETIME NOT NULL,
		last_techical_overview DATE , 
        last_repair DATE , 
        repairs_count INT NOT NULL, 
        locomotiv_age INT NOT NULL,
        locomotive_team_department_id INT NOT NULL, 
        locomotive_team_id INT NOT NULL, 
        tech_team_department_id INT NOT NULL, 
        tech_team_id INT NOT NULL,
        FOREIGN KEY (main_station_id) REFERENCES stations(id),
        FOREIGN KEY (current_station_id) REFERENCES stations(id),
        FOREIGN KEY (locomotive_team_department_id) REFERENCES departments(id),
        FOREIGN KEY (tech_team_department_id) REFERENCES departments(id));
        
CREATE TABLE journeys (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
		rout_id INT NOT NULL,
        canceled BOOL NOT NULL,
        delay_id INT NOT NULL,
        beginning_delay DATETIME,
        end_delay DATETIME,
        departure_time DATETIME NOT NULL,
		arrival_time DATETIME NOT NULL,
        price_ticket INT NOT NULL,
        type_journey INT NOT NULL,
        type_train INT NOT NULL,
        # international_or_internal BOOL NOT NULL,
        FOREIGN KEY (rout_id) REFERENCES routs(id),
        FOREIGN KEY (delay_id) REFERENCES delays(id),
        FOREIGN KEY (type_journey) REFERENCES types_journey(id),
        FOREIGN KEY (type_train) REFERENCES types_train(id));
        
CREATE TABLE tickets (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
		full_name CHAR(255) NOT NULL,
        journey_id INT NOT NULL,
        carload_id INT NOT NULL,
		seat_number INT NOT NULL,
		ticket_status ENUM('заброньовано', 'куплено', 'повернено') NOT NULL,
		buying_time DATETIME,
		return_time DATETIME,
		price INT NOT NULL,
		sex ENUM('Чоловік', 'Жінка', 'Не визначився', 'інше') NOT NULL,
		age INT NOT NULL,
        handed_luggage BOOL NOT NULL,
		FOREIGN KEY (journey_id) REFERENCES journeys(id));
        
CREATE TABLE preparation_for_the_journey ( journey_id INT NOT NULL PRIMARY KEY,
		technical_inspection BOOL NOT NULL,
        minor_repairs BOOL NOT NULL,
        cleaning_of_cars BOOL NOT NULL,
        replenishment BOOL NOT NULL,
        FOREIGN KEY (journey_id) REFERENCES journeys(id));