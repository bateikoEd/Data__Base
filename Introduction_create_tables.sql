DROP DATABASE ukr_zaliznitca;
CREATE DATABASE ukr_zaliznitca;
USE ukr_zaliznitca;
# SHOW TABLES; 

CREATE TABLE Ranges (id INT AUTO_INCREMENT PRIMARY KEY, title CHAR(255) NOT NULL);
CREATE TABLE Department (id INT AUTO_INCREMENT PRIMARY KEY, title CHAR(255) NOT NULL);

CREATE TABLE Employees (id INT PRIMARY KEY AUTO_INCREMENT, full_name CHAR(255), rang_id INT,
		department_id INT, team_id INT, count_of_children INT,
        Sex ENUM(), Salary INT, Overview ENUM, Age INT, );
        
CREATE TABLE Locomotives (Registration_number INT, Count_of_completed_routes INT, Main_station CHAR(50), Arival_time DATETIME,
		Last_techical_overview DATE, Last_repair DATE, Repairs_count INT, Locomotiv_age INT,
        Locomotive_team_department_number INT, Locomotive_team_number INT, Tech_team_department_number INT, Tech_team_number INT);


drop table Locomotives;