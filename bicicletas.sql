CREATE DATABASE bicicletas_compartidas;
USE bicicletas_compartidas;

CREATE TABLE estacion (
    codigo_estacion VARCHAR(10) PRIMARY KEY,
    direccion       VARCHAR(150) NOT NULL,
    capacidad_max   INT CHECK (capacidad_max > 0)
);

CREATE TABLE operario (
    legajo INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE bicicleta (
    numero_serie    VARCHAR(20) PRIMARY KEY,
    estado          VARCHAR(20) NOT NULL DEFAULT 'DISPONIBLE',
    codigo_estacion VARCHAR(10) NOT NULL,
    CONSTRAINT fk_bici_estacion FOREIGN KEY (codigo_estacion)
        REFERENCES estacion (codigo_estacion) ON DELETE RESTRICT
);

CREATE TABLE usuario (
    dni    VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE usuario_medio_pago (
    dni            VARCHAR(10),
    numero_tarjeta VARCHAR(20),
    PRIMARY KEY (dni, numero_tarjeta),
    CONSTRAINT fk_medio_usuario FOREIGN KEY (dni)
        REFERENCES usuario (dni) ON DELETE CASCADE
);

CREATE TABLE viaje (
    id_viaje            INT PRIMARY KEY,
    fecha_inicio        DATETIME NOT NULL,
    fecha_fin           DATETIME,
    dni_usuario         VARCHAR(10) NOT NULL,
    numero_serie_bici   VARCHAR(20) NOT NULL,
    codigo_est_origen   VARCHAR(10) NOT NULL,
    codigo_est_destino  VARCHAR(10) NOT NULL,
    CONSTRAINT fk_viaje_usuario  FOREIGN KEY (dni_usuario) REFERENCES usuario (dni) ON DELETE RESTRICT,
    CONSTRAINT fk_viaje_bici     FOREIGN KEY (numero_serie_bici) REFERENCES bicicleta (numero_serie) ON DELETE RESTRICT,
    CONSTRAINT fk_viaje_origen   FOREIGN KEY (codigo_est_origen) REFERENCES estacion (codigo_estacion) ON DELETE RESTRICT,
    CONSTRAINT fk_viaje_destino  FOREIGN KEY (codigo_est_destino) REFERENCES estacion (codigo_estacion) ON DELETE RESTRICT
);

CREATE TABLE tarea_mantenimiento (
    codigo_estacion  VARCHAR(10),
    numero_tarea     INT,
    fecha            DATE NOT NULL,
    descripcion      VARCHAR(200),
    legajo_operario  INT NOT NULL,
    PRIMARY KEY (codigo_estacion, numero_tarea),
    CONSTRAINT fk_tarea_estacion FOREIGN KEY (codigo_estacion)
        REFERENCES estacion (codigo_estacion) ON DELETE CASCADE,
    CONSTRAINT fk_tarea_operario FOREIGN KEY (legajo_operario)
        REFERENCES operario (legajo) ON DELETE RESTRICT
);
