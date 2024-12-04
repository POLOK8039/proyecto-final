INSERT INTO user_type (code, name, description) VALUES 
('ADMIN', 'administrator', "User with full access to the system"),
('SUPER', 'supervisor', "User who oversees other users"),
('EMPLO', 'employee', "User with limited access to the system");

INSERT INTO user (username, password, name, first_surname, second_surname, date_of_birth, neighborhood, street, postal_code, phone, email, user_type, supervisor)
VALUES 
('Axel', '1', 'Yerlan', 'Suastegui', 'Leyva', '2004-06-03', 'Villas', 'E', 12345, '555-1234', 'admin01@example.com', 'ADMIN', NULL),
('super01', 'superpass', 'Jane', 'Doe', NULL, '1985-07-20', 'Uptown', 'Second St', 54321, '555-5678', 'super01@example.com', 'SUPER', 1),
('emp01', 'emppass', 'Alice', 'Johnson', 'Brown', '1990-03-12', 'Westside', 'Third St', 23456, '555-9876', 'alice@example.com', 'EMPLO', 2),
('emp02', 'emppass', 'Bob', 'Williams', NULL, '1992-11-08', 'Eastside', 'Fourth St', 65432, '555-6543', 'bob@example.com', 'EMPLO', 2),
('emp03', 'emppass', 'Charlie', 'Martinez', 'Garcia', '1995-09-30', 'Northside', 'Fifth St', 11111, '555-4321', 'charlie@example.com', 'EMPLO', 2);

INSERT INTO box (height, width, length, volume, weight)
VALUES 
(10.5, 12.0, 15.0, 1890.0, 3.5),
(8.0, 10.0, 20.0, 1600.0, 2.8),
(5.0, 7.0, 10.0, 350.0, 1.2),
(15.0, 15.0, 15.0, 3375.0, 5.0),
(12.0, 14.0, 16.0, 2688.0, 4.2);

INSERT INTO zone (code, area, available_capacity, total_capacity)
VALUES 
('Z001', 'Warehouse A', 50, 100),
('Z002', 'Warehouse B', 75, 150),
('Z003', 'Section C', 30, 80),
('Z004', 'Section D', 60, 120),
('Z005', 'Overflow Area', 10, 50);

INSERT INTO outbound (date, exit_quantity)
VALUES 
('2024-10-01', 100),
('2024-10-02', 150),
('2024-10-03', 200),
('2024-10-04', 50),
('2024-10-05', 75);

INSERT INTO tag_type (code, description)
VALUES 
('TT01', 'Standard'),
('TT02', 'Fragile'),
('TT03', 'Heavy'),
('TT04', 'Urgent'),
('TT05', 'Perishable');

INSERT INTO tag (date, barcode, tag_type)
VALUES 
('2024-10-01', 123456789, 'TT01'),
('2024-10-02', 987654321, 'TT02'),
('2024-10-03', 112233445, 'TT03'),
('2024-10-04', 556677889, 'TT04'),
('2024-10-05', 998877665, 'TT05');

INSERT INTO packaging (code, height, width, length, package_quantity, zone, outbound, tag)
VALUES 
('PK001', 10.0, 15.0, 20.0, 100, 'Z001', 1, 1),
('PK002', 12.0, 18.0, 25.0, 150, 'Z002', 2, 2),
('PK003', 8.0, 10.0, 15.0, 75, 'Z003', 3, 3),
('PK004', 14.0, 16.0, 30.0, 50, 'Z004', 4, 4),
('PK005', 9.0, 11.0, 22.0, 60, 'Z005', 5, 5);

INSERT INTO unit_of_measure (code, description)
VALUES 
('kg', 'Kilograms'),
('lt', 'Liters'),
('pz', 'Pieces'),
('mts', 'Meters'),
('pd', 'Pounds');

INSERT INTO material (code,material_name, description, available_quantity, unit_of_measure)
VALUES 
('stl','Steel', 'High-quality steel', 500, 'kg'),
('pla','Plastic', 'Durable plastic', 200, 'kg'),
('wod','Wood', 'Solid oak wood', 300, 'kg'),
('alm','Aluminum', 'Lightweight aluminum', 400, 'mts'),
('glas','Glass', 'Tempered glass', 150, 'mts');

INSERT INTO packaging_protocol (name, file_name)
VALUES 
('Protocol_Standard', 'protocol_st.pdf'),
('Protocol_Fragile', 'protocol_fr.pdf'),
('Protocol_Heavy', 'protocol_h.pdf'),
('Protocol_Urgent', 'protocol_urg.pdf'),
('Protocol_Perishable', 'protocol_per.pdf');

INSERT INTO product (code,name, description, height, width, length, weight, packaging_protocol)
VALUES 
('S10', 'Samsung S10', 'Medium-quality product', 14.99, 7.04, 0.78, 157, 1),
('P30', 'Huawei P30', 'Medium-quality product', 14.91, 7.14, 0.76, 165,2),
('X', 'iPhone X', 'Budget product', 14.36, 7.09, 0.77, 174,3),
('S23', 'Samsung S23', 'Standard product', 14.63, 7.09, 0.76, 168,4),
('S24', 'Samsung S24', 'Ultra product', 16.23, 7.9, 0.86, 232,5); 

INSERT INTO package (product_quantity, weight, product,packaging, box, tag)
VALUES 
(10, 25.5, 'S10','PK001', 1, 1),
(20, 50.0, 'P30','PK002', 2, 2),
(15, 35.2,  'X','PK003', 3, 3),
(30, 60.7,  'S23','PK004', 4, 4),
(25, 45.9,  'S24','PK005', 5, 5);



INSERT INTO state (code, description)
VALUES 
('ST01', 'In Transit'),
('ST02', 'Delivered'),
('ST03', 'In Warehouse'),
('ST04', 'Out for Delivery'),
('ST05', 'Returned');

--ESTO EMPEZO DESDE 6 NO DE 1
INSERT INTO traceability (product, box, package, packaging, state)
VALUES 
('S10', 1, 1, 'PK001', 'ST01'),
('P30', 2, 2, 'PK002', 'ST02'),
('X', 3, 3, 'PK003', 'ST03'),
('S23', 4, 4, 'PK004', 'ST04'),
('S23', 5, 5, 'PK005', 'ST05');

INSERT INTO incident (date, description, user, traceability)
VALUES 
('2024-10-05', 'Package damaged during transport', 3, 1),
('2024-10-06', 'Late delivery', 4, 2),
('2024-10-07', 'Wrong item delivered', 5, 3),
('2024-10-08', 'Missing items in package', 2, 4),
('2024-10-09', 'Package lost in transit', 1, 5);


--ESTO EMPEZO DESDE 6 NO DE 1
INSERT INTO report (start_date, end_date, report_date, packed_products, observations, traceability)
VALUES 
('2024-09-01', '2024-09-30', '2024-10-01', 1000, 'No major issues', 1),
('2024-09-01', '2024-09-30', '2024-10-02', 1200, 'Delayed deliveries', 2),
('2024-09-01', '2024-09-30', '2024-10-03', 1100, 'Damaged products', 3),
('2024-09-01', '2024-09-30', '2024-10-04', 1050, 'Excellent performance', 4),
('2024-09-01', '2024-09-30', '2024-10-05', 1150, 'Returned packages', 5);

INSERT INTO user_traceability (user, traceability)
VALUES 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO material_packging (material,packaging, quantity)
VALUES 
('pla', 'PK002', 100),
('stl', 'PK001', 50),
('wod', 'PK003', 75),
('alm', 'PK004', 150),
('glas','PK005', 60);


INSERT INTO material_package (material, package, quantity)
VALUES 
('stl',16, 30),
('pla',17, 40),
('wod',18, 50),
('alm',19, 60),
('glas',20, 70);