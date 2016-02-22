-- Which is the small country with the biggest gnp? Give answers for "small" by area and population


-- What is the sum of surface area of the 10 biggest countries in the world? The 10 smallest?

WITH
largest_countries as
	(SELECT
		name,
		surfacearea
	FROM country
	WHERE surfacearea > 0
	ORDER BY surfacearea DESC
	LIMIT 10)

SELECT
	SUM (surfacearea)

FROM largest_countries;

##############

WITH
smallest_countries as
	(SELECT
		name,
		surfacearea
	FROM country
	WHERE surfacearea > 0
	ORDER BY surfacearea ASC
	LIMIT 10)

SELECT
	SUM (surfacearea)

FROM smallest_countries;


-- List the countries in africa that have a population smaller than 30,000,000 and a life expectancy of more than 45?

	SELECT
		name,
		population,
		lifeexpectancy
	FROM country

	WHERE  continent = 'Africa'
		AND
	       population < 3e+7
	       AND
	       lifeexpectancy > 45;

--
-- How many countries gained independence after 1910 that are also a republic.

SELECT
  name,
  indepyear
  governmentform
FROM country

WHERE  governmentform = 'Republic'
  AND
       indepyear > 1910

-- Which region has the highest ave gnp?

SELECT
	region,
	avg(gnp) AS average_gnp

FROM
	country
GROUP BY
	region
ORDER BY
	average_gnp desc
LIMIT 1

-- Who is the head of state for the Top 10 highest ave gnp?

SELECT
	name,
	headofstate,
	gnp

FROM
	country

ORDER BY
	gnp desc

LIMIT 10


-- What are the forms of government for the top ten countries by surface area?

SELECT
	name,
	governmentform,
	surfacearea
FROM
	country

ORDER BY
	surfacearea desc

LIMIT 10


-- Which fifteen countries have the lowest life expectancy?

SELECT
	name,
	lifeexpectancy

FROM
	country

ORDER BY
	lifeexpectancy asc

LIMIT 15

-- Which five countries have the lowest population density?

SELECT
	name,
	population,
	surfacearea,
	(population) / (surfacearea) AS population_density

FROM
	country
WHERE
	population > 0

ORDER BY
	population_density asc

LIMIT 5


-- Which countries are in the top 5% in terms of area?


SELECT name, surfacearea
FROM country
ORDER BY surfacearea desc limit 239*0.05
