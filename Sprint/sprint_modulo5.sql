USE sprintmodulo5;

CREATE TABLE proveedores (
    id_proveedor INT NOT NULL,
    nombre_representante VARCHAR(50),
    nombre_corporativo VARCHAR(50),
    telefono1 VARCHAR(30),
    telefono2 VARCHAR(30),
    nombre_recepcionista VARCHAR(50),
    categoria VARCHAR(30),
    correo_proveedor VARCHAR(30),
    PRIMARY KEY (id_proveedor)
);
CREATE TABLE clientes (
    id_cliente INT NOT NULL,
    nombre_cliente VARCHAR(50),
    apellido_cliente VARCHAR(50),
    direccion VARCHAR(50),
    PRIMARY KEY (id_cliente)
);
CREATE TABLE productos (
    id_producto INT NOT NULL,
    nombre_producto VARCHAR(50),
    stock_producto INT,
    precio_producto INT,
    categoria VARCHAR(30),
    proveedor VARCHAR(50),
    color VARCHAR(30),
    PRIMARY KEY (id_producto)
);

INSERT INTO proveedores (id_proveedor, nombre_representante, nombre_corporativo, telefono1, telefono2, nombre_recepcionista, categoria, correo_proveedor)
VALUES
('1', 'Pedro Picapiedra', 'Telecom s.a', '997852524', '745273636', 'Daniela', 'Tecnologia', 'contacto@telecom.com'),
('2', 'Pablo Marmol', 'ChileSys s.a', '997854125', '7456338965', 'Lorena', 'Comunicaciones', 'contacto@chilesys.com'),
('3', 'Juan Castro', 'Hardwow s.a', '997851144', '7453633636', 'Jenny', 'Software', 'contacto@hardwow.com'),
('4', 'Diego Saraceda', 'FibraChile s.a', '997855544', '7457783636', 'Marcela', 'Fibra Optica', 'contacto@fibrachile.com'),
('5', 'Fernando Lopez', 'Electrogram s.a', '997858865', '7457788821', 'Andrea', 'Electronica', 'contacto@electrogram');

INSERT INTO clientes ( id_cliente, nombre_cliente, apellido_cliente, direccion)
VALUES
('1', 'Pamela', 'Zamora', 'Avda. Independencia 143'),
('2', 'Patricia', 'Nuñez', 'Avda. Oriente 55'),
('3', 'Victoria', 'Alamos', 'Calle Las Industrias 8947'),
('4', 'Mercedes', 'Prieto', 'Avda. Noruega 663'),
('5', 'Jessica', 'Flores', 'Las Perdices 414');

INSERT INTO productos ( id_producto, nombre_producto, stock_producto, precio_producto, categoria, proveedor, color)
VALUES
('1', 'celular', 40, 60000, 'tecnologia', 'prove1', 'azul'),
('2', 'switch', 30, 25000, 'comunicaciones', 'prove2', 'blanco'),
('3', 'windows', 80, 54000, 'software', 'prove3', 'verde-azul'),
('4', 'cable Rj45', 8000, 2000, 'fibra optica', 'prove4', 'rojo'),
('5', 'tarjeta memoria', 120, 23000, 'electronica', 'prove5', 'amarillo'),
('6', 'audifono', 140, 5000, 'tecnologia', 'prove1', 'azul'),
('7', 'router', 36, 27000, 'comunicaciones', 'prove2', 'crema'),
('8', 'sql server', 20, 44000, 'software', 'prove3', 'azul degrade'),
('9', 'cable rt-12', 200, 650, 'electronica', 'prove4', 'marron'),
('10', 'tarjeta red', 220, 18000, 'electronica', 'prove5', 'azul');

select * from proveedores;
select * from clientes;
select * from productos;
-- ****************************************************************************************************************************
-- Cual es la categoria de productos que mas se repite
SELECT categoria, COUNT( categoria ) AS total
FROM  productos
GROUP BY categoria
ORDER BY total DESC; 
-- ****************************************************************************************************************************
-- Cuáles son los productos con mayor stock
SELECT id_producto, nombre_producto
FROM productos
WHERE stock_producto = ( 
SELECT MAX( stock_producto )  FROM productos);
-- ****************************************************************************************************************************
-- Qué color de producto es más común en nuestra tienda.
SELECT id_producto, nombre_producto, color, COUNT( color ) AS total
FROM  productos
GROUP BY color
ORDER BY total DESC; 
-- ****************************************************************************************************************************
-- - Cual o cuales son los proveedores con menor stock de productos.
SELECT proveedor, nombre_producto, stock_producto
FROM productos
WHERE stock_producto = ( 
SELECT MIN( stock_producto )  FROM productos);

-- - Cambien la categoría de productos más popular por ‘Electrónica y computación’.
SELECT nombre_producto, categoria, COUNT(categoria) AS MasPopular
FROM productos
GROUP BY categoria
ORDER BY COUNT(categoria) DESC
LIMIT 0 , 3;
UPDATE productos SET categoria = 'Electronica y Computacion' WHERE categoria = 'electronica';


