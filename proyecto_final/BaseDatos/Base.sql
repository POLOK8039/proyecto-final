-- Active: 1723058837855@@127.0.0.1@3306@embalaje


-- TABLA TIPO USUARIO
CREATE TABLE tipo_usuario (
    codigo VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(50) NOT NULL
);

-- TABLA USUARIO 
CREATE TABLE usuario (
    num INT AUTO_INCREMENT PRIMARY KEY,
    nombreUsuario VARCHAR(30) NOT NULL UNIQUE, -- Unique para nombre de usuario
    contrasena VARCHAR(20) NOT NULL,
    
    -- Atributos de la tabla persona
    nombre VARCHAR(50) NOT NULL,
    apellidoPa VARCHAR(30) NOT NULL,
    apellidoMa VARCHAR(30),
    fecNac DATE,
    colonia VARCHAR(50),
    calle VARCHAR(50),
    cp INT,
    telefono VARCHAR(15),
    email VARCHAR(30),
    activo BOOLEAN DEFAULT TRUE,

    tipo_usuario varchar(5),
    supervisor INT,
    CONSTRAINT fk_tipo_usuario FOREIGN KEY (tipo_usuario) REFERENCES tipo_usuario(num),
    CONSTRAINT fk_supervisor_usuario FOREIGN KEY (supervisor) REFERENCES usuario(num) 
);


--TABLA CAJA
CREATE TABLE caja (
    num INT AUTO_INCREMENT PRIMARY KEY,
    alto DECIMAL(10, 2),
    ancho DECIMAL(10, 2),
    largo DECIMAL(10, 2),
    volumen DECIMAL(10, 2) GENERATED ALWAYS AS (alto * ancho * largo), --Investigar bien como funciona esto mejor Triggers
    peso DECIMAL(10, 2)
);

--tabla zona
CREATE TABLE zona (
    clave VARCHAR(5)  PRIMARY KEY,
    area VARCHAR(50) NOT NULL UNIQUE, --Opinion de UNIQUE
    capacidad_disponible int,
    capacidad_total int
);

--tabla salida
CREATE TABLE salida (
    num INT AUTO_INCREMENT PRIMARY KEY,
    fecha date,
    cantidadSalida int
)

--tabla Tipo etiqueta
CREATE TABLE tipo_etiqueta (
    clave VARCHAR(5)  PRIMARY KEY,
    descripcion VARCHAR(50) 
    );

--tabla Etiqueta
CREATE TABLE etiqueta (
    num INT AUTO_INCREMENT PRIMARY KEY,
    fecha date,
    codigo_barras int,
    tipo_etiqueta VARCHAR(5),
    CONSTRAINT fk_tipo_etiqueta_etiqueta FOREIGN KEY (tipo_etiqueta) REFERENCES tipo_etiqueta(clave)
);


--tabla embalaje
CREATE TABLE embalaje (
    clave varchar(5)  PRIMARY KEY,
    alto DECIMAL(10, 2),
    ancho DECIMAL(10, 2),
    largo DECIMAL(10, 2),
    cantidad_paquetes INT,
    zona VARCHAR(5),
    salida int,
    etiqueta int,
    CONSTRAINT fk_zona_embalaje FOREIGN KEY (zona) REFERENCES zona(clave),
    CONSTRAINT fk_salida_embalaje FOREIGN KEY (salida) REFERENCES salida(num),
    CONSTRAINT fk_etiqueta_embalaje FOREIGN KEY (etiqueta) REFERENCES etiqueta(num)
);

--TABLA UNIDAD DE MEDIDA
CREATE TABLE unidad_medida (
    clave VARCHAR(5)  PRIMARY KEY,
    descripcion VARCHAR(50),
);

--TABLA Material
CREATE TABLE material (
    num INT AUTO_INCREMENT PRIMARY KEY,
    nombre_material VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    cantidad_disponible int,
    unidad_medida VARCHAR(5),
    CONSTRAINT fk_unidad_medida FOREIGN KEY (unidad_medida) REFERENCES unidad_medida(clave)
);


--TABLA paquete
CREATE TABLE paquete (
    num INT AUTO_INCREMENT PRIMARY KEY,
    cantidad_producto INT,
    peso DECIMAL(10, 2),
    codigo_rastreo INT,
    embalaje VARCHAR(5),
    caja int,
    etiqueta int,
    CONSTRAINT fk_embalaje_paquete FOREIGN KEY (embalaje) REFERENCES embalaje(clave),
    CONSTRAINT fk_caja_paquete FOREIGN KEY (caja) REFERENCES caja(num),
    CONSTRAINT fk_etiqueta_paquete FOREIGN KEY (etiqueta) REFERENCES etiqueta(num)
);

--TABLA PROCOLO EMBALJE
CREATE TABLE protocolo_embalaje (
    num INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    nom_archivo VARCHAR(30)
);

--Tabla producto
CREATE TABLE producto (
    num INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(255),
    peso DECIMAL(10, 2),
    alto DECIMAL(10, 2),
    ancho DECIMAL(10, 2),
    largo DECIMAL(10, 2),
    paquete int,
    protocolo_embalaje int,
    CONSTRAINT fk_paquete_producto FOREIGN KEY (paquete) REFERENCES paquete(num),
    CONSTRAINT fk_protocolo_embalaje_producto FOREIGN KEY (protocolo_embalaje) REFERENCES protocolo_embalaje(num)
);

--TABLA Estado par trazabilidad
CREATE TABLE estado (
    codigo VARCHAR (5) PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);



-- TABLA trazabilidad   producto, caja, paquete y embalaje
CREATE TABLE trazabilidad (
    num INT AUTO_INCREMENT PRIMARY KEY,
    producto INT, 
    caja INT, 
    paquete INT, 
    embalaje VARCHAR(5), 
    estado VARCHAR(5),
    CONSTRAINT fk_producto_trazabilidad FOREIGN KEY (producto) REFERENCES producto(num),
    CONSTRAINT fk_caja_trazabilidad FOREIGN KEY (caja) REFERENCES caja(num),
    CONSTRAINT fk_paquete_trazabilidad FOREIGN KEY (paquete) REFERENCES paquete(num),
    CONSTRAINT fk_embalaje_trazabilidad FOREIGN KEY (embalaje) REFERENCES embalaje(clave),
    CONSTRAINT fk_estado_trazabilidad FOREIGN KEY (estado) REFERENCES estado(codigo)
);


--TABLA incidencia
CREATE TABLE incidencia (
    num INT AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    descripcion TEXT NOT NULL,
    usuario INT,
    trazabilidad INT,  
    CONSTRAINT fk_usuario_incidencia FOREIGN KEY (usuario) REFERENCES usuario(num),
    CONSTRAINT fk_trazabilidad_incidencia FOREIGN KEY (trazabilidad) REFERENCES trazabilidad(num)
);


--Tabla infome 
--Definir bien los nombre de inicio y Fin
CREATE TABLE informe (
    folio INT AUTO_INCREMENT PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    fecha_informe DATE,
    productos_empacados INT,  
    observaciones TEXT,
    trazabilidad int,
    CONSTRAINT fk_trazabilidad_informe FOREIGN KEY (trazabilidad) REFERENCES trazabilidad(num)
);


---TABLAS DE MUCHOS A MUCHOS 
CREATE TABLE usuario_trazabilidad (
    usuario  INT, 
    trazabilidad INT, 
    PRIMARY KEY (usuario, trazabilidad),
    CONSTRAINT fk_usuario_trazabilidad FOREIGN KEY (usuario) REFERENCES usuario(num),
    CONSTRAINT fk_trazabilidad_usuario FOREIGN KEY (trazabilidad) REFERENCES trazabilidad(num)
);

--embalje-material
CREATE TABLE embalaje_material (
    embalaje VARCHAR(5), 
    material INT, 
    cantidad INT, -- Cantidad de material utilizado
    PRIMARY KEY (embalaje, material),
    CONSTRAINT fk_embalaje_material FOREIGN KEY (embalaje) REFERENCES embalaje(clave),
    CONSTRAINT fk_material_embalaje FOREIGN KEY (material) REFERENCES material(num)
);


--material-paquete
CREATE TABLE material_paquete (
    material INT, 
    paquete INT, 
    cantidad INT, 
    PRIMARY KEY (material, paquete),
    CONSTRAINT fk_material_paquete FOREIGN KEY (material) REFERENCES material(num),
    CONSTRAINT fk_paquete_material FOREIGN KEY (paquete) REFERENCES paquete(num)
);


