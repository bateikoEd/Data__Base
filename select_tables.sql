# Перелік всіх працівників залізничної станції
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

# начальник
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

# count of начальник
SELECT COUNT(*) AS 'Кількість начальник'FROM employees 
WHERE employees.rang_id = 1;

# print locomotives
SELECT locomotives.id AS 'Реєстраційний номер',
		locomotives.count_of_completed_routes AS '',
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
LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id;



