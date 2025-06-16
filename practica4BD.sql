-- Crear la tabla de estudiantes
CREATE TABLE estudiantes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Crear la tabla de cursos
CREATE TABLE cursos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

-- Crear la tabla de inscripciones (relación N-N)
CREATE TABLE inscripciones (
    estudiante_id INT,
    curso_id INT,
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id),
    PRIMARY KEY (estudiante_id, curso_id)
);

CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    precio NUMERIC(10, 2)
);

INSERT INTO productos (nombre, precio) VALUES ('Laptop', 999.99);
INSERT INTO productos (nombre, precio) VALUES ('Smartphone', 499.99);
INSERT INTO productos (nombre, precio) VALUES ('Tablet', 299.99);

SELECT * FROM productos;

-- Insertar datos de ejemplo en la tabla de estudiantes
INSERT INTO estudiantes (nombre) VALUES
('Juan Pérez'),
('Ana García'),
('Luis Martínez'),
('María López'),
('Pedro González');

SELECT * FROM estudiantes;

-- Insertar datos de ejemplo en la tabla de cursos
INSERT INTO cursos (nombre) VALUES
('Matemáticas'),
('Historia'),
('Ciencias'),
('Literatura'),
('Física');

SELECT * FROM cursos;
-- Insertar datos de ejemplo en la tabla de inscripciones
INSERT INTO inscripciones (estudiante_id, curso_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 2), (2, 3), (2, 4),
(3, 1), (3, 4), (3, 5),
(4, 2), (4, 5),
(5, 1), (5, 3), (5, 5);
SELECT * FROM inscripciones;

--1
CREATE OR REPLACE FUNCTION obtener_numero_cursos_con_mas_de(n INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE 
	numero_cursos INT;
BEGIN 
	SELECT COUNT(*) INTO numero_cursos FROM cursos  
	WHERE (SELECT COUNT(*) FROM inscripciones
		WHERE inscripciones.curso_id = cursos.id) > n;
	RETURN numero_cursos;
END;
$$; 

SELECT obtener_numero_cursos_con_mas_de(1);
----------------------------------
--2

CREATE OR REPLACE FUNCTION obtener_numero_estudiantes_con_mas_de(n INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE 
	numero_cursos INT;
BEGIN 
	SELECT COUNT(*) INTO numero_cursos FROM estudiantes  
	WHERE (SELECT COUNT(*) FROM inscripciones
		WHERE inscripciones.estudiante_id = estudiantes.id) > n;
	RETURN numero_cursos;
END;
$$; 

SELECT obtener_numero_estudiantes_con_mas_de(3);
