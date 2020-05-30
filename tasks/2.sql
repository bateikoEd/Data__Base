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
