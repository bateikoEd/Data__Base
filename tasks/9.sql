DELIMITER //
CREATE PROCEDURE tickets_average_sold_in_period_of_time_on_some_rout (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME, OUT count_tickets INT)
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
    (tickets.buying_time BETWEEN begining_period AND end_period);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (SELECT journeys.rout_id AS rout, 
		tickets.buying_time AS buy_time 
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = tickets.journey_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.rout = rout_id AND 
    a.buy_time BETWEEN begining_period AND end_period;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_in_period_of_time_on_some_rout(1,'2020-03-10 12:45:30','2020-03-10 19:45:30',@count_delays);

 DELIMITER //
CREATE PROCEDURE tickets_average_sold_in_period_of_hour_on_some (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME, IN hours INT, OUT count_tickets INT)
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
    WHERE journeys.rout_id = rout_id  
	AND (TIMESTAMPDIFF(HOUR,journeys.departure_time,journeys.arrival_time) BETWEEN hours - 1 AND hours + 1)
    AND (tickets.buying_time BETWEEN begining_period AND end_period)
    AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.rout_id AS r_id,
				journeys.departure_time AS d_time, 
                journeys.arrival_time AS a_time,
				tickets.buying_time AS buy_time,
                tickets.ticket_status AS tic_status
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = rout_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.r_id = rout_id  
	AND TIMESTAMPDIFF(HOUR,a.d_time,a.a_time) BETWEEN hours - 1 AND hours + 1
    AND (a.buy_time BETWEEN begining_period AND end_period)
    AND a.tic_status = 'куплено';
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_in_period_of_hour_on_some (1,'2020-03-10 12:45:30','2020-03-10 19:45:30',25,@COUNT_OF_BUY_TICKETS);

DELIMITER //
CREATE PROCEDURE tickets_average_sold_price_of_ticket_rout (IN rout_id INT, IN begining_period DATETIME, IN end_period DATETIME,IN price_ticket INT, OUT count_tickets INT)
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
    WHERE journeys.rout_id = rout_id  
    AND (tickets.buying_time BETWEEN begining_period AND end_period)
    AND tickets.ticket_status = 'куплено'
    AND (tickets.price BETWEEN price_ticket - 20 AND price_ticket + 20);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.rout_id AS r_id,
				tickets.buying_time AS buy_time,
                tickets.ticket_status AS tic_status,
                tickets.price AS price
		FROM tickets
		LEFT JOIN journeys ON journeys.rout_id = rout_id
		WHERE journeys.rout_id = rout_id ) AS a
    WHERE a.r_id = rout_id  
    AND (a.buy_time BETWEEN begining_period AND end_period)
    AND a.tic_status = 'куплено'
    AND (a.price BETWEEN price_ticket - 20 AND price_ticket + 20);
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_average_sold_price_of_ticket_rout (1,'2020-03-10 12:45:30','2020-03-10 19:45:30',500,@COUNT_OF_BUY_TICKETS);
