
-- Work with MovieDB

a) Which males, who are at least 2.10m tall, were born in the London district of Barnes?
SELECT name
FROM person
WHERE sex = 'm' AND height > 210
AND birth_location LIKE '% Barnes %'

b) Which males, who are between 1.30m and 1.35m tall, have a last name beginning with ’D’? Discard
people who have no place of birth. Also discard people who have a country where they died. Return the
name and the place of birth.

SELECT name , birth_location
FROM person
WHERE sex = 'm' AND height BETWEEN 130 AND 135
AND birth_location IS NOT NULL AND death_country IS NULL
AND name LIKE 'D%'

c) For which currencies are there productions with a budget of more than 1010? Don’t output a currency
name twice and sort the result in descending order.

SELECT DISTINCT currency
FROM budget
WHERE budget > 10000000000
ORDER BY currency DESC


d) Which people born in Norway, Belgium or Sweden celebrate their birthday on May 19? Return the name,
country of birth and date of birth (in format May 19, 2020).

SELECT name , birth_country , TO_CHAR ( birth_date , ’Month DD , YYYY ’)
FROM person
WHERE TO_CHAR ( birth_date , 'DD ') = '19' AND TO_CHAR ( birth_date , 'MM') = '05'
AND birth_country IN ('Norway', 'Belgium', 'Sweden')



e) Output the rating and the number of votes of productions. Limit the result to ratings better than 9.5 and
output each rating only once. Output ’many votes’ for over 5 000 votes cast, and ’few votes’ for 5 000 or
less votes cast. Sort the result in ascending order by the rating, then in descending order by the number
of votes cast.

SELECT DISTINCT rating ,
	CASE WHEN votes > 5000 THEN
		'many votes'
	ELSE
		'few votes'
	END vote
FROM rating
WHERE rating > 9.5
ORDER BY rating , vote DESC


f) Give the name and country of birth of persons whose first name is Lena. Restrict the result to persons
for whom the height and the country of birth is known. The country of birth should not be Germany or
Sweden.Sort the result in ascending order by country of birth.

SELECT name , birth_country
FROM person
WHERE SUBSTR (name , STRPOS (name , ',')+2) = 'Lena'
AND height IS NOT NULL AND birth_country IS NOT NULL
AND birth_country NOT IN ('Germany', 'Sweden')
ORDER BY birth_country



g) The output is a quote from Sheldon Cooper in which the word ’Spock’ is mentioned. The quotations are
sorted alphabetically and only the quotation part after the colon is printed.

SELECT SUBSTR (quote , STRPOS (quote , ':')+2) AS " quote "
FROM quote
WHERE quote LIKE '% Spock %'
AND SUBSTR (quote , 1, STRPOS (quote , ':')) = 'Sheldon Cooper :'
ORDER BY " quote "


h) First name and last name in the form [firstname lastname], the gender, height and date of birth of persons
born in Hannover after 1970 are displayed. The output is in the form of a sentence and the short name
for the gender from the database is converted into a word depending on the value. In addition, 0 is output
for height if no value is stored in the database.

SELECT SUBSTR (name , STRPOS (name , ',')+2 , LENGTH ( name )) || ' '||
	SUBSTR (name , 0, STRPOS (name , ',')) || '(' ||
	CASE sex WHEN 'm' THEN 'male'
		WHEN 'f' THEN 'female'
	ELSE 'unknown'
	END || ') is ' ||
	COALESCE (height , 0) || 'cm tall and was born on' ||
		TO_CHAR ( birth_date , 'DD.MM. YYYY')
FROM person
WHERE birth_location = 'Hannover' AND
	TO_CHAR ( birth_date , 'YYYY') > '1970'



i) The query provides the real name, country of birth and height of persons born after January 1, 1998
whose real name is available in the database. In addition, the name of the country of birth must have
more than six characters and start with a letter lower than F. The result is sorted in descending order of
height, then in ascending order of country of birth. Values for body height that do not exist are replaced
by 0.

SELECT realname , birth_country , COALESCE (height , 0) height
FROM person
WHERE birth_date > '01 -01 -1998' AND realname IS NOT NULL
AND LENGTH ( birth_country ) > 6 AND birth_country < 'F'
ORDER BY height DESC , birth_country

j) What are Malcolm Ford’s parents’ names? Give the names of the mother and father

SELECT fa.name , mo. name
FROM person fa JOIN parents ON (fa. person = father )
	JOIN person mo ON (mo. person = mother )
	JOIN person child ON ( parents . person = child . person )
WHERE child . name = 'Ford , Malcolm '




k) Which people have starred in both the television series The Big Bang Theory and the television series
Brooklyn Nine-Nine? List the names and roles in each series (without duplicates) and use appropriate
column aliases for the roles.

SELECT DISTINCT name , BP. role " Role in Big Bang Theory ", LP. role " Role in Brooklyn Nine - Nine "
FROM person JOIN plays BP USING ( person )
	JOIN episode BE USING ( production )
	JOIN series BS USING ( series )
	JOIN plays LP USING ( person )
	JOIN episode LE ON (LP. production = LE. production )
	JOIN series LS ON (LE. series = LS. series )
WHERE BS. title = 'The Big Bang Theory ' AND LS. title = 'Brooklyn Nine - Nine '

l) Provide the names of all persons who acted in the most expensive production in the currency ’EUR’.

SELECT name
FROM budget JOIN works USING ( production )
	JOIN person USING ( person )
WHERE currency = 'EUR ' AND job = 'actor ' AND budget >= ALL ( SELECT budget
															   FROM budget
															   WHERE currency = 'EUR ')
															   
m)  The query provides the names of all persons who have already worked on a popular (10 000 votes or more)
movie that received a rating of 9 or better, but have never worked on a popular movie that received a
rating of 8 or worse.

SELECT name
FROM person p1
WHERE EXISTS ( SELECT *
			   FROM works JOIN rating USING ( production )
			   WHERE works . person = p1. person AND rating >= 9.0
			   AND votes > 10000)
AND NOT EXISTS ( SELECT *
				 FROM works JOIN rating USING ( production )
				 WHERE works . person = p1. person AND rating <= 8.0
				 AND votes > 10000)
n) The query returns the title and production year of all productions that have at least three sequels, as well
as the title and production year of these sequels; the first part having been produced in 1984 and the
fourth part in 1987.

SELECT p1.title , p1.year , p2.title , p2.year , p3.title , p3.year , p4.title , p4. year
FROM link l1
	JOIN link l2 ON (l2. production2 = l1. production1 )
	JOIN link l3 ON (l3. production2 = l2. production1 )
	JOIN production p1 ON (l1. production2 = p1. production )
	JOIN production p2 ON (l2. production2 = p2. production )
	JOIN production p3 ON (l3. production2 = p3. production )
	JOIN production p4 ON (l3. production1 = p4. production )
WHERE l1. link = 'follows ' AND l2. link = 'follows ' AND l3. link = 'follows '
AND p1. year = 1984 AND p4. year = 1987


o)  The query provides the titles of all productions in which only Germany and France were jointly involved.

SELECT title
FROM production p JOIN country c1 ON (p. production = c1. production )
	JOIN country c2 ON (p. production = c2. production )
WHERE c1. country = 'France ' AND c2. country = 'Germany ' AND NOT EXISTS ( SELECT *
																			FROM country c3
																			WHERE c3. production = p. production
																			AND c3. country NOT IN ('France ', 'Germany '))










