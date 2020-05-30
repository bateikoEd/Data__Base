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