-- Active: 1729280514950@@127.0.0.1@3306@packaging
show  index from user

--En la tabla tag campo barcode
CREATE UNIQUE INDEX UQ_tag_barcode ON tag(barcode);

--Tabla packaging en campo tag
CREATE UNIQUE INDEX UQ_packaging_tag ON packaging(tag);

--Tabla package en campo tag
CREATE UNIQUE INDEX UQ_package_tag ON package(tag);

--Tabla package en campo tracking_code
CREATE UNIQUE INDEX UQ_package_tracking_code ON package(tracking_code);

--Tabla product campo name
CREATE UNIQUE INDEX UQ_product_name ON product(name);

--Tabla traceability campo product  
CREATE UNIQUE INDEX UQ_traceability_product ON traceability(product);

--Tabla incident  cammpo date
CREATE UNIQUE INDEX UQ_incident_date ON incident(date);

--Tabla report campo report_date
CREATE UNIQUE INDEX UQ_report_report_date ON report(report_date);

