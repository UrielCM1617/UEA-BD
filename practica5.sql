---- Tabla peliculas 
CREATE TABLE peliculas (
    id_pelicula INT PRIMARY KEY,
    titulo VARCHAR(100)
);

INSERT INTO peliculas (id_pelicula, titulo) VALUES
(1, 'Drive'),
(2, 'El Gran Hotel Budapest'),
(3, 'The Vast of Night'),
(4, 'Pontypool'),
(5, 'Blade Runner 2049');

----- Tabla actores
CREATE TABLE actores (
    id_actor SERIAL PRIMARY KEY,
    nombre_actor VARCHAR(100),
    apellido_actor VARCHAR(100)
);

INSERT INTO actores (id_actor, nombre_actor, apellido_actor) VALUES
(1, 'Ryan', 'Gosling'),
(2, 'Crey', 'Muligan'),
(3, 'Ralph', 'Fiennes'),
(4, 'Murray','Abraham'),
(5, 'Sierra','McCormick'),
(6, 'Jake','Horowitz'),
(7, 'Stephen','McHattie'),
(8, 'Lisa','Houle'),
(9, 'Harrison','Ford');

---- Tabla peliculas_actores
CREATE TABLE peliculas_actores (
    id_pelicula INT,
    id_actor INT, 
	PRIMARY KEY(id_pelicula, id_actor),
	FOREIGN KEY(id_pelicula) REFERENCES peliculas,
	FOREIGN KEY(id_actor) REFERENCES actores
);

INSERT INTO peliculas_actores (id_pelicula, id_actor) VALUES
	(1,1),
	(1,2),
	(2,3),
	(2,4),
	(3,5),
	(3,6),
	(4,7),
	(4,8),
	(5,1),
	(5,9);

---- Tabla generos
CREATE TABLE generos (
    id_genero INT PRIMARY KEY,
    genero VARCHAR(100)
);

INSERT INTO generos (id_genero, genero) VALUES
	(1, 'Accion'),
	(2, 'Thriller'),
	(3, 'Comedia'),
	(4, 'Drama'),
	(5, 'Ciencia Ficción'),
	(6, 'Misterio'),
	(7, 'Terror');
	
----- Tabla peliculas_generos
CREATE TABLE peliculas_generos (
    id_pelicula INT,
    id_genero INT, 
	PRIMARY KEY(id_pelicula, id_genero),
	FOREIGN KEY(id_pelicula) REFERENCES peliculas,
	FOREIGN KEY(id_genero) REFERENCES generos
);

INSERT INTO peliculas_generos (id_pelicula, id_genero) VALUES
	(1,1),
	(1,2),
	(2,3),
	(2,4),
	(3,5),
	(3,6),
	(4,7),
	(4,6),
	(5,5),
	(5,1);

----------------------
/* Haga una consulta con joins que muestre el 
título de la película, actor y género. */

SELECT peliculas.titulo, actores.nombre_actor, generos.genero FROM peliculas
	INNER JOIN peliculas_actores ON peliculas.id_pelicula = peliculas_actores.id_pelicula 
	INNER JOIN actores ON peliculas_actores.id_actor = actores.id_actor
	INNER JOIN peliculas_generos ON peliculas.id_pelicula = peliculas_generos.id_pelicula 
	INNER JOIN generos ON peliculas_generos.id_genero = generos.id_genero;


-------------------------------------------------------------------------------- parte 2
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    producto VARCHAR(50),
    precio DECIMAL(10, 2)
);

INSERT INTO productos (producto, precio) VALUES
('Smartphone X200', 699),
('Laptop Pro 15', 1299),
('Camiseta de Algodon', 25),
('Silla Ergonomica', 150),
('Televisor UltraHD 4K', 799);


CREATE TABLE categorias (
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(50)
);

INSERT INTO categorias (nombre_categoria) VALUES
('Electronica'),
('Gadgets'),
('Computadoras'),
('Ropa'),
('Moda'),
('Muebles'),
('Oficina'),
('Electrodomesticos');

CREATE TABLE proveedores (
    id_proveedor SERIAL PRIMARY KEY,
    nombre_proveedor VARCHAR(50)
);

INSERT INTO proveedores (nombre_proveedor) VALUES
('TechCorp'),
('GadgetWorld'),
('OfficeSupply'),
('FashionHub'),
('TrendyWear'),
('ComfortSeats'),
('VisionElectronics');


CREATE TABLE producto_categorias (
    id_producto INT,
    id_categoria INT,
    PRIMARY KEY (id_producto, id_categoria),
	FOREIGN KEY(id_producto) REFERENCES productos,
	FOREIGN KEY(id_categoria) REFERENCES categorias
);

INSERT INTO producto_categorias (id_producto, id_categoria) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 3),
(3, 4),
(3, 5),
(4, 6),
(4, 7),
(5, 1),
(5, 8);

CREATE TABLE producto_proveedores (
    id_producto INT,
    id_proveedor INT,
    PRIMARY KEY (id_producto, id_proveedor),
	FOREIGN KEY(id_producto) REFERENCES productos,
	FOREIGN KEY(id_proveedor) REFERENCES proveedores
);

INSERT INTO producto_proveedores (id_producto, id_proveedor) VALUES
(1, 1), 
(1, 2), 
(2, 1), 
(2, 3), 
(3, 4), 
(3, 5), 
(4, 6), 
(4, 3), 
(5, 7),
(5, 1);

SELECT productos.producto AS "PRODUCTO", categorias.nombre_categoria AS "CATEGORIAS", proveedores.nombre_proveedor AS "PROVEEDORES", productos.precio AS "PRECIO" FROM productos 
	INNER JOIN producto_categorias ON productos.id_producto = producto_categorias.id_producto
	INNER JOIN categorias ON producto_categorias.id_categoria = categorias.id_categoria
	INNER JOIN producto_proveedores ON productos.id_producto = producto_proveedores.id_producto
	INNER JOIN proveedores ON proveedores.id_proveedor = producto_proveedores.id_proveedor;














