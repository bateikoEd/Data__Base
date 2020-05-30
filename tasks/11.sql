DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_journey (IN journey_id INT, OUT count_tickets INT)
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
    WHERE journeys.id = journey_id;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id 
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id
		WHERE journeys.id = journey_id ) AS a
    WHERE a.j_id = journey_id;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_journey(1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_date_departure (IN journey_id INT,IN current_day DATE, OUT count_tickets INT)
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
    WHERE DATE(journeys.departure_time) = current_day
    AND journeys.id = journey_id
    AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.d_time = current_day 
    AND a.j_id = journey_id
    AND a.t_status = 'куплено';

    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_date_departure(1,'2020-03-13',@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_in_date_departure_abroad (IN journey_id INT, IN current_day DATE, OUT count_tickets INT)
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
    WHERE DATE(journeys.departure_time) = current_day
    AND journeys.type_journey = 2
    AND journeys.id = journey_id
	AND tickets.ticket_status = 'куплено';
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                journeys.type_journey AS t_journey,
                tickets.ticket_status AS t_status
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.d_time = current_day 
	AND a.t_journey = 2
    AND a.j_id = journey_id
    AND a.t_status = 'куплено';
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_in_date_departure_abroad(6,'2020-03-09',@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_handed_luggage (IN journey_id INT, OUT count_tickets INT)
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
    AND tickets.handed_luggage = 1;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                DATE(journeys.departure_time) AS d_time,
                DATE(journeys.arrival_time) AS a_time,
                tickets.handed_luggage AS h_laguage
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.h_laguage = 1;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_handed_luggage(1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_sex (IN journey_id INT,IN sex INT, OUT count_tickets INT)
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
    AND tickets.sex = sex;
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.sex AS t_sex,
                tickets.handed_luggage AS h_laguage
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND a.t_sex = sex;
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_sex(1,1,@count_customers);

DELIMITER //
CREATE PROCEDURE tickets_count_of_customers_age (IN journey_id INT,IN age INT, OUT count_tickets INT)
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
    AND (tickets.age BETWEEN age - 2 AND age + 2);
    
    SELECT COUNT(*) INTO count_tickets FROM 
    (	SELECT journeys.id AS j_id, 
				tickets.id AS tick_id,
                tickets.age AS t_age
		FROM tickets
		LEFT JOIN journeys ON journeys.id = tickets.journey_id) AS a
	WHERE a.j_id = journey_id 
	AND (a.t_age BETWEEN age - 2 AND age + 2);
    
    SELECT count_tickets;
END //
DELIMITER ;

# CALL tickets_count_of_customers_age(1,45,@count_customers);

