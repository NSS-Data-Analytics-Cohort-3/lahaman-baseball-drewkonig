SELECT 	CONCAT(p.namefirst, ' ', p.namelast) AS name,
		(SELECT (ROUND(CAST(MIN(height) AS int)/12,0)) FROM people as p) AS feet, 
		(SELECT (MOD(CAST(MIN(height) AS numeric),12)) FROM people as p) AS inches,
		t.name AS team, 
		a.g_all AS games
FROM people as p
INNER JOIN appearances as a
ON p.playerid = a.playerid
INNER JOIN teams as t
ON a.teamid = t.teamid
ORDER BY height
LIMIT 1;