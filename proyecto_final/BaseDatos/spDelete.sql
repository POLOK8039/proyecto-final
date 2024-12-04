---------------------------------------
--Eliminar registro
---------------------------------------

--Usuario  --active
DELIMITER $$
Create PROCEDURE dropUser(In p_num int)
BEGIN
    UPDATE user SET active = 0 WHERE num = p_num;
END$$



--Tipo de usuario

Drop Procedure dropUserType
DELIMITER $$
Create PROCEDURE dropUserType(IN p_code varchar(5))
BEGIN
    UPDATE user_type SET active = 0 WHERE code = p_code;
END$$



--caja
DELIMITER $$
Create PROCEDURE dropBox(In p_num int)
BEGIN
    UPDATE box SET active = 0 WHERE num = p_num;
END$$



--Material
drop Procedure dropMaterial

DELIMITER $$
Create PROCEDURE dropMaterial(In p_code varchar(5))
BEGIN
    UPDATE material SET active = 0 WHERE code = p_code;
END$$



--producto
drop Procedure dropProduct
DELIMITER $$
Create PROCEDURE dropProduct(In p_code varchar(5))
Begin
    UPDATE product SET active = 0 WHERE code = p_code;
End $$


--Salida
DELIMITER $$
Create PROCEDURE dropOutBound(In p_num int)
Begin
    UPDATE outbound SET active = 0 WHERE num = p_num;
End$$



--Zona
drop Procedure dropZone

DELIMITER $$
Create PROCEDURE dropZone(In p_code varchar(5))
BEGIN
    UPDATE zone SET active = 0 WHERE code = p_code;
END$$


--Protocolo
DELIMITER $$
Create PROCEDURE dropProtocol(In p_num int)
BEGIN
    UPDATE packaging_protocol SET active = 0 WHERE num = p_num;
END$$




--Paquete
--Embalaje
--Etiqueta
--Tipo de etiqueta
--Report
--Incidente
