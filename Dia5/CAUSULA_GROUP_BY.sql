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

-- TRAER
-- NOMBRE_ALUMNO | APELLIDO_ALUMNO| NOMBRE_CURSO | ESTADO_CURSO



                    
CREATE DATABASE CALIFICACIONES;
USE CALIFICACIONES;

INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Matthew', 'Ramirez', 'khouston@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Jeremy', 'Briggs', 'dawn66@thompson.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Crystal', 'Gomez', 'laurenford@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Paula', 'Griffin', 'millerdana@anderson-davis.org');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Charles', 'Hart', 'gonzalezmaria@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Crystal', 'Adams', 'greerdaniel@yahoo.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Zachary', 'Jensen', 'nancy85@smith.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Alyssa', 'Perez', 'michaelflores@flores-king.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Mark', 'Huynh', 'daniel40@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Kyle', 'Cisneros', 'lorimoore@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Debra', 'Edwards', 'jeremygarrett@maxwell.org');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Rachel', 'Delgado', 'susan98@woods.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Patricia', 'Oconnor', 'loretta34@sandoval.info');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Matthew', 'Klein', 'jeffreynichols@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Daniel', 'Young', 'kanestephen@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Lauren', 'Thornton', 'gibbsjonathan@yahoo.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Brianna', 'Shah', 'stevensonsean@colon.net');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Lori', 'Shea', 'robertmartinez@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('David', 'Crane', 'thomasstuart@horton-bowen.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('David', 'Williams', 'biancacarson@phillips.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Lauren', 'Buck', 'joshua94@morrow.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Jessica', 'Hawkins', 'moorepaige@yahoo.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Justin', 'Mendoza', 'allenkevin@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Jesus', 'Meyers', 'garciamegan@gould.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Michael', 'Weeks', 'jessica83@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Christina', 'Harris', 'bcole@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Ashlee', 'Smith', 'kevin08@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Brittney', 'Montoya', 'mfarley@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Kayla', 'Gallagher', 'whenson@roberts.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Patrick', 'Torres', 'cassandra68@gomez-golden.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Mark', 'Gonzalez', 'jcampbell@stewart-murray.info');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Jonathan', 'Acosta', 'ian23@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('John', 'Mosley', 'mccarthyangela@lee.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Mark', 'Cain', 'ashleymartin@pena-davis.net');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Ryan', 'Hill', 'dixonreginald@flynn-le.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Brad', 'Holmes', 'vhall@yahoo.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Nathaniel', 'Townsend', 'kathleen40@ramirez.net');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Sandra', 'Wagner', 'cruzphilip@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Crystal', 'Miller', 'kirstenstokes@olson.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Casey', 'White', 'tyler63@mason.org');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Sarah', 'Lawson', 'kristinjones@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Melissa', 'Hernandez', 'austinellis@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Robert', 'Palmer', 'yrodriguez@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Anne', 'Chen', 'zmueller@yahoo.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Michael', 'Cardenas', 'gmendoza@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Michelle', 'Frost', 'jennifer91@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Alyssa', 'Burgess', 'urodriguez@gmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Jessica', 'Golden', 'washingtondavid@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Christine', 'Wilson', 'hurstjeremiah@hotmail.com');
INSERT INTO ALUMNOS (nombre, apellido, correo) VALUES ('Matthew', 'Thompson', 'walkertaylor@yahoo.com');
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (25, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (32, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (6, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (50, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (2, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (7, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (40, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (41, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (41, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (43, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (43, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (2, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (35, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (28, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (7, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (6, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (39, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (3, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (38, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (50, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (20, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (2, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (7, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (42, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (47, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (26, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (23, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (15, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (42, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (22, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (32, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (15, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (6, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (29, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (33, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (29, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (31, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (42, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (41, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (13, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (9, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (24, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (23, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (38, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (22, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (31, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (7, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (15, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (17, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (40, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (35, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (32, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (37, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (33, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (5, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (2, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (21, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (13, 2);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (40, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (12, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (18, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (15, 3);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (14, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (20, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (18, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (44, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (25, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (50, 1);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 5);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (41, 4);
INSERT INTO ALUMNOS_CURSOS (ID_ALUMNO, ID_CURSO) VALUES (30, 5);