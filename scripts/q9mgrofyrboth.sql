/*Which managers have won the TSN Manager of the Year award 
in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.*/

SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		a.yearid, 
		a.lgid, 
		franchname
FROM awardsmanagers as a
LEFT JOIN people as p
	ON a.playerid = p.playerid
LEFT JOIN managers as m
	ON a.playerid = m.playerid
	AND a.yearid = m.yearid
LEFT JOIN teams as t
	ON m.teamid = t.teamid
LEFT JOIN teamsfranchises as tf
	ON t.franchid = tf.franchid
WHERE awardid ILIKE '%tsn%'
	AND a.yearid >= 1986
	AND franchname NOT ILIKE '%senators%'
GROUP BY CONCAT(namefirst, ' ', namelast), a.yearid, a.lgid, franchname
ORDER BY yearid;

--only returning AL
SELECT a.playerid, a.yearid, a.lgid
FROM awardsmanagers as a
LEFT JOIN (SELECT awardsmanagers.playerid FROM awardsmanagers
WHERE lgid = 'NL') AS subquery
ON a.playerid = subquery.playerid
WHERE awardid ILIKE '%tsn%'
AND lgid = 'AL'
GROUP BY a.playerid, a.yearid, a.lgid