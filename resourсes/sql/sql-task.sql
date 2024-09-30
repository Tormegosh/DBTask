/*
1. Вывести к каждому самолету класс обслуживания и количество мест этого класса

SELECT aircraft_code, fare_conditions, COUNT(seat_no) AS seat_count
FROM seats
GROUP BY aircraft_code, fare_conditions;

*/

/*
 2.Найти 3 самых вместительных самолета (модель + кол-во мест)

SELECT s.aircraft_code, a.model, COUNT(s.seat_no) AS seat_count
FROM seats s
JOIN aircrafts_data a ON s.aircraft_code = a.aircraft_code
GROUP BY s.aircraft_code, a.model
ORDER BY seat_count DESC
LIMIT 3;

*/

/*
3. Найти все рейсы, которые задерживались более 2 часов

SELECT flight_no, scheduled_arrival, actual_arrival
FROM flights
WHERE (actual_arrival - scheduled_arrival) > INTERVAL '2 hours';

*/

/*
 4. Найти последние 10 билетов, купленные в бизнес-классе (fare_conditions = 'Business'), с указанием имени пассажира и контактных данных

SELECT t.ticket_no, t.passenger_name, t.contact_data
FROM tickets t
JOIN ticket_flights tf ON t.ticket_no = tf.ticket_no
WHERE tf.fare_conditions = 'Business'
ORDER BY t.ticket_no DESC
LIMIT 10;
*/

/*
 5. Найти все рейсы, у которых нет забронированных мест в бизнес-классе (fare_conditions = 'Business')
SELECT f.flight_id, f.flight_no
FROM flights f
WHERE NOT EXISTS (
    SELECT flight_id
    FROM ticket_flights tf
    WHERE tf.flight_id = f.flight_id AND tf.fare_conditions = 'Business'
);

*/

/*
 6. Получить список аэропортов (airport_name) и городов (city), в которых есть рейсы с задержкой по вылету

SELECT DISTINCT a.airport_name, a.city
FROM flights f
JOIN airports_data a ON f.departure_airport = a.airport_code
WHERE f.actual_departure > f.scheduled_departure;

 */

/*
 7. Получить список аэропортов (airport_name) и количество рейсов, вылетающих из каждого аэропорта, отсортированный по убыванию количества рейсов

SELECT a.airport_name, COUNT(f.flight_id) AS flight_count
FROM flights f
JOIN airports_data a ON f.departure_airport = a.airport_code
GROUP BY a.airport_name
ORDER BY flight_count DESC;

 */

/*
 8. Найти все рейсы, у которых запланированное время прибытия (scheduled_arrival) было изменено и новое время прибытия (actual_arrival) не совпадает с запланированным

SELECT flight_id, flight_no, scheduled_arrival, actual_arrival
FROM flights
WHERE scheduled_arrival != actual_arrival;

*/

/*
 9. Вывести код, модель самолета и места не эконом класса для самолета "Аэробус A321-200" с сортировкой по местам

SELECT s.aircraft_code, a.model->>'ru' AS model_name, s.seat_no, s.fare_conditions
FROM seats s
JOIN aircrafts_data a ON s.aircraft_code = a.aircraft_code
WHERE a.model->>'ru' = 'Аэробус A321-200' AND s.fare_conditions != 'Economy'
ORDER BY s.seat_no;

*/

/*
 10. Вывести города, в которых больше 1 аэропорта (код аэропорта, аэропорт, город)

 SELECT airport_code, airport_name, city
FROM airports_data
WHERE city IN (
    SELECT city
    FROM airports_data
    GROUP BY city
    HAVING COUNT(airport_code) > 1
);

 */

/*
 11. Найти пассажиров, у которых суммарная стоимость бронирований превышает среднюю сумму всех бронирований

 SELECT t.passenger_name, SUM(b.total_amount) AS total_booking
FROM tickets t
JOIN bookings b ON t.book_ref = b.book_ref
GROUP BY t.passenger_name
HAVING SUM(b.total_amount) > (SELECT AVG(total_amount) FROM bookings);

*/

/*
 12. Найти ближайший вылетающий рейс из Екатеринбурга в Москву, на который еще не завершилась регистрация

SELECT f.flight_no, f.scheduled_departure, f.departure_airport, f.arrival_airport
FROM flights f
JOIN airports dep ON f.departure_airport = dep.airport_code
JOIN airports arr ON f.arrival_airport = arr.airport_code
WHERE dep.city = 'Екатеринбург'
  AND arr.city = 'Москва'
  AND f.scheduled_departure > NOW()
ORDER BY f.scheduled_departure
LIMIT 1;

*/

/*
 13. Вывести самый дешевый и дорогой билет и стоимость (в одном результирующем ответе)

(SELECT ticket_no, amount
FROM ticket_flights
ORDER BY amount ASC
LIMIT 1)
UNION ALL
(SELECT ticket_no, amount
FROM ticket_flights
ORDER BY amount DESC
LIMIT 1);

*/

/*
 14. Написать DDL таблицы Customers

	CREATE TABLE Customers (
    id SERIAL PRIMARY KEY,
    firstName VARCHAR(50) NOT NULL,
    lastName VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL
);

*/

/*
 15. Написать DDL таблицы Orders

 CREATE TABLE Orders (
    id SERIAL PRIMARY KEY,
    customerId INT REFERENCES Customers(id),
    quantity INT NOT NULL,
    CONSTRAINT chk_quantity CHECK (quantity > 0)
);

*/

/*
 16. Написать 5 insert в эти таблицы

INSERT INTO Customers (firstName, lastName, email, phone) VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890'),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321'),
('Alice', 'Johnson', 'alice.johnson@example.com', '5555555555'),
('Bob', 'Brown', 'bob.brown@example.com', '4444444444'),
('Charlie', 'Davis', 'charlie.davis@example.com', '3333333333');

INSERT INTO Orders (customerId, quantity) VALUES
(1, 3),
(2, 1),
(3, 5),
(4, 2),
(5, 4);

*/

/*
 17. Удалить таблицы

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

*/
