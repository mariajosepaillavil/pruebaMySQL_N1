CREATE SCHEMA MinimarketDeJose;
USE MinimarketDeJose; # PARA INDICAR QUE SE HACE REFERENCIA AL ESQUEMA MinimarketDeJose, RECIEN CREADO. 

CREATE TABLE Productos( #LA TABLA PRODUCTOS, ES LA BASE Y POR LO TANTO, NO TIENE FOREIGN KEY ASOCIADA.
productos_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreProducto VARCHAR (25),
descripcion VARCHAR (100),
precio DECIMAL(10,2)

); 

CREATE TABLE categorias ( 
categorias_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreCategorias VARCHAR (50)

);


CREATE TABLE Proveedores ( 
proveedores_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
nombreProveedor VARCHAR (50),
email VARCHAR (40),
fonoContacto VARCHAR (20),
direccion VARCHAR (100)

);

CREATE TABLE Abastecimientos ( 
abastecimientos_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
tipoProveedor VARCHAR(7) #PREMIUM,REGULAR,LOWCOST

);


CREATE TABLE Ventas (
    ventas_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fechaTransaccion DATE,
    cantidad INTEGER
   
);

#---------------------------------------------------------------------------------------------------------

# AGREGA UNA COLUMNA A UNA DE LAS TABLAS (DIFERENTES A LA TABLA BASE USUARIOS).

ALTER TABLE productos ADD categorias_id INTEGER NOT NULL;

ALTER TABLE productos
ADD FOREIGN KEY (categorias_id) REFERENCES categorias(categorias_id);

#AHORA QUE YA TENEMOS TODAS LAS TABLITAS, PASAMOS A ALTERARLAS E INCORPORAR LAS RESPECTIVAS FOREIGN KEY FALTANTES.

ALTER TABLE abastecimientos ADD productos_id INTEGER NOT NULL;

ALTER TABLE abastecimientos
ADD FOREIGN KEY (productos_id) REFERENCES productos(productos_id);


#---------------------------------------------------------------------------------------------------------

#AHORA REPETIR CON DEMÁS TABLAS

ALTER TABLE abastecimientos ADD ventas_id INTEGER NOT NULL;

ALTER TABLE abastecimientos
ADD FOREIGN KEY (ventas_id) REFERENCES ventas(ventas_id);

#---------------------------------------------------------------------------------------------------------

ALTER TABLE abastecimientos ADD proveedores_id INTEGER NOT NULL;

ALTER TABLE abastecimientos
ADD FOREIGN KEY (proveedores_id) REFERENCES proveedores(proveedores_id);

#---------------------------------------------------------------------------------------------------------

ALTER TABLE proveedores ADD categorias_id INTEGER NOT NULL;

ALTER TABLE proveedores
ADD FOREIGN KEY (categorias_id) REFERENCES categorias(categorias_id);

INSERT INTO categorias (nombreCategorias) VALUES
    ('Alimentos'),
    ('Bebidas'),
	('Mascotas'),
    ('Artículos de fiesta'),
    ('Artículos de aseo')
    ;

INSERT INTO productos (nombreProducto,descripcion,precio,categorias_id) VALUES
    ('Arroz','1 kg de arroz BANQUETE pregraneado grano largo blanco',1500.00, 1),
    ('Leche','1 litro de leche descremada SOPROLE sin lactosa sabor chocolate',1190.00,2),
    ('Alimento mascota','1 kg de alimento a granel PEDIGREE adulto raza mediano',3150.00,3),
    ('Piñata','Piñata mediana con motivo Paw Patrol',2500.00,4),
    ('Detergente','800 ml de detergente Ariel liquido concentrado',3890.00,5);
    
INSERT INTO Proveedores (nombreProveedor,email,fonoContacto,direccion,categorias_id) VALUES
    ('Distribuidora Oasis','distribuidora.oasis@gmail.com','+56959597712','Av. Padre Hurtado 741, San Bernardo',1),
    ('Distribuidora a la Orden','distribuidora.ala.orden@gmail.com','+5699989665','Calle Baquedano Flores 456, Santiago Centro',2),
    ('Distribuidora Salvador','distribuidora.salvador@gmail.com','+56944455877','Calle Salvador 780, Providencia',3),
    ('Distribuidora La familia','distribuidora.lafamilia@gmail.com','+56977888911','Calle Pio Nono 180, Providencia',4),
	('Distribuidora Alegría','distribuidora.alegria@gmail.com','+56959887744','Calle Gran Avenida 155, El Bosque',5);
    

INSERT INTO Ventas (fechaTransaccion,cantidad) VALUES
    ('2023-03-14',20),
    ('2023-02-14',40),
	('2023-01-14',80),
	('2023-03-14',20),
    ('2023-03-14',20),
	('2023-01-14',100),
	('2023-01-14',20),
	('2023-03-14',120),
    ('2023-03-14',20);
    
INSERT INTO abastecimientos (tipoProveedor,productos_id,ventas_id,proveedores_id) VALUES
    ('Premium',1,1,1),
    ('Regular',2,2,2),
	('Premium',3,3,3),
    ('Lowcost',4,4,4),
    ('Premium',5,5,5)
    ;

#---------------------------------------------------------------------------------------------------------


#INTENTAR 2 CONSULTAS BÁSICAS

SELECT * FROM categorias;
SELECT * FROM productos;
SELECT * FROM proveedores;
SELECT * FROM ventas;
SELECT * FROM abastecimientos;


SELECT nombreProveedor,fonoContacto FROM proveedores
WHERE proveedores_id=1;

#---------------------------------------------------------------------------------------------------------

#INTENTAR CONSULTA MEDIANTE JOIN

SELECT categorias.nombreCategorias,proveedores.nombreProveedor FROM categorias JOIN proveedores ON (categorias.categorias_id=proveedores.categorias_id);

#------------------------------------------------------------------------------------------------------------------------------------------------
#INFORME SOBRE GANANCIAS ANUALES:

SELECT nombreProducto, descripcion,cantidad, precio, (cantidad * precio) AS totalGananciasAnuales
FROM abastecimientos a
JOIN ventas v ON a.ventas_id = v.ventas_id
JOIN productos p ON a.productos_id = p.productos_id;
#------------------------------------------------------------------------------------------------------------------------------------------------
#INFORME SOBRE VENTAS ANUALES:

SELECT p.nombreProducto,p.categorias_id, a.tipoProveedor,SUM(v.cantidad) AS totalProductosVendidosAnualmente
FROM abastecimientos a
JOIN ventas v ON a.ventas_id = v.ventas_id
JOIN productos p ON a.productos_id = p.productos_id
GROUP BY p.nombreProducto,p.categorias_id,a.tipoProveedor;

#------------------------------------------------------------------------------------------------------------------------------------------------

DROP DATABASE minimarketDeJose; #PARA REINICIAR