--Problem Statement
/*
Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.
Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
If more than one wand has same power, sort the result in order of descending age.
*/


--Solution
## 1st Method:
SELECT w.id, p.age, m.coins, w.power
FROM Wands w
INNER JOIN (SELECT code, power, MIN(coins_needed) AS coins FROM Wands
            GROUP BY code,power) AS m
            ON m.code = w.code AND m.power = w.power AND m.coins = w.coins_needed
INNER JOIN Wands_Property p ON p.code = w.code
WHERE p.is_evil = 0
ORDER BY w.power DESC,p.age DESC;



## 2nd Method:
SELECT
w.id, p.age, w.coins_needed, w.power
FROM 
Wands w INNER JOIN Wands_Property p ON w.code = p.code
WHERE p.is_evil = 0
AND w.coins_needed = (SELECT MIN(ww.coins_needed)
                      FROM Wands ww
                      INNER JOIN Wands_Property pp ON ww.code = pp.code
                      WHERE pp.is_evil = 0
                      AND ww.power = w.power
                      AND pp.age = p.age)
ORDER BY w.power DESC,p.age DESC;
