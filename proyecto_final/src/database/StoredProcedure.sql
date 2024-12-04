-- Active: 1730432982636@@127.0.0.1@3306@packaging
-----------------------------------
        --STORED PROCEDURE
-----------------------------------

drop Procedure check_zone_capacity

--corregir 
CREATE PROCEDURE sp_check_zone_capacity (
    IN zone_code VARCHAR(5), 
    IN package_quantity INT, 
    OUT result BIT
)
BEGIN
    DECLARE capacity INT;
    
    SELECT available_capacity INTO capacity 
    FROM zone
    WHERE code = zone_code;
    
    IF capacity >= package_quantity THEN
        SET result = TRUE;
    ELSE
        SET result = FALSE;
    END IF;
END;

select * from zone

CALL check_zone_capacity('Z001',55,@Resultado);

select @Resultado as respuesta

--Pudieramos cambiar el nombre a search_report
CREATE PROCEDURE sp_generate_report(
    IN start_date DATE,
    IN end_date DATE
)
BEGIN
    SELECT * FROM report 
    WHERE start_date = start_date
    AND end_date = end_date ;
END;


call sp_generate_report ('2024-09-01','2024-09-30');


--Pudieramos hacer un sp o  triggers que al hacer un moviento en el proceso del embalaje actualice la tabla estado de la trazabilidad
--Creo que seria mejor un trigger por que nos evitamos tener que mandarlo a llamar
--

drop PROCEDURE addUser

--usuario general
DELIMITER $$
CREATE PROCEDURE addUser(
    IN p_username VARCHAR(30),
    IN p_password VARCHAR(20),
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
        p_username, p_password, p_name, p_first_surname, p_second_surname,
        p_date_of_birth, p_neighborhood, p_street, p_postal_code, p_phone,
        p_email, p_user_type, p_supervisor
    );

    SELECT num, username,
    CONCAT(name,' ',first_surname,IFNULL(CONCAT(' ',second_surname), '')) AS full_name,user_type
    FROM user
    WHERE username = p_username;
END $$

CALL addUser('administ', 'adminpass', 'John', 'Doe', 'Smith', '1980-05-14', 'Downtown', 'Main St', 12345, '555-1234', 'admin02@example.com', 'ADMIN', NULL)

DELIMITER $$
CREATE PROCEDURE validateUser(IN usern VARCHAR(30), IN passw VARCHAR(50))
BEGIN
    DECLARE user_exists INT;
    SET user_exists = (
        SELECT COUNT(*) FROM user 
        WHERE username = usern 
        AND password = passw
        AND active = 1
    );
    
    IF user_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid username or password';
    END IF;

    SELECT num, username, user_type 
    FROM vw_user_info
    WHERE username = usern;
END $$

CALL validateUser('administ', 'adminpass')

drop Procedure addIncident

DELIMITER $$

--Le agregue el user por que no lo tenia entonces si se usaba esto ninguna incidencia dentria usuario
--Ocupo saber si ocupan el id o el nombre

CREATE PROCEDURE addIncident(
    IN p_date DATE,
    IN p_description VARCHAR(255),
    IN p_user VARCHAR(30),
    IN p_traceability INT
)
BEGIN
    DECLARE traceability_count INT DEFAULT 0;

    SELECT COUNT(*) INTO traceability_count FROM traceability WHERE num = p_traceability;

    IF traceability_count = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid traceability ID';
    END IF;

    INSERT INTO incident (date, description, user,traceability)
    VALUES (p_date, p_description,p_user ,p_traceability);

    SELECT num, date, description, user, traceability
    FROM incident WHERE num = LAST_INSERT_ID();
END $$

call addIncident('2023-11-11','N/A',1,3)

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

call addBox(5,5,5,5)

drop procedure addMaterial;
DELIMITER $$
CREATE PROCEDURE addMaterial(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_quantity INT,
    IN p_unit VARCHAR(5)
)
BEGIN
    DECLARE exist_unit INT;

    SELECT COUNT(*) INTO exist_unit
    FROM unit_of_measure WHERE code = p_unit;

    IF exist_unit = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid unit of measure code';
    END IF;

    INSERT INTO material (code, material_name, description, available_quantity, unit_of_measure)
    VALUES(p_code, p_name, p_description, p_quantity, p_unit);

    SELECT code, material_name, description, available_quantity, unit_of_measure
    FROM material WHERE code = p_code;
END $$

call addMaterial ('tl','Tela','Tela para celulares','500','mt')

drop Procedure addProduct

Delimiter $$
CREATE PROCEDURE addProduct(
    IN p_code VARCHAR(5),
    IN p_name VARCHAR(50),
    IN p_description VARCHAR(255),
    IN p_height DECIMAL(10,2),
    IN p_width DECIMAL(10,2),
    IN p_length DECIMAL(10,2),
    IN p_weight DECIMAL(10,2),
    IN p_packaging_protocol INT
)
BEGIN
    DECLARE exist_unit INT;

    IF exist_unit = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid product code';
    END IF;

    INSERT INTO product
    VALUES(p_code,p_name,p_description,p_height,
    p_width,p_length,p_weight,p_packaging_protocol);

    SELECT code,name,description,packaging_protocol
    From product WHERE code = p_code;
END $$

call addProduct('S20', 'Samsung S20', 'Medium-quality product', 14.99, 7.04, 0.78, 157, 1)


drop Procedure addPackagingProtocol
DELIMITER $$
Create Procedure addPackagingProtocol(
    IN p_name varchar(50),
    IN p_file_name varchar (30)
)
BEGIN
    DECLARE exist_unit INT;

    IF exist_unit = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid protocol code';
    END IF;

    INSERT INTO packaging_protocol(name,file_name)
    VALUES(p_name,p_file_name);

    SELECT num,name,file_name
    From packaging_protocol WHERE num = LAST_INSERT_ID();
END $$
END $$

call addPackagingProtocol('Hola','HOLAGUAPO.PDF')







