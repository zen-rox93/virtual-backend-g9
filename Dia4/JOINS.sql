-- continuamos con las clases

USE pruebas;

-- Traeme todas las columnas de la tabla historia_vacinaciones y medicos cuando his_vac.medio_id se igual
SELECT * FROM historial_vacunaciones 
		INNER JOIN medicos 
        ON historial_vacunaciones.medico_id = medicos.id
        INNER JOIN personas
        ON historial_vacunaciones.paciente_id = personas.id;

-- Sirve para ver la descripcion de la tabla        
DESC MEDICOS;

INSERT INTO MEDICOS (CMP, NOMBRE, APELLIDO) VALUES ('129', 'JUAN', 'ZEGARRA');

DESC HISTORIAL_VACUNACIONES;

INSERT INTO HISTORIAL_VACUNACIONES (VACUNA, LOTE, FECHA, PACIENTE_ID)
							VALUES ('ASTRAZENECA', '15964', now(), 4);
                            
SELECT * FROM HISTORIAL_VACUNACIONES;

 -- consulta pra saber que medio es el id=1                           
SELECT * FROM MEDICOS where id = 1;

-- Left Join (todo lo que concierne en el lado izquierdo y adicionalemnte si esta en el )
-- lado derecho

SELECT * FROM MEDICOS LEFT JOIN HISTORIAL_VACUNACIONES
						ON MEDICOS.ID = HISTORIAL_VACUNACIONES.MEDICO_ID;

-- Left Join (todo lo que concierne en el lado derecho y adicionalemnte si esta en el )
-- lado izquierdo                        
SELECT * FROM MEDICOS RIGHT JOIN HISTORIAL_VACUNACIONES
						ON MEDICOS.ID = HISTORIAL_VACUNACIONES.MEDICO_ID;
					