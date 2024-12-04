-- SQLBook: Code
-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
-- SQLBook: Code
---------------------------------------
--Insertar registro
---------------------------------------
drop Procedure addUser
DELIMITER $$

--Este procedimiento dice que invalid colum username pero eso se debia a que la vista vw_user_personal_info
--no tiene la columna username entonces la agregue
CREATE PROCEDURE addUser(
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

    DECLARE type_exists INT;
    SET type_exists = (SELECT COUNT(*) FROM user_type WHERE code = p_user_type);


    IF type_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid user_type code';
    END IF;


    INSERT INTO user (
        username, password, name, first_surname, second_surname,
        date_of_birth, neighborhood, street, postal_code, phone,
        email, user_type, supervisor
    ) VALUES (
        p_username, SHA1(p_password), p_name, p_first_surname, p_second_surname,
        p_date_of_birth, p_neighborhood, p_street, p_postal_code, p_phone,
        p_email, p_user_type, p_supervisor
    );

END $$



--Usertype
drop Procedure insertUserType

DELIMITER $$
Create PROCEDURE addUserType(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(100)
)
Begin
    INSERT into user_type (code,name,description)
    VALUES (p_code,p_name,p_description);

    Select code,name,description
    from tag_type
    where code = p_code;
END$$

--box
DELIMITER $$
CREATE PROCEDURE addBox(
    IN p_height DECIMAL(10,2),
    IN p_width DECIMAL(10,2),
    IN p_length DECIMAL(10,2),
    IN p_weight DECIMAL(10,2)
)
BEGIN
    INSERT INTO box (height, width, length, weight)
    VALUES(p_height, p_width, p_length, p_weight);

    SELECT num, height, width, length, volume, weight
    FROM box WHERE num = LAST_INSERT_ID();
END $$

--Material
drop Procedure addMaterial

DELIMITER $$

CREATE PROCEDURE addMaterial(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_available_quantity INT,
    IN p_unit VARCHAR(5)
)
BEGIN
    DECLARE exist_unit INT;
    DECLARE exist_code INT;

    SELECT COUNT(*) INTO exist_unit
    FROM unit_of_measure 
    WHERE code = p_unit;

    IF exist_unit = 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid unit of measure code';
    END IF;


    SELECT COUNT(*) INTO exist_code
    FROM material 
    WHERE code = p_code;

    IF exist_code > 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Material code already exists';
    END IF;


    INSERT INTO material (code, name, description, available_quantity, unit_of_measure)
    VALUES (p_code, p_name, p_description, p_available_quantity, p_unit);

    SELECT code, name, description, available_quantity, unit_of_measure
    FROM material 
    WHERE code = p_code;
END $$


call addMaterial('alm','aluminium','N/A',17,'UOM01')

select * from material


--------------------
DROP PROCEDURE addProduct;
DELIMITER $$

CREATE PROCEDURE addProduct(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(100),
    IN p_height DECIMAL(10,2),
    IN p_width DECIMAL(10,2),
    IN p_length DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    IN p_packaging_protocol INT
)
BEGIN
    INSERT INTO product (code, name, description, height, width, length, weight, packaging_protocol)
    VALUES (p_code, p_name, p_description, p_height, p_width, p_length, p_weight, p_packaging_protocol);

END$$

CALL addProduct('C001', 'Product A', 'Description', 10.5, 5.2, 15.0, 1.2, 1);


----------------------------------

--outBound
drop Procedure addOutbound

DELIMITER $$

CREATE PROCEDURE addOutbound(
    IN p_date DATE,
    IN p_exit_quantity INT
)
BEGIN
    DECLARE exist_unit INT DEFAULT 1; 

    INSERT INTO outbound(date, exit_quantity)
    VALUES (p_date, p_exit_quantity);

    SELECT num, date, exit_quantity
    FROM outbound
    WHERE num = LAST_INSERT_ID();
END $$


--Zone

drop Procedure addZone;

DELIMITER $$

CREATE PROCEDURE addZone(
    IN p_code VARCHAR(5),
    IN p_area VARCHAR(50),
    IN p_available_capacity INT,
    IN p_total_capacity INT
)
BEGIN
    IF p_available_capacity < 0 OR p_total_capacity < 0 THEN
        SELECT 0 AS success, 'Capacity values must be non-negative.' AS message;
    ELSEIF EXISTS (SELECT 1 FROM zone WHERE area = p_area) THEN
        SELECT 0 AS success, 'The area name is already in use.' AS message;
    ELSE
        INSERT INTO zone (code, area, available_capacity, total_capacity)
        VALUES (p_code, p_area, p_available_capacity, p_total_capacity);
        SELECT 1 AS success, 'Zone added successfully.' AS message;
    END IF;
END$$

DELIMITER ;


DELIMITER ;


DELIMITER $$



--Protocol

CREATE PROCEDURE addIncident(
    IN p_date DATE,
    IN p_description VARCHAR(255),
    IN p_traceability INT
)
BEGIN
    DECLARE traceability_count INT DEFAULT 0;

    SELECT COUNT(*) INTO traceability_count FROM trazabilidad WHERE num = p_traceability;

    IF traceability_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid traceability ID';
    END IF;

    INSERT INTO incident (date, description, traceability)
    VALUES (p_date, p_description, p_traceability);

    SELECT num, date, description, user, traceability
    FROM incident WHERE num = LAST_INSERT_ID();

END $$




--sp para insertar embalaje sin el campo de salida

drop Procedure addPackaging;
DELIMITER $$
CREATE PROCEDURE addPackaging(
    IN p_height DECIMAL(10, 2),
    IN p_width DECIMAL(10, 2),
    IN p_length DECIMAL(10, 2),
    IN p_weight DECIMAL(10, 2),
    IN p_package_quantity INT,
    IN p_zone VARCHAR(5),
    IN p_tag int
)
BEGIN
    DECLARE num_pack INT;

    INSERT INTO packaging(height,width,length,weight,package_quantity,zone,tag)
    VALUES(p_height,p_width,p_length,p_weight,p_package_quantity,p_zone,p_tag);

    SET num_pack = LAST_INSERT_ID();

    SELECT code,volume,package_quantity,zone
    FROM PACKAGING WHERE code = p_code;
END$$
DELIMITER ;

CALL addPackaging('NEYZE',11,11,11,11,10,'Z001',7);

--sp para insertar informe   //Que se ocupario insetar aqui?
drop Procedure addReport
DELIMITER $$
CREATE Procedure addReport(
    IN p_start_date DATE,
    IN p_end_date DATE,
    IN p_report_date DATE,
    IN p_packed_products INT,
    IN p_observations TEXT,
    IN p_traceability INT
)
BEGIN
    DECLARE exist_unit INT;

    IF exist_unit = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Zone code';
    END IF;

    INSERT INTO report(start_date,end_date,report_date,packed_products,observations,traceability)
    VALUES(p_start_date,p_end_date,p_report_date,p_packed_products,p_observations,p_traceability);

    SELECT start_date,end_date,packed_products,observations,traceability
    FROM report where folio = LAST_INSERT_ID();
END $$


--sp para insertar tag
drop Procedure addTag
DELIMITER $$
CREATE Procedure addTag(
    IN p_date DATE,
    IN p_tag_type varchar(5),
    IN p_destination VARCHAR(25),
    OUT tag_num INT
)
BEGIN
    INSERT INTO tag(date,tag_type,destination)
    VALUES (p_date,p_tag_type,p_destination);

    SELECT num, barcode,date,tag_type,destination
    from tag where num = LAST_INSERT_ID();

    set tag_num = LAST_INSERT_ID();
END$$


DESCRIBE tag

SHOW TRIGGERS LIKE 'tag';

call addTag('2024-11-11','TT01','cuba')

select * from tag

drop Procedure addTagType

Create procedure addTagType(
    IN p_code varchar(5),
    IN p_description varchar(50)
)
BEGIN
    INSERT INTO tag_type(code,description)
    VALUES (p_code,p_description);

    Select code,description
    from tag_type
    where code = p_code;
END$$


--unidad de medida  
drop Procedure addUnit_of_measure

DELIMITER $$
CREATE PROCEDURE addUnit_of_measure(
    IN p_code VARCHAR(5),
    IN p_description VARCHAR(50)
)
BEGIN
    INSERT INTO unit_of_measure(code, description)
    VALUES (p_code, p_description);

    SELECT code, description
    FROM unit_of_measure
    WHERE code = p_code;
END$$



--trazabilidad

--tablas muchos a muchos

DELIMITER $$

CREATE PROCEDURE addUserTraceability(
    IN p_user INT,
    IN p_traceability INT
)
BEGIN
    INSERT INTO user_traceability(user, traceability)
    VALUES (p_user, p_traceability);

    SELECT user, traceability
    FROM user_traceability
    WHERE user = p_user AND traceability = p_traceability;
END$$



drop procedure addMaterialPackging;
DELIMITER $$

CREATE PROCEDURE addMaterialPackging(
    IN p_packaging INT,
    IN p_material VARCHAR(5),
    IN p_quantity INT
)
BEGIN
    INSERT INTO material_packging(packaging, material, quantity)
    VALUES (p_packaging, p_material, p_quantity);

    SELECT packaging, material, quantity
    FROM material_packging
    WHERE packaging = p_packaging AND material = p_material;
END$$




DELIMITER $$

CREATE PROCEDURE addMaterialPackage(
    IN p_material VARCHAR(5),
    IN p_package INT,
    IN p_quantity INT
)
BEGIN
    INSERT INTO material_package(material, package, quantity)
    VALUES (p_material, p_package, p_quantity);

    SELECT material, package, quantity
    FROM material_package
    WHERE material = p_material AND package = p_package;
END$$


select * from material_package

--sp para insertar en package

drop Procedure addPackage
DELIMITER $$

CREATE PROCEDURE addPackage(
    IN p_product_quantity INT,
    IN p_weight DECIMAL(10, 2),
    IN p_product VARCHAR(5),
    IN p_packaging INT,
    IN p_box INT,
    IN p_tag_type VARCHAR(5),
    IN p_date DATE
)
BEGIN

    call addTag(p_date, p_tag_type, NULL, @tag_num);

    INSERT INTO package(product_quantity, weight, product, packaging, box, tag)
    VALUES(p_product_quantity, p_weight, p_product, p_packaging, p_box, @tag_num);

END$$


select * from package

CALL addPackage(10, 15.5, 'X', 'PK001', 3, 1);


select * from report

CREATE PROCEDURE addPackagingProtocol(
    IN prot_name VARCHAR(100),
    IN prot_file_name VARCHAR(255)
)
BEGIN
    INSERT INTO packaging_protocol(name, file_name)
    VALUES(prot_name, prot_file_name);
END $$

