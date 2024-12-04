-- Active: 1730432982636@@127.0.0.1@3306@packaging

--Miniimos 2 triggers
--Minimo 2 Stored Procedure

--Tenemos que decir el nombre
--Tenememos que describir que es lo va a realizar

-----------------------------------
            --TRIGGERS
-----------------------------------
SELECT TRIGGER_NAME, EVENT_MANIPULATION, EVENT_OBJECT_TABLE, ACTION_STATEMENT, ACTION_TIMING 
FROM information_schema.TRIGGERS 
WHERE TRIGGER_SCHEMA = 'packaging';

DROP TRIGGER after_insert_tag

--CHECAR Como Funciona el INSERT OR UPDATE

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


INSERT INTO box (height, width, length, weight)
VALUES (5.5,5.5,5.5, 3.5)


uPDATE box
set height = 10
where num = 6


--Hacer pruebas bien con respecto a este aun no estoy seguro

--Por que agrega varios productos diferentes y se hace el calculo bien osea suma el peso de todos los prodcutos y lo multiplica
--por la cantida de producto ej  180+180+157=517 * 10 = 5170 no se si eso deberia de ser correcto jeje
DELIMITER $$

CREATE TRIGGER calculate_package_weight_after_product_insert
AFTER INSERT ON product
FOR EACH ROW
BEGIN
    DECLARE total_weight DECIMAL(10, 2);

    SELECT SUM(p.weight * pk.product_quantity) INTO total_weight
    FROM product p
    JOIN package pk ON pk.num = p.package
    WHERE p.package = NEW.package;

    UPDATE package
    SET weight = total_weight
    WHERE num = NEW.package;
END $$

drop trigger calculate_package_weight;
DELIMITER $$
CREATE TRIGGER calculate_package_weight
BEFORE INSERT ON package
FOR EACH ROW
BEGIN
    DECLARE prod_weight DECIMAL(10, 2);

    SET prod_weight = (
        SELECT SUM(weight) * NEW.product_quantity
        FROM product
        WHERE package = NEW.num
    );

    SET NEW.weight = prod_weight;
END $$

DELIMITER ;

-- Insert de prueba en la tabla product
INSERT INTO product (code, name, description, height, width, length, weight, package, packaging_protocol)
VALUES ('P0', 'Pixel 5', 'Premium product', 14.40, 7.30, 0.80, 180, 1, 1);
INSERT INTO product (code, name, description, height, width, length, weight, package, packaging_protocol)
VALUES ('P0', 'Pixel 5', 'Premium product', 14.40, 7.30, 0.80, 1, 1);


select * from product where package = 1;
select * from product where package = 1;
SELECT * FROM package;

INSERT INTO package(product_quantity, tracking_code, box, tag) VALUES
(5, 2345,3, 2 )

SELECT SUM(weight)
    FROM product
    WHERE package = 1;

SELECT * FROM package WHERE num = 1;



select * from package


select * from packaging


--Falta saber lo del peso del embalaje



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

DELIMITER ;



DELIMITER $$

CREATE TRIGGER material_package_insert
AFTER INSERT ON material_package
FOR EACH ROW
BEGIN
    UPDATE material
    SET available_quantity = available_quantity - NEW.quantity
    WHERE code = NEW.material;
END $$
DELIMITER ;


select * from material


INSERT INTO material_packging (packaging, material, quantity)
VALUES 
('PK001', 'alm', 50)

INSERT INTO material_package (material, package, quantity)
VALUES 
('stl',3, 70)

select * from packaging


---Etiqueta

drop Trigger before_insert_tag

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
        '(410)', NEW.destination,
        '(420)', NEW.tag_type
    );
    
    -- Longitud del código generado
    SET len = CHAR_LENGTH(gs1_code);

    -- Calcular el checksum recorriendo cada carácter
    WHILE i <= len DO
        SET digito = CAST(SUBSTRING(gs1_code, i, 1) AS UNSIGNED);

        IF i % 2 = 1 THEN
            -- Sumar posición impar y multiplicar por 3
            SET suma_impar = suma_impar + digito;
        ELSE
            -- Sumar posición par
            SET suma_par = suma_par + digito;
        END IF;
        
        SET i = i + 1;
    END WHILE;

    -- Sumar los resultados y calcular el checksum
    SET checksum = (10 - ((suma_impar * 3 + suma_par) % 10)) % 10;

    -- Concatenar el checksum al final del código GS1-128
    SET NEW.barcode = CONCAT(gs1_code, checksum);
END;

DELIMITER ;

select * from tag

Insert into tag (date,tag_type,destination)
values ('2024-10-30','TT03','UABC')


