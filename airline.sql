CREATE DATABASE airline_database;
USE airline_database;

CREATE TABLE customers(
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100) NOT NULL,
                          status VARCHAR(20) NOT NULL,
                          total_mileage INT NOT NULL
);

SELECT * FROM customers;

CREATE TABLE aircrafts(
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(100) NOT NULL,
                          total_seats INT NOT NULL
);

CREATE TABLE flights(
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        flight_number VARCHAR(20) NOT NULL,
                        mileage INT NOT NULL,
                        aircraft_id INT NOT NULL,
                        FOREIGN KEY (aircraft_id) REFERENCES aircrafts(id)

);

CREATE TABLE bookings(
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         customer_id INT NOT NULL,
                         flight_id INT NOT NULL,
                         FOREIGN KEY (customer_id) REFERENCES customers(id),
                         FOREIGN KEY (flight_id) REFERENCES flights(id)

);

INSERT INTO customers(name, status, total_mileage)
VALUES
    ('Agustine Riviera','Silver', 115235),
    ('Alaina Sepulvida','None',6008),
    ('Tom Jones','Gold',205767),
    ('Sam Rio','None',2653),
    ('Jessica James','Silver',127656),
    ('Ana Janco', 'Silver',136773),
    ('Jennifer Cortez','Gold',300582),
    ('Christian Janco','Silver',14642);

INSERT INTO aircrafts(name, total_seats)
VALUES
    ('Boeing 747',400),
    ('Airbus A330',236),
    ('Boeing 777',264);

SELECT * FROM aircrafts;


INSERT INTO flights(flight_number, mileage, aircraft_id)
VALUES
    ('DL143',135,1),
    ('DL122',4370,2),
    ('DL53',2078,3),
    ('DL222',1765,3),
    ('DL37',531,1);


SELECT * FROM customers;

SELECT * FROM flights;

INSERT INTO bookings(customer_id, flight_id)
VALUES
    (1,1), -- Agustine → DL143 QUEEE DIFICIL RELACIONARRR
    (1,2), -- Agustine → DL122
    (2,2), -- Alaina → DL122
    (3,2), -- Tom → DL122
    (3,3), -- Tom → DL53
    (4,1), -- Sam → DL143
    (5,1), -- Jessica → DL143
    (6,4), -- Ana → DL222
    (7,4), -- Jennifer → DL222
    (5,2), -- Jessica → DL122
    (4,5), -- Sam → DL37
    (8,4); -- Christian → DL222)

SELECT * FROM bookings;

--  Mostrar nombre el cliente y vuelo
SELECT customers.name,flights.flight_number
FROM bookings
         JOIN customers
              ON bookings.customer_id = customers.id
         JOIN flights
              ON bookings.flight_id = flights.id;


-- Mostrar promedio de Millas de vuelos, agrupado por status del cliente
SELECT customers.status,
       AVG(flights.mileage)
FROM bookings
         JOIN customers
              ON bookings.customer_id = customers.id
         JOIN flights
              ON bookings.flight_id = flights.id
GROUP BY customers.status;


-- Mostrar la cantidad maxima de millas, por cada grupo (Gold,Silver,none)
SELECT customers.status,
       MAX(total_mileage)
FROM customers
GROUP BY customers.status;

-- Mostrar vuelos entre 300 y 2000 millas
SELECT flights.flight_number, flights.mileage
FROM flights
WHERE mileage BETWEEN 300 AND 2000;

-- Conatr cuantos clientes hay por status
SELECT customers.status,
       COUNT(id)
FROM customers
GROUP BY customers.status;

-- mostrar clientes con mas de 100000 millas
SELECT customers.name,customers.total_mileage
FROM customers
WHERE total_mileage > 100000;


-- mostrar cuantos vuelos reservó cada cliente
SELECT customers.name,
       COUNT(customer_id)
FROM customers
         JOIN bookings b
              ON customers.id = b.customer_id
GROUP BY customers.name;


-- Total de numeros de vuelos
SELECT COUNT(DISTINCT flight_number) AS total_flights
FROM flights;


-- calcular numero de millas
SELECT AVG(mileage) AS average_flight_distance
FROM flights;


-- calcular promedio de asientos por avion
SELECT AVG(total_seats) AS average_seats
FROM aircrafts;


-- calcular promedio de millas por status
SELECT status, AVG(total_mileage) AS average_customer_mileage
FROM customers
GROUP BY status;

-- Max cantidad maxima de millas por cada status
SELECT status, MAX(total_mileage) AS max_customer_mileage
FROM customers
GROUP BY status;


-- cuantos aviones boing hay
SELECT COUNT(*) AS boeing_aircrafts
FROM aircrafts
WHERE name LIKE '%Boeing%';


-- Mostras vuelos entre 300 y 2000 millas
SELECT flight_number, mileage
FROM flights
WHERE mileage BETWEEN 300 AND 2000;


-- promedio de millas reservadas, agrupado por status
SELECT c.status,
       AVG(f.mileage) AS average_booked_distance
FROM bookings b
         JOIN customers c
              ON b.customer_id = c.id
         JOIN flights f
              ON b.flight_id = f.id
GROUP BY c.status;
