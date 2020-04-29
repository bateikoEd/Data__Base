SELECT * FROM ranges;
SELECT * FROM departments;
SELECT * FROM stations;
SELECT * FROM delays;
SELECT * FROM routs;
SELECT * FROM employees;
SELECT * FROM locomotives;
SELECT * FROM journeys;
SELECT * FROM preparation_for_the_journey;

INSERT INTO ranges (title)
	VALUES ('начальник'), 
			('заступник начальника'),
            ('водій локомотива'), 
            ('водій рухомого складу'),
            ('диспетчер'),
            ('ремонтник технічного складу'),
            ('ремонтник шляхів'),
            ('касир'),
            ('працівник служби підготовки складів'),
            ('працівник довідкової служби'),
            ('фахівець з пошуку персоналу'),
            ('технік-ремонтник');
            
INSERT INTO departments (title)
	VALUES ('Департамент адміністративного забезпечення'), 
			('Департамент безпеки руху'),
            ('Департамент управління рухом'),
            ('Департамент майнової політики'),
            ('Департамент колії та споруд'),
            ('Департамент вагонного господарства'),
            ('Департамент комерційної роботи'),
            ('Департамент приміських пасажирських перевезень'),
            ('Управління статистики'),
            ('Департамент автоматики та телекомунікацій'),
            ('Департамент електрифікації та електропостачання'),
            ('Департамент оплати праці та мотивації персоналу'),
            ('Департамент розвитку і технічної політики'),
            ('Департамент бухгалтерського, податкового обліку, звітності та методології'),
            ('Юридичний департамент'),
            ('Головне управління воєнізованої охорони'),
            ('Департамент матеріально-технічного забезпечення'),
            ('Перше управління'),
            ('Спеціальне управління'),
            ('Департамент міжнародного співробітництва'),
            ('Департамент капітальних вкладень'),
            ('Департамент внутрішнього аудиту та контролю'),
            ('Департамент будівель та споруд'),
            ('Департамент реформування та корпоративного розвитку'),
            ('Департамент інформаційної політики та зв’язків з громадськістю'),
            ('Департамент охорони праці та промислової безпеки'),
            ('Департамент корпоративної соціальної відповідальності (ЦКСВ)'),
            ('Департамент менеджменту якості продукції та послуг'),
            ('Департамент безпеки'),
            ('Департамент енергоменеджменту'),
            ('Департамент казначейства'),
            ('Департамент економіки, планування та бюджетування'),
            ('Департамент цінової політики'),
            ('Департамент організаційного розвитку'),
            ('Департамент оперативного моніторингу'),
            ('Департамент маркетингу і реклами'),
            ('Департамент корпоративного управління'),
            ('Департамент розвитку персоналу та кадрової політики'),
            ('Управління соціальної політики'),
            ('Департамент стратегічного розвитку та планування'),
            ('Управління екологічного менеджменту'),
            ('Департамент інвестиційної політики'),
            ('Довідкова інформація');

INSERT INTO delays (title)
	VALUES ('без запізнення'),
			('запізнення потяга'),
			('погодні умови'),
			('технічні неполадки');
INSERT INTO stations (title)
	VALUES ('Івангород'),
			('Іване-Пусте'),
			('Іваничі'),
			('Іванівка'),
			('Іванівці'),
			('Іванківці'),
			('Іванковецький	'),
			('Івано-Копине'),
            ('Івано-Франківськ'),
			('Іванопілля'),
			('Івахни'),
			('Івачкове'),
            ('Ігнатпіль'),
			('Ізюм'),
			('Ізяслав'),
			('Іловайськ'),
            ('Абазівка'),
			('Абамеликове'),
			('Абрикосовий'),
			('Августівський'),
            ('Авдіївка'),
			('Автостанція'),
			('Агрономічний'),
			('Адабаш'),
            ('Адамівське'),
            ('Адампіль'),
            ('Азовсталь'),
            ('Азовська'),
            ('Айвазовська'),
            ('Академмістечко'),
            ('Аккаржа'),
            ('Аксютівка'),
            ('Алебастрова'),
            ('Аліївка'),
            ('Аліяга'),
            ('Алмаз	'),
            ('Алтинівка'),
            ('Амбари'),
            ('Амвросіївка'),
            ('Аметхан-Султан'),
            ('Амур'),
            ('Ангелівка'),
            ('Андріївка'),
            ('Бабаківка'),
            ('Бабариківська'),
            ('Бабенкове'),
            ('Бабичівський'),
            ('Багачеве'),
            ('Багерове'),
            ('Баглаї'),
            ('Баглаї'),
            ('Багринівка'),
            ('Бадівка'),
            ('База'),
            ('Байдаківка'),
            ('Байрак'),
            ('Бакирівка'),
            ('Бакланове'),
            ('Бакшеївка'),
            ('Балабине'),
            ('Балаклія'),
            ('Вагонозавод'),
            ('Вадим'),
            ('Вадул-Сірет'),
            ('Вакуленчук'),
            ('Вакулинці'),
            ('Валуйська'),
            ('Валянівський'),
            ('Валява'),
            ('Вальянівка'),
            ('Ванчиківці'),
            ('Ваньковичі'),
            ('Вапнярка'),
            ('Вапнярки'),
            ('Вараш	'),
            ('Варварівка'),
            ('Варварівський'),
            ('Вариводки'),
            ('Варшиця'),
            ('Васильків'),
            ('Гаврилівка'),
            ('Гавриші'),
            ('Гадзинка'),
            ('Гадинківці'),
            ('Гадяч імені Сергієнка М.І.'),
            ('Газове'),
            ('Гаї Великі'),
            ('Гаї Ситенські'),
            ('Гай'),
            ('Гайворон'),
            ('Гайсин'),
            ('Гайчур'),
            ('Галаганівка'),
            ('Галайбине'),
            ('Галещина'),
            ('Галине'),
            ('Галинівка'),
            ('Галич'),
            ('Галичини'),
            ('Галка'),
            ('Ганнівка'),
            ('Ганнівка'),
            ('Ганнусине');

INSERT INTO routs (start_station_id,end_station_id)
	VALUES (1,100),
			(2,99),
            (3,98),
            (4,97),
            (5,96),
            (6,95),
            (7,94),
            (8,93),
            (9,92),
            (10,91),
            (11,90),
            (12,89),
            (13,88),
            (14,87),
            (15,86),
            (16,85),
            (17,84),
            (18,83),
            (19,82),
            (20,81),
            (21,80),
            (22,79);
            
INSERT INTO employees (full_name,rang_id,department_id,team_id,count_of_children,sex,salary,overview,age)
	VALUES ('Корнієнко Олександр Сергійович', 1, 1, 0, 2, 'Чоловік',20000,TRUE,35),
			('Разумков Дмитро Олександрович', 2, 1, 1, 2, 'Чоловік',2000,TRUE,40),
            ('Стефанчук Руслан Олексійович', 3, 1,1, 10, 'Не визначився',13000,TRUE,25),
            ('Арахамія Давид Георгійович', 4, 1,2, 4, 'Чоловік',2000,TRUE,35),
            ('Янченко Галина Ігорівна', 5, 1,2, 5, 'Жінка',2000,TRUE,20),
            
            ('Радіна Анастасія Олегівна', 1, 2,0, 2, 'Жінка',30000,TRUE,30),
            ('Ткаченко Олександр Владиславович', 2, 2,1, 3, 'Чоловік',2000,FALSE,25),
            ('Беленюк Жан Венсанович', 3, 2,1, 0, 'Чоловік',2000,TRUE,20),
            ('Бабак Сергій Віталійович', 4, 2,2, 0, 'Чоловік',2000,FALSE,30),
            ('Шуляк Олена Олексіївна', 5, 2,3, 2, 'Жінка',20000,TRUE,30);

INSERT INTO locomotives (count_of_completed_routes,main_station_id,current_station_id,arival_time,
		last_techical_overview,last_repair,repairs_count,locomotiv_age,locomotive_team_department_id,
        locomotive_team_id,tech_team_department_id,tech_team_id)
	VALUES (355,1,1,'2020-05-02 13:45:33', '2019-12-30', '2019-10-30',60, 40, 1,1,2,1),
			(200,2,1,'2020-06-02 10:40:33', '2020-4-30', '2019-10-30',10, 20, 1,1,2,1),
            (100,3,2,'2020-03-13 11:45:30', '2020-01-25', '2019-10-30',5, 10, 1,1,2,1),
            
            (50,4,3,'2020-05-02 10:45:33', '2019-12-30', '2019-10-30',1, 5, 2,2,1,2),
            (1000,1,1,'2020-04-03 13:45:33', '2019-12-30', '2019-10-30',40, 60, 2,2,1,2);

INSERT INTO journeys (rout_id,canceled,delay_id,beginning_delay,end_delay,
					departure_time,arrival_time,international_or_internal)
	VALUES (1,0,1,NULL,NULL,'2020-03-13 11:45:30','2020-03-14 13:45:33',1),
			(2,0,1,NULL,NULL,'2020-04-12 11:45:30','2020-04-14 13:45:33',1),
            (3,1,1,NULL,NULL,'2020-03-13 11:45:30','2020-03-14 13:45:33',1),
            (4,0,1,NULL,NULL,'2020-05-13 11:45:30','2020-05-14 13:45:33',0),
            (5,0,1,NULL,NULL,'2020-03-10 11:45:30','2020-03-15 13:45:33',0),
			(6,0,1,'2020-03-10 12:45:30','2020-03-10 18:59:30','2020-03-09 11:45:30','2020-03-15 13:45:33',0);

INSERT INTO tickets (journey_id,full_name,ticket_status,buying_time,return_time,price,
					carload_id,seat_number,sex,age)
	VALUES (1,'Бойко Юрій Володимирович', 'заброньовано',NULL,NULL,500,1,1,'Не визначився',50),
			(1,'Лерос Гео Багратович', 'куплено','2020-03-10 12:45:30',NULL,500,1,2,'Чоловік',45),
            (1,'Кальченко Сергій Віталійович', 'повернено','2020-03-10 12:45:30','2020-03-10 12:55:30',500,1,3,'Не визначився',35),
			(1,'Наталуха Дмитро Андрійович', 'куплено','2020-03-12 12:45:30',NULL,500,1,4,'Чоловік',78),
            (1,'Ясько Єлизавета Олексіївна', 'заброньовано',NULL,NULL,500,1,5,'Жінка',16),
			(1,'Герус Андрій Михайлович', 'куплено','2020-03-14 12:45:30',NULL,500,1,6,'Чоловік',30),
            (6,'Бойко Юрій Володимирович', 'повернено','2020-03-01 12:45:30','2020-03-10 15:45:30',500,1,1,'Не визначився',50),
			(1,'Монастирський Денис Анатолійович', 'куплено','2020-03-10 12:45:30',NULL,500,1,7,'Чоловік',45);
    
    