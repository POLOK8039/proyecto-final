-- Active: 1728065056405@@127.0.0.1@3306@packaging_test
-- SQLBook: Code
INSERT INTO user_type (code, name, description) VALUES 
('ADMIN', 'Administrator', "User with full access to the system"),
('SUPER', 'Supervisor', "User who oversees other users"),
('EMPLO', 'Employee', "User with limited access to the system");

INSERT INTO user (username, password, name, first_surname, second_surname, date_of_birth, neighborhood, street, postal_code, phone, email, user_type, supervisor)
VALUES 
('admin01', SHA1('adminpass'), 'John', 'Doe', 'Smith', '1980-05-14', 'Downtown', 'Main St', 12345, '555-1234', 'admin01@example.com', 'ADMIN', NULL),
('super01', SHA1('superpass'), 'Jane', 'Doe', NULL, '1985-07-20', 'Uptown', 'Second St', 54321, '555-5678', 'super01@example.com', 'SUPER', NULL),
('emp01', SHA1('emppass'), 'Alice', 'Johnson', 'Brown', '1990-03-12', 'Westside', 'Third St', 23456, '555-9876', 'alice@example.com', 'EMPLO', NUll),
('emp02', SHA1('emppass'), 'Bob', 'Williams', NULL, '1992-11-08', 'Eastside', 'Fourth St', 65432, '555-6543', 'bob@example.com', 'EMPLO', Null),
('emp03', SHA1('emppass'), 'Charlie', 'Martinez', 'Garcia', '1995-09-30', 'Northside', 'Fifth St', 11111, '555-4321', 'charlie@example.com', 'EMPLO', Null);

INSERT INTO user (username, password, name, first_surname, second_surname, date_of_birth, neighborhood, street, postal_code, phone, email, user_type, supervisor)
VALUES 
('admin02', SHA1('Admin1234'), 'Juan', 'Pérez', 'González', '1980-05-14', 'Centro', 'Calle Principal', 12345, '555-1234', 'admin01@example.com', 'ADMIN', NULL),
('super02', SHA1('Super4567'), 'María', 'López', 'Hernández', '1985-07-20', 'Uptown', 'Segunda Calle', 54321, '555-5678', 'super01@example.com', 'SUPER', NULL),
('emp04', SHA1('Emp12345'), 'Ana', 'Martínez', 'Ramírez', '1990-03-12', 'Oeste', 'Tercera Calle', 23456, '555-9876', 'ana@example.com', 'EMPLO', 2),
('emp05', SHA1('Emp45678'), 'Luis', 'García', 'Torres', '1992-11-08', 'Este', 'Cuarta Calle', 65432, '555-6543', 'luis@example.com', 'EMPLO', 2),
('emp06', SHA1('Emp98765'), 'Carlos', 'Sánchez', 'Flores', '1995-09-30', 'Norte', 'Quinta Calle', 11111, '555-4321', 'carlos@example.com', 'EMPLO', 2);

INSERT INTO box (height, width, length, volume, weight)
VALUES 
(10.5, 12.0, 15.0, 1890.0, 3.5),
(8.0, 10.0, 20.0, 1600.0, 2.8),
(5.0, 7.0, 10.0, 350.0, 1.2),
(15.0, 15.0, 15.0, 3375.0, 5.0),
(12.0, 14.0, 16.0, 2688.0, 4.2);

INSERT INTO zone (code, area, available_capacity, total_capacity)
VALUES 
('Z001', 'Apple', 50, 100),
('Z002', 'Oppo', 75, 150),
('Z003', 'Xiomi', 30, 80),
('Z004', 'Huawei', 60, 120),
('Z005', 'Samsug', 10, 50);



INSERT INTO tag_type (code, description)
VALUES 
('std', 'Standard'),
('frg', 'Fragile'),
('hvy', 'Heavy'),
('urg', 'Urgent')


INSERT INTO tag (date, tag_type,destination)
VALUES 
('2024-10-01', 'std','Tecate'),
('2024-10-02', 'frg','Cancun'),
('2024-10-03', 'frg','Guadalajara'),
('2024-10-04',= 'hvy','Sinaloa'),
('2024-10-05', Null, 'urg',NULL);

INSERT INTO packaging (height, width, length, weight, package_quantity, zone, outbound, tag)
VALUES 
(10.0, 15.0, 20.0, 10, 30 ,'Z001', 1, 1),
(12.0, 18.0, 25.0, 10, 10, 'Z002', 2, 2),
(8.0, 10.0, 15.0, 7, 20 ,'Z003', 3, 3),
(14.0, 16.0, 30.0, 5, 40, 'Z004', 4, 4),
(9.0, 11.0, 22.0, 6, 5, 'Z005', 5, 5);

INSERT INTO outbound (date, exit_quantity,active)
VALUES 
('2024-10-01', 100,1),
('2024-10-02', 120,0),
('2024-10-03', 20,1),
('2024-10-04', 50,1),
('2024-10-05', 75,0);



INSERT INTO unit_of_measure (code, description)
VALUES 
('g', 'Grams'),
('kg', 'Kilograms'),
('lt', 'Liters'),
('pc', 'Pieces'),
('m', 'Meters'),
('lb', 'Pounds');

INSERT INTO material (code, name, description, available_quantity, unit_of_measure)
VALUES 
('stl', 'Steel', 'High-quality steel', 500, 'kg'),
('pla', 'Plastic', 'Durable plastic', 200, 'pc'),
('wod', 'Wood', 'Solid oak wood', 300, 'pc')


INSERT INTO packaging_protocol (name, file_name)
VALUES 
('Protocol_Standard', 'protocol_st.pdf'),
('Protocol_Fragile', 'protocol_fr.pdf'),
('Protocol_Heavy', 'protocol_h.pdf'),
('Protocol_Urgent', 'protocol_urg.pdf')


INSERT INTO product (code, name, description, height, width, length, weight, packaging_protocol)
VALUES 
('S10', 'Samsung S10', 'Medium-quality product', 14.99, 7.04, 0.78, 157, 1),
('P30', 'Huawei P30', 'Medium-quality product', 14.91, 7.14, 0.76, 165, 2),
('X', 'iPhone X', 'Budget product', 14.36, 7.09, 0.77, 174, 3),
('S23', 'Samsung S23', 'Standard product', 14.63, 7.09, 0.76, 168, 4),
('S24', 'Samsung S24', 'Ultra product', 16.23, 7.9, 0.86, 232, 4);

INSERT INTO package (product_quantity, weight, product, packaging, box, tag)
VALUES 
(10, 25.5, 'S10', 1, 1, 1),
(20, 50.0, 'P30', 2, 2, 2),
(15, 35.2, 'X', 3, 3, 3),
(30, 60.7, 'S23', 4, 4, 4),
(25, 45.9, 'S24', 5, 5, 5);

INSERT INTO state (code, description)
VALUES 
('START', 'Starting Process'),
('RECV', 'Receiving Product'),
('PACK', 'Packing Products'),
('PACKG', 'Packaging Boxes'),
('WARHS', 'In Warehouse'),
('DELIV', 'Delivered'),
('CANCL', 'Canceled');

INSERT INTO traceability (product, packaging, state)
VALUES 
('S10', 1, 'WARHS'),
('P30', 2, 'WARHS'),
('X',3, 'WARHS'),
('S23', 4, 'WARHS'),
('S24',  5, 'WARHS');

-- Ahora ajustamos el insert en la tabla incident que hace referencia a los registros de traceability
INSERT INTO incident (date, description, user, traceability)
VALUES 
('2024-10-05', 'Package damaged during packaging', 3, 1),
('2024-10-06', 'Wrong material for this packaging', 4, 2),
('2024-10-08', 'Missing items in package', 2, 4)

-- Ajustamos también el insert en la tabla report que depende de traceability
INSERT INTO report (start_date, end_date, report_date, packed_products, observations, traceability)
VALUES 
('2024-09-01', '2024-09-30', '2024-10-01', 100, 'All packages were properly sealed and taged.', 1),
('2024-09-01', '2024-09-30', '2024-10-02', 120, 'Delays occurred due to insufficient materials in stock.', 2),
('2024-09-01', '2024-09-30', '2024-10-03', 110, 'Several packages required repacking due to damaged boxes.', 3),
('2024-09-01', '2024-09-30', '2024-10-04', 150, 'Exceptional packaging performance; quality checks passed.', 4)


INSERT INTO user_traceability (user, traceability)
VALUES 
(1, 1),
(2, 1),
(5, 1),
(1, 2),
(5, 2),
(3, 3),
(2, 4),
(3, 4),
(4, 4),
(5, 5);

INSERT INTO material_packging (material,packaging, quantity)
VALUES 
('pla', 2, 100),
('stl', 1, 50),
('wod', 3, 75)

INSERT INTO material_package (material, package, quantity)
VALUES 
('stl',1, 30),
('pla',2, 40),
('wod',3, 50)


