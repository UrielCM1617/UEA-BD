-- Autor: Uriel Castillo Martínez
CREATE TABLE empleados (
	id_empleado SERIAL PRIMARY KEY,
	primer_nombre VARCHAR(100),
	apellido VARCHAR(100),
	salario INT,
	departamento VARCHAR (100)
);

-- Insertar datos en la tabla empleados
INSERT INTO empleados (id_empleado, primer_nombre, apellido, salario, departamento) VALUES
(1, 'Homero', 'Simpson', 3000, 'Ventas'),
(2, 'Marge', 'Simpson', 3500, 'Marketing'),
(3, 'Bart', 'Simpson', 2800, 'Ventas'),
(4, 'Lisa', 'Simpson', 3200, 'IT');

SELECT * FROM empleados

-- Requerimientos
--1 Agregar una nueva columna
ALTER TABLE empleados ADD COLUMN departamento_id INTEGER
SELECT * FROM empleados
	
--2 Crear una nueva tabla
CREATE TABLE departamentos(
	departamento_id serial PRIMARY KEY,
	nombre_departamento VARCHAR(100)
);
SELECT * FROM departamentos 

--3 Insertar Datos en la tabla 
INSERT INTO departamentos (nombre_departamento) VALUES
('Ventas'),
('Marketing'),
('IT');
SELECT * FROM departamentos 

--4 Actualizar la columna
UPDATE empleados
SET departamento_id = (SELECT departamento_id 
	FROM departamentos 
	WHERE nombre_departamento = empleados.departamento);
SELECT * FROM empleados
--5 Agregar una llave Foranea
ALTER TABLE empleados ADD CONSTRAINT fk_departamento FOREIGN KEY (departamento_id) 
	REFERENCES departamentos (departamento_id)
	
--6 Eliminar Columna
ALTER TABLE empleados DROP COLUMN departamento
SELECT * FROM empleados

--7 Cambiar el tipo de dato de la columna
ALTER TABLE empleados ALTER COLUMN salario TYPE DECIMAL(8,2)
SELECT * FROM empleados 