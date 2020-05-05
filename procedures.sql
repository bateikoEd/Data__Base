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
DROP PROCEDURE IF EXISTS journeys_count_of_routs;
DROP PROCEDURE IF EXISTS journeys_count_of_time_rout;
DROP PROCEDURE IF EXISTS journeys_count_of_cancelled_end_station;
DROP PROCEDURE IF EXISTS journeys_count_of_cancelled_journeys_and_rout;
DROP PROCEDURE IF EXISTS journeys_count_of_cancelled_journeys;
DROP PROCEDURE IF EXISTS journeys_count_of_time_price_routs;
DROP PROCEDURE IF EXISTS journeys_count_of_price_rout;
DROP PROCEDURE IF EXISTS locomotives_period_of_age_and_count;
DROP PROCEDURE IF EXISTS locomotives_last_repair_and_count;
DROP PROCEDURE IF EXISTS locomotives_period_of_last_techical_overview_and_count;
DROP PROCEDURE IF EXISTS locomotives_count_of_completed_routes_and_count;
DROP PROCEDURE IF EXISTS employees_rang_age_and_count;
DROP PROCEDURE IF EXISTS employees_rang_overview_count;
DROP PROCEDURE IF EXISTS journeys_count_of_cancelled_end_station;
DROP PROCEDURE IF EXISTS journeys_delays_count;
DROP PROCEDURE IF EXISTS journeys_couse_delay_and_rout_count;
DROP PROCEDURE IF EXISTS tickets_couse_delay_rout_and_return_tickets_on_journey_count;
DROP PROCEDURE IF EXISTS tickets_average_sold_in_period_of_time_on_some_rout;
DROP PROCEDURE IF EXISTS tickets_average_sold_in_period_of_hour_on_some;
DROP PROCEDURE IF EXISTS tickets_average_sold_price_of_ticket_rout;
DROP PROCEDURE IF EXISTS journeys_couse_delay_count;
DROP PROCEDURE IF EXISTS tickets_average_sold_in_period_of_hour_on_some_rout;
DROP PROCEDURE IF EXISTS journeys_count_of_types_end_station;
DROP PROCEDURE IF EXISTS journeys_count_of_types;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_in_journey;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_in_date_departure;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_in_date_departure_abroad;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_handed_luggage;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_sex;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_age;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_who_does_not_buy_ticket;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_who_does_not_buy_ticket_date;
DROP PROCEDURE IF EXISTS tickets_count_of_customers_who_does_not_buy_ticket_rout;
DROP PROCEDURE IF EXISTS tickets_count_of_return_tickets_in_journey;
DROP PROCEDURE IF EXISTS tickets_count_of_return_tickets_in_date;
DROP PROCEDURE IF EXISTS tickets_count_of_return_tickets_in_rout;

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

# CALL employees_rang_and_count(2,@count_employees_rang);

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

# CALL employees_child_and_count(@count_employees_child);

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

# CALL employees_locomotive_and_count(1, @count_employees_locomotive);

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

DELIMITER //
CREATE PROCEDURE journeys_count_of_routs (IN rout_id INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.rout_id = rout_id;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.rout_id = rout_id;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_routs(5, @count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_time_rout (IN hours INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE  hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    and TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 ;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    and TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_time_rout(26,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_price_rout (IN price INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE  price - 50 <= journeys.price_ticket and journeys.price_ticket <= price + 50 ;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  price - 50 <= journeys.price_ticket and journeys.price_ticket <= price + 50 ;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_price_rout(500,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_time_price_routs (IN rout_id INT, IN hours INT, IN price INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE  journeys.rout_id = rout_id 
    AND hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    AND TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 
    AND price - 50 <= journeys.price_ticket AND journeys.price_ticket <= price + 50;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  journeys.rout_id = rout_id 
    AND hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    AND TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 
    AND price - 50 <= journeys.price_ticket AND journeys.price_ticket <= price + 50;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_time_price_routs(1,26,500,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_cancelled_journeys (OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.canceled = 1;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.canceled = 1;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_cancelled_journeys(@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_cancelled_journeys_and_rout (IN rout_id INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.canceled = 1 AND journeys.rout_id = rout_id;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.canceled = 1 AND journeys.rout_id = rout_id;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_cancelled_journeys_and_rout(3,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_cancelled_end_station (IN end_station_id1 int, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.canceled = 1 AND routs.end_station_id = end_station_id1;

    SELECT COUNT(*) INTO count_routs 
	FROM ( SELECT routs.id AS rout_id,
				stations.id AS stat_start,
				stations2.id AS stat_end, 
				journeys.canceled AS j_canc
			FROM journeys 
            LEFT JOIN routs ON journeys.rout_id = routs.id
            LEFT JOIN stations ON routs.start_station_id = stations.id
			LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id) AS a
	WHERE a.j_canc = 1 
    AND a.stat_end = end_station_id1;
--     
	SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_cancelled_end_station(98,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_couse_delay_count (IN couse_delay INT,OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.delay_id = couse_delay;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.delay_id = couse_delay;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_couse_delay_count(2,@count_delays);
 
DELIMITER //
CREATE PROCEDURE journeys_couse_delay_and_rout_count (IN couse_delay INT, IN rout_id INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.delay_id = couse_delay AND journeys.rout_id = rout_id;
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.delay_id = couse_delay AND journeys.rout_id = rout_id;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_couse_delay_and_rout_count(2,6,@count_delays);
 
DELIMITER //
CREATE PROCEDURE tickets_couse_delay_rout_and_return_tickets_on_journey_count (IN rout_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
	LEFT JOIN routs ON tickets.journey_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id AND 
    (tickets.return_time BETWEEN journeys.beginning_delay AND journeys.end_delay);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (SELECT journeys.rout_id AS rout, 
		tickets.return_time AS ret_time, 
        journeys.beginning_delay AS beg_del, 
        journeys.end_delay AS end_del
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.rout = rout_id AND 
    a.ret_time BETWEEN a.beg_del AND a.end_del;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_couse_delay_rout_and_return_tickets_on_journey_count(6,@count_delays);
 
DELIMITER //
CREATE PROCEDURE tickets_average_sold_in_period_of_time_on_some_rout (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
	LEFT JOIN routs ON tickets.journey_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id AND 
    (tickets.buying_time BETWEEN begining_period AND end_period);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (SELECT journeys.rout_id AS rout, 
		tickets.buying_time AS buy_time 
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.rout = rout_id AND 
    a.buy_time BETWEEN begining_period AND end_period;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_in_period_of_time_on_some_rout(1,'2020-03-10 12:45:30','2020-03-10 19:45:30',@count_delays);

 DELIMITER //
CREATE PROCEDURE tickets_average_sold_in_period_of_hour_on_some (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME, IN hours INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
	LEFT JOIN routs ON tickets.journey_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id  
	AND (TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) BETWEEN hours - 1 AND hours + 1)
    AND (tickets.buying_time BETWEEN begining_period AND end_period)
    AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.rout_id AS r_id,
				journeys.departure_time AS d_time, 
                journeys.arrival_time AS a_time,
				tickets.buying_time AS buy_time,
                tickets.ticket_status AS tic_status
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = rout_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.r_id = rout_id  
	AND TIMESTAMPDIFF(HOUR,a.d_time,a.a_time) BETWEEN hours - 1 AND hours + 1
    AND (a.buy_time BETWEEN begining_period AND end_period)
    AND a.tic_status = 'куплено';
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_in_period_of_hour_on_some (1,'2020-03-10 12:45:30','2020-03-10 19:45:30',25,@COUNT_OF_BUY_TICKETS);

DELIMITER //
CREATE PROCEDURE tickets_average_sold_price_of_ticket_rout (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME,IN price_ticket INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
	LEFT JOIN routs ON tickets.journey_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id  
    AND (tickets.buying_time BETWEEN begining_period AND end_period)
    AND tickets.ticket_status = 'куплено'
    AND (tickets.price BETWEEN price_ticket - 20 AND price_ticket + 20);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.rout_id AS r_id,
				tickets.buying_time AS buy_time,
                tickets.ticket_status AS tic_status,
                tickets.price AS price
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = rout_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.r_id = rout_id  
    AND (a.buy_time BETWEEN begining_period AND end_period)
    AND a.tic_status = 'куплено'
    AND (a.price BETWEEN price_ticket - 20 AND price_ticket + 20);
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_price_of_ticket_rout (1,'2020-03-10 12:45:30','2020-03-10 19:45:30',500,@COUNT_OF_BUY_TICKETS);

DELIMITER //
CREATE PROCEDURE journeys_count_of_types (IN type_journey_id INT, IN type_train_id INT, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id;

    SELECT COUNT(*) INTO count_routs 
	FROM journeys 
	WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id;
    
	SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_types(1,1,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_types_end_station (IN type_journey_id INT, IN type_train_id INT, IN end_station_id1 int, OUT count_routs INT)
BEGIN 
	SELECT routs.id AS 'Номер рейсу',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
			delays.title AS 'Причина затримки',
			IF (journeys.beginning_delay IS NOT NULL,journeys.beginning_delay,'-') AS 'Початок затримки',
			IF (journeys.end_delay IS NOT NULL, journeys.end_delay,'-') AS 'Кінець затримки',
			journeys.departure_time AS 'Час відправлення',
			journeys.arrival_time AS 'Час прибуття',
			journeys.price_ticket AS 'Ціна за квиток',
			types_journey.title AS 'Тип маршруту',
			types_train.title AS 'Тип потяга'
	FROM journeys 
	LEFT JOIN delays ON journeys.delay_id = delays.id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
	LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id
    AND routs.end_station_id = end_station_id1;

    SELECT COUNT(*) INTO count_routs 
	FROM ( SELECT routs.id AS rout_id,
				stations.id AS stat_start,
				stations2.id AS stat_end, 
				types_journey.id AS t_journey,
				types_train.id AS t_train
			FROM journeys 
            LEFT JOIN routs ON journeys.rout_id = routs.id
            LEFT JOIN stations ON routs.start_station_id = stations.id
			LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
            LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
			LEFT JOIN types_train ON journeys.type_train = types_train.id) AS a
	WHERE a.t_journey = type_journey_id
    AND a.t_train = type_train_id
    AND a.stat_end = end_station_id1;
    
	SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_types_end_station(1,1,98,@count_routs);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_journey (IN journey_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.id = journey_id;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id 
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id
		WHERE journeys.id = journey_id ) AS a
    WHERE a.j_id = journey_id;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_journey(1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_date_departure (IN journey_id INT,IN current_day DATE, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE DATE(journeys.departure_time) = current_day
    AND journeys.id = journey_id
    AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.d_time = current_day 
    AND a.j_id = journey_id
    AND a.t_status = 'куплено';

    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_date_departure(1,'2020-03-13',@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_date_departure_abroad (IN journey_id INT, IN current_day DATE, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE DATE(journeys.departure_time) = current_day
    AND journeys.type_journey = 2
    AND journeys.id = journey_id
	AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                journeys.type_journey AS t_journey,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.d_time = current_day 
	AND a.t_journey = 2
    AND a.j_id = journey_id
    AND a.t_status = 'куплено';
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_date_departure_abroad(6,'2020-03-09',@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_handed_luggage (IN journey_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE tickets.journey_id = journey_id
    AND tickets.handed_luggage = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                tickets.handed_luggage AS h_laguage
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.h_laguage = 1;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_handed_luggage(1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_sex (IN journey_id INT,IN sex INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE tickets.journey_id = journey_id
    AND tickets.sex = sex;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.sex AS t_sex,
                tickets.handed_luggage AS h_laguage
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.t_sex = sex;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_sex(1,1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_age (IN journey_id INT,IN age INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE tickets.journey_id = journey_id
    AND (tickets.age BETWEEN age - 2 AND age + 2);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.age AS t_age
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND (a.t_age BETWEEN age - 2 AND age + 2);
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_age(1,45,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket (IN journey_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE tickets.journey_id = journey_id
    AND tickets.ticket_status = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.t_status = 1 ;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket(1,@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket_date (IN cur_date DATE, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE (DATE(tickets.buying_time) <> cur_date 
    OR tickets.buying_time IS NULL)
    AND tickets.ticket_status <> 3;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.buying_time AS t_buy_time,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE (DATE(a.t_buy_time) <> cur_date
    OR a.t_buy_time IS NULL)
    AND a.t_status <> 3;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket_date('2020-03-10',@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket_rout (IN rout_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id
    AND tickets.ticket_status = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                journeys.rout_id AS r_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.r_id = rout_id 
	AND a.t_status = 1;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket_rout(1,@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_return_tickets_in_journey (IN journey_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.id = journey_id
    AND tickets.ticket_status = 3;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                journeys.rout_id AS r_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.t_status = 3;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_return_tickets_in_journey(1,@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_return_tickets_in_date (IN date_return DATE, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE DATE(tickets.return_time) = date_return;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                journeys.rout_id AS r_id,
                tickets.return_time AS t_buy_time
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE DATE(a.t_buy_time) = date_return;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_return_tickets_in_date('2020-03-10',@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_return_tickets_in_rout (IN rout_id INT, OUT count_tickets INT)
BEGIN 
	SELECT tickets.id,
			tickets.full_name AS 'ПІБ',
			journeys.id AS 'Номер рейсу',
			tickets.carload_id AS 'Номер вагону',
			tickets.seat_number AS 'Номер місця',
			tickets.price AS 'Ціна',
			stations.title AS 'Початкова станція',
			stations2.title AS 'Кінцева станція',
			tickets.ticket_status AS 'Статус квитка',
			IF (tickets.buying_time IS NOT NULL,tickets.buying_time, '-') AS 'Час купівлі',
			IF (tickets.return_time IS NOT NULL,tickets.return_time, '-') AS 'Час повернення',
			tickets.sex AS 'Стать',
			tickets.age AS 'Вік',
            IF (tickets.handed_luggage,'Так','Ні') AS 'Зданий багаж'
	FROM tickets
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id
    AND tickets.ticket_status = 3;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                journeys.rout_id AS r_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.r_id = rout_id 
	AND a.t_status = 3;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_return_tickets_in_rout(1,@count_not_buy);
