DROP DATABASE ukr_zaliznitca;
CREATE DATABASE ukr_zaliznitca;
USE ukr_zaliznitca;
# SHOW TABLES; 

CREATE TABLE Ranges (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);
CREATE TABLE Departments (id INT AUTO_INCREMENT PRIMARY KEY,
		title CHAR(255) NOT NULL);

CREATE TABLE Employees (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL, 
		full_name CHAR(255) NOT NULL, 
        rang_id INT NOT NULL,
		department_id INT NOT NULL, 
        team_id INT NOT NULL, 
        count_of_children INT,
        sex ENUM('Чоловік', 'Жінка', 'Не визначився', 'інше'), 
        salary INT NOT NULL, 
        overview BOOL NOT NULL, 
        age INT NOT NULL,
        FOREIGN KEY (rang_id) REFERENCES Ranges(id),
        FOREIGN KEY (department_id)  REFERENCES Departments(id));
        
CREATE TABLE Locomotives (id INT PRIMARY KEY AUTO_INCREMENT NOT NULL , 
		count_of_completed_routes INT NOT NULL, 
        main_station CHAR(255) NOT NULL, 
        arival_time DATETIME NOT NULL,
		last_techical_overview DATE , 
        last_repair DATE , 
        repairs_count INT NOT NULL, 
        locomotiv_age INT NOT NULL,
        locomotive_team_department_number INT NOT NULL, 
        locomotive_team_number INT NOT NULL, 
        tech_team_department_number INT NOT NULL, 
        tech_team_number INT NOT NULL);

DROP TABLE Employees;
DROP TABLE Locomotives;

DROP TABLE Ranges;
DROP TABLE Departments;
# DROP TABLE ;



# drop table Locomotives;