DELIMITER //
CREATE PROCEDURE journeys_couse_delay_count (IN couse_delay INT,OUT count_routs INT)
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
    WHERE journeys.delay_id = couse_delay;
    
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.delay_id = couse_delay;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_couse_delay_count(2,@count_delays);
 
DELIMITER //
CREATE PROCEDURE journeys_couse_delay_and_rout_count (IN couse_delay INT, IN rout_id INT, OUT count_routs INT)
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
    WHERE journeys.delay_id = couse_delay AND journeys.rout_id = rout_id;
    
    SELECT COUNT(*) INTO count_routs FROM journeys
    WHERE journeys.delay_id = couse_delay AND journeys.rout_id = rout_id;
    
    SELECT count_routs;
END //
DELIMITER ;

# CALL journeys_couse_delay_and_rout_count(2,6,@count_delays);
 
DELIMITER //
CREATE PROCEDURE tickets_couse_delay_rout_and_return_tickets_on_journey_count (IN rout_id INT, OUT count_tickets INT)
BEGIN 
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
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id AND 
    (tickets.return_time BETWEEN journeys.beginning_delay AND journeys.end_delay);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (SELECT journeys.rout_id AS rout, 
		tickets.return_time AS ret_time, 
        journeys.beginning_delay AS beg_del, 
        journeys.end_delay AS end_del
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.rout = rout_id AND 
    a.ret_time BETWEEN a.beg_del AND a.end_del;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_couse_delay_rout_and_return_tickets_on_journey_count(6,@count_delays);
