-- Active: 1723058837855@@127.0.0.1@3306@packaging
-- Deshabilitar restricciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 0;

-- Eliminar registros de las tablas dependientes primero
DELETE FROM user_traceability;
DELETE FROM material_packging;
DELETE FROM material_package;
DELETE FROM report;
DELETE FROM incident;
DELETE FROM traceability;
DELETE FROM package;
DELETE FROM state;
DELETE FROM product;
DELETE FROM packaging;
DELETE FROM tag;
DELETE FROM material;
DELETE FROM packaging_protocol;
DELETE FROM outbound;
DELETE FROM zone;
DELETE FROM box;
DELETE FROM tag_type;
DELETE FROM unit_of_measure;
DELETE FROM user;

-- Finalmente eliminar de las tablas independientes
DELETE FROM user_type;

-- Rehabilitar restricciones de claves foráneas
SET FOREIGN_KEY_CHECKS = 1;



-- Reiniciar valores AUTO_INCREMENT en las tablas
ALTER TABLE user AUTO_INCREMENT = 1;
ALTER TABLE box AUTO_INCREMENT = 1;
ALTER TABLE outbound AUTO_INCREMENT = 1;
ALTER TABLE tag AUTO_INCREMENT = 1;
ALTER TABLE packaging AUTO_INCREMENT = 1;
ALTER TABLE packaging_protocol AUTO_INCREMENT = 1;
ALTER TABLE package AUTO_INCREMENT = 1;
ALTER TABLE traceability AUTO_INCREMENT = 1;
ALTER TABLE incident AUTO_INCREMENT = 1;
ALTER TABLE report AUTO_INCREMENT = 1;

