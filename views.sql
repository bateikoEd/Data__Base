DROP VIEW employees_view;
DROP VIEW locomotives_view;
DROP VIEW journeys_view;
DROP VIEW VIEW_NAME;
DROP VIEW VIEW_NAME;
DROP VIEW VIEW_NAME;
DROP VIEW VIEW_NAME;
DROP VIEW VIEW_NAME;
DROP VIEW VIEW_NAME;

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
        IF (employees.overview, 'Так','Ні') AS 'Пройдений медогляд', 
        employees.age AS 'Вік',
        employees.experiance AS 'Стаж'
FROM employees
LEFT JOIN ranges ON employees.rang_id = ranges.id
LEFT JOIN departments ON employees.department_id = departments.id;

CREATE VIEW locomotives_view AS
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
LEFT JOIN departments departments2 ON locomotives.tech_team_department_id = departments2.id;

CREATE 
VIEW journeys_view AS
SELECT routs.id AS 'Номер рейсу',
		stations.title AS 'Початкова станція',
        stations2.title AS 'Кінцева станція',
		IF (journeys.canceled,'Так','Ні') AS 'Чи відмінений',
        delays.title AS 'Причина затримки',
        journeys.beginning_delay AS 'Початок затримки',
        journeys.end_delay AS 'Кінець затримки',
        journeys.departure_time AS 'Час відправлення',
        journeys.arrival_time AS 'Час прибуття',
        IF (journeys.international_or_internal, 'Внутрішній','Міжнародний') AS 'Тип рейсу'
FROM journeys 
LEFT JOIN delays ON journeys.delay_id = delays.id
LEFT JOIN routs ON journeys.rout_id = routs.id
LEFT JOIN stations ON routs.start_station_id = stations.id
LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id;