-- Active: 1730432982636@@127.0.0.1@3306@packaging

drop DATABASE packaging;

create DATABASE packaging;


-- TABLE USER TYPE
CREATE TABLE user_type (
    code VARCHAR(5)  PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(50) NOT NULL
);

-- TABLE USER

CREATE TABLE user (
    num INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(30) NOT NULL UNIQUE, 
    password VARCHAR(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    first_surname VARCHAR(30) NOT NULL,
    second_surname VARCHAR(30),
    date_of_birth DATE,
    neighborhood VARCHAR(50),
    street VARCHAR(50),
    postal_code INT,
    phone VARCHAR(15),
    email VARCHAR(30),
    active BIT DEFAULT TRUE,
    user_type VARCHAR(5),
    supervisor INT,
    CONSTRAINT fk_user_type FOREIGN KEY (user_type) REFERENCES user_type(code),
    CONSTRAINT fk_user_supervisor FOREIGN KEY (supervisor) REFERENCES user(num)
);


-- TABLE BOX
CREATE TABLE box (
    num INT AUTO_INCREMENT PRIMARY KEY,
    height DECIMAL(10, 2),
    width DECIMAL(10, 2),
    length DECIMAL(10, 2),
    volume DECIMAL(10, 2), 
    weight DECIMAL(10, 2)
);

-- TABLE ZONE
CREATE TABLE zone (
    code VARCHAR(5) PRIMARY KEY,
    area VARCHAR(50) NOT NULL UNIQUE,
    available_capacity INT,
    total_capacity INT
);

-- TABLE OUTBOUBD
CREATE TABLE outbound (
    num INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    exit_quantity INT
);

-- TABLE TAG TYPE
CREATE TABLE tag_type (
    code VARCHAR(5)  PRIMARY KEY,
    description VARCHAR(50)
);

-- TABLE TAG
CREATE TABLE tag (
    num INT AUTO_INCREMENT PRIMARY KEY,
    date DATE,
    barcode VARCHAR(255),
    tag_type varchar(5),
    destination VARCHAR(25),
    CONSTRAINT fk_tag_type_tag FOREIGN KEY (tag_type) REFERENCES tag_type(code)
);

-- TABLE PACKAGING
CREATE TABLE packaging (
    code VARCHAR(5)  PRIMARY KEY,
    height DECIMAL(10, 2),
    width DECIMAL(10, 2),
    length DECIMAL(10, 2),
    package_quantity INT,
    zone VARCHAR(5),
    outbound INT,
    tag int,
    CONSTRAINT fk_zone_packaging FOREIGN KEY (zone) REFERENCES zone(code),
    CONSTRAINT fk_outbound_packaging FOREIGN KEY (outbound) REFERENCES outbound(num),
    CONSTRAINT fk_tag_packaging FOREIGN KEY (tag) REFERENCES tag(num)
);

-- TABLE UNIT OF MEASURE
CREATE TABLE unit_of_measure (
    code VARCHAR(5)  PRIMARY KEY,
    description VARCHAR(50)
);

-- TABLE MATERIAL
CREATE TABLE material (
    code VARCHAR(5) PRIMARY KEY,
    material_name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    available_quantity INT,
    unit_of_measure VARCHAR(5),
    CONSTRAINT fk_unit_of_measure FOREIGN KEY (unit_of_measure) REFERENCES unit_of_measure(code)
);

-- TABLE PACKAGING PROTOCOL
CREATE TABLE packaging_protocol (
    num INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    file_name VARCHAR(30)
);



-- TABLE PRODUCT
CREATE TABLE product (
    code VARCHAR(5) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    height DECIMAL(10, 2),
    width DECIMAL(10, 2),
    length DECIMAL(10, 2),
    weight DECIMAL(10, 2),
    packaging_protocol INT,
    CONSTRAINT fk_packaging_protocol_product FOREIGN KEY (packaging_protocol) REFERENCES packaging_protocol(num)
);

-- TABLE STATE FOR TRACEABILITY
CREATE TABLE state (
    code VARCHAR (5)  PRIMARY KEY,
    description VARCHAR(50) NOT NULL
);

-- TABLE TRACEABILITY 
CREATE TABLE traceability (
    num INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(5),
    packaging VARCHAR(5),
    state VARCHAR(5),
    CONSTRAINT fk_product_traceability FOREIGN KEY (product) REFERENCES product(code),
    CONSTRAINT fk_packaging_traceability FOREIGN KEY (packaging) REFERENCES packaging(code),
    CONSTRAINT fk_state_traceability FOREIGN KEY (state) REFERENCES state(code)
);


-- TABLE PACKAGE
CREATE TABLE package (
    num INT AUTO_INCREMENT PRIMARY KEY,
    product_quantity INT,
    weight DECIMAL(10, 2),
    product VARCHAR (5),
    packaging VARCHAR(5),
    box INT,
    tag int,
    traceability int,
    CONSTRAINT fk_product_package FOREIGN KEY (product) REFERENCES product(code),
    CONSTRAINT fk_packaging_package FOREIGN KEY (packaging) REFERENCES packaging(code),
    CONSTRAINT fk_box_package FOREIGN KEY (box) REFERENCES box(num),
    CONSTRAINT fk_tag_package FOREIGN KEY (tag) REFERENCES tag(num),
    CONSTRAINT fk_traceability_package FOREIGN KEY (traceability) REFERENCES traceability(num)
);







-- TABLE INCIDENT
CREATE TABLE incident (
    num INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    description TEXT NOT NULL,
    user INT,
    traceability INT,
    CONSTRAINT fk_user_incident FOREIGN KEY (user) REFERENCES user(num),
    CONSTRAINT fk_traceability_incident FOREIGN KEY (traceability) REFERENCES traceability(num)
);

-- TABLE REPORT
CREATE TABLE report (
    folio INT AUTO_INCREMENT PRIMARY KEY,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    report_date DATE,
    packed_products INT,
    observations TEXT,
    traceability INT,
    CONSTRAINT fk_traceability_report FOREIGN KEY (traceability) REFERENCES traceability(num)
);

-- MANY-TO-MANY TABLES
CREATE TABLE user_traceability (
    user INT,
    traceability INT,
    PRIMARY KEY (user, traceability),
    CONSTRAINT fk_user_traceability FOREIGN KEY (user) REFERENCES user(num),
    CONSTRAINT fk_traceability_user FOREIGN KEY (traceability) REFERENCES traceability(num)
);

-- PACKAGING-MATERIAL
CREATE TABLE material_packging (
    packaging VARCHAR(5),
    material VARCHAR (5),
    quantity INT,
    PRIMARY KEY (material,packaging),
    CONSTRAINT fk_packaging_material FOREIGN KEY (packaging) REFERENCES packaging(code),
    CONSTRAINT fk_material_packaging FOREIGN KEY (material) REFERENCES material(code)
);

-- MATERIAL-PACKAGE
CREATE TABLE material_package (
    material VARCHAR(5),
    package INT,
    quantity INT,
    PRIMARY KEY (material, package),
    CONSTRAINT fk_material_package FOREIGN KEY (material) REFERENCES material(code),
    CONSTRAINT fk_package_material FOREIGN KEY (package) REFERENCES package(num)
);
