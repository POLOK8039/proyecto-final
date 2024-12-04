-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
-----------------------------------
        --STORED PROCEDURE
-----------------------------------



drop Procedure check_zone_capacity

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


--Pudieramos cambiar el nombre a search_report
drop PROCEDURE search_report

CREATE PROCEDURE search_report(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN
    SELECT folio,start_date,end_date,report_date,packed_products,observations,traceability
    FROM report 
    WHERE start_date = p_start_date
    AND end_date = p_end_date ;
END;

drop procedure validateUser;
DELIMITER $$
CREATE PROCEDURE validateUser(IN usern VARCHAR(30), IN passw VARCHAR(50))
BEGIN
    DECLARE user_exists INT;
    SET user_exists = (
        SELECT COUNT(*) FROM user 
        WHERE username = usern 
        AND password = SHA1(passw)
        AND active = 1
    );
    
    IF user_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid username or password';
    END IF;

    SELECT num, username, user_type 
    FROM vw_user_info
    WHERE username = usern;
END $$
DELIMITER $$


drop procedure login;
DELIMITER $$

CREATE PROCEDURE login(
    IN p_user VARCHAR(30),
    IN p_password VARCHAR(40)
)
BEGIN
    DECLARE user_exists INT; 


    SET user_exists = (SELECT COUNT(*) FROM user WHERE username = p_user AND password = SHA1(p_password));
    
    IF user_exists > 0 THEN
        SELECT num, username, user_type 
        FROM user WHERE username = p_user 
        AND password = SHA1(p_password);
    END IF;
END $$

CALL addUser('Axel', 'Leyva', 'John', 'Doe', 'Smith', '1985-06-15', 'Downtown', 'Main Street 123', 
12345, '123-456-7890', 'jdoe@example.com', 'ADMIN', NULL);

SET @login_result = NULL;


CALL login('Axel', 'Leyva', @login_result);

DROP PROCEDURE packing_process;
CREATE PROCEDURE packing_process(
    IN p_product_quantity INT,
    IN p_product VARCHAR(5),
    IN p_box INT,
    IN p_tag_type VARCHAR(5),
    IN p_date DATE,
    IN trac_code INT,
    IN id_user INT
)
BEGIN
    DECLARE package_code INT;
    DECLARE packaging_code INT;

    DECLARE err_message VARCHAR(255); 
    DECLARE err_code INT;  
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            err_code = MYSQL_ERRNO, 
            err_message = MESSAGE_TEXT;
        
        ROLLBACK;

        SELECT err_code AS Error_Code, err_message AS Error_Message;
    END;
    START TRANSACTION;

        call addTag(p_date, p_tag_type, NULL, @tag_num);

        SET packaging_code = (
            SELECT packaging FROM traceability
            WHERE num = trac_code
        );

        INSERT INTO package(product_quantity, product, packaging, box, tag)
        VALUES(p_product_quantity, p_product, packaging_code, p_box, @tag_num);

        SET package_code = LAST_INSERT_ID();

        UPDATE traceability
        SET product = p_product,
        state = 'PACK'
        WHERE num = trac_code;

        call addUserInProcess(id_user, trac_code);

    COMMIT;
END $$


call packing_process(5, 'S23', 1, 'TT01', '2024-11-27', 10, 2);

DROP PROCEDURE createPackages;
DELIMITER $$
CREATE PROCEDURE createPackages(
    IN p_quantity INT,
    IN p_user INT,
    IN trac_code INT
)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE quantity INT;

    DECLARE product VARCHAR(5);
    DECLARE p_packaging INT;
    DECLARE prod_quant INT;
    DECLARE box INT;
    DECLARE tag_type VARCHAR(5);
    DECLARE p_date DATE;


    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;

    SELECT Product_Code, Start_Date, Packaging
    INTO product, p_date , p_packaging
    FROM vw_process
    WHERE Traceability = trac_code;

    SELECT product_quantity, box 
    INTO prod_quant, box 
    FROM package
    WHERE packaging = p_packaging;

    SELECT tag_type INTO tag_type
    FROM packaging WHERE num = p_packaging;

    SET quantity = p_quantity - (
        SELECT COUNT(*) FROM package
        WHERE packaging = p_packaging
    );

    START TRANSACTION;
        WHILE i <= quantity DO
            call packing_process(
                prod_quant, product, box,
                tag_type, p_date, p_user, trac_code
            );

            SET i = i + 1;
        END WHILE;

        UPDATE packaging
        SET package_quantity = (
            SELECT COUNT(*) FROM package
            WHERE packaging = p_packaging
        )
        WHERE num = p_packaging;
    COMMIT;
END $$

call createPackages(5,2, 16);

SELECT COUNT(*) FROM package
        WHERE packaging = 10

CREATE PROCEDURE packaging_process(
    IN p_quantity INT,
    IN p_material VARCHAR(5),
    IN p_mat_quant DECIMAL(10,2),
    IN p_user INT,
    IN trac_code INT
) 
BEGIN 
END$$


SELECT @login_result; 

set autocommit = 1;
select @@autocommit;

commit;

create procedure addMaterialToPackaging(
    IN mat VARCHAR(5),
    IN pack INT,
    IN quant INT
)
BEGIN
    INSERT INTO material_packging 
    VALUES (pack, mat, quant);
END$$

DROP PROCEDURE startProcess;
DELIMITER $$
CREATE PROCEDURE startProcess(
    IN p_user INT
)
BEGIN

    DECLARE trac_code INT;
    DECLARE pack_code INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT "ERROR" AS error;
        
        ROLLBACK;

    END;

    START TRANSACTION;

        INSERT INTO packaging (num) VALUES(NULL);
        SET pack_code = LAST_INSERT_ID();

        INSERT INTO traceability(state, packaging) 
        VALUES ('START', pack_code);
        
        SET trac_code = LAST_INSERT_ID();

        INSERT INTO report (start_date, traceability)
        VALUES (NOW(), trac_code);

        call addUserInProcess(p_user, trac_code);

        SELECT trac_code AS Traceability, 
               pack_code AS Packaging;
    
    COMMIT;

END $$

DELIMITER $$
CREATE PROCEDURE addUserInProcess(
    IN p_user INT,
    IN p_trac INT
)
BEGIN
    DECLARE rows_inserted INT DEFAULT 0;

    SET rows_inserted = (
        SELECT COUNT(*) FROM user_traceability
        WHERE traceability = p_trac AND user = p_user
    );

    IF rows_inserted < 1 THEN
        INSERT INTO user_traceability(user, traceability)
        VALUES (p_user, p_trac);
    END IF; 
END $$
DELIMITER ;

call `startProcess`(5);

ROLLBACK;
SHOW WARNINGS;

select * from user_traceability;

SELECT COUNT(*) FROM user_traceability
        WHERE traceability = 3 AND user = 2

drop procedure add_packaging_quantity;
DELIMITER $$

CREATE PROCEDURE change_state(
    IN trac_code INT,
    IN new_state VARCHAR(5)
)
BEGIN 
    UPDATE traceability
    SET state = new_state
    WHERE num = trac_code;
END$$


DROP PROCEDURE `startPackaging`;
CREATE PROCEDURE startPackaging(
    IN Destination VARCHAR(25),
    IN trac_code INT,
    IN user INT
)
BEGIN 
    DECLARE tag_type VARCHAR(5);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SELECT "ERROR" AS error;
        ROLLBACK;
    END;

    START TRANSACTION;

        SET tag_type = (
            SELECT code FROM tag_type
            WHERE description = (
                SELECT Package_Type FROM vw_process
                WHERE Traceability = trac_code
            )
        );


        call addTag(CURRENT_DATE, tag_type, Destination, @tag);

        select @tag, tag_type, destination, CURRENT_DATE;

        UPDATE packaging 
        SET tag = @tag 
        WHERE num = (
            SELECT packaging 
            FROM traceability
            WHERE num = trac_code
        );

    COMMIT;
END $$
SELECT code FROM tag_type
            WHERE description = (
                SELECT Package_Type FROM vw_process
                WHERE Traceability = 2
            );

CREATE PROCEDURE add_packaging_quantity(
    IN quantity INT,
    IN user INT,
    IN trac_code INT
)
BEGIN

    UPDATE packaging 
    SET package_quantity = quantity 
    WHERE num = (
        SELECT packaging from traceability
        WHERE num = trac_code
    );

    call addUserInProcess(user, trac_code);

    call change_state(trac_code, "PACKG");

END $$

create procedure chage_state(
    IN trac_code INT,
    IN new_state VARCHAR(5)
)
BEGIN
    UPDATE traceability
    SET state = new_state
    WHERE num = trac_code;
END $$

call add_packaging_quantity(12,17);
SELECT * FROM packaging;
UPDATE packaging 
SET package_quantity = 17 
WHERE num = 12;

SELECT packaging from traceability
        WHERE num = 12


drop procedure addPackagingInZone;
DELIMITER $$
CREATE PROCEDURE addPackagingInZone(
    IN new_zone VARCHAR(5),
    IN trac_code INT,
    IN user INT
)
BEGIN
    call addUserInProcess(user, trac_code);

    UPDATE packaging
    SET zone = new_zone
    WHERE num = (
        SELECT packaging FROM traceability
        WHERE num = trac_code
    );

    call change_state(trac_code, "WARHS");
END $$

drop procedure availableMaterial;
create procedure availableMaterial(IN packaging INT)
BEGIN
    SELECT mi.code AS Code,
        mi.name AS Name,
        mi.unit_of_measure AS Unit
    FROM vw_material_info as mi
    WHERE Code NOT IN (
        SELECT mp.Code
        FROM vw_material_process AS mp
        WHERE mp.Packaging = packaging
    );
END

call availableMaterial(@prueba);

set @prueba = 2;

SELECT mi.code AS Code,
        mi.name AS Name,
        mi.unit_of_measure AS Unit
    FROM vw_material_info as mi
    WHERE mi.code NOT IN (
        SELECT mp.Code
        FROM vw_material_process AS mp
        WHERE mp.Packaging = @prueba
    );

    SELECT mp.Code
        FROM vw_material_process AS mp
        WHERE mp.Packaging = @prueba