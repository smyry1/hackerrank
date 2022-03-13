--Problem
A median is defined as a number separating the higher half of a data set from the lower half.
Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.


--Solution
##Method 1
SELECT ROUND(LAT_N,4)
FROM
    (SELECT LAT_N, ROW_NUMBER() OVER (ORDER BY LAT_N) as num 
     FROM STATION) AS X
WHERE num = (SELECT ROUND((COUNT(LAT_N)+1)/2,0)
             FROM STATION);


##Method 2
SELECT ROUND(S.LAT_N,4)
FROM STATION AS S 
WHERE 
(SELECT COUNT(Lat_N) FROM STATION WHERE Lat_N < S.LAT_N ) = (SELECT COUNT(Lat_N) FROM STATION WHERE Lat_N > S.LAT_N);
