CREATE DATABASE IF NOT EXISTS employee_db;

CREATE TABLE employee
(
	person_name VARCHAR(30),
    street VARCHAR(100),
    city VARCHAR(100),
    PRIMARY KEY(person_name)
);
CREATE TABLE company
(
	company_name VARCHAR(100),
    city VARCHAR(50),
    PRIMARY KEY(company_name)
);

CREATE TABLE works
(
	person_name VARCHAR(30),
    company_name VARCHAR(100),
    salary NUMERIC(8,2),
    PRIMARY KEY(person_name)
);



