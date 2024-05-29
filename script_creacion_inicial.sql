BEGIN TRANSACTION

USE [GD1C2024]
GO

CREATE SCHEMA FURIOUS_QUERYING
GO

--TABLAS

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
codigo DECIMAL(18,0) primary key not null identity(1,1),
descripcion VARCHAR(255),
fecha_inicio DATETIME not null,
fecha_fin DATETIME not null,
porcentaje_descuetno DECIMAL(18,0) not null,
tope DECIMAL(18,0) null
)

CREATE TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO(
pago_numero DECIMAL(18,0) not null,
descuento_codigo DECIMAL(18,0) not null
)

CREATE TABLE FURIOUS_QUERYING.TICKET(
numero DECIMAL(18,0) primary key not null identity(1,1),
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
subcategoria_id VARCHAR(255) not null
)

CREATE TABLE FURIOUS_QUERYING.MARCA(
id DECIMAL(18,0) primary key not null identity(1,1),
marca VARCHAR(255)
)

CREATE TABLE FURIOUS_QUERYING.SUBCATEGORIA(
id VARCHAR(255) primary key not null,
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
codigo DECIMAL(18,0) primary key not null identity(1,1),
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
domiciolio VARCHAR(255) not null,
fecha_inicio_actividad DATETIME not null,
condicion_fiscal VARCHAR(255) not null,
localidad_id DECIMAL(18,0) not null,
provincia_id DECIMAL(18,0) not null
)
--===================================================Primary keys============================================================= 
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_MEDIO_DE_PAGO add constraint pk_descuento_por_medio_de_pago primary key (medio_de_pago_codigo,descuento_codigo) 
ALTER TABLE FURIOUS_QUERYING.DESCUENTO_POR_PAGO add constraint pk_descuento_por_pago primary key (pago_numero,descuento_codigo) 
ALTER TABLE FURIOUS_QUERYING.ITEM add constraint pk_item primary key (producto_id,ticket_numero) 
ALTER TABLE FURIOUS_QUERYING.ITEM_X_PROMOCION add constraint pk_item_x_promocion primary key (producto_id,ticket_numero,codigo_promocion) 

--===================================================Foreign keys=============================================================
ALTER TABLE FURIOUS_QUERYING.CLIENTE add constraint fk_provincia_por_cliente foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)
ALTER TABLE FURIOUS_QUERYING.CLIENTE add constraint fk_localidad_por_cliente foreign key (localidad_id) references FURIOUS_QUERYING.LOCALIDAD (id)

ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_detalle_pago foreign key (detalle_pago_id) references FURIOUS_QUERYING.DETALLE_PAGO (id)
ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_medio_de_pago foreign key (medio_de_pago_codigo) references FURIOUS_QUERYING.MEDIO_DE_PAGO (codigo)
ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_ticket foreign key (ticket_numero) references FURIOUS_QUERYING.TICKET (numero)
ALTER TABLE FURIOUS_QUERYING.PAGO add constraint fk_descuento foreign key (descuento_codigo) references FURIOUS_QUERYING.DESCUENTO (codigo)

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
ALTER TABLE FURIOUS_QUERYING.PRODUCTO add constraint fk_subcategoria_id foreign key (subcategoria_id) references FURIOUS_QUERYING.SUBCATEGORIA (id)

ALTER TABLE FURIOUS_QUERYING.SUBCATEGORIA add constraint fk_categoria_id foreign key (categoria_id) references FURIOUS_QUERYING.CATEGORIA (id)

ALTER TABLE FURIOUS_QUERYING.LOCALIDAD add constraint fk_provincia_id_por_localidad foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)

ALTER TABLE FURIOUS_QUERYING.PROMOCION add constraint fk_regla_id foreign key (regla_id) references FURIOUS_QUERYING.SET_DE_REGLAS (id)

ALTER TABLE FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION add constraint fk_promocion_codigo foreign key (promocion_codigo) references FURIOUS_QUERYING.PROMOCION (codigo)
ALTER TABLE FURIOUS_QUERYING.PRODUCTO_CON_PROMOCION add constraint fk_producto_id_por_producto_con_promocion foreign key (producto_id) references FURIOUS_QUERYING.PRODUCTO (id)

ALTER TABLE FURIOUS_QUERYING.SUPERMERCADO add constraint fk_localidad_id_por_supermercado foreign key (localidad_id) references FURIOUS_QUERYING.LOCALIDAD (id)
ALTER TABLE FURIOUS_QUERYING.SUPERMERCADO add constraint fk_provincia_id_por_supermercado foreign key (provincia_id) references FURIOUS_QUERYING.PROVINCIA (id)