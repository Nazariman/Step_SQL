--1
SELECT * FROM items
WHERE type = 'овоч' AND calories < 50;

SELECT * FROM items
WHERE type = 'овоч' AND calories < 50;

SELECT * FROM items
WHERE type = 'овоч' AND name ILIKE '%капуста%';

SELECT * FROM items
WHERE description ILIKE '%гемоглобін%';

SELECT * FROM items
WHERE color IN ('жовтий', 'червоний');

-- 2
SELECT COUNT(*) AS total_vegetables
FROM items
WHERE type = 'овоч';

SELECT COUNT(*) AS total_fruits
FROM items
WHERE type = 'фрукт';

SELECT COUNT(*) AS count_by_color
FROM items
WHERE color = 'зелений';

SELECT color, COUNT(*) AS total
FROM items
GROUP BY color;

SELECT color, COUNT(*) AS total
FROM items
GROUP BY color
ORDER BY total ASC
LIMIT 1;

SELECT color, COUNT(*) AS total
FROM items
GROUP BY color
ORDER BY total DESC
LIMIT 1;

SELECT MIN(calories) AS min_calories FROM items;

SELECT MAX(calories) AS max_calories FROM items;

SELECT AVG(calories) AS avg_calories FROM items;

SELECT * FROM items
WHERE type = 'фрукт'
ORDER BY calories 
LIMIT 1;

SELECT * FROM items
WHERE type = 'фрукт'
ORDER BY calories DESC
LIMIT 1;
