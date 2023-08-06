```sql
CREATE TABLE people (name VARCHAR(100), birthdate DATE, sex CHAR(1),
                     citizenship CHAR(2));
 
INSERT INTO people VALUES
("Jimmy Hendrix", "19421127", "M", "US"),
("Herbert G Wells", "18660921", "M", "UK"),
("Angela Merkel", "19540717", "F", "DE"),
("Rigoberta Menchu", "19590109", "F", "GT"),
("Georges Danton", "17591026", "M", "FR"),
("Tracy Chapman", "19640330", "F", "US");


CREATE TABLE country(code CHAR(2), name VARCHAR(100));

INSERT INTO country VALUES
("GT", "Guatemala"),
("DE", "Germany"),
("FR", "France"),
("UK", "United Kingdom"),
("US", "United States of America");
```

```sql
SET @rownum:=0;

SELECT @rownum:=(@rownum+1) AS num, name, birthdate
FROM people
ORDER BY birthdate;

SELECT @rownum:=(@rownum+1) AS num, name, birthdate
FROM (SELECT @rownum:=0) AS initialization, people
ORDER BY birthdate;

SET @rownum:=0;

SELECT @rownum:=(@rownum+1) AS num, people.name,
       people.birthdate, country.name
FROM people JOIN country ON people.citizenship=country.code
ORDER BY people.birthdate;

SET @rownum:=0;
SELECT A.*, country.name FROM
(SELECT @rownum:=(@rownum+1) AS num, people.name,
       people.birthdate, citizenship
FROM people ORDER BY people.birthdate) A JOIN country ON A.citizenship=country.code
;
```
