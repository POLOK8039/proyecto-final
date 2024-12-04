-- Active: 1730432982636@@127.0.0.1@3306@packaging
--Apartado para la creacion de vistas 
--FALATARIA AGREGARLE ALIAS A LOS CAMPOS QUE LO REQUIERAN
--En los que tienen _ deberia de quitarselo y agregar un espacio hblando del alias?

--Vistas de Usuario
drop view vw_user_info;

CREATE VIEW vw_user_info AS
SELECT 
    num,
    username,
    password,
    active,
    user_type,
    supervisor
FROM user AS u WHERE u.active = 1;

CREATE VIEW vw_user_personal_info AS
SELECT 
    num,
    CONCAT(name,' ',first_surname,IFNULL(CONCAT(' ',second_surname), '')) AS full_name,
    DATE_FORMAT(date_of_birth, "%M-%d-%y") AS date_of_birth,
    neighborhood,
    street,
    postal_code,
    phone,
    email,
    (SELECT name FROM user_type 
    WHERE code = u.user_type) AS user
FROM user AS u WHERE u.active = 1;

drop view vw_supervisor;
CREATE VIEW vw_supervisor AS
SELECT num,
    username,
    CONCAT(name,' ',first_surname,IFNULL(CONCAT(' ',second_surname), '')) AS full_name,
    DATE_FORMAT(date_of_birth, "%M-%d-%y") AS date_of_birth,
    neighborhood,
    street,
    postal_code,
    phone,
    email
From user
where user_type = 'super'


--VISTA DE CAJA
CREATE VIEW vw_box_info AS
SELECT 
    num,
    height,
    width,
    length,
    volume,
    weight
FROM box;

--VISTA ZONA
CREATE VIEW vw_zone_info AS
SELECT 
    code,
    area,
    available_capacity,
    total_capacity
FROM zone;

--VISTA DE SALIDA
CREATE VIEW vw_outbound_info AS
SELECT 
    num,
    date,
    exit_quantity
FROM outbound;

--VISTA ETIQUETA
CREATE VIEW vw_tag_info AS
SELECT 
    num,
    date,
    barcode,
    tag_type,
    destination
FROM tag;


--VISTA EMBALAJE

CREATE VIEW vw_packaging_info AS
SELECT 
    code,
    height,
    width,
    length,
    package_quantity,
    zone,
    outbound,
    tag
FROM packaging;

--VISTA MATERIAL
CREATE VIEW vw_material_info AS
SELECT 
    code,
    material_name,
    description,
    available_quantity,
    unit_of_measure
FROM material;

--VISTA PAQUETE
CREATE VIEW vw_package_info AS
SELECT 
    num,
    product_quantity,
    weight,
    packaging,
    box,
    tag
FROM package;

--VISTA PROTOCOLO EMBALAJE
CREATE VIEW vw_packaging_protocol_info AS
SELECT 
    num,
    name,
    file_name
FROM packaging_protocol;


--VISTA DE PRODUCTO
CREATE VIEW vw_product_info AS
SELECT 
    num,
    name,
    description,
    height,
    width,
    length,
    weight,
    package,
    packaging_protocol
FROM product;

--VISTA DE TRAZABILIDAD
CREATE VIEW vw_traceability_info AS
SELECT 
    num,
    product,
    box,
    package,
    packaging,
    state
FROM traceability;

--VISTA DE INCIDENCIA
CREATE VIEW vw_incident_info AS
SELECT 
    num,
    date,
    description,
    user,
    traceability
FROM incident;


