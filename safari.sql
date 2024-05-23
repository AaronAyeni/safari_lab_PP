DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosure;
DROP TABLE IF EXISTS assignment;
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


CREATE TABLE animals (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    type VARCHAR(255),
    age INT,
    enclosure_id INT REFERENCES enclosure(id)
);

