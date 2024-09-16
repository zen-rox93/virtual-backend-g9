use empresa;

select count(departamento_id), departamento_id, nombre 
from personales
group by departamento_id, nombre;

-- mostrar cuantos empleados hay en el departamento 2 
SELECT 'departamento 2' departamento, count(*) total
from personales
where departamento_id = 2;

-- MOSTRAR CUANTAS PERSONAS NO TIENEN JEFE
-- TOTAL
-- 20
SELECT COUNT(*)
FROM PERSONALES
WHERE SUPERVISOR_ID IS NULL;

-- DE ESAS PERSONAS INDICAR DE QUE DEPARTAMENTOS SON
-- DEPARTAMENTO | TOTAL
-- 		1			10
-- 		2			4
-- 		3			2 
-- 		4			4

SELECT COUNT(*) TOTAL, DEPARTAMENTO_ID
FROM PERSONALES
WHERE SUPERVISOR_ID IS NULL
GROUP BY DEPARTAMENTO_ID
ORDER BY 1 DESC;

-- Mostrar el nombre del departamento y su cantidad de empleados

-- DEPARTAMENTO  | CANTIDAD DE EMPLEADOS
-- ventas		| 	150
-- adm			| 	200
-- mkt			|	26

SELECT departamentos.nombre, count(personales.id) as 'CANTIDAD DE EMPLEADOS'
FROM departamentos inner join personales
	on departamentos.id = personales. departamento_id
GROUP BY departamentos.nombre;



