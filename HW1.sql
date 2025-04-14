-- 1

CREATE DATABASE Birds;

-- 2
ALTER DATABASE Birds RENAME TO Cats;

--3
DROP DATABASE Cats;

--4 
CREATE DATABASE fruits_vegetables;

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    type VARCHAR(20),         -- 'овоч' або 'фрукт'
    color VARCHAR(50),
    calories INTEGER,
    description TEXT
);

--5 
SELECT * FROM items;
SELECT * FROM items
WHERE type = 'овоч';

SELECT * FROM items
WHERE type = 'фрукт';

SELECT name FROM items;

SELECT DISTINCT color FROM items;

SELECT * FROM items
WHERE type = 'фрукт' AND color = 'червоний';

SELECT * FROM items
WHERE type = 'овоч' AND color = 'зелений';
