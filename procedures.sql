DROP PROCEDURE IF EXISTS employees_all_and_count;
DROP PROCEDURE IF EXISTS employees_rang_and_count;
DROP PROCEDURE IF EXISTS employees_departament_and_count;
DROP PROCEDURE IF EXISTS employees_age_and_count;
DROP PROCEDURE IF EXISTS employees_child_and_count;
DROP PROCEDURE IF EXISTS employees_sex_and_count;
DROP PROCEDURE IF EXISTS employees_experiance_and_count;
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