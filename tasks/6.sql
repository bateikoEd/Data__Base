DELIMITER //
CREATE PROCEDURE journeys_count_of_routs (IN rout_id INT, OUT count_routs INT)
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
    WHERE journeys.rout_id = rout_id;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.rout_id = rout_id;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_routs(5, @count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_time_rout (IN hours INT, OUT count_routs INT)
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
    WHERE  hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    and TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 ;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    and TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_time_rout(26,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_price_rout (IN price INT, OUT count_routs INT)
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
    WHERE  price - 50 <= journeys.price_ticket and journeys.price_ticket <= price + 50 ;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  price - 50 <= journeys.price_ticket and journeys.price_ticket <= price + 50 ;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_price_rout(500,@count_routs);

DELIMITER //
CREATE PROCEDURE journeys_count_of_time_price_routs (IN rout_id INT, IN hours INT, IN price INT, OUT count_routs INT)
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
    WHERE  journeys.rout_id = rout_id 
    AND hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    AND TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 
    AND price - 50 <= journeys.price_ticket AND journeys.price_ticket <= price + 50;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE  journeys.rout_id = rout_id 
    AND hours - 1 <= TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) 
    AND TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) <= hours + 1 
    AND price - 50 <= journeys.price_ticket AND journeys.price_ticket <= price + 50;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_count_of_time_price_routs(1,26,500,@count_routs);
