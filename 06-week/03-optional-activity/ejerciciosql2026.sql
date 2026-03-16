
-- PROYECTO: CONSULTAS SQL AVANZADAS
-- SISTEMA DE VENTAS
-- Autor: Julian Andrade
-- 1. CREAR TABLAS
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    ciudad VARCHAR(50)
);
CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(50),
    precio NUMERIC(10,2)
);
CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT,
    id_producto INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);
-- 2. INSERTAR DATOS
INSERT INTO clientes (nombre, ciudad) VALUES
('Juan', 'Bogota'),
('Maria', 'Medellin'),
('Carlos', 'Cali');
INSERT INTO productos (nombre_producto, precio) VALUES
('Laptop', 2500),
('Mouse', 50),
('Teclado', 120);
INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha) VALUES
(1, 1, 1, '2024-01-10'),
(1, 2, 2, '2024-01-11'),
(2, 3, 1, '2024-01-12'),
(3, 2, 3, '2024-01-13'),
(2, 1, 1, '2024-01-14');
-- 3. CONSULTA AVANZADA
-- TOTAL GASTADO POR CLIENTE
SELECT 
    c.nombre,
    SUM(p.precio * v.cantidad) AS total_gastado
FROM ventas v
JOIN clientes c 
ON v.id_cliente = c.id_cliente
JOIN productos p 
ON v.id_producto = p.id_producto
GROUP BY c.nombre
ORDER BY total_gastado DESC;
-- 4. PRODUCTO MAS VENDIDO
SELECT 
    p.nombre_producto,
    SUM(v.cantidad) AS total_vendido
FROM ventas v
JOIN productos p 
ON v.id_producto = p.id_producto
GROUP BY p.nombre_producto
ORDER BY total_vendido DESC;
-- 5. CLIENTES QUE HAN HECHO MAS DE UNA COMPRA
-- (Uso de HAVING)
SELECT 
    c.nombre,
    COUNT(v.id_venta) AS numero_compras
FROM ventas v
JOIN clientes c 
ON v.id_cliente = c.id_cliente
GROUP BY c.nombre
HAVING COUNT(v.id_venta) > 1;
-- 6. CLIENTE QUE MAS HA GASTADO
-- (SUBCONSULTA)
SELECT nombre, total_gastado
FROM (
    SELECT 
        c.nombre,
        SUM(p.precio * v.cantidad) AS total_gastado
    FROM ventas v
    JOIN clientes c 
    ON v.id_cliente = c.id_cliente
    JOIN productos p 
    ON v.id_producto = p.id_producto
    GROUP BY c.nombre
) AS resumen
ORDER BY total_gastado DESC
LIMIT 1;
-- FIN DEL EJERCICIO
