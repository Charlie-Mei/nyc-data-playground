/* Create one combined table of commerical, residential, total, water consumption */
SELECT c.year, 
	r.consumption residential_consumption,
	c.consumption commercial_consumption,
	t.consumption total_consumption,
	t.consumption - c.consumption - r.consumption other_consumption
FROM commercial_consumption c, residential_consumption r, total_consumption t
WHERE
c.year = r.year AND t.year = r.year
ORDER BY year;

/* create one year lagged residential consumption and YoY */
SELECT a.year, 
	a.consumption, 
	a.consumption / LAG(a.consumption, 1) OVER() - 1 consumption_yoy
FROM (SELECT * FROM residential_consumption ORDER BY consumption) a
ORDER BY year;