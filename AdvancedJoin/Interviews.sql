--Problem
/*
Samantha interviews many candidates from different colleges using coding challenges and contests.
Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views,
and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are 0.

Note: A specific contest can be used to screen candidates at more than one college, but each college only holds 1 screening contest.

*/

--Solution
SELECT
c1.contest_id,
c1.hacker_id,
c1.name,
SUM(s.sum1) AS sum11,
SUM(s.sum2) AS sum22,
SUM(v.sum3) AS sum33,
SUM(v.sum4) AS sum44
FROM Contests c1
INNER JOIN Colleges c2 ON c1.contest_id = c2.contest_id
INNER JOIN Challenges c3 ON c2.college_id = c3.college_id
LEFT JOIN 
    (SELECT challenge_id,
     SUM(total_views) AS sum3,
     SUM(total_unique_views) AS sum4
     FROM View_Stats
     GROUP BY challenge_id) v
ON c3.challenge_id = v.challenge_id
LEFT JOIN
    (SELECT challenge_id,
     SUM(total_submissions) AS sum1,
     SUM(total_accepted_submissions) AS sum2
     FROM Submission_Stats
     GROUP BY challenge_id) s
ON c3.challenge_id = s.challenge_id
GROUP BY c1.contest_id,c1.hacker_id,c1.name
HAVING sum11 != 0 OR sum22 != 0 OR sum33 != 0 OR sum44 != 0
ORDER BY c1.contest_id;
