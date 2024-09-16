INSERT INTO CURSOS (NOMBRE, DURACION, CREDITOS, ESTADO)
            VALUES     ('REACT', 4, 5, true),
                    ('ANGULAR', 3, 3, true),
                    ('DJANGO', 5, 6, true),
                    ('FLASK', 4, 5, true),
                    ('EXPRESS', 4, 5, true);

SELECT * FROM CURSOS;
-- NOMBRES QUE EMPIEZEN QUE CON LETRA A 
SELECT * FROM ALUMNOS WHERE NOMBRE LIKE 'A%';
-- NOMBRES QUE TERMINEN QUE CON LETRA A 
SELECT * FROM ALUMNOS WHERE NOMBRE LIKE '%A';
-- NOMBRES QUE TENGAN LETRA A 
SELECT * FROM ALUMNOS WHERE NOMBRE LIKE '%A%';
-- LOS NOMBRES QUE EMPIECEN CON LETRA A Y QUE CONTENGAN LETRA E
SELECT * FROM ALUMNOS WHERE NOMBRE LIKE 'A%E';

-- todos los alumnos cuyo correo sea hotmail
SELECT * FROM ALUMNOS WHERE CORREO LIKE '%HOTMAIL%';

-- FUNCION DE AGREGACION
-- son funciones de sql que se usan para calculos en mutiples valores realizados
-- por un select y retorna un unico valor
-- Nota: si usamos una funcion de agregacion esta tiene que ir acompañada de la clausula
-- Group By en los casos que agregemos una columna adicional que no tenga nada que ver 
-- con la funcion de agregacion (tambien se puede usar la clausula having by)
SELECT count(CORREO), nombre
from alumnos 
where correo like '%hotmail%'
group by nombre;

select correo, nombre from alumnos where correo like '%hotmail%';

SELECT count(nombre) total, nombre
from alumnos
group by nombre
-- EL ORDER BY SIEMPRE VA DESPUES DEL GROUP BY Y DEL WHERE O FROM
order by total desc, nombre asc;

-- SELECT COLUMNAS | *
-- WHERE CONDICION
-- FROM TABLAS [JOIN]
-- [GROUP BY AGRUPAMIENTOS]
-- [ORDER BY COL ASC | DESC];

use calificaciones;
-- TRAER
-- NOMBRE_ALUMNO | APELLIDO_ALUMNO| NOMBRE_CURSO | ESTADO_CURSO
SELECT alumnos.nombre as NombreAlumno, alumnos.apellido as ApellidoAlumno,
		cursos.nombre as NombreCurso, cursos.estado as EstadoCurso
        
FROM ALUMNOS
INNER JOIN ALUMNOS_CURSOS ON alumnos.id = alumnos_cursos.id_alumno
INNER JOIN cursos ON cursos.id = alumnos_cursos.id_curso;

-- SABER CUANTOS ALUMNOS ESTAN INSCRITOS EN CADA CURSO

select * from cursos;

-- que este ordenado de mas a menos alumnos inscritos y si es el mismo numero
-- de alumnos inscritos que me de los cursos ordenados alfabeticamente
-- CURSO_NOMBRE | ALUMNOS_INSCRITOS
SELECT count(id_alumno) as ALUMNOS_INSCRITOS, nombre as CURSO_NOMBRE
from alumnos_cursos INNER JOIN cursos ON alumnos_cursos.id_curso = cursos.id
group by nombre
order by 1 desc, 2 asc;
-- para el order by se puede poner los siguientes valores en relacion alos nombres
-- de las columnas
-- nombre original | alias | numerode la columna empezando en 1 



