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

#####################################
-- SQL Country Database Challenge
--
-- What languages are spoken in the 20 poorest (GNP/ capita) countries in the world?

SELECT
	c.name AS country,
	c.gnp / c.population AS gnp_per_capita,
	cl.language AS language

FROM
	country c JOIN
	countrylanguage cl ON (c.code = cl.countrycode)

WHERE

	c.code IN (SELECT code
		FROM country
		WHERE gnp > 0
		ORDER BY gnp/population ASC LIMIT 20)


ORDER BY
	gnp_per_capita ASC



	-- What are the cities in the countries with no official language?

	SELECT
		c.name AS city_name

	FROM
		city c JOIN
		countrylanguage cl ON (c.countrycode = cl.countrycode)
	EXCEPT

	SELECT
		c.name AS city_name

	FROM
		city c JOIN
		countrylanguage cl ON (c.countrycode = cl.countrycode)

	WHERE
		isofficial = 'TRUE'



	-- Which languages are spoken in the ten largest (area) countries?

	SELECT
		c.name AS country,
		c.surfacearea AS surface_area,
		cl.language AS language

	FROM
		country c JOIN
		countrylanguage cl ON (c.code = cl.countrycode)

	WHERE

		c.code IN (SELECT code
			FROM country
			WHERE surfacearea > 0
			ORDER BY surfacearea DESC LIMIT 10)


	ORDER BY
		surface_area DESC


	-- What is the total city population in countries where English is an official language? Spanish?

	WITH
country_pop as

(SELECT
	c.name AS city_name,
	c.population AS city_population,
	cl.language AS language,
	c.countrycode AS countrycode

FROM
	city c JOIN
	countrylanguage cl ON (c.countrycode = cl.countrycode)
WHERE
	language = 'English'
	AND
	isofficial = 'TRUE' )

SELECT
SUM(city_population)
FROM country_pop

###############################

WITH
country_pop as

(SELECT
	c.name AS city_name,
	c.population AS city_population,
	cl.language AS language,
	c.countrycode AS countrycode

FROM
	city c JOIN
	countrylanguage cl ON (c.countrycode = cl.countrycode)
WHERE
	language = 'Spanish'
	AND
	isofficial = 'TRUE' )

SELECT
SUM(city_population)
FROM country_pop


	-- Are there any countries without an official language?

	SELECT
	c.name AS country

FROM
	country c JOIN
	countrylanguage cl ON (c.code = cl.countrycode)
EXCEPT

SELECT
	c.name AS country

FROM
	country c JOIN
	countrylanguage cl ON (c.code = cl.countrycode)

WHERE
	isofficial = 'TRUE'


	-- How many countries have no cities?
	SELECT
	c.code AS Countrycode,
	c.name AS Country

	FROM
	country c LEFT JOIN city ci ON c.code = ci.countrycode

	WHERE
	ci.name is null

	order by
	c.name



	-- Which countries have the 100 biggest cities in the world?

	SELECT
	c.name AS country,
	cl.name AS city,
	cl.population AS population

FROM
	country c JOIN
	city cl ON (c.code = cl.countrycode)

WHERE

	cl.countrycode IN (SELECT countrycode
		FROM city
		ORDER BY population DESC LIMIT 100)


ORDER BY
	population DESC LIMIT 100

	-- What languages are spoken in the countries with the 100 biggest cities in the world?
	SELECT
	c.language AS language,
	c.countrycode AS code,
	cl.name AS city



FROM
	countrylanguage c JOIN
	city cl ON (c.countrycode = cl.countrycode)

WHERE

	cl.countrycode IN (SELECT countrycode
		FROM city
		ORDER BY population DESC LIMIT 100)


ORDER BY
	language DESC LIMIT 100


	-- Which countries have the highest proportion of official language speakers? The lowest?
	SELECT
		DISTINCT c.name AS country_name,
	

	FROM
		countrylanguage cl JOIN
		country c ON (cl.countrycode = c.code)


	WHERE

		cl.countrycode IN (SELECT countrycode
			FROM countrylanguage
			WHERE isofficial = 'True'
			ORDER BY percentage DESC LIMIT 10)


--#######

SELECT
	DISTINCT c.name AS country_name,
	

	

FROM
	countrylanguage cl JOIN
	country c ON (cl.countrycode = c.code)


WHERE

	cl.countrycode IN (SELECT countrycode
		FROM countrylanguage
		WHERE isofficial = 'True' AND
		percentage>0
		ORDER BY percentage ASC LIMIT 10)


