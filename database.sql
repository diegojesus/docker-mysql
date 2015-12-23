CREATE DATABASE IF NOT EXISTS dockerdb DEFAULT CHARSET=utf8;

USE dockerdb;

--
-- Estructura de la tabla 'usuarios'
--

DROP TABLE IF EXISTS usuarios;
CREATE TABLE usuarios (
  id int(10) NOT NULL AUTO_INCREMENT,
  nombre varchar(30) NOT NULL,
  puesto varchar(100) DEFAULT NULL,
  area varchar(50) NOT NULL,
  PRIMARY KEY (id)
);


LOCK TABLES usuarios WRITE;
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Diego Jesús Hernández','Arquitecto de Aplicaciones y Negocios', 'Arquitectura - Unidad Central');
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Ariel Presa','Jefe de Aplicaciones y Negocios', 'Arquitectura - Unidad Central');
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Mauro Novillo','Jefe de Arquitecto', 'Arquitectura - Unidad Central');
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Guillermo Rodriguez','Arquitecto de BBDD y Servicios', 'Arquitectura - Unidad Central');
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Gustavo Arenas','Arquitecto de BBDD y Servicios', 'Arquitectura - Unidad Central');
INSERT INTO usuarios (nombre, puesto, area) VALUES ('Hugo Ruiz','Arquitecto Funcional de Aplicaciones y Negocios', 'Arquitectura - Unidad Central');
UNLOCK TABLES;
