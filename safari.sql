DROP TABLE IF EXISTS animal;
DROP TABLE IF EXISTS assignment;
DROP TABLE IF EXISTS enclosure;
DROP TABLE IF EXISTS staff;


CREATE TABLE staff (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    employeeNumber INT
);

CREATE TABLE enclosure (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    capacity INT,
    closedForMaintenance BOOLEAN
);

CREATE TABLE assignment (
    id SERIAL PRIMARY KEY,
    day VARCHAR(255),
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosure(id)
);


CREATE TABLE animal (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosure(id)
);
-- staff
INSERT INTO staff(name, employeeNumber) VALUES ('Aaron Ayeni',1);
INSERT INTO staff(name, employeeNumber) VALUES ('Gellila Zeru',2);
INSERT INTO staff(name, employeeNumber) VALUES ('Ranger Rick',3);
INSERT INTO staff(name, employeeNumber) VALUES ('Zookeeper Karen',4);
INSERT INTO staff(name, employeeNumber) VALUES ('Captain Chloe',5);

-- enclosure
INSERT INTO enclosure(name, capacity, closedForMaintenance) VALUES ('Big Cat Field', 20, false);
INSERT INTO enclosure(name, capacity, closedForMaintenance) VALUES ('Monkey Mansion', 30, false);
INSERT INTO enclosure(name, capacity, closedForMaintenance) VALUES ('Snake Pit', 100, true);
INSERT INTO enclosure(name, capacity, closedForMaintenance) VALUES ('Lion Land', 20, false);
INSERT INTO enclosure(name, capacity, closedForMaintenance) VALUES ('Zebra Zone', 15, false);

-- ASSIGNMENT;
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Monday', 1, 5);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Tuesday', 1, 3);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Wednesday', 1, 2);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Friday', 1, 1);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Saturday', 1, 4);

INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Monday', 2, 5);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Tuesday', 2, 3);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Wednesday', 2, 2);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Friday', 2, 1);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Saturday', 2, 4);

INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Monday', 3, 4);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Tuesday', 3, 2);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Wednesday', 3, 1);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Friday', 3, 3);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Saturday', 3, 5);

INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Monday', 4, 4);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Tuesday', 4, 2);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Wednesday', 4, 5);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Friday', 4, 1);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Saturday', 4, 3);

INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Monday', 5, 4);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Tuesday', 5, 3);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Wednesday', 5, 5);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Friday', 5, 2);
INSERT INTO assignment(day, employeeId, enclosureId) VALUES ('Saturday', 5, 1);

-- SELECT * FROM assignment;

-- animals
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('Tony', 'Tiger', 59, 1);
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('George', 'Monkey', 3, 2);
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('Naga', 'Python', 6, 3);
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('Alex', 'Lion', 14, 4);
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('Marty', 'Zebra', 8, 5);
INSERT INTO animal(name, type, age, enclosure_id) VALUES ('Zain', 'Zebra', 11, 5);

--SELECT * FROM animal;

SELECT name FROM animal WHERE enclosure_id = 5;



-- <-- 1. enter code --> 
-- Writing a query to find the name of the animals from 'Monkey Mansion'
SELECT name FROM animal WHERE enclosure_id = 5;

-- <-- 2. enter code -->
-- Finding the name of the staff working in a given enclosure 
SELECT staff.name FROM staff JOIN assignment ON staff.id = assignment.employeeId WHERE assignment.enclosureId = 2;
-- if we wanted to check specific day --
SELECT staff.name FROM staff JOIN assignment ON staff.id = assignment.employeeId WHERE assignment.enclosureId = 2 AND assignment.day = 'Tuesday';


-- EXTENSIONS --

-- names of staff working on closed maintenance
SELECT staff.name FROM staff JOIN assignment ON staff.id = assignment.employeeId JOIN enclosure ON assignment.enclosureId = enclosure.Id WHERE enclosure.closedForMaintenance = true; 

-- name of the enclosure where the oldest animal lives
SELECT enclosure.name FROM enclosure JOIN animal ON enclosure.id = animal.enclosure_id ORDER BY age DESC LIMIT 1;

-- number of animal types each keeper is assigned to work with
 SELECT COUNT(DISTINCT animal.type) FROM assignment JOIN staff ON assignment.employeeId = staff.id JOIN enclosure ON assignment.enclosureid = enclosureid JOIN animal ON enclosure.id = animal.enclosure_id WHERE staff.id = 5;

-- The number of different keepers who have been assigned to work in a given enclosure
SELECT COUNT(DISTINCT staff.id )
FROM staff
JOIN assignment ON staff.id = assignment.employeeId
WHERE assignment.enclosureId = 3;
-- The names of the other animals sharing an enclosure with a given animal (eg. find the names of all the animals sharing the big cat field with Tony)
SELECT animal.name
FROM animal
JOIN animal AS animal2 ON animal.enclosure_id = animal2.enclosure_id
WHERE animal2.name = 'Marty' AND animal.name != 'Marty';