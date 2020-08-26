SELECT 	CONCAT(p.namefirst, ' ', p.namelast) AS name,
		/* converts height to feet and inches, requires GROUP BY, very slow
		(ROUND(CAST(MIN(height) AS int)/12,0)) AS feet, 
		MOD(CAST(MIN(height) AS numeric),12) AS inches, */
		p.height,
		t.name AS team, 
		a.g_all AS games
FROM people as p
INNER JOIN appearances as a
ON p.playerid = a.playerid
INNER JOIN teams as t
ON a.teamid = t.teamid
--GROUP BY p.namefirst, p.namelast, t.name, a.g_all, p.height
ORDER BY height
LIMIT 1;