BEGIN TRANSACTION
USE [GD1C2024]
GO
CREATE SCHEMA FURIOUS_QUERYING
GO
--===================================================TABLAS=================================================================== 
CREATE TABLE FURIOUS_QUERYING.CLIENTE(
id DECIMAL(18,0) primary key not null identity(1,1),
dni DECIMAL(18,0) not null,
nombre VARCHAR(255) not null,
apellido VARCHAR(255) not null,
domicilio VARCHAR(255) not null,
fecha_registro DATETIME not null,
telefono DECIMAL(18,0) not null,
mail VARCHAR(255) not null,
fecha_nacimiento DATE not null,
localidad_id DECIMAL(18,0) not null,
provincia_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.PAGO(
numero DECIMAL(18,0) primary key not null identity(1,1),
fecha_y_hora DATETIME not null,
detalle_pago_id DECIMAL(18,0) not null,
medio_de_pago_codigo DECIMAL(18,0) not null,
ticket_numero DECIMAL(18,0) not null,
importe DECIMAL(18,0) not null,
descuento_aplicado DECIMAL(18,0) null,
descuento_codigo DECIMAL(18,0) null
)

CREATE TABLE FURIOUS_QUERYING.DETALLE_PAGO(
id DECIMAL(18,0) primary key not null identity(1,1),
cliente_id DECIMAL(18,0) not null,
tarjeta_numero VARCHAR(50) not null,
cuotas DECIMAL (18,0) null
)

CREATE TABLE FURIOUS_QUERYING.TARJETA(
numero VARCHAR(50) primary key not null, 
fecha_vencimiento DATETIME not null
)

CREATE TABLE FURIOUS_QUERYING.MEDIO_DE_PAGO(
codigo DECIMAL(18,0) primary key not null identity(1,1),
descripcion VARCHAR(255) not null,
tipo_medio_de_pago_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO(
id DECIMAL(18,0) primary key not null identity(1,1),
tipo VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO( 
medio_de_pago_codigo DECIMAL(18,0) not null,
descuento_codigo DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.DESCUENTO(
codigo DECIMAL(18,0) primary key not null,
descripcion VARCHAR(255),
fecha_inicio DATETIME not null,
fecha_fin DATETIME not null,
porcentaje_descuento DECIMAL(18,0) not null,
tope DECIMAL(18,0) null
)

CREATE TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO(
pago_numero DECIMAL(18,0) not null,
descuento_codigo DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.TICKET(
numero DECIMAL(18,0) primary key not null,
fecha_y_hora DATETIME not null,
subtotal_productos DECIMAL(18,2) not null,
descuento_promociones_total DECIMAL(18,2) null,
descuento_medio_de_pago_total DECIMAL(18,2) null,
total_envio DECIMAL(18,2) null,
total DECIMAL(18,2) not null,
sucursal_nombre VARCHAR(255) not null,
caja_numero DECIMAL(18,0) not null,
empleado_id DECIMAL(18,0) not null,
tipo_comprobante_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.TIPO_COMPROBANTE(
id DECIMAL(18,0) primary key not null identity(1,1),
tipo_comprobante VARCHAR(255) not null,
)


CREATE TABLE FURIOUS_QUERYING.ENVIO(
numero DECIMAL(18,0) not null identity(1,1),
fecha_programada DATETIME not null,
fecha_entrega DATETIME not null,
hora_inicio_programada DECIMAL(18,0) not null,
hora_fin_programada DECIMAL(18,0) not null,
costo DECIMAL(18,0) not null,
estado_envio_id DECIMAL(18,0) not null,
ticket_numero DECIMAL(18,0) not null,
cliente_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.ESTADO_ENVIO(
id DECIMAL(18,0) primary key not null identity(1,1),
estado VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.ITEM(
producto_id DECIMAL(18,0) not null,
ticket_numero DECIMAL(18,0) not null,
cantidad DECIMAL(18,0),
precio_unitario DECIMAL(18,2)
)

CREATE TABLE FURIOUS_QUERYING.ITEM_X_PROMOCION(
codigo_promocion DECIMAL(18,0) not null,
producto_id DECIMAL(18,0) not null,
ticket_numero DECIMAL(18,0) not null,
promo_aplicada_descuento DECIMAL(18,2)
)


CREATE TABLE FURIOUS_QUERYING.SUCURSAL(
nombre VARCHAR(255) primary key not null,
direccion VARCHAR(255) not null,
localidad_id DECIMAL(18,0),
supermercado_id VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.CAJA(
numero DECIMAL(18,0) primary key not null,
tipo_caja_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.TIPO_CAJA(
id DECIMAL(18,0) primary key not null identity(1,1),
tipo VARCHAR (255)
)

CREATE TABLE FURIOUS_QUERYING.EMPLEADO(
id DECIMAL(18,0) primary key not null identity(1,1),
dni DECIMAL(18,0) not null,
nombre VARCHAR(255) not null,
apellido VARCHAR(255) not null,
fecha_registro DATETIME not null,
telefono DECIMAL(18,0) not null,
mail VARCHAR(255) not null,
fecha_nacimiento DATE not null,
sucursal_nombre VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.PRODUCTO(
id DECIMAL(18,0) primary key not null identity(1,1), 
nombre VARCHAR(255) not null,
descripcion VARCHAR(255) not null,
precio_unitario DECIMAL(18,0) not null,
marca_id DECIMAL(18,0) not null,
subcategoria_id VARCHAR(255) not null,
categoria_id VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.MARCA(
id DECIMAL(18,0) primary key not null identity(1,1),
marca VARCHAR(255)
)

CREATE TABLE FURIOUS_QUERYING.SUBCATEGORIA(
id VARCHAR(255) not null,
categoria_id VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.CATEGORIA(
id VARCHAR(255) primary key not null
)

CREATE TABLE FURIOUS_QUERYING.PROVINCIA(
id DECIMAL(18,0) primary key not null identity(1,1),
provincia VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.LOCALIDAD(
id DECIMAL(18,0) primary key not null identity(1,1),
localidad VARCHAR(255) not null,
provincia_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.SET_DE_REGLAS(
id DECIMAL(18,0) primary key not null identity(1,1),
descripcion VARCHAR(255) not null,
porcentaje_descuento_a_aplicar DECIMAL(18,2) not null,
cantidad_aplicable_regla DECIMAL(18,0) not null,
cantidad_a_aplicar_descuento DECIMAL(18,0) not null,
cantidad_maxima_productos DECIMAL(18,0) not null,
aplica_misma_marca DECIMAL(18,0) not null,
aplica_mismo_producto DECIMAL(18,0)
)

CREATE TABLE FURIOUS_QUERYING.PROMOCION(
codigo DECIMAL(18,0) primary key not null,
descripcion VARCHAR(255) not null,
fecha_inicio DATETIME not null,
fecha_fin DATETIME not null,
regla_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION(
promocion_codigo DECIMAL(18,0) not null,
producto_id DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.SUPERMERCADO(
cuit VARCHAR(255) primary key not null,
nombre VARCHAR(255) not null,
razon_social VARCHAR(255) not null,
ingresos_brutos VARCHAR(255) not null,
domicilio VARCHAR(255) not null,
fecha_inicio_actividad DATETIME not null,
condicion_fiscal VARCHAR(255) not null,
localidad_id DECIMAL(18,0) not null,
provincia_id DECIMAL(18,0) not null
)
--===================================================PRIMARY KEYS============================================================= 
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO add constraint pk_descuento_por_medio_de_pago primary key (medio_de_pago_codigo,descuento_codigo) 
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO add constraint pk_descuento_por_pago primary key (pago_numero,descuento_codigo) 
ALTER TABLE FURIOUS_QUERYING.ITEM add constraint pk_item primary key (producto_id,ticket_numero) 
ALTER TABLE FURIOUS_QUERYING.ITEM_X_PROMOCION add constraint pk_item_x_promocion primary key (producto_id,ticket_numero,codigo_promocion) 
ALTER TABLE FURIOUS_QUERYING.SUBCATEGORIA add constraint pk_subcategoria primary key (id,categoria_id) 
--===================================================FOREIGN KEYS=============================================================
ALTER TABLE FURIOUS_QUERYING.CLIENTE add constraint fk_provincia_por_cliente foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)
ALTER TABLE FURIOUS_QUERYING.CLIENTE add constraint fk_localidad_por_cliente foreign key (localidad_id) references FURIOUS_QUERYING.LOCALIDAD (id)

ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_detalle_pago foreign key (detalle_pago_id) references FURIOUS_QUERYING.DETALLE_PAGO (id)
ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_medio_de_pago foreign key (medio_de_pago_codigo) references FURIOUS_QUERYING.MEDIO_DE_PAGO (codigo)
ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_ticket foreign key (ticket_numero) references FURIOUS_QUERYING.TICKET (numero)


ALTER TABLE FURIOUS_QUERYING.DETALLE_PAGO add constraint fk_cliente_id_por_detalle_pago foreign key (cliente_id) references FURIOUS_QUERYING.CLIENTE (id)
ALTER TABLE FURIOUS_QUERYING.DETALLE_PAGO add constraint fk_tarjeta_numero foreign key (tarjeta_numero) references FURIOUS_QUERYING.TARJETA (numero)

ALTER TABLE FURIOUS_QUERYING.MEDIO_DE_PAGO add constraint fk_tipo_medio_de_pago_id foreign key (tipo_medio_de_pago_id) references FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO (id)

ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO add constraint fk_medio_de_pago_codigo foreign key (medio_de_pago_codigo) references FURIOUS_QUERYING.MEDIO_DE_PAGO (codigo)
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO add constraint fk_descuento_codigo_por_medio_de_pago foreign key (descuento_codigo) references FURIOUS_QUERYING.DESCUENTO (codigo)

ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO add constraint fk_pago_numero foreign key (pago_numero) references FURIOUS_QUERYING.PAGO (numero)
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO add constraint fk_descuento_codigo_por_pago foreign key (descuento_codigo) references FURIOUS_QUERYING.DESCUENTO (codigo)

ALTER TABLE FURIOUS_QUERYING.TICKET add constraint fk_sucursal_nombre_por_ticket foreign key (sucursal_nombre) references FURIOUS_QUERYING.SUCURSAL (nombre)
ALTER TABLE FURIOUS_QUERYING.TICKET add constraint fk_caja_numero foreign key (caja_numero) references FURIOUS_QUERYING.CAJA (numero)
ALTER TABLE FURIOUS_QUERYING.TICKET add constraint fk_empleado_id foreign key (empleado_id) references FURIOUS_QUERYING.EMPLEADO (id)
ALTER TABLE FURIOUS_QUERYING.TICKET add constraint fk_tipo_comprobante_id foreign key (tipo_comprobante_id) references FURIOUS_QUERYING.TIPO_COMPROBANTE (id)

ALTER TABLE FURIOUS_QUERYING.ENVIO add constraint fk_estado_envio_id foreign key (estado_envio_id) references FURIOUS_QUERYING.ESTADO_ENVIO (id)
ALTER TABLE FURIOUS_QUERYING.ENVIO add constraint fk_ticket_numero_por_envio foreign key (ticket_numero) references FURIOUS_QUERYING.TICKET (numero)
ALTER TABLE FURIOUS_QUERYING.ENVIO add constraint fk_cliente_id_por_envio foreign key (cliente_id) references FURIOUS_QUERYING.CLIENTE (id)

ALTER TABLE FURIOUS_QUERYING.ITEM add constraint fk_producto_id_por_item foreign key (producto_id) references FURIOUS_QUERYING.PRODUCTO (id)
ALTER TABLE FURIOUS_QUERYING.ITEM add constraint fk_ticket_numero_por_item foreign key (ticket_numero) references FURIOUS_QUERYING.TICKET (numero)

ALTER TABLE FURIOUS_QUERYING.ITEM_X_PROMOCION add constraint fk_codigo_promocion foreign key (codigo_promocion) references FURIOUS_QUERYING.PROMOCION (codigo)
ALTER TABLE FURIOUS_QUERYING.ITEM_X_PROMOCION add constraint fk_item foreign key (producto_id,ticket_numero) references FURIOUS_QUERYING.ITEM (producto_id,ticket_numero)

ALTER TABLE FURIOUS_QUERYING.SUCURSAL add constraint fk_localidad_id_por_sucursal foreign key (localidad_id) references FURIOUS_QUERYING.LOCALIDAD (id)
ALTER TABLE FURIOUS_QUERYING.SUCURSAL add constraint fk_supermercado_id foreign key (supermercado_id) references FURIOUS_QUERYING.SUPERMERCADO (cuit)

ALTER TABLE FURIOUS_QUERYING.CAJA add constraint fk_tipo_caja_id foreign key (tipo_caja_id) references FURIOUS_QUERYING.TIPO_CAJA (id)

ALTER TABLE FURIOUS_QUERYING.EMPLEADO add constraint fk_sucursal_nombre_por_empleado foreign key (sucursal_nombre) references FURIOUS_QUERYING.SUCURSAL (nombre)

ALTER TABLE FURIOUS_QUERYING.PRODUCTO add constraint fk_marca_id foreign key (marca_id) references FURIOUS_QUERYING.MARCA (id)
ALTER TABLE FURIOUS_QUERYING.PRODUCTO add constraint fk_subcategoria_id foreign key (subcategoria_id,categoria_id) references FURIOUS_QUERYING.SUBCATEGORIA (id,categoria_id)


ALTER TABLE FURIOUS_QUERYING.SUBCATEGORIA add constraint fk_categoria_id foreign key (categoria_id) references FURIOUS_QUERYING.CATEGORIA (id)

ALTER TABLE FURIOUS_QUERYING.LOCALIDAD add constraint fk_provincia_id_por_localidad foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)

ALTER TABLE FURIOUS_QUERYING.PROMOCION add constraint fk_regla_id foreign key (regla_id) references FURIOUS_QUERYING.SET_DE_REGLAS (id)

ALTER TABLE FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION add constraint fk_promocion_codigo foreign key (promocion_codigo) references FURIOUS_QUERYING.PROMOCION (codigo)
ALTER TABLE FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION add constraint fk_producto_id_por_producto_con_promocion foreign key (producto_id) references FURIOUS_QUERYING.PRODUCTO (id)

ALTER TABLE FURIOUS_QUERYING.SUPERMERCADO add constraint fk_localidad_id_por_supermercado foreign key (localidad_id) references FURIOUS_QUERYING.LOCALIDAD (id)
ALTER TABLE FURIOUS_QUERYING.SUPERMERCADO add constraint fk_provincia_id_por_supermercado foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)
--===================================================STORED PROCEDURES============================================================= 
GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_PROVINCIA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.PROVINCIA(provincia) SELECT DISTINCT provincia FROM(
SELECT cliente_provincia AS provincia FROM gd_esquema.Maestra where cliente_provincia IS NOT NULL
UNION
SELECT sucursal_provincia AS provincia FROM gd_esquema.Maestra where sucursal_provincia IS NOT NULL
UNION
SELECT super_provincia AS provincia FROM gd_esquema.Maestra where super_provincia IS NOT NULL
) AS provincias                                                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_LOCALIDAD
AS BEGIN
INSERT INTO FURIOUS_QUERYING.LOCALIDAD(localidad,provincia_id) SELECT DISTINCT localidad,provincia FROM(
SELECT cliente_localidad AS localidad , p.id AS provincia FROM gd_esquema.Maestra m
JOIN FURIOUS_QUERYING.PROVINCIA p on  cliente_provincia = p.provincia where cliente_localidad IS NOT NULL
UNION
SELECT sucursal_localidad AS localidad,p.id AS provincia  FROM gd_esquema.Maestra m 
JOIN FURIOUS_QUERYING.PROVINCIA p on  sucursal_provincia = p.provincia where sucursal_localidad IS NOT NULL
UNION
SELECT super_localidad AS localidad, p.id AS provincia  FROM gd_esquema.Maestra m
JOIN FURIOUS_QUERYING.PROVINCIA p on  super_provincia = p.provincia where super_localidad IS NOT NULL
) AS localidades
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TARJETA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.TARJETA(numero,fecha_vencimiento) SELECT DISTINCT PAGO_TARJETA_NRO, PAGO_TARJETA_FECHA_VENC 
                                                                FROM gd_esquema.Maestra WHERE PAGO_TARJETA_NRO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TIPO_COMPROBANTE
AS BEGIN
INSERT INTO FURIOUS_QUERYING.TIPO_COMPROBANTE(tipo_comprobante) SELECT DISTINCT TICKET_TIPO_COMPROBANTE 
                                                                FROM gd_esquema.Maestra WHERE TICKET_TIPO_COMPROBANTE IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TIPO_MEDIO_DE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO(tipo) SELECT DISTINCT PAGO_TIPO_MEDIO_PAGO 
                                                        FROM gd_esquema.Maestra WHERE PAGO_TIPO_MEDIO_PAGO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_CATEGORIA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.CATEGORIA(id) SELECT DISTINCT PRODUCTO_CATEGORIA 
                                            FROM gd_esquema.Maestra WHERE PRODUCTO_CATEGORIA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_SUBCATEGORIA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.SUBCATEGORIA (id,categoria_id) SELECT DISTINCT PRODUCTO_SUB_CATEGORIA, PRODUCTO_CATEGORIA 
                                                            FROM gd_esquema.Maestra WHERE PRODUCTO_SUB_CATEGORIA IS NOT NULL AND PRODUCTO_CATEGORIA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_MARCA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.MARCA(marca) SELECT DISTINCT PRODUCTO_MARCA FROM gd_esquema.Maestra WHERE PRODUCTO_MARCA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_SET_DE_REGLAS
AS BEGIN
INSERT INTO FURIOUS_QUERYING.SET_DE_REGLAS(descripcion,porcentaje_descuento_a_aplicar,cantidad_aplicable_regla,cantidad_a_aplicar_descuento,cantidad_maxima_productos,aplica_misma_marca,aplica_mismo_producto) 
                            SELECT DISTINCT REGLA_DESCRIPCION,REGLA_DESCUENTO_APLICABLE_PROD,REGLA_CANT_APLICABLE_REGLA,REGLA_CANT_APLICA_DESCUENTO,REGLA_CANT_MAX_PROD,REGLA_APLICA_MISMA_MARCA,REGLA_APLICA_MISMO_PROD
                            FROM gd_esquema.Maestra 
                            WHERE REGLA_DESCRIPCION IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_PROMOCION
AS BEGIN
INSERT INTO FURIOUS_QUERYING.PROMOCION(codigo, descripcion, fecha_inicio, fecha_fin, regla_id)
                            SELECT DISTINCT PROMO_CODIGO,PROMOCION_DESCRIPCION, PROMOCION_FECHA_INICIO, PROMOCION_FECHA_FIN, r.id
                            FROM gd_esquema.Maestra 
                            JOIN FURIOUS_QUERYING.SET_DE_REGLAS r ON r.descripcion = REGLA_DESCRIPCION
                            WHERE PROMO_CODIGO IS NOT NULL
END
  
GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_PRODUCTO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.PRODUCTO(nombre, descripcion, precio_unitario, marca_id, subcategoria_id, categoria_id)
                            SELECT DISTINCT PRODUCTO_NOMBRE,PRODUCTO_DESCRIPCION,PRODUCTO_PRECIO,m.id,s.id,s.categoria_id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MARCA m on m.marca=PRODUCTO_MARCA
                            JOIN FURIOUS_QUERYING.SUBCATEGORIA s on s.id=PRODUCTO_SUB_CATEGORIA AND s.categoria_id=PRODUCTO_CATEGORIA 
                            WHERE PRODUCTO_DESCRIPCION IS NOT NULL
END


GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_PRODUCTO_CON_PROMOCION
AS BEGIN
INSERT INTO FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION(promocion_codigo, producto_id)
                            SELECT DISTINCT PROMO_CODIGO, p.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MARCA m ON m.marca = PRODUCTO_MARCA 
                            JOIN FURIOUS_QUERYING.PRODUCTO p ON p.nombre = PRODUCTO_NOMBRE AND p.marca_id= m.id AND p.subcategoria_id =PRODUCTO_SUB_CATEGORIA AND p.categoria_id= PRODUCTO_CATEGORIA
                            WHERE PROMO_CODIGO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_CLIENTE
AS BEGIN
INSERT INTO FURIOUS_QUERYING.CLIENTE(dni, nombre, apellido, domicilio, fecha_registro, telefono, mail, fecha_nacimiento, localidad_id, provincia_id)
                            SELECT DISTINCT CLIENTE_DNI, CLIENTE_NOMBRE,CLIENTE_APELLIDO, CLIENTE_DOMICILIO,CLIENTE_FECHA_REGISTRO, CLIENTE_TELEFONO,
                            CLIENTE_MAIL, CLIENTE_FECHA_NACIMIENTO, l.id, p.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.PROVINCIA p on p.provincia = CLIENTE_PROVINCIA
                            JOIN FURIOUS_QUERYING.LOCALIDAD l on l.localidad = CLIENTE_LOCALIDAD AND l.provincia_id = p.id
                            WHERE CLIENTE_NOMBRE IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_SUPERMERCADO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.SUPERMERCADO(cuit, nombre, razon_social, ingresos_brutos, domicilio, fecha_inicio_actividad, condicion_fiscal, localidad_id, provincia_id)
                            SELECT DISTINCT SUPER_CUIT, SUPER_NOMBRE ,SUPER_RAZON_SOC, SUPER_IIBB, SUPER_DOMICILIO, SUPER_FECHA_INI_ACTIVIDAD,
                            SUPER_CONDICION_FISCAL, l.id, p.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.PROVINCIA p on p.provincia = SUPER_PROVINCIA
                            JOIN FURIOUS_QUERYING.LOCALIDAD l on l.localidad = SUPER_LOCALIDAD AND l.provincia_id =p.id
                            WHERE CLIENTE_NOMBRE IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_DESCUENTO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.DESCUENTO(codigo, descripcion, fecha_inicio, fecha_fin, porcentaje_descuento, tope)
                            SELECT DISTINCT DESCUENTO_CODIGO,DESCUENTO_DESCRIPCION,DESCUENTO_FECHA_INICIO,
                            DESCUENTO_FECHA_FIN,DESCUENTO_PORCENTAJE_DESC,DESCUENTO_TOPE
                            FROM gd_esquema.Maestra
                            WHERE DESCUENTO_CODIGO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_ESTADO_ENVIO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.ESTADO_ENVIO(estado)
                            SELECT DISTINCT ENVIO_ESTADO
                            FROM gd_esquema.Maestra
                            WHERE ENVIO_ESTADO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_EMPLEADO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.EMPLEADO(dni,nombre, apellido, fecha_registro, telefono, mail, fecha_nacimiento, sucursal_nombre)
                            SELECT DISTINCT EMPLEADO_DNI, EMPLEADO_NOMBRE, EMPLEADO_APELLIDO, EMPLEADO_FECHA_REGISTRO, EMPLEADO_TELEFONO, 
                            EMPLEADO_MAIL, EMPLEADO_FECHA_NACIMIENTO, SUCURSAL_NOMBRE
                            FROM gd_esquema.Maestra     
                            WHERE EMPLEADO_DNI IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TIPO_CAJA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.TIPO_CAJA(tipo) SELECT DISTINCT CAJA_TIPO 
                                FROM gd_esquema.Maestra
                                WHERE CAJA_TIPO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_CAJA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.CAJA(numero,tipo_caja_id) SELECT DISTINCT CAJA_NUMERO, t.id 
                                                       FROM gd_esquema.Maestra
                                                       JOIN FURIOUS_QUERYING.TIPO_CAJA t ON t.tipo = CAJA_TIPO
                                                       WHERE CAJA_TIPO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TICKET
AS BEGIN
INSERT INTO FURIOUS_QUERYING.TICKET(numero,fecha_y_hora, subtotal_productos, descuento_promociones_total, descuento_medio_de_pago_total, 
                                    total_envio, total, sucursal_nombre, caja_numero, empleado_id, tipo_comprobante_id)
                            SELECT DISTINCT TICKET_NUMERO, TICKET_FECHA_HORA, TICKET_SUBTOTAL_PRODUCTOS, TICKET_TOTAL_DESCUENTO_APLICADO, TICKET_TOTAL_DESCUENTO_APLICADO_MP,
                            TICKET_TOTAL_ENVIO, TICKET_TOTAL_TICKET, Maestra.SUCURSAL_NOMBRE, CAJA_NUMERO, e.id, tc.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.EMPLEADO e ON e.dni= EMPLEADO_DNI  AND e.NOMBRE= EMPLEADO_NOMBRE
                            JOIN FURIOUS_QUERYING.TIPO_COMPROBANTE tc ON tc.tipo_comprobante= TIPO_COMPROBANTE     
                            WHERE TICKET_NUMERO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_ENVIO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.ENVIO(fecha_programada,fecha_entrega,hora_inicio_programada,hora_fin_programada,costo,
                                    estado_envio_id,ticket_numero, cliente_id)
                            SELECT DISTINCT ENVIO_FECHA_PROGRAMADA, ENVIO_FECHA_ENTREGA, ENVIO_HORA_INICIO, ENVIO_HORA_FIN,ENVIO_COSTO,
                            ee.id, TICKET_NUMERO, c.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.ESTADO_ENVIO ee ON ee.estado = ENVIO_ESTADO
                            JOIN FURIOUS_QUERYING.CLIENTE c ON c.dni = CLIENTE_DNI
                            WHERE ENVIO_FECHA_PROGRAMADA IS NOT NULL           
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_DETALLE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.DETALLE_PAGO(cliente_id, tarjeta_numero, cuotas)
                            SELECT DISTINCT c.id, PAGO_TARJETA_NRO, PAGO_TARJETA_CUOTAS 
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.CLIENTE c ON c.dni = CLIENTE_DNI
                            WHERE PAGO_FECHA IS NOT NULL           
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_MEDIO_DE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.MEDIO_DE_PAGO(descripcion, tipo_medio_de_pago_id)
                            SELECT DISTINCT PAGO_MEDIO_PAGO, tp.id
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO tp ON tp.tipo = PAGO_TIPO_MEDIO_PAGO
                            WHERE PAGO_FECHA IS NOT NULL           
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.PAGO(fecha_y_hora,detalle_pago_id,medio_de_pago_codigo,ticket_numero,importe,descuento_aplicado)
                            SELECT DISTINCT PAGO_FECHA, dp.id ,mp.codigo, TICKET_NUMERO ,PAGO_IMPORTE,PAGO_DESCUENTO_APLICADO
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.DETALLE_PAGO dp ON dp.tarjeta_numero = PAGO_TARJETA_NRO
                            JOIN FURIOUS_QUERYING.MEDIO_DE_PAGO mp ON mp.descripcion = PAGO_MEDIO_PAGO
                            WHERE PAGO_FECHA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_DESCUENTO_POR_MEDIO_DE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO(medio_de_pago_codigo, descuento_codigo)
                            SELECT DISTINCT mp.codigo, d.codigo
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MEDIO_DE_PAGO mp ON mp.descripcion = PAGO_MEDIO_PAGO
                            JOIN FURIOUS_QUERYING.DESCUENTO d ON d.descripcion = DESCUENTO_DESCRIPCION
                            WHERE PAGO_FECHA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_DESCUENTO_POR_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.DESCUENTO_POR_PAGO(pago_numero, descuento_codigo)
                            SELECT DISTINCT p.numero, d.codigo
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MEDIO_DE_PAGO mp ON mp.descripcion = PAGO_MEDIO_PAGO
                            JOIN FURIOUS_QUERYING.PAGO p ON p.ticket_numero = gd_esquema.Maestra.TICKET_NUMERO AND p.medio_de_pago_codigo = mp.codigo
                            JOIN FURIOUS_QUERYING.DESCUENTO d ON d.descripcion = DESCUENTO_DESCRIPCION
                            WHERE PAGO_FECHA IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_ITEM
AS BEGIN
INSERT INTO FURIOUS_QUERYING.ITEM(producto_id, ticket_numero, cantidad, precio_unitario)
                            SELECT DISTINCT p.id, TICKET_NUMERO, TICKET_DET_CANTIDAD,  TICKET_DET_PRECIO
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MARCA m ON m.marca = PRODUCTO_MARCA
                            JOIN FURIOUS_QUERYING.producto p ON p.nombre = PRODUCTO_NOMBRE AND p.id = m.id 
                            AND p.subcategoria_id = PRODUCTO_SUB_CATEGORIA AND p.categoria_id = PRODUCTO_CATEGORIA
                            WHERE TICKET_NUMERO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_ITEM_X_PROMOCION
AS BEGIN
INSERT INTO FURIOUS_QUERYING.ITEM_X_PROMOCION(codigo_promocion,producto_id,ticket_numero,promo_aplicada_descuento)
                            SELECT DISTINCT PROMO_CODIGO,p.id, TICKET_NUMERO, PROMO_APLICADA_DESCUENTO
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.MARCA m ON m.marca = PRODUCTO_MARCA
                            JOIN FURIOUS_QUERYING.producto p ON p.nombre = PRODUCTO_NOMBRE AND p.id = m.id 
                            AND p.subcategoria_id = PRODUCTO_SUB_CATEGORIA AND p.categoria_id = PRODUCTO_CATEGORIA                               
                            WHERE PROMO_CODIGO IS NOT NULL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_SUCURSAL
AS BEGIN
INSERT INTO FURIOUS_QUERYING.SUCURSAL(nombre, direccion, localidad_id, supermercado_id)
                            SELECT DISTINCT SUCURSAL_NOMBRE, SUCURSAL_DIRECCION, l.id, SUPER_CUIT
                            FROM gd_esquema.Maestra
                            JOIN FURIOUS_QUERYING.PROVINCIA p ON p.provincia = SUCURSAL_PROVINCIA
                            JOIN FURIOUS_QUERYING.LOCALIDAD l ON l.localidad= SUCURSAL_LOCALIDAD AND l.provincia_id=p.id
                            WHERE SUCURSAL_NOMBRE IS NOT NULL
END
GO
--=================================================================EXEC============================================================= 
EXEC FURIOUS_QUERYING.MIGRAR_PROVINCIA;
EXEC FURIOUS_QUERYING.MIGRAR_LOCALIDAD;
EXEC FURIOUS_QUERYING.MIGRAR_TARJETA;
EXEC FURIOUS_QUERYING.MIGRAR_TIPO_COMPROBANTE;
EXEC FURIOUS_QUERYING.MIGRAR_TIPO_MEDIO_DE_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_CATEGORIA;
EXEC FURIOUS_QUERYING.MIGRAR_SUBCATEGORIA;
EXEC FURIOUS_QUERYING.MIGRAR_MARCA;
EXEC FURIOUS_QUERYING.MIGRAR_SET_DE_REGLAS;
EXEC FURIOUS_QUERYING.MIGRAR_PROMOCION;
EXEC FURIOUS_QUERYING.MIGRAR_PRODUCTO;
EXEC FURIOUS_QUERYING.MIGRAR_PRODUCTO_CON_PROMOCION;
EXEC FURIOUS_QUERYING.MIGRAR_CLIENTE;
EXEC FURIOUS_QUERYING.MIGRAR_SUPERMERCADO;
EXEC FURIOUS_QUERYING.MIGRAR_SUCURSAL;
EXEC FURIOUS_QUERYING.MIGRAR_EMPLEADO;
EXEC FURIOUS_QUERYING.MIGRAR_DESCUENTO;
EXEC FURIOUS_QUERYING.MIGRAR_ESTADO_ENVIO;
EXEC FURIOUS_QUERYING.MIGRAR_TIPO_CAJA;
EXEC FURIOUS_QUERYING.MIGRAR_CAJA;
EXEC FURIOUS_QUERYING.MIGRAR_TICKET;
EXEC FURIOUS_QUERYING.MIGRAR_ENVIO;
EXEC FURIOUS_QUERYING.MIGRAR_DETALLE_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_MEDIO_DE_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_DESCUENTO_POR_MEDIO_DE_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_DESCUENTO_POR_PAGO;
EXEC FURIOUS_QUERYING.MIGRAR_ITEM;
EXEC FURIOUS_QUERYING.MIGRAR_ITEM_X_PROMOCION;