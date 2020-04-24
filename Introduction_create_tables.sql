CREATE DATABASE ukr_zaliznitca;
USE ukr_zaliznitca;
SHOW TABLES;
CREATE TABLE Employees (Registration_number INT, Full_name CHAR(100), Rang CHAR(50), Department_number INT,
		Team INT, Count_of_children INT, Sex CHAR, Salary INT, Overview CHAR(3), Age INT);
CREATE TABLE Locomotives (Registration_number INT, Count_of_completed_routes INT, Main_station CHAR(50), Arival_time DATETIME,
		Last_techical_overview DATE, Last_repair DATE, Repairs_count INT, Locomotiv_age INT,
        Locomotive_team_department_number INT, Locomotive_team_number INT, Tech_team_department_number INT, Tech_team_number INT);
drop table Locomotives;