DELIMITER //
CREATE PROCEDURE journeys_count_of_types (IN type_journey_id INT, IN type_train_id INT, OUT count_routs INT)
BEGIN 
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
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id;

    SELECT COUNT(*) INTO count_routs 
	FROM journeys 
	WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id;
    
	SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_types(1,1,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_types_end_station (IN type_journey_id INT, IN type_train_id INT, IN end_station_id1 int, OUT count_routs INT)
BEGIN 
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
	LEFT JOIN types_train ON journeys.type_train = types_train.id
    WHERE journeys.type_train = type_train_id 
    AND journeys.type_journey = type_journey_id
    AND routs.end_station_id = end_station_id1;

    SELECT COUNT(*) INTO count_routs 
	FROM ( SELECT routs.id AS rout_id,
				stations.id AS stat_start,
				stations2.id AS stat_end, 
				types_journey.id AS t_journey,
				types_train.id AS t_train
			FROM journeys 
            LEFT JOIN routs ON journeys.rout_id = routs.id
            LEFT JOIN stations ON routs.start_station_id = stations.id
			LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
            LEFT JOIN types_journey ON journeys.type_journey = types_journey.id
			LEFT JOIN types_train ON journeys.type_train = types_train.id) AS a
	WHERE a.t_journey = type_journey_id
    AND a.t_train = type_train_id
    AND a.stat_end = end_station_id1;
    
	SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_types_end_station(1,1,98,@count_routs);
