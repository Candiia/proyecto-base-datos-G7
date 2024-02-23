DROP TABLE IF EXISTS administrador, usuario, cliente, devolucion, venta, linea_devolucion, linea_venta, producto, categoria, variante, contiene CASCADE;


CREATE TABLE usuario(
	id_usuario		SERIAL,
	nombre 			VARCHAR(100) NOT NULL,
	apellidos 		VARCHAR(200),
	nombre_usuario 	VARCHAR(300)NOT NULL,
	contrasenia 	VARCHAR(200)NOT NULL,
	email			VARCHAR(200),
	CONSTRAINT pk_usuario PRIMARY KEY(id_usuario),
	CONSTRAINT ck_email_valido CHECK(email ILIKE '%@%')
);

CREATE TABLE cliente(
	id_cliente		INTEGER,
	telefono		VARCHAR(100),
	direccion 		VARCHAR(100),
	numero_tarjeta 	BIGINT,
	CONSTRAINT pk_cliente PRIMARY KEY(id_cliente)
);


CREATE TABLE administrador(
	id_admi		INTEGER NOT NULL,
	CONSTRAINT pk_administrador PRIMARY KEY (id_admi)
);

CREATE TABLE devolucion(
	id_devolucion	SERIAL,
	id_cliente		INT,
	fecha_devolucion DATE,
	CONSTRAINT pk_devolucion PRIMARY KEY(id_devolucion)
);

CREATE TABLE venta(
	id_venta	SERIAL,
	id_cliente	INT,
	fecha_venta DATE,
	importe_total NUMERIC(5,2),
	CONSTRAINT pk_venta PRIMARY KEY(id_venta),
	CONSTRAINT ck_importe_positivo CHECK(importe_total > 0)
);

CREATE TABLE linea_devolucion(
	cod_linea_devolucion	SERIAL,
	id_devolucion		INT,
	id_venta 			INT,
	cod_linea_venta 	INT,
	cantidad			INT,
	subtotal			NUMERIC,
	CONSTRAINT pk_linea_devolucion PRIMARY KEY(cod_linea_devolucion),
	CONSTRAINT ck_subtotal_positivo CHECK(subtotal > 0)
);

CREATE TABLE linea_venta(

	cod_linea_venta SERIAL,
	id_venta 		INTEGER,
	id_producto 	INTEGER NOT NULL,
	cantidad 		INTEGER NOT NULL,
	subtotal 		NUMERIC(5,2),
	CONSTRAINT pk_linea_venta PRIMARY KEY (cod_linea_venta, id_venta),
	CONSTRAINT ck_precio_positivo CHECK(subtotal > 0)
);


CREATE TABLE producto(

	id_producto 	SERIAL,
	id_categoria 	INTEGER,
	nombre 			VARCHAR(150) NOT NULL,
	descripcion 	VARCHAR(200),
	precio 			NUMERIC(5,2) NOT NULL,
	foto 			BYTEA,
	CONSTRAINT pk_producto PRIMARY KEY (id_producto),
	CONSTRAINT ck_precio_positivo CHECK( precio> 0)
);

CREATE TABLE categoria(
	id_categoria 	SERIAL,
	tipo_ropa 		VARCHAR (100),
	CONSTRAINT pk_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE variante(
	
	id_variante SERIAL,
	color VARCHAR(150),
	talla VARCHAR(10),
	stock INTEGER NOT NULL,
	material VARCHAR(150),
	CONSTRAINT pk_variante PRIMARY KEY (id_variante),
	CONSTRAINT ck_stock CHECK(stock > 0)
);

CREATE TABLE contiene(

	id_producto 	INTEGER,
	id_categoria 	INTEGER,
	CONSTRAINT pk_contiene PRIMARY KEY (id_producto, id_categoria)
);


ALTER TABLE administrador
	ADD CONSTRAINT fk_administrador_usuario 
		FOREIGN KEY (id_admi) REFERENCES usuario (id_usuario);

ALTER TABLE cliente
	ADD CONSTRAINT fk_cliente_usuario 
		FOREIGN KEY (id_cliente) REFERENCES usuario (id_usuario);


ALTER TABLE devolucion
	ADD CONSTRAINT fk_devolucion_cliente 
		FOREIGN KEY (id_cliente) REFERENCES cliente;

ALTER TABLE venta
	ADD CONSTRAINT fk_venta_cliente
		FOREIGN KEY (id_cliente) REFERENCES cliente;



ALTER TABLE linea_venta
	ADD CONSTRAINT fk_linea_venta_venta 
		FOREIGN KEY (id_venta) REFERENCES venta,
	ADD CONSTRAINT fk_liena_venta_producto 
		FOREIGN KEY (id_producto) REFERENCES producto(id_producto);
	
ALTER TABLE linea_devolucion
	ADD CONSTRAINT fk_linea_devolucion_devolucion 
		FOREIGN KEY (id_devolucion) REFERENCES devolucion,
	ADD CONSTRAINT fk_linea_devolucion_linea_venta 
		FOREIGN KEY (cod_linea_venta, id_venta) REFERENCES linea_venta;
		
ALTER TABLE producto
	ADD CONSTRAINT fk_producto_categoria 
		FOREIGN KEY (id_categoria) REFERENCES categoria;
		
ALTER TABLE contiene 
	ADD CONSTRAINT fk_contiene_producto 
		FOREIGN KEY (id_producto) REFERENCES producto,
	ADD CONSTRAINT fk_contiene_varinate 
		FOREIGN KEY (id_categoria) REFERENCES variante;
	
INSERT INTO usuario (id_usuario, nombre, apellidos, nombre_usuario, contrasenia, email) VALUES
(1, 'Marina', 'Hernández López', 'marinahl', 'marinapass', 'marinahl@gmail.com'),
(2, 'Adrián', 'García Martín', 'adriangm', 'adrianpass', 'adriangm@gmail.com'),
(3, 'Eva', 'Sánchez Martínez', 'evasm', 'evapass', 'evasm@gmail.com'),
(4, 'Sergio', 'Martínez López', 'sergioml', 'sergiopass', 'sergioml@gmail.com'),
(5, 'Isabel', 'Rodríguez Sánchez', 'isabelrs', 'isabelpass', 'isabelrs@gmail.com'),
(6, 'Alejandro', 'Gómez Martínez', 'alejandrogm', 'alejandropass', 'alejandrogm@gmail.com'),
(7, 'Cristina', 'Pérez Sánchez', 'cristinaps', 'cristinapass', 'cristinaps@gmail.com'),
(8, 'Daniel', 'Martín Rodríguez', 'danielmr', 'danielpass', 'danielmr@gmail.com'),
(9, 'Elena', 'Gómez López', 'elenagl', 'elenapass', 'elenagl@gmail.com'),
(10, 'Rubén', 'Sánchez Martínez', 'rubensm', 'rubenpass', 'rubensm@gmail.com'),
(11, 'Marta', 'López Rodríguez', 'martalr', 'martapass', 'martalr@gmail.com'),
(12, 'Óscar', 'García Sánchez', 'oscargs', 'oscarpass', 'oscargs@gmail.com'),
(13, 'Laura', 'Martínez García', 'lauramg', 'laurapass', 'lauramg@gmail.com'),
(14, 'Javier', 'Gómez Rodríguez', 'javiergr', 'javierpass', 'javiergr@gmail.com'),
(15, 'Carmen', 'Sánchez Martín', 'carmensm', 'carmenpass', 'carmensm@gmail.com'),
(16, 'Alba', 'García López', 'albagl', 'albapass', 'albagl@gmail.com'),
(17, 'Diego', 'Martínez Sánchez', 'diegomartinez', 'diegopass', 'diegomartinez@gmail.com'),
(18, 'Inés', 'López Martínez', 'ineslm', 'inespass', 'ineslm@gmail.com'),
(19, 'Pablo', 'Sánchez Rodríguez', 'pablosr', 'pablopas', 'pablosr@gmail.com'),
(20, 'Sara', 'García López', 'saragl', 'sarapass', 'saragl@gmail.com'),
(21, 'Iván', 'Martínez Rodríguez', 'ivanmr', 'ivanpass', 'ivanmr@gmail.com'),
(22, 'Nuria', 'Sánchez García', 'nuriasg', 'nuriapass', 'nuriasg@gmail.com'),
(23, 'Marcos', 'García Martínez', 'marcosgm', 'marcospass', 'marcosgm@gmail.com'),
(24, 'Lucía', 'Martínez López', 'luciaml', 'luciapass', 'luciaml@gmail.com'),
(25, 'Mario', 'Gómez Martínez', 'mariogm', 'mariopas', 'mariogm@gmail.com'),
(26, 'Elena', 'López García', 'elenalg', 'elenapass', 'elenalg@gmail.com'),
(27, 'Rubén', 'Sánchez López', 'rubensl', 'rubenpass', 'rubensl@gmail.com'),
(28, 'Ana', 'Martínez Rodríguez', 'anamr', 'anapass', 'anamr@gmail.com'),
(29, 'David', 'García Sánchez', 'davidgs', 'davidpass', 'davidgs@gmail.com'),
(30, 'Sofía', 'López Martínez', 'sofialm', 'sofiapass', 'sofialm@gmail.com'),
(31, 'Javier', 'Martínez Sánchez', 'javierms', 'javierpass', 'javierms@gmail.com'),
(32, 'Carmen', 'Gómez Rodríguez', 'carmengr', 'carmenpass', 'carmengr@gmail.com'),
(33, 'Pablo', 'Sánchez Martínez', 'pablosm', 'pablopas', 'pablosm@gmail.com'),
(34, 'Lucía', 'García Rodríguez', 'luciagr', 'luciapass', 'luciagr@gmail.com'),
(35, 'Alberto', 'Martínez López', 'albertoml', 'albertopass', 'albertoml@gmail.com'),
(36, 'María', 'Sánchez García', 'mariamsg', 'mariapass', 'mariamsg@gmail.com'),
(37, 'Marcos', 'García Sánchez', 'marcosgs', 'marcospass', 'marcosgs@gmail.com'),
(38, 'Laura', 'Martínez Rodríguez', 'lauramr', 'laurapass', 'lauramr@gmail.com'),
(39, 'Pedro', 'López Martínez', 'pedrolm', 'pedropass', 'pedrolm@gmail.com'),
(40, 'Sara', 'García López', 'saragl', 'sarapass', 'saragl@gmail.com'),
(41, 'Carlos', 'Martínez García', 'carlosmg', 'carlospass', 'carlosmg@gmail.com'),
(42, 'Ana', 'Sánchez Rodríguez', 'anasr', 'anapass', 'anasr@gmail.com'),
(43, 'Adrián', 'Gómez Martínez', 'adriangm', 'adrianpass', 'adriangm@gmail.com'),
(44, 'Elena', 'Martínez López', 'elenaml', 'elenapass', 'elenaml@gmail.com'),
(45, 'Daniel', 'García Sánchez', 'danielgs', 'danielpass', 'danielgs@gmail.com'),
(46, 'Marina', 'López Rodríguez', 'marinalr', 'marinapass', 'marinalr@gmail.com'),
(47, 'Sergio', 'Martínez García', 'sergiomg', 'sergiopass', 'sergiomg@gmail.com'),
(48, 'Nuria', 'García López', 'nuriagl', 'nuriapass', 'nuriagl@gmail.com'),
(49, 'Lucía', 'Martínez Rodríguez', 'luciamr', 'luciapass', 'luciamr@gmail.com'),
(50, 'Marcos', 'Gómez López', 'marcosgl', 'marcospass', 'marcosgl@gmail.com');

INSERT INTO cliente (id_cliente, telefono, direccion, numero_tarjeta) VALUES
(1, '601234567', 'Calle Gran Vía 123', 12345890),
(2, '602345678', 'Avenida Principal 456', 23678901),
(3, '603456789', 'Plaza Central 789', 34567012),
(4, '604567890', 'Calle Secundaria 321', 45690123),
(5, '605678901', 'Avenida Central 654', 56701230),
(6, '606789012', 'Plaza Pequeña 987', 67890345),
(7, '607890123', 'Calle Grande 159', 78901256),
(8, '608901234', 'Avenida Pequeña 357', 89012367),
(9, '609012345', 'Plaza Grande 753', 9014567),
(10, '610123456', 'Calle Larga 456', 12367890),
(11, '611234567', 'Calle Corta 123', 23458901),
(12, '612345678', 'Avenida Ancha 456', 34789012),
(13, '613456789', 'Plaza Estrecha 789', 47890123),
(14, '614567890', 'Calle Pequeña 321', 567892345),
(15, '615678901', 'Avenida Secundaria 654', 69012345),
(16, '616789012', 'Plaza Principal 987', 78923456),
(17, '617890123', 'Calle Grande 159', 89012567),
(18, '618901234', 'Avenida Larga 357', 9012567),
(19, '619012345', 'Plaza Central 753', 12345890),
(20, '620123456', 'Calle Corta 456', 23456701),
(21, '621234567', 'Avenida Ancha 789', 34569012),
(22, '622345678', 'Plaza Principal 123', 45890123),
(23, '623456789', 'Calle Larga 456', 56789034),
(24, '624567890', 'Avenida Corta 789', 67812345),
(25, '625678901', 'Plaza Pequeña 321', 78903456),
(26, '626789012', 'Calle Estrecha 654', 89034567),
(27, '627890123', 'Avenida Grande 987', 90123678),
(28, '628901234', 'Plaza Central 159', 12347890),
(29, '629012345', 'Calle Grande 753', 23456901),
(30, '630123456', 'Avenida Secundaria 456', 34569012),
(31, '631234567', 'Calle Estrecha 789', 4567890123),
(32, '632345678', 'Avenida Corta 123', 56789014),
(33, '633456789', 'Plaza Grande 456', 67890121),
(34, '634567890', 'Calle Larga 789', 78901232),
(35, '635678901', 'Avenida Ancha 321', 89012363),
(36, '636789012', 'Plaza Pequeña 654', 90123474),
(37, '637890123', 'Calle Principal 987', 12345696),
(38, '638901234', 'Avenida Central 159', 23456787),
(39, '639012345', 'Plaza Secundaria 753', 34567890),
(40, '640123456', 'Calle Grande 456', 45678907),
(41, '641234567', 'Avenida Principal 789', 56789078),
(42, '642345678', 'Plaza Corta 123', 67890789),
(43, '643456789', 'Calle Pequeña 456', 78907890),
(44, '644567890', 'Avenida Larga 789', 89078901),
(45, '645678901', 'Plaza Ancha 321', 90789014),
(46, '646789012', 'Calle Secundaria 654', 78901234),
(47, '647890123', 'Avenida Estrecha 987', 23456789),
(48, '648901234', 'Plaza Grande 159', 34567898),
(49, '649012345', 'Calle Larga 753', 45678907),
(50, '650123456', 'Avenida Principal 456', 5678907);

INSERT INTO administrador (id_admi) VALUES (1);

INSERT INTO devolucion (id_devolucion, id_cliente, fecha_devolucion) VALUES
(1, 1, '2023-01-05'),
(2, 5, '2023-01-10'),
(3, 15, '2023-01-15'),
(4, 18, '2023-01-20'),
(5, 6, '2023-01-25'),
(6, 23, '2023-01-30'),
(7, 2, '2023-02-05'),
(8, 8, '2023-02-10'),
(9, 16, '2023-02-15'),
(10, 15, '2023-02-20'),
(11, 46, '2023-02-25'),
(12, 50, '2023-03-05'),
(13, 29, '2023-03-10'),
(14, 3, '2023-03-15'),
(15, 4, '2023-03-20');

INSERT INTO venta (id_cliente, fecha_venta, importe_total) VALUES
(1, '2023-01-01', 100.50),
(2, '2023-01-02', 75.25),
(3, '2023-01-03', 120.75),
(4, '2023-01-04', 50.00),
(5, '2023-01-05', 200.00),
(6, '2023-01-06', 80.50),
(7, '2023-01-07', 150.25),
(8, '2023-01-08', 90.75),
(9, '2023-01-09', 180.00),
(10, '2023-01-10', 70.25),
(11, '2023-01-11', 110.75),
(12, '2023-01-12', 95.00),
(13, '2023-01-13', 160.00),
(14, '2023-01-14', 85.50),
(15, '2023-01-15', 130.25),
(16, '2023-01-16', 140.75),
(17, '2023-01-17', 100.00),
(18, '2023-01-18', 55.25),
(19, '2023-01-19', 75.75),
(20, '2023-01-20', 180.00),
(21, '2023-01-21', 65.25),
(22, '2023-01-22', 95.75),
(23, '2023-01-23', 200.00),
(24, '2023-01-24', 90.50),
(25, '2023-01-25', 120.25),
(26, '2023-01-26', 170.75),
(27, '2023-01-27', 110.00),
(28, '2023-01-28', 45.25),
(29, '2023-01-29', 80.75),
(30, '2023-01-30', 190.00),
(31, '2023-01-31', 75.25),
(32, '2023-02-01', 105.75),
(33, '2023-02-02', 140.00),
(34, '2023-02-03', 60.50),
(35, '2023-02-04', 95.25),
(36, '2023-02-05', 175.75),
(37, '2023-02-06', 120.00),
(38, '2023-02-07', 50.25),
(39, '2023-02-08', 85.75),
(40, '2023-02-09', 160.00),
(41, '2023-02-10', 70.25),
(42, '2023-02-11', 115.75),
(43, '2023-02-12', 145.00),
(44, '2023-02-13', 55.50),
(45, '2023-02-14', 85.25),
(46, '2023-02-15', 180.75),
(47, '2023-02-16', 130.00),
(48, '2023-02-17', 60.25),
(49, '2023-02-18', 95.75),
(50, '2023-02-19', 170.00);

INSERT INTO categoria (id_categoria, tipo_ropa) VALUES
(1, 'Camisetas'),
(2, 'Pantalones'),
(3, 'Sudaderas'),
(4, 'Vestidos'),
(5, 'Chaquetas'),
(6, 'Faldas'),
(7, 'Ropa interior'),
(8, 'Abrigos'),
(9, 'Ropa deportiva'),
(10, 'Trajes');

INSERT INTO producto (id_producto, id_categoria, nombre, descripcion, precio, foto) VALUES
(1, 1, 'Camiseta básica blanca', 'Camiseta de algodón unisex en color blanco', 15.99, NULL),
(2, 1, 'Camiseta estampada', 'Camiseta de manga corta con estampado de flores', 20.50, NULL),
(3,2, 'Pantalón vaquero azul', 'Pantalón vaquero unisex en tono azul claro', 39.99, NULL),
(4,2, 'Pantalón chino negro', 'Pantalón chino unisex en color negro', 29.95, NULL),
(5,3, 'Sudadera con capucha', 'Sudadera unisex con capucha y bolsillo canguro', 45.75, NULL),
(6,3, 'Sudadera deportiva', 'Sudadera de material transpirable para actividades deportivas', 34.99, NULL),
(7, 4, 'Vestido veraniego floral', 'Vestido de tirantes con estampado floral para el verano', 55.00, NULL),
(8, 4, 'Vestido de fiesta', 'Vestido largo de fiesta con detalles bordados', 120.00, NULL),
(9, 5, 'Chaqueta acolchada', 'Chaqueta unisex acolchada con capucha desmontable', 89.99, NULL),
(10, 5, 'Chaqueta de cuero', 'Chaqueta de cuero clásica con cierre de cremallera', 199.95, NULL),
(11, 6, 'Falda plisada', 'Falda corta plisada en color negro', 29.99, NULL),
(12, 6, 'Falda vaquera', 'Falda vaquera con cierre de botones en la parte delantera', 34.50, NULL),
(13, 7, 'Conjunto de ropa interior', 'Conjunto de sujetador y braguita de encaje', 25.00, NULL),
(14, 7, 'Pack de calzoncillos', 'Pack de 3 calzoncillos de algodón en colores surtidos', 15.95, NULL),
(15, 8, 'Abrigo de invierno', 'Abrigo acolchado para el invierno con cierre de botones', 79.99, NULL),
(16, 8, 'Chaleco acolchado', 'Chaleco acolchado unisex con cierre de cremallera', 49.95, NULL),
(17, 9, 'Leggings deportivos', 'Leggings deportivos de compresión para entrenamiento', 29.50, NULL),
(18, 9, 'Chándal completo', 'Conjunto de chándal de poliéster con chaqueta y pantalón', 55.00, NULL),
(19, 10, 'Traje de hombre', 'Traje de hombre entallado en color gris oscuro', 199.99, NULL),
(20, 10, 'Vestido de noche', 'Vestido largo de noche con escote en V y abertura lateral', 149.95, NULL),
(21, 1, 'Camiseta de manga larga', 'Camiseta de manga larga unisex en varios colores', 18.50, NULL),
(22, 2, 'Pantalón cargo', 'Pantalón cargo unisex con múltiples bolsillos', 42.75, NULL),
(23, 3, 'Sudadera sin capucha', 'Sudadera unisex de manga larga sin capucha', 39.99, NULL),
(24, 4, 'Vestido corto', 'Vestido corto con estampado geométrico y cuello redondo', 65.00, NULL),
(25, 5, 'Chaqueta vaquera', 'Chaqueta vaquera clásica con efecto desgastado', 59.95, NULL),
(26, 6, 'Falda larga', 'Falda larga de gasa con estampado de lunares', 44.99, NULL),
(27,7, 'Sujetador deportivo', 'Sujetador deportivo de alto impacto con tirantes ajustables', 29.95, NULL),
(28, 8, 'Parka impermeable', 'Parka unisex impermeable con capucha y forro de pelo sintético', 129.00, NULL),
(29, 9, 'Pantalón de yoga', 'Pantalón de yoga de cintura alta y tejido elástico', 32.50, NULL),
(30, 10, 'Smoking', 'Smoking de dos piezas en color negro para ocasiones formales', 249.99, NULL),
(31, 1, 'Top corto', 'Top corto de tirantes ajustables en varios colores', 12.99, NULL),
(32, 2, 'Pantalón corto', 'Pantalón corto deportivo con cintura elástica', 22.50, NULL),
(33, 3, 'Jersey de punto', 'Jersey de punto unisex con cuello redondo', 49.99, NULL),
(34, 4, 'Vestido de encaje', 'Vestido de encaje con escote en la espalda y falda de vuelo', 79.95, NULL),
(35, 5, 'Chaleco de pelo', 'Chaleco de pelo sintético con cierre de gancho y ojo', 79.99, NULL),
(36, 6, 'Falda midi', 'Falda midi plisada con estampado de lunares y cinturón a juego', 39.95, NULL),
(37, 7, 'Braguitas de algodón', 'Pack de 5 braguitas de algodón en colores básicos', 18.99, NULL),
(38, 8, 'Cazadora bomber', 'Cazadora bomber unisex con estampado de camuflaje', 89.50, NULL),
(39, 9, 'Leggings estampados', 'Leggings deportivos estampados con cintura alta', 27.75, NULL),
(40, 10, 'Vestido largo de gala', 'Vestido largo de gala con escote halter y pedrería en la cintura', 299.00, NULL);


INSERT INTO linea_venta (cod_linea_venta, id_venta, id_producto, cantidad, subtotal) VALUES
(1, 1, 2, 50.00, 100.00),
(2, 2, 4, 25.00, 100.00),
(3, 3, 6, 1, 80.50),
(4, 4, 8, 3, 272.25),
(5, 5, 10, 2, 140.50),
(6, 6, 12, 1, 95.00),
(7, 7, 14, 4, 342.00),
(8, 8, 16, 2, 281.50),
(9, 9, 18, 3, 156.75),
(10, 10, 20, 1, 70.25),
(11, 11, 22, 5, 308.75),
(12, 12, 24, 2, 180.50),
(13, 13, 26, 1, 170.75),
(14, 14, 28, 4, 181.00),
(15, 15, 30, 3, 570.00),
(16, 16, 32, 1, 140.75),
(17, 17, 34, 2, 191.50),
(18, 18, 36, 3, 527.25),
(19, 19, 38, 1, 85.75),
(20, 20, 40, 2, 320.00);

INSERT INTO variante (color, talla, stock, material) VALUES
('Negro', 'S', 50, 'Algodón'),
('Negro', 'M', 40, 'Algodón'),
('Negro', 'L', 30, 'Algodón'),
('Negro', 'XL', 20, 'Algodón'),
('Blanco', 'S', 60, 'Algodón'),
('Blanco', 'M', 55, 'Algodón'),
('Blanco', 'L', 45, 'Algodón'),
('Blanco', 'XL', 35, 'Algodón'),
('Azul', 'S', 45, 'Algodón'),
('Azul', 'M', 35, 'Algodón'),
('Azul', 'L', 25, 'Algodón'),
('Azul', 'XL', 20, 'Algodón'),
('Rojo', 'S', 30, 'Algodón'),
('Rojo', 'M', 25, 'Algodón'),
('Rojo', 'L', 20, 'Algodón'),
('Rojo', 'XL', 15, 'Algodón'),
('Verde', 'S', 35, 'Algodón'),
('Verde', 'M', 30, 'Algodón'),
('Verde', 'L', 25, 'Algodón'),
('Verde', 'XL', 20, 'Algodón');


INSERT INTO contiene (id_producto, id_categoria) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 2),
(8, 3),
(9, 4),
(10, 5),
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 1),
(17, 2),
(18, 3),
(19, 4),
(20, 5);


INSERT INTO linea_devolucion (id_devolucion, id_venta, cod_linea_venta, cantidad, subtotal) VALUES
(1, 5, 5, 2, 50.00),
(1, 5, 5, 1, 25.00),
(2, 15, 15, 3, 75.75),
(3, 18, 18, 1, 55.25),
(4, 6, 6, 2, 35.50),
(6, 2, 2, 3, 105.75),
(7, 8, 8, 1, 90.75),
(8, 16, 16, 2, 70.50),
(9, 15, 15, 1, 130.25),
(13, 3, 3, 2, 140.50),
(14, 4, 4, 1, 50.00);

