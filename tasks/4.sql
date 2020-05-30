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