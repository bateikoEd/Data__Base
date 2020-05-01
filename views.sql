CREATE 
VIEW employees_view AS
SELECT  employees.id AS 'ідентифікаційний код', 
		employees.full_name AS 'ПІБ', 
        ranges.title AS 'Посада', 
        departments.title AS 'Департамент', 
        employees.team_id AS 'Номер бригади',
		employees.count_of_children AS 'К-сть дітей',
        employees.sex AS 'Стать', 
        employees.salary AS 'Зарплата', 
        employees.overview AS 'Пройдений медогляд', 
        employees.age AS 'Вік',
        IF (employees.overview, 'Так','Ні')
FROM employees
LEFT JOIN ranges ON employees.rang_id = ranges.id
LEFT JOIN departments ON employees.rang_id = departments.id;


 
 