drop table empleado_proyecto
drop table proyectos
drop table departamentos
drop table empleados

CREATE TABLE empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    id_departamento INT,
    salario NUMERIC(10, 2),
    fecha_contratacion DATE
);

INSERT INTO empleados (nombre, apellido, id_departamento, salario, fecha_contratacion) VALUES
('Juan', 'Pérez', 1, 60000, '2020-01-15'),
('Ana', 'García', 2, 55000, '2019-03-20'),
('Samuel', 'Rodríguez', 1, 48000, '2021-07-11'),
('María', 'López', 3, 72000, '2018-09-25');

SELECT *FROM empleados
CREATE TABLE departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nombre_departamento VARCHAR(100),
    id_jefe INT
);

INSERT INTO departamentos (nombre_departamento, id_jefe) VALUES
('Recursos Humanos', 1),
('Finanzas', 2),
('TI', 3);

CREATE TABLE proyectos (
    id_proyecto SERIAL PRIMARY KEY,
    nombre_proyecto VARCHAR(100),
    fecha_inicio DATE,
    fecha_fin DATE
);

INSERT INTO proyectos (nombre_proyecto, fecha_inicio, fecha_fin) VALUES
('Rediseño de Sitio Web', '2021-01-01', '2021-06-30'),
('Auditoría Financiera', '2020-07-01', '2020-12-31'),
('Nuevo Sistema de RRHH', '2019-04-01', '2020-04-30');


CREATE TABLE empleados_proyecto(
	id_empleado INT,
	id_proyecto INT,
	FOREIGN KEY (id_empleado) REFERENCES empleados (id_empleado),
	FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
);

INSERT INTO empleados_proyecto (id_empleado, id_proyecto) VALUES
(1,1),
(2,2),
(3,1),
(4,3),
(1,3);

SELECT * FROM departamentos
SELECT * FROM empleados_proyecto
/*1. Recupera todos los nombres y apellidos de los empleados que trabajan en el
departamento de 'TI'.	*/
SELECT nombre, apellido, nombre_departamento FROM empleados LEFT JOIN departamentos
	ON  empleados.id_empleado = departamentos.id_departamento  
	WHERE departamentos.nombre_departamento= 'TI'; 
/*2. Encuentra el salario promedio de los empleados que se unieron a la
empresa después del 1 de enero de 2020.*/
	SELECT AVG (salario) FROM empleados WHERE fecha_contratacion > '2020-01-01'; 
/*3. Lista todos los empleados junto con el nombre del departamento al que
pertenecen.*/
	SELECT nombre,apellido, nombre_departamento FROM empleados LEFT JOIN departamentos
	ON empleados.id_empleado = departamentos.id_departamento

/*4. Encuentra los proyectos en los que participó 'Juan Pérez'.*/
	SELECT nombre, apellido, nombre_proyecto FROM empleados LEFT JOIN empleados_proyecto
	ON empleados.id_empleado = empleados_proyecto.id_empleado
	LEFT JOIN proyectos 
	ON empleados_proyecto.id_proyecto = proyectos.id_proyecto
	WHERE empleados.nombre = 'Juan'AND empleados.apellido = 'Pérez';

/*5. Recupera el número de empleados por departamento cuyo salario sea
mayor a 50,000.*/
	SELECT nombre_departamento, COUNT(empleados)
	FROM departamentos INNER JOIN empleados
	ON empleados.salario > 50000
	WHERE departamentos.id_departamento = empleados.id_departamento
	GROUP BY nombre_departamento;

/*6. Muestra los empleados en orden descendente de salario y luego por fecha
de contratación ascendente.*/
	SELECT nombre, apellido, salario, fecha_contratacion FROM empleados
	ORDER BY salario DESC, fecha_contratacion ASC;

/*7. Cuenta el número total de empleados en cada departamento.*/
	SELECT nombre_departamento, COUNT(empleados)
	FROM departamentos INNER JOIN empleados
	WHERE departamentos.id_departamento = empleados.id_departamento
	GROUP BY nombre_departamento;

/*8. Aumenta el salario en un 10% para todos los empleados del departamento
de 'Finanzas'.*/
	UPDATE empleados SET salario = salario*1.1
	WHERE id_empleado = (SELECT id_empleado FROM empleados LEFT JOIN departamentos
		ON empleados.id_departamento = departamentos.id_departamento
		WHERE nombre_departamento = 'Finanzas');
SELECT * FROM empleados;
/*9. Encuentra el salario máximo, mínimo y promedio de los empleados que
trabajan en el departamento de 'Recursos Humanos'.*/
SELECT nombre_departamento,MAX(salario), MIN(salario), AVG(salario)
	FROM empleados INNER JOIN departamentos 
	ON empleados.id_departamento = departamentos.id_departamento
	WHERE nombre_departamento = 'Recursos Humanos'
	GROUP BY departamentos.id_departamento;

