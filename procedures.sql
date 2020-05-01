DROP PROCEDURE IF EXISTS all_employees_and_count;

DELIMITER // 
CREATE PROCEDURE employees_all_and_count(OUT count_employees INT)
BEGIN
	SELECT COUNT(*) INTO count_employees FROM employees;
    SELECT * FROM employees_view;
    SELECT count_employees AS 'К-сть працівників';
END //
DELIMITER ;

CALL employees_all_and_count(@count_employees);

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
			employees.overview AS 'Пройдений медогляд', 
			employees.age AS 'Вік'
			FROM employees
	LEFT JOIN ranges ON employees.rang_id = ranges.id
	LEFT JOIN departments ON employees.rang_id = departments.id
	WHERE employees.rang_id = 1;
    
    SELECT COUNT(*) INTO count_employees FROM employees
    WHERE employees.rang_id = rang_id;
    SELECT count_employees;
END //
DELIMITER ;

CALL employees_rang_and_count(1,@count_employees_rang);

