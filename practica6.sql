
CREATE TABLE carro (
	niv INT PRIMARY KEY,
	marca VARCHAR (100),
	modelo VARCHAR (100),
	color VARCHAR (100)
);

INSERT INTO carro (niv, marca, modelo, color)
VALUES
(555123, 'Dodge', 'Dart', 'Amarillo'),
(555456, 'Dodge', 'Caravan', 'Azul'),
(555789, 'Pontiac', 'Grand Am', 'Verde'),
(555321, 'Ferrari', '308 GTS', 'Rosa'),
(555654, 'Toyota', 'Land Cruiser', 'Blanco'),
(555987, 'Toyota', 'Pickup', 'Gris');


CREATE TABLE conductores (
	num_licencia INT PRIMARY KEY,
	nombre VARCHAR(100),
	apellido VARCHAR(100),
	edad_conductor VARCHAR(100)
);

INSERT INTO conductores (num_licencia, nombre, apellido, edad_conductor)
VALUES
(12345, 'Homero', 'Simpson', 40),
(54321, 'Marge', 'Simpson', 38),
(67890, 'Bart', 'Simpson', 10),
(11223, 'Lisa', 'Simpson', 14),
(33445, 'Maggie', 'Simpson', 2),
(55667, 'Ned', 'Flanders', 45);

CREATE TABLE tarifas(
	tipo_viaje VARCHAR(20) PRIMARY KEY,
	costo DECIMAL (5,3)
);

INSERT INTO tarifas (tipo_viaje, costo)
VALUES
('X', 36.00),
('Comfort', 45.00),
('Pool', 27.00);

CREATE TABLE viajes (
    id_viaje INT PRIMARY KEY,
    niv INT,
    num_licencia INT,
    tipo_viaje VARCHAR(20),
    distancia_km DECIMAL(5, 2),
    duracion_minutos INT,
    tarifa_total DECIMAL(8,2),
	FOREIGN KEY(niv) REFERENCES carro(niv),
	FOREIGN KEY(num_licencia) REFERENCES conductores(num_licencia),
	FOREIGN KEY(tipo_viaje) REFERENCES tarifas(tipo_viaje)
);

INSERT INTO viajes (id_viaje, niv, num_licencia, tipo_viaje, distancia_km, duracion_minutos, tarifa_total)
VALUES
(1, 555123, 12345, 'X', 12.50, 25, 530.00),
(2, 555456, 54321, 'Comfort', 18.75, 35, 1070.75),
(3, 555789, 67890, 'Pool', 8.00, 15, 276.00),
(4, 555321, 11223, 'X', 20.00, 40, 760.00),
(5, 555654, 33445, 'Comfort', 25.00, 50, 1185.00),
(6, 555987, 55667, 'Pool', 15.00, 30, 495.00);

SELECT 
    v.id_viaje,
    c.niv AS niv_carro,
    c.marca AS marca_carro,
    c.modelo AS modelo_carro,
    c.color AS color_carro,
    d.num_licencia,
    d.nombre AS nombre_conductor,
    d.apellido AS apellido_conductor,
    d.edad_conductor,
    t.tipo_viaje,
    t.costo AS tarifa_base,
    v.distancia_km,
    v.duracion_minutos,
    v.tarifa_total
FROM 
    viajes v
FULL JOIN 
    carro c ON v.niv = c.niv
FULL JOIN 
    conductores d ON v.num_licencia = d.num_licencia
FULL JOIN 
    tarifas t ON v.tipo_viaje = t.tipo_viaje;
