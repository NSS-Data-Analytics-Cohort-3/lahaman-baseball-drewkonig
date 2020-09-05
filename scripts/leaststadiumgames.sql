SELECT SUM(games) AS least_games, park_name
FROM homegames AS h
LEFT JOIN parks AS p
ON h.park = p.park
WHERE year >=1950
GROUP BY h.park, park_name
ORDER BY least_games