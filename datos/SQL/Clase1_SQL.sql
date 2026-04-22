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
WHERE "Total" > 10

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
