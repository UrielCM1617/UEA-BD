--Paso 1: Crear base y tabla

CREATE TABLE productos (
	id SERIAL PRIMARY KEY,
	nombre VARCHAR (100),
	categoria VARCHAR (50),
	precio DECIMAL (10,2)
);

--paso 2: Genera datos de prueba
INSERT INTO productos (nombre, categoria, precio)
	
SELECT 
	'Producto'|| serie.numero,
	'Categoria' ||(RANDOM()*10)::INTEGER,
	(RANDOM()*500)::DECIMAL
	
FROM(
	SELECT generate_series(1,100) AS numero
) AS serie;

--Paso 3 Mostar primeros renglones
SELECT * FROM productos LIMIT 10;

--Paso 4 Explain ANALYZE en valores específicos
EXPLAIN ANALYZE SELECT * FROM productos WHERE categoria = 'Categoria5';

--Paso 5 Explain ANALYZE en desigualdades 
EXPLAIN ANALYZE SELECT * FROM productos WHERE precio>100;

--Paso 6 Crear Índices
CREATE INDEX idx_categoria ON productos (categoria);
CREATE INDEX idx_precio ON productos (precio);

--Paso 7 Consulta con Índices en valores específicos
EXPLAIN ANALYZE SELECT * FROM productos WHERE categoria = 'Categoria 5';

--Paso 8 Consulta con Índices en desigualdades.
EXPLAIN ANALYZE SELECT * FROM productos WHERE precio>100;

