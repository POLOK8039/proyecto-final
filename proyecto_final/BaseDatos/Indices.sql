-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
show  index from user

--En la tabla tag campo barcode
CREATE UNIQUE INDEX UQ_tag_barcode ON tag(barcode);

DROP INDEX UQ_tag_barcode on tag;


--Tabla packaging en campo tag
CREATE UNIQUE INDEX UQ_packaging_tag ON packaging(tag);

--Tabla package en campo tag
CREATE UNIQUE INDEX UQ_package_tag ON package(tag);

--Tabla package en campo tracking_code
--CREATE UNIQUE INDEX UQ_package_tracking_code ON package(tracking_code);

--Tabla product campo name
CREATE UNIQUE INDEX UQ_product_name ON product(name);

CREATE UNIQUE INDEX UQ_username ON user(username);
