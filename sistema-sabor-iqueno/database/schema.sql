-- =====================================================================
-- SISTEMA DE GESTIÓN GASTRONÓMICA: "EL SABOR IQUEÑO"
-- Script Completo de Base de Datos PostgreSQL (Capítulo 3)
-- =====================================================================

DROP TABLE IF EXISTS detalle_pedidos CASCADE;
DROP TABLE IF EXISTS pedidos CASCADE;
DROP TABLE IF EXISTS productos CASCADE;
DROP TABLE IF EXISTS mesas CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;
DROP TABLE IF EXISTS bitacora_auditoria CASCADE;

-- 1. Tabla de Usuarios y Roles (RBAC)
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL CHECK (rol IN ('ADMIN', 'MESERO', 'COCINA', 'CAJERO')),
    estado BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Tabla de Mesas del Salón
CREATE TABLE mesas (
    id SERIAL PRIMARY KEY,
    numero_mesa INT UNIQUE NOT NULL,
    capacidad INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'LIBRE' CHECK (estado IN ('LIBRE', 'OCUPADA', 'RESERVADA', 'MANTENIMIENTO'))
);

-- 3. Tabla de Productos, Platos Típicos y Stock
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL,
    stock_minimo INT DEFAULT 5,
    disponible BOOLEAN DEFAULT TRUE
);

-- 4. Tabla de Pedidos / Comandas
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    mesa_id INT REFERENCES mesas(id) ON DELETE SET NULL,
    mesero_id INT REFERENCES usuarios(id) ON DELETE SET NULL,
    tipo_pedido VARCHAR(30) DEFAULT 'LOCAL' CHECK (tipo_pedido IN ('LOCAL', 'PARA_LLEVAR')),
    nombre_cliente VARCHAR(100),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'PENDIENTE' CHECK (estado IN ('PENDIENTE', 'EN_PREPARACION', 'LISTO', 'PAGADO', 'ANULADO')),
    subtotal DECIMAL(10, 2) DEFAULT 0.00,
    igv DECIMAL(10, 2) DEFAULT 0.00,
    total DECIMAL(10, 2) DEFAULT 0.00
);

-- 5. Tabla de Detalle de Pedidos
CREATE TABLE detalle_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id) ON DELETE CASCADE,
    producto_id INT REFERENCES productos(id) ON DELETE RESTRICT,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    notas VARCHAR(150)
);

-- 6. Tabla de Auditoría del Sistema
CREATE TABLE bitacora_auditoria (
    id SERIAL PRIMARY KEY,
    usuario VARCHAR(50),
    accion VARCHAR(100),
    detalles TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserción de Datos Iniciales (Mock Data Operativo)
INSERT INTO usuarios (username, password, rol) VALUES
('admin', 'admin123', 'ADMIN'),
('mesero1', '1234', 'MESERO'),
('chef1', '1234', 'COCINA'),
('cajero1', '1234', 'CAJERO');

INSERT INTO mesas (numero_mesa, capacidad, estado) VALUES
(1, 4, 'LIBRE'), (2, 4, 'LIBRE'), (3, 6, 'LIBRE'),
(4, 2, 'LIBRE'), (5, 4, 'LIBRE'), (6, 8, 'LIBRE'),
(7, 4, 'LIBRE'), (8, 2, 'LIBRE'), (9, 4, 'LIBRE');

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Carapulcra con Sopa Seca', 'Platos Típicos', 28.00, 50),
('Seco de Ica con Frijoles', 'Platos Típicos', 32.00, 40),
('Ceviche Mixto Iqueño', 'Marina', 35.00, 30),
('Tacu Tacu con Lomo Saltado', 'Platos Típicos', 38.00, 25),
('Pisco Sour Catedral', 'Bebidas', 22.00, 100),
('Chicha Morada Jarra', 'Bebidas', 15.00, 60);