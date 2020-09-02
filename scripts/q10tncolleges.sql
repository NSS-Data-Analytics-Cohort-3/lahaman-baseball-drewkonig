/*Analyze all the colleges in the state of Tennessee. Which college has had the most success in the major leagues. 
Use whatever metric for success you like - number of players, number of games, salaries, world series wins, etc.*/
--salary
SELECT distinct s.schoolname, SUM(salary) AS total_salary
FROM schools AS s
LEFT JOIN collegeplaying AS c
ON s.schoolid = c.schoolid
LEFT JOIN salaries AS sal
ON c.playerid = sal.playerid
GROUP BY s.schoolid
HAVING schoolstate = 'TN'
AND SUM(salary) IS NOT NULL
ORDER BY total_salary DESC;
--total games
SELECT distinct s.schoolname, SUM(a.g_all) AS total_games
FROM schools AS s
LEFT JOIN collegeplaying AS c
ON s.schoolid = c.schoolid
LEFT JOIN appearances AS a
ON c.playerid = a.playerid
GROUP BY s.schoolid
HAVING schoolstate = 'TN'
AND SUM(a.g_all) IS NOT NULL
ORDER BY total_games DESC;
--total players
SELECT distinct s.schoolname, COUNT(playerid) AS total_players
FROM schools AS s
LEFT JOIN collegeplaying AS c
ON s.schoolid = c.schoolid
GROUP BY s.schoolid
HAVING schoolstate = 'TN'
ORDER BY total_players DESC;