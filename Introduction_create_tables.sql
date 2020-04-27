DROP DATABASE ukr_zaliznitca;
CREATE DATABASE ukr_zaliznitca;
USE ukr_zaliznitca;

ALTER DATABASE ukr_zaliznitca CHARACTER SET utf8 COLLATE utf8_unicode_ci;

# DROP TABLE Employees;
# DROP TABLE Locomotives;
# DROP TABLE Ranges;
# DROP TABLE Departments;

CREATE TABLE Ranges (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Departments (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Stations (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Delays (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Routs (id INT AUTO_INCREMENT PRIMARY KEY,
		start_station_id INT NOT NULL,
        end_station_id INT NOT NULL);
CREATE TABLE Ticket_statuses(id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Employees (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
		full_name CHAR(255) NOT NULL, 
        rang_id INT NOT NULL,
		department_id INT NOT NULL, 
        team_id INT NOT NULL, 
        count_of_children INT,
        sex ENUM('Чоловік', 'Жінка', 'Не визначився', 'інше') NOT NULL, 
        salary INT NOT NULL, 
        overview BOOL NOT NULL, 
        age INT NOT NULL,
        FOREIGN KEY (rang_id) REFERENCES Ranges(id),
        FOREIGN KEY (department_id)  REFERENCES Departments(id));
CREATE TABLE Locomotives (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL , 
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
        FOREIGN KEY (main_station_id) REFERENCES Stations(id),
        FOREIGN KEY (current_station_id) REFERENCES Stations(id),
        FOREIGN KEY (locomotive_team_department_id) REFERENCES Departments(id),
        FOREIGN KEY (tech_team_department_id) REFERENCES Departments(id));
CREATE TABLE Journeys (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
		rout_id INT NOT NULL,
        canceled BOOL NOT NULL,
        delay_id INT NOT NULL,
        beginning_delay DATETIME,
        end_delay DATETIME,
        departure_time DATETIME NOT NULL,
		arrival_time DATETIME NOT NULL,
        international_or_internal BOOL NOT NULL,
        FOREIGN KEY (rout_id) REFERENCES Routs(id),
        FOREIGN KEY (delay_id) REFERENCES Delays(id));
CREATE TABLE Tickets (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL ,
	journey_id INT NOT NULL,
    full_name CHAR(255) NOT NULL,
    ticket_status_id INT NOT NULL,
    buying_time DATETIME,
    return_time DATETIME,
    price INT NOT NULL,
    carload_id INT NOT NULL,
    seat_number INT NOT NULL,
    sex ENUM('Чоловік', 'Жінка', 'Не визначився', 'інше') NOT NULL,
    age INT NOT NULL,
    FOREIGN KEY (journey_id) REFERENCES Journeys(id),
    FOREIGN KEY (ticket_status_id) REFERENCES Ticket_statuses(id));
CREATE TABLE Preparation_for_the_journey (journey_id INT NOT NULL,
		technical_inspection BOOL NOT NULL,
        minor_repairs BOOL NOT NULL,
        cleaning_of_cars BOOL NOT NULL,
        replenishment BOOL NOT NULL,
        FOREIGN KEY (journey_id) REFERENCES Journeys(id));

    