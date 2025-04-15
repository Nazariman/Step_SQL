--1 
SELECT t.surname, g.name
FROM teachers t, groups g;

--2 
SELECT f.name
FROM faculties f
JOIN departments d ON d.faculty_id = f.id
GROUP BY f.id, f.name
HAVING SUM(d.financing) > f.financing;

--3 
SELECT t.surname, g.name
FROM groups g
JOIN teachers t ON g.curator_id = t.id;

--4
SELECT t.name, t.surname
FROM lectures l
JOIN teachers t ON l.teacher_id = t.id
JOIN groups g ON l.group_id = g.id
WHERE g.name = 'P107';

--5
SELECT DISTINCT t.surname, f.name AS faculty
FROM lectures l
JOIN teachers t ON l.teacher_id = t.id
JOIN groups g ON l.group_id = g.id
JOIN faculties f ON g.faculty_id = f.id;

--6 
SELECT d.name AS department, g.name AS group_name
FROM groups g
JOIN departments d ON g.department_id = d.id;

--7 
SELECT s.name AS subject
FROM lectures l
JOIN teachers t ON l.teacher_id = t.id
JOIN subjects s ON l.subject_id = s.id
WHERE t.name = 'Samantha' AND t.surname = 'Adams';

--8 
SELECT DISTINCT d.name AS department
FROM lectures l
JOIN subjects s ON l.subject_id = s.id
JOIN teachers t ON l.teacher_id = t.id
JOIN departments d ON t.department_id = d.id
WHERE s.name = 'Database Theory';

--9
SELECT g.name
FROM groups g
JOIN faculties f ON g.faculty_id = f.id
WHERE f.name = 'Computer Science';

--10 
SELECT g.name AS group_name, f.name AS faculty
FROM groups g
JOIN faculties f ON g.faculty_id = f.id
WHERE g.year = 5;

--11
SELECT t.name || ' ' || t.surname AS full_name,
       s.name AS subject_name,
       g.name AS group_name
FROM lectures l
JOIN teachers t ON l.teacher_id = t.id
JOIN groups g ON l.group_id = g.id
JOIN subjects s ON l.subject_id = s.id
WHERE l.auditorium = 'B103';

