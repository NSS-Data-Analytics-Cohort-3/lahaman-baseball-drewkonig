SELECT 	p.namefirst,
		p.namelast,
		s1.schoolname AS school,
		SUM(s2.salary) AS total_salary
FROM schools AS s1
INNER JOIN collegeplaying AS c
ON s1.schoolid = c.schoolid
INNER JOIN people AS p
ON c.playerid = p.playerid
INNER JOIN salaries AS s2
ON c.playerid = s2.playerid
WHERE s1.schoolname = 'Vanderbilt University'
GROUP BY s1.schoolname, p.namefirst, p.namelast
ORDER BY total_salary DESC