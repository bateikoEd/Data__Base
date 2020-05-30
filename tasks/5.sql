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