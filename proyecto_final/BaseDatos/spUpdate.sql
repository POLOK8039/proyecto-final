-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
---------------------------------------
--Actualizar registro
---------------------------------------

--Usuario
drop Procedure UpdateUser
DELIMITER $$
Create PROCEDURE UpdateUser(
    IN p_num int,
    IN p_username VARCHAR(30),
    IN p_password VARCHAR(50),
    IN p_name VARCHAR(50),
    IN p_first_surname VARCHAR(30),
    IN p_second_surname VARCHAR(30),
    IN p_date_of_birth DATE,
    IN p_neighborhood VARCHAR(50),
    IN p_street VARCHAR(50),
    IN p_postal_code INT,
    IN p_phone VARCHAR(15),
    IN p_email VARCHAR(30),
    IN p_user_type VARCHAR(5),
    IN p_supervisor INT
)
BEGIN
    UPDATE user
    SET num=p_num,username=p_username,password = sha1(p_password), name = p_name, first_surname = p_first_surname,
    second_surname = p_second_surname, date_of_birth = p_date_of_birth,
    neighborhood = p_neighborhood, street = p_street, postal_code = p_postal_code,
    phone = p_phone, email = p_email,
    user_type= p_user_type, supervisor = p_supervisor
    WHERE num = p_num;
END$$


--Tipo de usuario
DELIMITER $$
Create PROCEDURE UpdateUserType(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(100),
    IN p_active bit
)
Begin
    UPDATE user_type
    SET name = p_name, description = p_description, active = p_active
    where code = p_code; 
END$$



--Caja
DELIMITER $$
Create PROCEDURE UpdateBox(
    IN p_num Int,
    IN p_height DECIMAL(10,2),
    IN p_width DECIMAL(10,2),
    IN p_length DECIMAL(10,2),
    IN p_weight DECIMAL(10,2)
)
BEGIN
    UPDATE box
    SET height = p_height, 
    width = p_width, 
    length = p_length, 
    weight = p_weight
    WHERE num = p_num;
END$$



--Material

drop Procedure UpdateMaterial

DELIMITER $$

DELIMITER $$

CREATE PROCEDURE UpdateMaterial(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(100),
    IN p_available_quantity INT,
    IN p_active BIT,
    IN p_unit_of_measure VARCHAR(5)
)
BEGIN
    DECLARE success INT DEFAULT 0;
    DECLARE message VARCHAR(255) DEFAULT '';

    UPDATE material
    SET 
        name = p_name, 
        description = p_description, 
        available_quantity = p_available_quantity,
        active = p_active,
        unit_of_measure = p_unit_of_measure
    WHERE code = p_code;

    IF ROW_COUNT() > 0 THEN
        SET success = 1;
        SET message = 'Material successfully updated.';
    ELSE
        SET success = 0;
        SET message = 'Code repeated in material.';
    END IF;

    SELECT success AS success, message AS message;
END $$



--Producto 
DROP PROCEDURE `UpdateProduct`;
Delimiter $$
Create PROCEDURE UpdateProduct(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(100),
    IN p_height DECIMAL(10,2),
    IN p_width DECIMAL(10,2),
    IN p_length DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    In p_packaging_protocol INT
)
Begin
    UPDATE product
    SET name = p_name, description = p_description, height = p_height, width = p_width,
    length = p_length, weight = p_weight, packaging_protocol = p_packaging_protocol
    WHERE code = p_code;
END$$



--Salida 

drop Procedure `UpdateOutBound`;

DELIMITER $$
Create PROCEDURE UpdateOutBound(
    IN p_num INT,
    IN p_date DATE,
    In p_exit_quantity int,
    In p_active bit
)
Begin
    UPDATE outbound
    SET date = p_date, exit_quantity = p_exit_quantity, active = p_active
    WHERE num = p_num;
end $$




--Zona

DROP PROCEDURE `UpdateZone`;
DELIMITER $$


CREATE PROCEDURE UpdateZone(
    IN p_code VARCHAR(5),
    IN p_area VARCHAR(50),
    IN p_available_capacity INT,
    IN p_total_capacity INT
)
Begin
UPDATE zone
    SET area = p_area, available_capacity = p_available_capacity, total_capacity = p_total_capacity
    WHERE code = p_code;
end $$



DROP PROCEDURE UpdateProtocol;
--Protocolo
DELIMITER $$
Create PROCEDURE UpdateProtocol(
    IN p_num INT,
    In p_name varchar(50),
    In p_file_name varchar(255)
)
Begin
    UPDATE packaging_protocol
    SET name = p_name, file_name = p_file_name
    WHERE num = p_num;
end $$


--Paquete

drop procedure UpdatePackage;
DELIMITER $$
Create PROCEDURE UpdatePackage(
    IN p_num INT,
    IN p_product_quantity int,
    IN p_weight decimal (10,2),
    IN p_product varchar(5),
    In p_packaging INT,
    IN p_box int,
    IN p_tag int
)
begin
    UPDATE package
    SET product_quantity = p_product_quantity, weight = p_weight, product = p_product, 
    packaging= p_packaging, box = p_box, tag = p_tag
    WHERE num = p_num;
end $$


drop procedure UpdatePackaging;
--Embalaje 
DELIMITER $$
Create PROCEDURE UpdatePackaging(
    IN p_code INT,
    IN p_height DECIMAL(10, 2),
    IN p_width DECIMAL(10, 2),
    IN p_length DECIMAL(10, 2),
    IN p_weight DECIMAL(10, 2),
    IN p_package_quantity INT,
    IN p_zone VARCHAR(5),
    IN p_tag int
)
begin
    UPDATE packaging
    SET height = p_height, width = p_width, length = p_length,weight = p_weight,
    package_quantity = p_package_quantity,  zone = p_zone, tag = p_tag
    WHERE code = p_code;
end $$



--Etiqueta
DELIMITER $$
Create PROCEDURE UpdateTag(
    IN p_num INT,
    IN p_date DATE,
    IN p_tag_type varchar(5),
    IN p_destination VARCHAR(25)
)
begin
    UPDATE tag
    SET date = p_date, tag_type = p_tag_type, destination = p_destination
    WHERE num= p_num;
end $$



--Tipo de etiqueta
DELIMITER $$
Create PROCEDURE UpdateTagType(
    IN p_code VARCHAR(5),
    IN p_description VARCHAR(255)
)
begin
    UPDATE tag_type
    SET description = p_description
    WHERE code = p_code;
end $$



--Report

DELIMITER $$
Create PROCEDURE updateReport(
    IN p_folio VARCHAR(5),
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_report_date DATE,
    IN p_packed_products INT,
    IN p_observations TEXT,
    IN p_traceability INT
)
Begin 
    update report
    set start_date = p_start_date, end_date = p_end_date, 
    report_date = p_report_date, packed_products = p_packed_products,
    observations =p_observations, traceability = p_traceability
    WHERE folio = p_folio;
end $$


--Incidente
DELIMITER $$
Create PROCEDURE UpdateIncident(
    IN p_num int,
    IN p_date DATE,
    IN p_description VARCHAR(255),
    IN p_traceability INT
)
begin
    UPDATE incident
    SET date = p_date, description = p_description,traceability = p_traceability
    WHERE num = p_num;
end $$


--unidad de medida
Delimiter $$
Create procedure updateUnit_of_measure(
    IN p_code varchar(5),
    IN p_description varchar(50)
)
BEGIN
    UPDATE unit_of_measure
    SET description = p_description
    WHERE code = p_code;
END$$

--trazabilidad

--tablas muchos a muchos


CREATE PROCEDURE updateUserTraceability(
    IN p_old_user INT,
    IN p_old_traceability INT,
    IN p_new_user INT,
    IN p_new_traceability INT
)
BEGIN
    UPDATE user_traceability
    SET user = p_new_user, traceability = p_new_traceability
    WHERE user = p_old_user AND traceability = p_old_traceability;

    SELECT user, traceability
    FROM user_traceability
    WHERE user = p_new_user AND traceability = p_new_traceability;
END$$


CREATE PROCEDURE updateMaterialPackging(
    IN p_packaging INT,
    IN p_material VARCHAR(5),
    IN p_quantity INT
)
BEGIN
    UPDATE material_packging
    SET quantity = p_quantity
    WHERE packaging = p_packaging AND material = p_material;

    SELECT packaging, material, quantity
    FROM material_packging
    WHERE packaging = p_packaging AND material = p_material;
END$$


CREATE PROCEDURE updateMaterialPackage(
    IN p_material VARCHAR(5),
    IN p_package INT,
    IN p_quantity INT
)
BEGIN
    UPDATE material_package
    SET quantity = p_quantity
    WHERE material = p_material AND package = p_package;

    SELECT material, package, quantity
    FROM material_package
    WHERE material = p_material AND package = p_package;
END$$

