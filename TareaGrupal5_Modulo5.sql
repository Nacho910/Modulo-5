USE relacional5_grupal;
SELECT CURRENT_TIMESTAMP;
SELECT CURDATE();
-- ******************************************************************************************
-- Parte 2: Crear dos tablas
CREATE TABLE usuarios (
    id_usuario INT NOT NULL,
    nombre VARCHAR(50),
	apellido VARCHAR(50),
	contrasena VARCHAR(20),
	zona_horaria_utc TIMESTAMP(6),
	genero VARCHAR(2),
	telefono VARCHAR(20),
    PRIMARY KEY (id_usuario)
);
CREATE TABLE ingresos (
    id_ingreso INT NOT NULL,
    id_usuario INT NOT NULL,
    fecha DATETIME(6),
    PRIMARY KEY (id_ingreso)
);
-- Para seleccionar la fecha y hora actual en UTC:
SELECT UTC_TIMESTAMP();
SELECT UTC_TIMESTAMP;
SELECT CONVERT_TZ(NOW(), @@session.time_zone, '+00:00');

-- Para seleccionar la fecha y hora actual en la zona horaria de la sesión
SELECT NOW();
SELECT CURRENT_TIMESTAMP;
SELECT CURRENT_TIMESTAMP();
-- ******************************************************************************************
-- Parte 3: Modificación de la tabla
ALTER TABLE usuarios CHANGE COLUMN zona_horaria_utc zona_horaria_normal DATETIME(6);
-- ******************************************************************************************
-- Parte 4: Creación de registros.
INSERT INTO usuarios (id_usuario, nombre, apellido, contrasena, zona_horaria_utc, genero, telefono)
VALUES
('1', 'Pedro', 'Picapiedra', '1234', '2022-04-02', 'M', '991425857'),
('2', 'Pablo', 'Marcol', '2234', '2022-04-02', 'M', '991425452' ),
('3', 'Juan', 'Rojas', '3234', '2022-04-02', 'M', '991425487'),
('4', 'Diego', 'Ramirez', '4234', '2022-04-02', 'M', '991425996' ),
('5', 'Marta', 'Suarez', '5234', '2022-04-02', 'F', '991425445'),
('6', 'Jessica', 'Tolosa', '6234', '2022-04-02', 'F', '991425884' ),
('7', 'Laura', 'Mendez', '7234', '2022-04-02', 'F', '991425765'),
('8', 'Cecilia', 'Romero', '8234', '2022-04-02', 'F', '991425332' );

INSERT INTO ingresos (id_ingreso, id_usuario, fecha)
VALUES
('1', '1', '2022-04-02'),
('2', '2', '2022-04-02'),
('3', '3', '2022-04-02'),
('4', '4', '2022-04-02'),
('5', '5', '2022-04-02'),
('6', '6', '2022-04-02'),
('7', '7', '2022-04-02'),
('8', '8', '2022-04-02');

select * from usuarios;
select * from ingresos;
-- ******************************************************************************************
-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?
-- RESP :lo optimo seria usar en ambos caso el dato normal de cada pais 

-- ******************************************************************************************
-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, numero de telefono, correo electronico).
CREATE TABLE contactos (
    id_contacto INT NOT NULL,
    id_usuario INT NOT NULL,
	telefono VARCHAR(20),
	PRIMARY KEY (id_contacto)
);

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.
ALTER TABLE contactos ADD id_union INT NOT NULL;
ALTER TABLE contactos
ADD CONSTRAINT con_usu  
FOREIGN KEY (id_union) 
REFERENCES usuarios(id_usuario)  
ON DELETE CASCADE ON UPDATE CASCADE;
