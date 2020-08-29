/*Find the player who had the most success stealing bases in 2016, 
where success is measured as the percentage of stolen base attempts which are successful. 
(A stolen base attempt results either in a stolen base or being caught stealing.) 
Consider only players who attempted at least 20 stolen bases.*/

SELECT CONCAT(namefirst, ' ', namelast) AS fullname, 
		sb, (sb+cs) AS sbattempts, 
		ROUND(100*(CAST(sb AS decimal)/CAST((sb+cs) AS decimal)),2) AS sbpercent
FROM batting as b
LEFT JOIN people as p
ON b.playerid = p.playerid
WHERE b.yearid = 2016
AND (sb+cs) >= 20
GROUP BY CONCAT(namefirst, ' ', namelast), sb, (sb+cs)
ORDER BY sbpercent DESC
LIMIT 1