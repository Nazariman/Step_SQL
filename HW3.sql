CREATE DATABASE academy;

CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    financing NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (financing >= 0),
    name VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(name) > 0)
);

CREATE TABLE faculties (
    id SERIAL PRIMARY KEY,
    dean VARCHAR(255) NOT NULL CHECK (LENGTH(dean) > 0),
    name VARCHAR(100) NOT NULL UNIQUE CHECK (LENGTH(name) > 0)
);

CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(10) NOT NULL UNIQUE CHECK (LENGTH(name) > 0),
    rating INT NOT NULL CHECK (rating BETWEEN 0 AND 5),
    year INT NOT NULL CHECK (year BETWEEN 1 AND 5)
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    employment_date DATE NOT NULL CHECK (employment_date >= DATE '1990-01-01'),
    is_assistant BOOLEAN NOT NULL DEFAULT FALSE,
    is_professor BOOLEAN NOT NULL DEFAULT FALSE,
    name TEXT NOT NULL CHECK (LENGTH(name) > 0),
    position TEXT NOT NULL CHECK (LENGTH(position) > 0),
    premium NUMERIC(12,2) NOT NULL DEFAULT 0 CHECK (premium >= 0),
    salary NUMERIC(12,2) NOT NULL CHECK (salary > 0),
    surname TEXT NOT NULL CHECK (LENGTH(surname) > 0)
);

-- Query
--1
SELECT name, financing, id FROM departments;

--2 
SELECT groups.name AS "groups.name", groups.rating AS "groups.rating"
FROM groups;

--3
SELECT
  surname,
  ROUND((salary / NULLIF(premium, 0)) * 100, 2) AS salary_to_premium_percent,
  ROUND((salary / (salary + premium)) * 100, 2) AS salary_to_total_percent
FROM teachers;

--4
SELECT 
  'The dean of faculty ' || name || ' is ' || dean || '.' AS faculty_info
FROM faculties;

--5 
SELECT surname
FROM teachers
WHERE is_professor = TRUE AND salary > 1050;

--6
SELECT name
FROM departments
WHERE financing < 11000 OR financing > 25000;

--7
SELECT name
FROM faculties
WHERE name <> 'Computer Science';

--8
SELECT surname, position
FROM teachers
WHERE is_professor = FALSE;

--9
SELECT surname, position, salary, premium
FROM teachers
WHERE is_assistant = TRUE AND premium BETWEEN 160 AND 550;

--10
SELECT surname, salary
FROM teachers
WHERE is_assistant = TRUE;

--11
SELECT surname, position
FROM teachers
WHERE employment_date < DATE '2000-01-01';

--12
SELECT name AS "Name of Department"
FROM departments
WHERE name < 'Software Development';

--13
SELECT surname
FROM teachers
WHERE is_assistant = TRUE AND (salary + premium) <= 1200;

--14
SELECT name
FROM groups
WHERE year = 5 AND rating BETWEEN 2 AND 4;


--15 
SELECT surname
FROM teachers
WHERE is_assistant = TRUE AND (salary < 550 OR premium < 200);
