/* a.)En quin ordre s'han d'importar les dades? */
/* Començar per les taules indepedents. 
Les que no tenen claus forànees. 
Si comencem a omplir dades per les taules que contenen FK ens donarà
error. */

/* b.) Durant la importació de les dades de la taula flights, 
els camps de l’arxiu csv d’on s’importen estan ben correlacionats 
amb els camps de la taula? 
Per què creus que és això? */

/* A l’arxiu d’Excel, els camps de la taula on hi ha les dades no es 
corresponen amb els camps de la taula creada (falta el primer camp, 
flightID que és PK AI, i sobren els cinc camps últims). 
Cal que els camps de la taula a la base de dades 
i els camps de l’arxiu Excel coincideixin. */

/* 1.Quantitat registres taula Flights */
SELECT count(flightID) as Quantitat 
FROM Flights;

/* 2. Retard promig sortida arribada segons aeroport origen */
SELECT origin, avg(ArrDelay) AS promig_arribades, avg(DepDelay) AS promig_sortides
FROM Flights
GROUP BY origin;


/* 3. Retard promig arribada vols per mesos i aeroport origen*/
SELECT origin, colYear, colMonth, sum(ArrDelay)/count(origin) AS average_arr_delay
FROM Flights
GROUP BY origin, colYear, colMonth;


/* 4. Retard promig arribada vols, per mesos i aeroport origen i ciutat*/
SELECT USAirports.city, colYear, colMonth, avg(arrDelay) AS avge_arr_delay
FROM Flights
INNER JOIN USAirports
ON Flights.origin = USAirports.IATA
GROUP BY city. colYear, colMonth
ORDER BY city, colYear, colMonth;

/* 5. Companyies amb més vols cancel.lats*/
SELECT uniquecarrier, colYear, colMonth, sum(cancelled) AS total_cancelled
FROM Flights
GROUP BY uniquecarrier, colYear, colMonth
ORDER BY total_cancelled DESC;

/* 6. Els 10 avions amb més distància recorreguda*/
SELECT tailNum, sum(distance) as distancia_total 
FROM `Flights` 
GROUP BY tailNum
HAVING tailnum!='NA'
ORDER BY distancia_total DESC 
LIMIT 10;



/* 7. Companyies amb retard promig superior a 10m*/
SELECT uniquecarrier, avg(arrDelay) as avgDelay 
FROM `Flights`
GROUP BY uniquecarrier
HAVING avgDelay > 10
ORDER BY avgDelay DESC;

