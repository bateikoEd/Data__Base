DROP VIEW IF EXISTS employees_view;
DROP VIEW IF EXISTS locomotives_view;
DROP VIEW IF EXISTS journeys_view;
DROP VIEW IF EXISTS tickets_view;
DROP VIEW IF EXISTS routs_view;
DROP VIEW IF EXISTS VIEW_NAME;
DROP VIEW IF EXISTS VIEW_NAME;
DROP VIEW IF EXISTS VIEW_NAME;
DROP VIEW IF EXISTS VIEW_NAME;
DROP VIEW IF EXISTS VIEW_NAME;

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
LEFT JOIN types_train ON journeys.type_train = types_train.id;

CREATE VIEW tickets_view AS
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
LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id;

CREATE 
VIEW routs_view AS
SELECT stations.title AS 'Початкова станція',
        stations2.title AS 'кінцева станція' 
FROM routs
LEFT JOIN stations ON routs.start_station_id = stations.id
LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id;