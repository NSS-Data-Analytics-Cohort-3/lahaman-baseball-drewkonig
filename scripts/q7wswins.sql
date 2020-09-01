/*From 1970 – 2016, what is the largest number of wins for a team that did not win the world series?
What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion
– determine why this is the case.*/

SELECT 	yearid, 
		franchname, 
		MAX(w) as mostwins
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND wswin = 'N'
GROUP BY franchname, yearid
ORDER BY mostwins DESC
LIMIT 1;

SELECT 	yearid, 
		franchname, 
		MIN(w) as leastwins,
		g
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND wswin = 'Y'
GROUP BY franchname, yearid, g
ORDER BY leastwins
LIMIT 1;

/*Then redo your query, excluding the problem year.*/ 

SELECT 	yearid, 
		franchname, 
		MIN(w) as leastwins,
		g
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND yearid <> 1981
AND wswin = 'Y'
GROUP BY franchname, yearid, g
ORDER BY leastwins
LIMIT 1;

/*How often from 1970 – 2016 was it the case that a team with the most wins 
also won the world series? 
What percentage of the time?*/

SELECT 	wswin,
		COUNT(wswin) as wswincount,
		ROUND(COUNT(wswin) * 100.0 / 53,2) as wspercent
FROM(SELECT t.yearid, t.name, t.w, t.wswin
	FROM teams AS t
	INNER JOIN
    	(SELECT yearid, MAX(w) AS maxwins
    	FROM teams
    	GROUP BY yearid) AS groupedteams 
	ON t.yearid = groupedteams.yearid
	AND t.w = groupedteams.maxwins
	WHERE t.yearid >= 1970) AS subquery
WHERE wswin IS NOT NULL
GROUP BY wswin
ORDER BY wswin DESC;