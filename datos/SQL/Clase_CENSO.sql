--Total de personas por comuna

SELECT com.nom_comuna AS "COMUNA", COUNT(*) AS "Total"
FROM personas AS p
JOIN hogares AS hog
ON hog."hogar_ref_id" = p."hogar_ref_id"
JOIN viviendas as viv
ON viv."vivienda_ref_id" = hog."vivienda_ref_id"
JOIN zonas as zon
ON zon."zonaloc_ref_id" = viv."zonaloc_ref_id"
JOIN comunas as com
ON zon."codigo_comuna" = com."codigo_comuna"
GROUP BY nom_comuna
ORDER BY "Total" DESC;


-- Total de personas por zona censal

SELECT com.nom_comuna AS "COMUNA", zon.geocodigo AS "GEOCODIGO", COUNT(*) AS "TOTAL"
FROM personas AS p
JOIN hogares AS hog
ON hog."hogar_ref_id" = p."hogar_ref_id"
JOIN viviendas as viv
ON viv."vivienda_ref_id" = hog."vivienda_ref_id"
JOIN zonas as zon
ON zon."zonaloc_ref_id" = viv."zonaloc_ref_id"
JOIN comunas as com
ON zon."codigo_comuna" = com."codigo_comuna"
GROUP BY nom_comuna, geocodigo
ORDER BY "GEOCODIGO";


-- Total de personas mayores de edad por comuna

SELECT com.nom_comuna AS "COMUNA",
		COUNT(*) AS "TOTAL_PERSONAS",
		COUNT(*) FILTER (WHERE p.p09 >= 65) AS "TOTAL_PERSONAS_MAYORES",
		ROUND(((COUNT(*) FILTER (WHERE p.p09 >= 65))*100.0/(COUNT(*))),2) AS "PORCENTAJE_PERSONA_MAYOR"
FROM personas AS p
JOIN hogares AS hog
ON hog."hogar_ref_id" = p."hogar_ref_id"
JOIN viviendas as viv
ON viv."vivienda_ref_id" = hog."vivienda_ref_id"
JOIN zonas as zon
ON zon."zonaloc_ref_id" = viv."zonaloc_ref_id"
JOIN comunas as com
ON zon."codigo_comuna" = com."codigo_comuna"
GROUP BY nom_comuna
ORDER BY "TOTAL_PERSONAS_MAYORES" DESC;


-- Total de personas mayores de edad por zona censal

SELECT zon.geocodigo,
		com.nom_comuna,
		COUNT(*) AS "TOTAL_PERSONAS",
		COUNT(*) FILTER (WHERE p.p09 >= 65) AS "TOTAL_PERSONAS_MAYORES",
		ROUND(((COUNT(*) FILTER (WHERE p.p09 >= 65))*100.0/(COUNT(*))),2) AS "PORCENTAJE_PERSONA_MAYOR"
FROM personas AS p
JOIN hogares AS hog
ON hog."hogar_ref_id" = p."hogar_ref_id"
JOIN viviendas as viv
ON viv."vivienda_ref_id" = hog."vivienda_ref_id"
JOIN zonas as zon
ON zon."zonaloc_ref_id" = viv."zonaloc_ref_id"
JOIN comunas as com
ON zon."codigo_comuna" = com."codigo_comuna"
GROUP BY nom_comuna, zon.geocodigo
ORDER BY "TOTAL_PERSONAS_MAYORES" DESC;


-- Total de profesionales por zona censal
SELECT zon.geocodigo,
		com.nom_comuna,
		COUNT(*) AS "TOTAL_PERSONAS",
		COUNT(*) FILTER (WHERE p.p15 >= 12 and p.p15 <= 15) AS "TOTAL_PROFESIONALES",
		ROUND(((COUNT(*) FILTER (WHERE p.p15 >= 12 and p.p15 <= 15))*100.0/(COUNT(*))),2) AS "PORCENTAJE_PERSONAS_PROFESIONALES"
FROM personas AS p
JOIN hogares AS hog
ON hog."hogar_ref_id" = p."hogar_ref_id"
JOIN viviendas as viv
ON viv."vivienda_ref_id" = hog."vivienda_ref_id"
JOIN zonas as zon
ON zon."zonaloc_ref_id" = viv."zonaloc_ref_id"
JOIN comunas as com
ON zon."codigo_comuna" = com."codigo_comuna"
GROUP BY nom_comuna, zon.geocodigo
ORDER BY "TOTAL_PROFESIONALES" DESC;