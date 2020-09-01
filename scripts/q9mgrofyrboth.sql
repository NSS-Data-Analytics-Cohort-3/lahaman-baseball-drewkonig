/*Which managers have won the TSN Manager of the Year award 
in both the National League (NL) and the American League (AL)? 
Give their full name and the teams that they were managing when they won the award.*/

SELECT distinct CONCAT(p.namefirst, ' ', p.namelast) AS fullname, a.yearid, a.awardid, a.lgid, t.name AS team
FROM awardsmanagers as a
RIGHT JOIN
(SELECT playerid
FROM awardsmanagers
WHERE awardid ILIKE '%tsn%'
AND lgid = 'NL') as a2
ON a.playerid = a2.playerid
LEFT JOIN people AS p
ON a.playerid = p.playerid
LEFT JOIN managers AS m
ON a.playerid = m.playerid AND a.yearid = m.yearid
LEFT JOIN teams AS t
ON m.teamid = t.teamid AND a.yearid = t.yearid
WHERE awardid ILIKE '%tsn%'
AND a.lgid = 'AL'
UNION ALL
SELECT distinct CONCAT(p.namefirst, ' ', p.namelast) AS fullname, a.yearid, a.awardid, a.lgid, t.name AS team
FROM awardsmanagers as a
RIGHT JOIN
(SELECT playerid
FROM awardsmanagers
WHERE awardid ILIKE '%tsn%'
AND lgid = 'AL') as a2
ON a.playerid = a2.playerid
LEFT JOIN people AS p
ON a.playerid = p.playerid
LEFT JOIN managers AS m
ON a.playerid = m.playerid AND a.yearid = m.yearid
LEFT JOIN teams AS t
ON m.teamid = t.teamid AND a.yearid = t.yearid
WHERE awardid ILIKE '%tsn%'
AND a.lgid = 'NL'
ORDER BY fullname, yearid;