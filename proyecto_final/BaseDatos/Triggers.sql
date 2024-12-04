-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
-- Active: 1728665066730@@127.0.0.1@3306@packaging

-----------------------------------
            --TRIGGERS
-----------------------------------
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT, ACTION_TIMING 
FROM information_schema.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'packaging';

DROP TRIGGER after_insert_tag

--Calcular el volumen de la caja en un insert
DELIMITER $$
CREATE TRIGGER calculate_box_volume_insert
BEFORE INSERT ON box
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$
DELIMITER;

--Calcular el volumen de la caja en un update
DELIMITER $$
CREATE TRIGGER calculate_box_volume_update
BEFORE UPDATE ON box
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$
DELIMITER;


--Tigger para sacar el volumen del embalaje en insert y update

DELIMITER $$
CREATE TRIGGER calculate_packaging_volume_insert
BEFORE INSERT ON packaging
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$
DELIMITER;


DELIMITER $$
CREATE TRIGGER calculate_packaging_volume_update
BEFORE UPDATE ON packaging
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$


/* --Trigger para sacer el volumen de un producto en insert y update
DELIMITER $$
CREATE TRIGGER calculate_product_volume_insert
BEFORE INSERT ON product
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$


DELIMITER $$
CREATE TRIGGER calculate_product_volume_insert
BEFORE INSERT ON product
FOR EACH ROW
Begin
    SET NEW.volume = NEW.height*NEW.width*NEW.length;
END $$ */


--TRIGER DE MATERIAL

DELIMITER $$
CREATE TRIGGER material_packging_insert
AFTER INSERT ON material_packging
FOR EACH ROW
BEGIN
    UPDATE material
    SET available_quantity = available_quantity - NEW.quantity
    WHERE code = NEW.material;
END $$


DELIMITER $$

CREATE TRIGGER material_package_insert
AFTER INSERT ON material_package
FOR EACH ROW
BEGIN
    UPDATE material
    SET available_quantity = available_quantity - NEW.quantity
    WHERE code = NEW.material;
END $$

---Etiqueta

drop Trigger before_insert_tag;

CREATE TRIGGER before_insert_tag
BEFORE INSERT ON tag
FOR EACH ROW
BEGIN
    DECLARE checksum INT DEFAULT 0;
    DECLARE gs1_code VARCHAR(255);
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE digito INT;
    DECLARE suma_impar INT DEFAULT 0;
    DECLARE suma_par INT DEFAULT 0;

    -- Generar el código GS1-128 básico (sin checksum)
    SET gs1_code = CONCAT(
        '(17)', DATE_FORMAT(NEW.date, '%y%m%d'),
        '(410)', IFNULL(NEW.destination,''),
        '(420)', NEW.tag_type
    );
    
    -- Longitud del código generado
    SET len = CHAR_LENGTH(gs1_code);

    -- Calcular el checksum recorriendo cada carácter
    WHILE i <= len DO
        -- Verificar si el carácter es un dígito antes de convertirlo
        IF SUBSTRING(gs1_code, i, 1) REGEXP '^[0-9]$' THEN
            SET digito = CAST(SUBSTRING(gs1_code, i, 1) AS UNSIGNED);

            IF i % 2 = 1 THEN
                -- Sumar posición impar y multiplicar por 3
                SET suma_impar = suma_impar + digito;
            ELSE
                -- Sumar posición par
                SET suma_par = suma_par + digito;
            END IF;
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Sumar los resultados y calcular el checksum
    SET checksum = (10 - ((suma_impar * 3 + suma_par) % 10)) % 10;

    -- Concatenar el checksum al final del código GS1-128
    SET NEW.barcode = CONCAT(gs1_code, checksum);
END;

drop trigger before_update_tag;
CREATE TRIGGER before_update_tag
BEFORE UPDATE ON tag
FOR EACH ROW
BEGIN
    DECLARE checksum INT DEFAULT 0;
    DECLARE gs1_code VARCHAR(255);
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE digito INT;
    DECLARE suma_impar INT DEFAULT 0;
    DECLARE suma_par INT DEFAULT 0;

    -- Generar el código GS1-128 básico (sin checksum)
    SET gs1_code = CONCAT(
        '(17)', DATE_FORMAT(NEW.date, '%y%m%d'),
        '(410)', IFNULL(NEW.destination,''),
        '(420)', NEW.tag_type
    );
    
    -- Longitud del código generado
    SET len = CHAR_LENGTH(gs1_code);

    -- Calcular el checksum recorriendo cada carácter
    WHILE i <= len DO
        -- Verificar si el carácter es un dígito antes de convertirlo
        IF SUBSTRING(gs1_code, i, 1) REGEXP '^[0-9]$' THEN
            SET digito = CAST(SUBSTRING(gs1_code, i, 1) AS UNSIGNED);

            IF i % 2 = 1 THEN
                -- Sumar posición impar y multiplicar por 3
                SET suma_impar = suma_impar + digito;
            ELSE
                -- Sumar posición par
                SET suma_par = suma_par + digito;
            END IF;
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Sumar los resultados y calcular el checksum
    SET checksum = (10 - ((suma_impar * 3 + suma_par) % 10)) % 10;

    -- Concatenar el checksum al final del código GS1-128
    SET NEW.barcode = CONCAT(gs1_code, checksum);
END;

--Trigger para que se actulize automaticamente la available_capacity en zona  despues de insert en packaging


drop Trigger update_zone_capacity_after_insert

/* DELIMITER $$

CREATE TRIGGER update_zone_capacity_after_insert
AFTER INSERT ON packaging
FOR EACH ROW
BEGIN
    UPDATE zone
    SET available_capacity = available_capacity - NEW.package_quantity
    WHERE code = NEW.zone;
END$$ */

drop trigger update_zone_capacity_after_insert;
DELIMITER $$

CREATE TRIGGER update_zone_capacity_after_insert
AFTER INSERT ON packaging
FOR EACH ROW
BEGIN
    DECLARE new_available_capacity INT;

    SELECT available_capacity - NEW.package_quantity INTO new_available_capacity
    FROM zone
    WHERE code = NEW.zone;


    IF new_available_capacity >= 0 OR NEW.package_quantity IS NULL THEN
        UPDATE zone
        SET available_capacity = new_available_capacity
        WHERE code = NEW.zone;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'There is not enough capacity available in the area';
    END IF;
END$$

SELECT available_capacity - 2
    FROM zone
    WHERE code = "";
------------------------------------------------------

drop Procedure Sp_RecordPackagingExit

DELIMITER $$
-- CREATE PROCEDURE Sp_RecordPackagingExit (
--     IN p_packaging_code VARCHAR(5), 
--     IN p_exit_quantity INT          
-- )
-- BEGIN
--     DECLARE available_quantity INT;

--     SELECT package_quantity INTO available_quantity
--     FROM packaging
--     WHERE code = p_packaging_code;


--     IF available_quantity IS NULL THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Packaging not found.';
--     ELSEIF available_quantity < p_exit_quantity THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient quantity in inventory.';
--     ELSE
--         UPDATE packaging
--         SET package_quantity = package_quantity - p_exit_quantity
--         WHERE code = p_packaging_code;

--         INSERT INTO outbound (date, exit_quantity)
--         VALUES (CURRENT_DATE, p_exit_quantity);
--     END IF;
-- END $$
DELIMITER ;

-- Al llamarlo dice packaging not found pero funciona 
CALL Sp_RecordPackagingExit('PKG01', 50);


SELECT * FROM packaging;


SELECT * FROM outbound;


----------------------------------------------------------

drop trigger tUpdatePackagingOutbound;
DELIMITER $$
-- CREATE TRIGGER tUpdatePackagingOutbound
-- AFTER INSERT ON outbound
-- FOR EACH ROW
-- BEGIN
--     DECLARE available_quantity INT;


--     SELECT package_quantity INTO available_quantity
--     FROM packaging
--     WHERE outbound = NEW.num;


--     IF available_quantity IS NULL THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Packaging not found.';
--     ELSEIF available_quantity < NEW.exit_quantity THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Insufficient quantity in inventory.';
--     ELSE
--         UPDATE packaging
--         SET package_quantity = package_quantity - NEW.exit_quantity
--         WHERE outbound = NEW.num;
--     END IF;
-- END $$



--------------------------------------------------------------

--Trigger peso paquete el problema es que no puedes actualizar el peso del paquete
-- por que el peso depende directamente del peso del producto

drop Trigger before_insert_package

DELIMITER $$

CREATE TRIGGER before_insert_package
BEFORE INSERT ON package
FOR EACH ROW
BEGIN
    DECLARE product_weight DECIMAL(10, 2);
    
    SELECT weight INTO product_weight
    FROM product
    WHERE code = NEW.product;

    SET NEW.weight = product_weight*NEW.product_quantity;
END $$

CREATE TRIGGER before_update_package
BEFORE UPDATE ON package
FOR EACH ROW
BEGIN
    DECLARE product_weight DECIMAL(10, 2);
    
    SELECT weight INTO product_weight
    FROM product
    WHERE code = NEW.product;

    SET NEW.weight = product_weight * NEW.product_quantity;
END $$
---------------------------------------------------------------------------------------



--Trigger peso embalaje
------------------------------------------------------------
drop Trigger update_packaging_weight

DELIMITER $$

CREATE TRIGGER update_packaging_weight
AFTER INSERT ON package
FOR EACH ROW
BEGIN
    DECLARE total_weight DECIMAL(10,2);

    SELECT SUM(weight) INTO total_weight
    FROM package
    WHERE packaging = NEW.packaging;

    IF total_weight IS NULL THEN
        SET total_weight = 0;
    END IF;

    UPDATE packaging
    SET weight = total_weight
    WHERE num = NEW.packaging;
END;

drop trigger update_packaging_weight_update;
CREATE TRIGGER update_packaging_weight_update
AFTER update ON package
FOR EACH ROW
BEGIN
    DECLARE total_weight DECIMAL(10,2);

    SELECT SUM(weight) INTO total_weight
    FROM package
    WHERE packaging = NEW.packaging;

    IF total_weight IS NULL THEN
        SET total_weight = 0;
    END IF;

    UPDATE packaging
    SET weight = total_weight
    WHERE num = NEW.packaging;
END;
-------------------------------------------------------------

BEFORE UPDATE ON tag
FOR EACH ROW
BEGIN
    DECLARE checksum INT DEFAULT 0;
    DECLARE gs1_code VARCHAR(255);
    DECLARE i INT DEFAULT 1;
    DECLARE len INT;
    DECLARE digito INT;
    DECLARE suma_impar INT DEFAULT 0;
    DECLARE suma_par INT DEFAULT 0;

    -- Generar el código GS1-128 básico (sin checksum)
    SET gs1_code = CONCAT(
        '(17)', DATE_FORMAT(NEW.date, '%y%m%d'),
        '(410)', NEW.destination,
        '(420)', NEW.tag_type
    );
    
    -- Longitud del código generado
    SET len = CHAR_LENGTH(gs1_code);

    -- Calcular el checksum recorriendo cada carácter
    WHILE i <= len DO
        -- Verificar si el carácter es un dígito antes de convertirlo
        IF SUBSTRING(gs1_code, i, 1) REGEXP '^[0-9]$' THEN
            SET digito = CAST(SUBSTRING(gs1_code, i, 1) AS UNSIGNED);

            IF i % 2 = 1 THEN
                -- Sumar posición impar y multiplicar por 3
                SET suma_impar = suma_impar + digito;
            ELSE
                -- Sumar posición par
                SET suma_par = suma_par + digito;
            END IF;
        END IF;

        SET i = i + 1;
    END WHILE;

    -- Sumar los resultados y calcular el checksum
    SET checksum = (10 - ((suma_impar * 3 + suma_par) % 10)) % 10;

    -- Concatenar el checksum al final del código GS1-128
    SET NEW.barcode = CONCAT(gs1_code, checksum);
END;


-------------------------------------------------------------
--Trigger para productos empacados de informe
--se calcula sumando la cantidad de productos que tiene los paquetes involucrados en el embalaje


drop Trigger update_report_packed_products

DELIMITER //

CREATE TRIGGER update_report_packed_products
AFTER INSERT ON package
FOR EACH ROW
BEGIN
    DECLARE total_quantity INT;
    DECLARE related_traceability INT;

    SELECT num INTO related_traceability
    FROM traceability
    WHERE packaging = NEW.packaging
    LIMIT 1;

    SELECT SUM(product_quantity)
    INTO total_quantity
    FROM package
    WHERE packaging = NEW.packaging;


    UPDATE report
    SET packed_products = total_quantity
    WHERE traceability = related_traceability;
END;
//

DELIMITER ;



select * from report


select * from traceability

select * from package

select * from packaging WHERE code ='PK001'


select * from package WHERE packaging ='PK001'


INSERT INTO package (product_quantity, weight, product, packaging, box, tag)
VALUES 
(15, 1.5, 'S10', 'PK001', NULL, NULL);



drop TRIGGER  trg_UpdatePackagingOutbound
