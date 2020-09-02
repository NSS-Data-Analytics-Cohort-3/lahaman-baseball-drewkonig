/*\Is there any correlation between number of wins and team salary? 
Use data from 2000 and later to answer this question. 
As you do this analysis, keep in mind that salaries across the whole league tend to increase together, 
so you may want to look on a year-by-year basis.*/

SELECT yearid, corr(w,totalsalary) AS correlation
FROM (SELECT t.yearid, t.teamid, t.w, SUM(salary) AS totalsalary
FROM salaries AS s
LEFT JOIN teams AS t
ON s.teamid = t.teamid AND s.yearid = t.yearid
GROUP BY t.yearid, t.teamid, t.w
ORDER BY totalsalary) AS subquery
WHERE yearid >=2000
GROUP BY yearid