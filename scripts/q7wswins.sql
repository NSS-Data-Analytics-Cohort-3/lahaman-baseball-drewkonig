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

SELECT COUNT(wswin)
FROM
(SELECT 	yearid, 
		franchname, 
		w,
		wswin
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND (w, yearid) IN (SELECT MAX(w), 
					yearid
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					GROUP BY yearid)
GROUP BY franchname, yearid, wswin, w
ORDER BY yearid) AS subquery
WHERE wswin = 'Y';

SELECT (SELECT CAST(COUNT(wswin) AS decimal)
	   FROM (SELECT 	yearid, 
		franchname, 
		w,
		wswin
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND (w, yearid) IN (SELECT MAX(w), 
					yearid
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					GROUP BY yearid)
GROUP BY franchname, yearid, wswin, w
ORDER BY yearid) AS subquery2)
	   --WHERE wswin = 'Y')  
	   /CAST(COUNT(*) AS decimal) AS pctwswin
FROM
(SELECT 	yearid, 
		franchname, 
		w,
		wswin
FROM teams as t
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE yearid BETWEEN 1970 AND 2016
AND (w, yearid) IN (SELECT MAX(w), 
					yearid
					FROM teams
					WHERE yearid BETWEEN 1970 AND 2016
					GROUP BY yearid)
GROUP BY franchname, yearid, wswin, w
ORDER BY yearid) AS subquery
WHERE wswin = 'Y';