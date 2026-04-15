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