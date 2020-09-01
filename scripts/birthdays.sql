-- Same birthday, hitters
SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		b.yearid AS year, 
		t.name AS team, 
		f.pos AS primary_pos, 
		ROUND(b.h::numeric/b.ab,3) AS avg, 
		b.hr, 
		b.rbi
FROM 	(SELECT p.playerid
		FROM people AS p
		WHERE birthmonth = 1
		AND birthday = 7
		AND birthyear = 1991
		) 
		AS subquery
LEFT JOIN batting AS b
	ON subquery.playerid = b.playerid
LEFT JOIN people AS p
	ON subquery.playerid = p.playerid
LEFT JOIN teams AS t
	ON b.teamid = t.teamid AND b.yearid = t.yearid
LEFT JOIN fielding AS f
	ON subquery.playerid = f.playerid
WHERE (SELECT MAX(g)
	  FROM fielding as f2
	  WHERE f.playerid = f2.playerid) = f.g
	AND b.ab > 0
GROUP BY CONCAT(namefirst, ' ', namelast), b.yearid, t.name, f.pos, ROUND(b.h::numeric/b.ab,3), b.hr, b.rbi
ORDER BY fullname, year;

-- Same birthday, pitchers
SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		pi.yearid AS year, 
		t.name AS team, 
		f.pos AS primary_pos, 
		pi.w, 
		pi.l, 
		ROUND(pi.era::numeric,2) AS era, 
		pi.so AS k
FROM 	(SELECT p.playerid
		FROM people AS p
		WHERE birthmonth = 9
		AND birthday = 27
		AND birthyear = 1984
		) 
		AS subquery
LEFT JOIN pitching AS pi
	ON subquery.playerid = pi.playerid
LEFT JOIN people AS p
	ON subquery.playerid = p.playerid
LEFT JOIN teams AS t
	ON pi.teamid = t.teamid AND pi.yearid = t.yearid
LEFT JOIN fielding AS f
	ON subquery.playerid = f.playerid
WHERE (SELECT MAX(g)
	  FROM fielding as f2
	  WHERE f.playerid = f2.playerid) = f.g
	AND f.pos = 'P'
GROUP BY CONCAT(namefirst, ' ', namelast), pi.yearid, t.name, f.pos, pi.w, pi.l, ROUND(pi.era::numeric,2), pi.so
ORDER BY fullname, year;

-- Same birthday all-stars
SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		birthmonth, 
		birthday, 
		birthyear, 
		COUNT(a.playerid) AS asg_apps
FROM people as p
LEFT JOIN allstarfull as a
	ON p.playerid = a.playerid
WHERE birthmonth = 1
	AND birthday = 7
	AND a.playerid IS NOT NULL
GROUP BY CONCAT(namefirst, ' ', namelast), birthmonth, birthday, birthyear
ORDER BY asg_apps DESC;

--hitters from a given team with birthday
SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		birthmonth, 
		birthday, 
		birthyear, 
		t.name AS team,
		COUNT(b.playerid) AS seasons, 
		f.pos, 
		ROUND(SUM(b.h::numeric)/SUM(b.ab),3) AS avg, 
		SUM(b.hr) AS hr, 
		SUM(b.rbi) AS rbi
FROM people as p
LEFT JOIN batting AS b
	ON p.playerid = b.playerid
LEFT JOIN fielding AS f
	ON p.playerid = f.playerid
LEFT JOIN teams as t
	ON b.teamid = t.teamid
		AND b.yearid = t.yearid
WHERE birthmonth = 1
	AND birthday = 7
	AND b.teamid = 'CHN'
	AND (SELECT MAX(g)
	  	FROM fielding as f2
	  	WHERE f.playerid = f2.playerid) = f.g
	AND f.pos <> 'P'
GROUP BY CONCAT(namefirst, ' ', namelast), t.name, birthmonth, birthday, birthyear, f.pos
ORDER BY seasons DESC;

--pitchers from a given team with birthday
SELECT 	CONCAT(namefirst, ' ', namelast) AS fullname, 
		birthmonth, 
		birthday, 
		birthyear, 
		t.name AS team,
		COUNT(pit.playerid) AS seasons, 
		SUM(pit.w) AS wins, 
		SUM(pit.so) AS k 
FROM people as p
LEFT JOIN pitching AS pit
	ON p.playerid = pit.playerid
LEFT JOIN teams AS t
	ON pit.teamid = t.teamid
		AND pit.yearid = t.yearid
WHERE birthmonth = 1
	AND birthday = 7
	AND pit.teamid = 'CHN'
GROUP BY CONCAT(namefirst, ' ', namelast), birthmonth, birthday, birthyear, t.name
ORDER BY wins DESC, fullname;