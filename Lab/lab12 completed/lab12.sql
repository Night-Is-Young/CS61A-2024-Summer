.read data.sql


CREATE TABLE number_of_options AS
  WITH options(meat) AS (
    SELECT meat FROM main_course GROUP BY meat
  )
  SELECT COUNT(*) FROM options;


CREATE TABLE calories AS
  SELECT COUNT(*) FROM main_course AS m, pies AS p
    WHERE m.calories + p.calories < 2500;


CREATE TABLE healthiest_meats AS
  SELECT meat, MIN(m.calories + p.calories) AS calories
    FROM main_course AS m, pies AS p
    GROUP BY meat HAVING MAX(m.calories + p.calories) < 3000;

