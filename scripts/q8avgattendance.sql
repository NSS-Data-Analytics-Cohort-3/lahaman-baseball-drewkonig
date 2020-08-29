/*Using the attendance figures from the homegames table, 
find the teams and parks which had the top 5 average attendance per game in 2016 
(where average attendance is defined as total attendance divided by number of games). 
Only consider parks where there were at least 10 games played. 
Report the park name, team name, and average attendance.*/

SELECT franchname, park_name, h.attendance/h.games AS avgatt
FROM homegames as h
LEFT JOIN parks as p
ON h.park = p.park
LEFT JOIN teams as t
ON h.team = t.teamid
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE year = 2016
AND franchname NOT ILIKE '%senators%'
AND games >= 10
GROUP BY franchname, park_name, h.attendance/h.games
ORDER BY avgatt DESC
LIMIT 5;

/*Repeat for the lowest 5 average attendance.*/

SELECT franchname, park_name, h.attendance/h.games AS avgatt
FROM homegames as h
LEFT JOIN parks as p
ON h.park = p.park
LEFT JOIN teams as t
ON h.team = t.teamid
LEFT JOIN teamsfranchises as tf
ON t.franchid = tf.franchid
WHERE year = 2016
AND franchname NOT ILIKE '%senators%'
AND games >= 10
GROUP BY franchname, park_name, h.attendance/h.games
ORDER BY avgatt
LIMIT 5;