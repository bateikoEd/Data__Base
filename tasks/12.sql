DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket (IN journey_id INT, OUT count_tickets INT)
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
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE tickets.journey_id = journey_id
    AND tickets.ticket_status = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.t_status = 1 ;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket(1,@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket_date (IN cur_date DATE, OUT count_tickets INT)
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
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE (DATE(tickets.buying_time) <> cur_date 
    OR tickets.buying_time IS NULL)
    AND tickets.ticket_status <> 3;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.buying_time AS t_buy_time,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE (DATE(a.t_buy_time) <> cur_date
    OR a.t_buy_time IS NULL)
    AND a.t_status <> 3;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket_date('2020-03-10',@count_not_buy);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_who_does_not_buy_ticket_rout (IN rout_id INT, OUT count_tickets INT)
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
	LEFT JOIN journeys ON journeys.id = tickets.journey_id
	LEFT JOIN routs ON journeys.rout_id = routs.id
	LEFT JOIN stations ON routs.start_station_id = stations.id
	LEFT JOIN stations stations2 ON routs.end_station_id = stations2.id
    WHERE journeys.rout_id = rout_id
    AND tickets.ticket_status = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                journeys.rout_id AS r_id,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.r_id = rout_id 
	AND a.t_status = 1;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_who_does_not_buy_ticket_rout(1,@count_not_buy);
