--Problem
/*
Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by each student.
Sort your results by the total number of challenges in descending order.

If more than one student created the same number of challenges, then sort the result by hacker_id.
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.
*/


--Solution

SELECT
c.hacker_id,
h.name,
COUNT(c.challenge_id) AS num
FROM Hackers h INNER JOIN Challenges c on h.hacker_id = c.hacker_id
GROUP BY h.hacker_id,h.name
HAVING num = (SELECT COUNT(cc.challenge_id) FROM Challenges cc GROUP BY cc.hacker_id
             ORDER BY COUNT(cc.challenge_id) DESC LIMIT 1) OR
num NOT IN (SELECT COUNT(ccc.challenge_id) FROM Challenges ccc GROUP BY ccc.hacker_id
            HAVING ccc.hacker_id <> c.hacker_id)             
ORDER BY num DESC, c.hacker_id;

