
/*
ESTO
ES
UN
COMENTARIO
LARGO
(se usa para definir secciones)
*/

-- COMENTARIO CORTO (se usa para explicar lineas)

-- Consultar todos los artistas

SELECT * -- que columnas queremos consultar
FROM "Artist"; -- que tabla quiero consultar

SELECT "Name"
FROM "Artist"; 

SELECT "FirstName", "LastName" 
FROM "Customer"; 

SELECT * 
FROM "Customer"
WHERE "Country" = 'Chile';

SELECT * 
FROM "Customer"
WHERE "Country" = 'Brazil'
ORDER BY "LastName" DESC;

-- SEECCIONAR TODOS LOS EMPLEADOS QUE TRABAJAN EN IT STAFF ORDENADOS SEGUN EL PRIMER NOMBRE
SELECT * 
FROM "Employee"
WHERE "Title" = 'IT Staff'
ORDER BY "FirstName";

-- SELECCIONAR TODOS LOS ALBUMES ORDENADOS ALFABETICAMENTE
SELECT *
FROM "Album"
ORDER BY "Title";

-- HACER UNA TABLA QUE CONTENGA UNICAMENTE EL NOMBRE DE LA CANCION, SU DURACION Y ORDENADOS SEGUN DURACION
SELECT "Name", "Milliseconds"/60
FROM "Track"
ORDER BY "Milliseconds";

-- SELECCIONAR TODAS LAS BOLETAS CUYO VALOR SUPERE LOS $10
SELECT "Total"
FROM "Invoice"
WHERE "Total" > 10;

/* #########################
##### 2. OPERADORES ########
######################### */

-- Contar número de boletas
SELECT COUNT(*)
FROM "Invoice";

-- Sumar monto total de boletas
SELECT SUM("Total")
FROM "Invoice";

-- Calcular el costo promedio de las boletas
SELECT AVG("Total")
FROM "Invoice";

-- Calcular minimo y maximo valor de las boletas
SELECT MIN("Total")
FROM "Invoice";


SELECT MAX("Total")
FROM "Invoice";

-- Todas las estadisticas en una
SELECT COUNT(*) AS conteo, 
		SUM("Total") AS suma, 
		AVG("Total") AS promedio, 
		MIN("Total") AS minimo,
		MAX("Total") AS maximo
FROM "Invoice";

-- Mostrar todos los alumes y sus respectivos artistas
SELECT "Album"."Title" AS Album, "Artist"."Name" AS Artist
FROM "Album"
JOIN "Artist" -- que tabla queremos unir
ON "Album"."ArtistId" = "Artist"."ArtistId"; -- en base a qué columna hacemos la unión.

-- Mostrar todas las pistas, duracion y su respectivo album
SELECT "Album"."Title" AS Album, "Track"."Milliseconds" AS Duracion
FROM "Album"
JOIN "Track"
ON "Album"."AlbumId" = "Track"."AlbumId";

SELECT al."Title" AS Album, tra."Milliseconds" AS Duracion
FROM "Album" AS al
JOIN "Track" AS tra
ON al."AlbumId" = tra."AlbumId";

-- Mostrar todas las pistas, su artista y su album
SELECT *
FROM "Track";

SELECT *
FROM "Artist";

SELECT *
FROM "Album";

SELECT al."Title" AS Album, tra."Name" AS Cancion, ar."Name" AS Artista
FROM "Album" AS al
JOIN "Track" AS tra
ON al."AlbumId" = tra."AlbumId"
JOIN "Artist" AS ar
ON al."ArtistId" = ar."ArtistId";

-- Contar la cantidad de clientes según el país, y  generar un top 5
SELECT "Country", COUNT(*) AS "Total"
FROM "Customer"
GROUP BY "Country"
ORDER BY "Total" DESC
LIMIT 5;

-- Total de boletas por país
SELECT "BillingCountry", COUNT(*) AS "Total"
FROM "Invoice"
GROUP BY "BillingCountry";

-- Total de ventas en dolares
SELECT "BillingCountry", SUM("Total") AS "Total"
FROM "Invoice"
GROUP BY "BillingCountry";

-- Para cada genero musical, encontrar el total de pistas y duración promedio
-- de las pistas
SELECT genero."Name" AS Genero, COUNT(*) AS "Total", ROUND(AVG("Milliseconds"/60000),2) AS "Duracion"
FROM "Genre" AS genero
JOIN "Track" AS cancion
ON genero."GenreId" = cancion."GenreId"
GROUP BY genero."Name"
HAVING ROUND(AVG("Milliseconds"/60000),2) < 5
ORDER BY "Duracion" DESC;


SELECT *
FROM "Genre";

SELECT *
FROM "Track";

-- SUB QUERYS
--  Cual es el precio promedio de las boletas?
SELECT ROUND(AVG("Total"), 2)
FROM "Invoice";

-- Facturas mayores al promedio 
SELECT *
FROM "Invoice"
WHERE "Total" > (
		SELECT ROUND(AVG("Total"), 2)
		FROM "Invoice"
);

-- clientes que han gastado más que el promedio
SELECT *
FROM "Customer";

SELECT *
FROM "Invoice";

SELECT cli."FirstName" AS Nombre, ROUND(AVG("Total"), 2) AS Promedio_Gastos
FROM "Invoice" AS bol
JOIN "Customer" AS cli
ON cli."CustomerId" = bol."CustomerId"
GROUP BY cli."CustomerId"
HAVING ROUND(AVG("Total"), 2) > (
		SELECT ROUND(AVG("Total"), 2)
		FROM "Invoice"		
)
;