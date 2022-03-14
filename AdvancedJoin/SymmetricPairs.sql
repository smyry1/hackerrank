--Problem
/*
You are given a table, Functions, containing two columns: X and Y.

Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.
*/


--Solution
SELECT
f.X,f.Y
FROM Functions f INNER JOIN Functions ff ON f.X = ff.Y AND f.Y = ff.X
GROUP BY f.X,f.Y
HAVING COUNT(f.X) > 1 OR f.X < f.Y
ORDER BY f.X ASC;
