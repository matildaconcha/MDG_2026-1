
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

-- Tasa de profesionales por zona censal, ordenados de mayor a menor
CREATE TABLE tablas_cpm.tot_profesionales AS
SELECT z.geocodigo, 
    c.nom_comuna, 
    ROUND(COUNT(*) FILTER (WHERE p.p15 >= 12 AND p.p15 <= 14) * 100.0 / 
    COUNT(*) FILTER (WHERE p.p09 > 18),2) AS total_profesionales
FROM personas AS p
JOIN hogares AS h
ON p.hogar_ref_id = h.hogar_ref_id 
JOIN viviendas AS v                  
ON h.vivienda_ref_id = v.vivienda_ref_id
JOIN zonas AS z
ON v.zonaloc_ref_id = z.zonaloc_ref_id
JOIN comunas AS c
ON z.codigo_comuna = c.codigo_comuna
GROUP BY z.geocodigo, c.nom_comuna
ORDER BY total_profesionales DESC;

-- Se une la geometría a la tabla de profesionales
CREATE TABLE tablas_cpm.tot_prof_geom AS
SELECT tp.geocodigo,
		tp.nom_comuna,
		tp.total_profesionales AS tasa_prof,
		zona.geom 
FROM tablas_cpm.tot_profesionales AS tp
JOIN dpa.zonas_censales_v AS zona
ON tp.geocodigo::double precision = zona.geocodigo;

-- Acceder a sistema de coordenadas
SELECT ST_SRID(geom)
FROM tablas_cpm.tot_prof_geom