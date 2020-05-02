DROP PROCEDURE IF EXISTS employees_all_and_count;
DROP PROCEDURE IF EXISTS employees_rang_and_count;
DROP PROCEDURE IF EXISTS employees_departament_and_count;
DROP PROCEDURE IF EXISTS employees_age_and_count;
DROP PROCEDURE IF EXISTS employees_child_and_count;
DROP PROCEDURE IF EXISTS employees_sex_and_count;
DROP PROCEDURE IF EXISTS employees_experiance_and_count;
DROP PROCEDURE IF EXISTS employees_all_team_and_count;
DROP PROCEDURE IF EXISTS employees_salary_and_count;
DROP PROCEDURE IF EXISTS employees_team_average_sum_salary_and_count;
DROP PROCEDURE IF EXISTS employees_team_in_department_and_count;
DROP PROCEDURE IF EXISTS employees_team_age_and_count;
DROP PROCEDURE IF EXISTS employees_locomotive_and_count;
DROP PROCEDURE IF EXISTS employees_overview_count;
DROP PROCEDURE IF EXISTS employees_rang_salary_and_count;
DROP PROCEDURE IF EXISTS employees_rang_sex_and_count;
DROP PROCEDURE IF EXISTS locomotives_now_in_the_same_station_as_main_and_count;
DROP PROCEDURE IF EXISTS locomotives_arival_time_and_count;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;
DROP PROCEDURE IF EXISTS name_proc;

DELIMITER // 
CREATE PROCEDURE employees_all_and_count(OUT count_employees INT)
BEGIN
	SELECT COUNT(*) INTO count_employees FROM employees;
    SELECT * FROM employees_view;
    SELECT count_employees AS 'К-сть працівників';
END //
DELIMITER ;

# CALL employees_all_and_count(@count_employees);

DELIMITER // 
CREATE PROCEDURE employees_rang_and_count(IN rang_id INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.rang_id = rang_id;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.rang_id = rang_id;
    SELECT count_employees;
END //
DELIMITER ;

CALL employees_rang_and_count(2,@count_employees_rang);

DELIMITER // 
CREATE PROCEDURE employees_departament_and_count(IN departament_id INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.department_id = departament_id;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.department_id = departament_id;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_departament_and_count(1, @count_employees_departament);

DELIMITER // 
CREATE PROCEDURE employees_age_and_count(IN min_age INT, IN max_age INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE min_age <= employees.age and employees.age <= max_age;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE min_age <= employees.age and employees.age <= max_age;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_age_and_count(10, 40,@count_employees_experience);

DELIMITER // 
CREATE PROCEDURE employees_child_and_count(OUT count_employees INT)
BEGIN
	DECLARE count_withoud_child INTEGER;
    
	SELECT COUNT(*) INTO count_withoud_child FROM employees;
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.count_of_children > 0;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.count_of_children > 0;
    
    SET count_withoud_child = count_withoud_child - count_employees;
    
    SELECT count_employees, count_withoud_child;
    
    
END //
DELIMITER ;

CALL employees_child_and_count(@count_employees_child);

DELIMITER // 
CREATE PROCEDURE employees_sex_and_count(IN sex INT, OUT count_employees_sex INT)
BEGIN    
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.sex = sex;
    
    SELECT COUNT(*) INTO count_employees_sex FROM employees
    WHERE employees.sex = sex;
    
    SELECT count_employees_sex;
END //
DELIMITER ;

# CALL employees_sex_and_count(3,@count_employees_sex);

DELIMITER // 
CREATE PROCEDURE employees_experiance_and_count(IN min_experiance INT, IN max_experiance INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE min_experiance <= employees.experiance and employees.experiance <= max_experiance;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE min_experiance <= employees.experiance and employees.experiance <= max_experiance;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_experiance_and_count(1,3,@count_employees_experiance);

DELIMITER // 
CREATE PROCEDURE employees_salary_and_count(IN min_salary INT, IN max_salary INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE min_salary <= employees.salary and employees.salary <= max_salary;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE min_salary <= employees.salary and employees.salary <= max_salary;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_salary_and_count(100,30000,@count_employees_salary);

DELIMITER // 
CREATE PROCEDURE employees_all_team_and_count(OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.rang_id > 1;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.rang_id > 1;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_all_team_and_count(@count_employees_all_team);

DELIMITER // 
CREATE PROCEDURE employees_team_in_department_and_count(IN department_id INT, IN team_id INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.department_id = department_id and employees.team_id = team_id;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.department_id = department_id and employees.team_id = team_id;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_team_in_department_and_count(1,1,@count_employees_all_team);

DELIMITER // 
CREATE PROCEDURE employees_team_average_sum_salary_and_count(IN department_id INT, IN team_id INT, OUT sum_salary INT, OUT avg_salary INT)
BEGIN
	SELECT  departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			AVG(employees.salary) AS 'Середня зарплата',
			SUM(employees.salary) AS 'Сумарна зарплата'
	FROM employees
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.department_id = department_id and employees.team_id = team_id;
    
    SELECT AVG(employees.salary) INTO avg_salary FROM employees
    WHERE employees.department_id = department_id and employees.team_id = team_id;
    
    SELECT SUM(employees.salary) INTO sum_salary FROM employees
    WHERE employees.department_id = department_id and employees.team_id = team_id;
END //
DELIMITER ;

# CALL employees_team_average_sum_salary_and_count(1,1,@sum_salary, @avg_salary);

DELIMITER // 
CREATE PROCEDURE employees_team_age_and_count(IN department_id INT, IN team_id INT,IN min_age INT, IN max_age INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.department_id = department_id and employees.team_id = team_id 
		and min_age <= employees.age and employees.age <= max_age;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.department_id = department_id and employees.team_id = team_id 
		and min_age <= employees.age and employees.age <= max_age;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_team_age_and_count(1,1,15,30,@count_employees_in_team_age)

DELIMITER // 
CREATE PROCEDURE employees_locomotive_and_count(IN locomotive_id INT, OUT count_employees INT)
BEGIN

	DECLARE locomotive_team_department_id INT;
	DECLARE tech_team_department_id INT;
	DECLARE locomotive_team_id INT;
	DECLARE tech_team_id INT;
    
    SELECT locomotives.locomotive_team_department_id INTO locomotive_team_department_id
	FROM locomotives
	WHERE locomotives.id = locomotive_id;
        
    SELECT locomotives.tech_team_department_id INTO tech_team_department_id
	FROM locomotives
	WHERE locomotives.id = locomotive_id;
    
    SELECT locomotives.locomotive_team_id INTO locomotive_team_id
	FROM locomotives
	WHERE locomotives.id = locomotive_id;
    
    SELECT locomotives.tech_team_id INTO tech_team_id
	FROM locomotives
	WHERE locomotives.id = locomotive_id;
    
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE (employees.department_id = locomotive_team_department_id AND employees.team_id = locomotive_team_id) 
		OR (employees.department_id = tech_team_department_id AND employees.team_id = tech_team_id);
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE (employees.department_id = locomotive_team_department_id AND employees.team_id = locomotive_team_id) 
		OR (employees.department_id = tech_team_department_id AND employees.team_id = tech_team_id);
    
    SELECT count_employees;
END //
DELIMITER ;

CALL employees_locomotive_and_count(1, @count_employees_locomotive);

DELIMITER // 
CREATE PROCEDURE employees_rang_overview_count(IN rang_id INT, IN done_overview	BOOL, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
	FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.rang_id = rang_id and employees.overview = done_overview;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.rang_id = rang_id and employees.overview = done_overview;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_rang_overview_count(2,0, @count_employees_overview);

DELIMITER // 
CREATE PROCEDURE employees_rang_salary_and_count(IN rand_id INT,IN min_salary INT, IN max_salary INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE min_salary <= employees.salary and employees.salary <= max_salary and employees.rang_id = rand_id;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE min_salary <= employees.salary and employees.salary <= max_salary and employees.rang_id = rand_id;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_rang_salary_and_count(2, 100,30000,@count_employees_salary);

DELIMITER // 
CREATE PROCEDURE employees_rang_sex_and_count(IN rang_id INT, IN sex INT, OUT count_employees_sex INT)
BEGIN    
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE employees.sex = sex and employees.rang_id = rang_id;
    
    SELECT COUNT(*) INTO count_employees_sex FROM employees
    WHERE employees.sex = sex and employees.rang_id = rang_id;
    
    SELECT count_employees_sex;
END //
DELIMITER ;

# CALL employees_rang_sex_and_count(1,1,@count_employees_sex);

DELIMITER // 
CREATE PROCEDURE employees_rang_age_and_count(IN rang_id INT, IN min_age INT, IN max_age INT, OUT count_employees INT)
BEGIN
	SELECT  employees.id AS 'ідентифікаційний код', 
			employees.full_name AS 'ПІБ', 
			ranges.title AS 'Посада', 
			departments.title AS 'Департамент', 
			employees.team_id AS 'Номер бригади',
			employees.count_of_children AS 'К-сть дітей',
			employees.sex AS 'Стать', 
			employees.salary AS 'Зарплата', 
			IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
			employees.age AS 'Вік',
			employees.experiance AS 'Стаж'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.department_id = departments.id
	WHERE min_age <= employees.age and employees.age <= max_age and employees.rang_id = rang_id;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE min_age <= employees.age and employees.age <= max_age and employees.rang_id = rang_id;
    SELECT count_employees;
END //
DELIMITER ;

# CALL employees_rang_age_and_count(1, 10, 32,@count_employees_experience);

DELIMITER // 
CREATE PROCEDURE locomotives_now_in_the_same_station_as_main_and_count(OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
    WHERE locomotives.main_station_id = locomotives.current_station_id;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE locomotives.main_station_id = locomotives.current_station_id;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_now_in_the_same_station_as_main_and_count(@count_locomotives_in_the_same_station);

DELIMITER // 
CREATE PROCEDURE locomotives_arival_time_and_count(IN arival_time DATETIME,OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
    WHERE locomotives.arival_time = arival_time;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE locomotives.arival_time = arival_time;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_arival_time_and_count('2020-05-02 13:45:33',@count_locomotives_in_the_same_station);

DELIMITER // 
CREATE PROCEDURE locomotives_count_of_completed_routes_and_count(IN count_of_completed_routes INT,OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
    WHERE locomotives.count_of_completed_routes = count_of_completed_routes;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE locomotives.count_of_completed_routes = count_of_completed_routes;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_count_of_completed_routes_and_count(50,@count_locomotives_in_the_same_station);

DELIMITER // 
CREATE PROCEDURE locomotives_period_of_last_techical_overview_and_count(IN last_techical_overview_first DATE,IN last_techical_overview_second DATE,OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
    WHERE  last_techical_overview_first <= locomotives.last_techical_overview 
		and locomotives.last_techical_overview <= last_techical_overview_second;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE  last_techical_overview_first <= locomotives.last_techical_overview 
		and locomotives.last_techical_overview <= last_techical_overview_second;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_period_of_last_techical_overview_and_count('2019-01-01', '2020-01-01',@count_locomotives_period_of_last_techical_overview);

DELIMITER // 
CREATE PROCEDURE locomotives_last_repair_and_count(IN last_repair DATE,OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
    WHERE locomotives.last_repair = last_repair;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE  locomotives.last_repair = last_repair;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_last_repair_and_count('2019-10-30', @count_locomotives_period_of_last_techical_overview);

DELIMITER // 
CREATE PROCEDURE locomotives_period_of_age_and_count(IN age_first INT,IN age_second INT,OUT count_locomotives INT)
BEGIN
	SELECT locomotives.id AS 'Реєстраційний номер',
			locomotives.count_of_completed_routes AS 'К-сть завершених поїздок',
			stations.title AS 'Головна станція',
			stations2.title AS 'Поточна станція',
			locomotives.arival_time AS 'Час прибуття',
			locomotives.last_techical_overview AS 'Останній тех огляд',
			locomotives.last_repair AS 'Останній ремонт',
			locomotives.repairs_count AS 'К-сть ремонтів',
			locomotives.locomotiv_age AS 'Вік локомотиву',
			departments.title AS 'Департамент бригади локомотива',
			locomotives.locomotive_team_id AS 'Номер бригади локомотива',
			departments2.title AS 'Департамент тех бригади',
			locomotives.tech_team_id AS 'Номер тех бригади'
	FROM locomotives
	LEFT JOIN stations ON locomotives.main_station_id = stations.id
	LEFT JOIN stations stations2 ON locomotives.current_station_id = stations2.id
	LEFT JOIN departments ON locomotives.locomotive_team_department_id = departments.id
	LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id
	WHERE  age_first <= locomotives.locomotiv_age 
		and locomotives.locomotiv_age <= age_second;
    
    SELECT COUNT(*) INTO count_locomotives FROM locomotives
    WHERE  age_first <= locomotives.locomotiv_age 
		and locomotives.locomotiv_age <= age_second;
    
    SELECT count_locomotives;
END //
DELIMITER ;

# CALL locomotives_period_of_age_and_count(10,40,@count_locomotives_period_of_age);

