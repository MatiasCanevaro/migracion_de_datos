USE [GD1C2024]
GO
--===================================================TABLAS===================================================================
CREATE TABLE FURIOUS_QUERYING.BI_TIEMPO(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    anio DECIMAL(18,0),
    mes DECIMAL(18,0),
    cuatrimestre DECIMAL(18,0),
);

CREATE TABLE FURIOUS_QUERYING.BI_UBICACION(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    provincia_id DECIMAL(18,0),
    localidad_id DECIMAL(18,0),
    FOREIGN KEY (provincia_id) REFERENCES FURIOUS_QUERYING.PROVINCIA(id),
    FOREIGN KEY (localidad_id) REFERENCES FURIOUS_QUERYING.LOCALIDAD(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_SUCURSAL(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    localidad_id DECIMAL(18,0),
    FOREIGN KEY (localidad_id) REFERENCES FURIOUS_QUERYING.LOCALIDAD(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_RANGO_ETARIO(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    rango VARCHAR(20)
);

CREATE TABLE FURIOUS_QUERYING.BI_TURNOS(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    turno VARCHAR(20)
);

CREATE TABLE FURIOUS_QUERYING.BI_MEDIO_DE_PAGO(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    descripcion VARCHAR(255),
    tipo_medio_de_pago_id DECIMAL(18,0),
    FOREIGN KEY (tipo_medio_de_pago_id) REFERENCES FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO(id)
);


CREATE TABLE FURIOUS_QUERYING.BI_CATEGORIA_SUBCATEGORIA(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    subcategoria VARCHAR(255),
    categoria VARCHAR(255),
    FOREIGN KEY (categoria, subcategoria) REFERENCES FURIOUS_QUERYING.SUBCATEGORIA(categoria_id, id)
    FOREIGN KEY (categoria) REFERENCES FURIOUS_QUERYING.CATEGORIA(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_ENVIO(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    fecha_programada DATETIME,
    fecha_entrega DATETIME,
    costo DECIMAL(18,0),
    estado_envio VARCHAR(255)
);

CREATE TABLE FURIOUS_QUERYING.BI_TICKET(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    numero_ticket DECIMAL(18,0),
    fecha_y_hora DATETIME,
    tipo_comprobante_id DECIMAL(18,0),
    nombre_sucursal VARCHAR(255)
);

CREATE TABLE FURIOUS_QUERYING.BI_VENTA(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    tiempo_id DECIMAL(18,0),
    ubicacion_id DECIMAL(18,0),
    sucursal_id DECIMAL(18,0),
    rango_etario_cliente_id DECIMAL(18,0),
    rango_etario_empleado_id DECIMAL(18,0),
    turno_id DECIMAL(18,0),
    medio_de_pago_id DECIMAL(18,0),
    cantidad DECIMAL(18,0),
    total DECIMAL(18,2),
    FOREIGN KEY (tiempo_id) REFERENCES BI_TIEMPO(tiempo_id),
    FOREIGN KEY (ubicacion_id) REFERENCES BI_UBICACION(ubicacion_id),
    FOREIGN KEY (sucursal_id) REFERENCES BI_SUCURSAL(sucursal_id),
    FOREIGN KEY (rango_etario_cliente_id) REFERENCES BI_RANGO_ETARIO(rango_etario_id),
    FOREIGN KEY (rango_etario_empleado_id) REFERENCES BI_RANGO_ETARIO(rango_etario_id),
    FOREIGN KEY (turno_id) REFERENCES BI_TURNOS(turno_id),
    FOREIGN KEY (medio_de_pago_id) REFERENCES BI_MEDIO_DE_PAGO(medio_de_pago_id), 
    
);

CREATE TABLE FURIOUS_QUERYING.BI_VENTA_X_CATEGORIA_SUBCATEGORIA(
    venta_id DECIMAL(18,0),
    categoria_id DECIMAL(18,0),
    subcategoria_id DECIMAL(18,0)
    PRIMARY KEY (venta_id,categoria_id,subcategoria_id)
    FOREIGN KEY (categoria_id,subcategoria_id) REFERENCES FURIOUS_QUERYING.BI_CATEGORIA_SUBCATEGORIA
    FOREIGN KEY (venta_id) REFERENCES FURIOUS_QUERYING.BI_VENTA
)
--===================================================STORED PROCEDURES============================================================= 
GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TIEMPO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_TIEMPO(anio,mes,cuatrimestre) 
            SELECT DISTINCT YEAR(fecha_y_hora),MONTH(fecha_y_hora),
            CASE WHEN MONTH(fecha_y_hora) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(fecha_y_hora) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(fecha_y_hora) BETWEEN 9 AND 12 THEN 3 END
            FROM FURIOUS_QUERYING.TICKET
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_UBICACION
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_UBICACION(provincia_id, localidad_id)
                            SELECT DISTINCT provincia_id, id 
                            FROM FURIOUS_QUERYING.LOCALIDAD
                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_SUCURSAL
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_SUCURSAL(nombre, direccion, localidad_id)
                            SELECT DISTINCT nombre, direccion, localidad_id 
                            FROM FURIOUS_QUERYING.SUCURSAL
                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_RANGO_ETARIO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO(rango) VALUES ('< 25')
INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO(rango) VALUES ('25 - 35')
INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO(rango) VALUES ('35 - 50')
INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO(rango) VALUES ('> 50')                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TURNOS
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_TURNOS(turno) VALUES ('8:00 - 12:00')
INSERT INTO FURIOUS_QUERYING.BI_TURNOS(turno) VALUES ('12:00 - 16:00')
INSERT INTO FURIOUS_QUERYING.BI_TURNOS(turno) VALUES ('16:00 - 20:00 ')
INSERT INTO FURIOUS_QUERYING.BI_TURNOS(turno) VALUES ('Otros')
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_MEDIO_DE_PAGO(descripcion, tipo_medio_de_pago_id)
                            SELECT DISTINCT direccion, tipo_medio_de_pago_id 
                            FROM FURIOUS_QUERYING.MEDIO_DE_PAGO
                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_CATEGORIA_SUBCATEGORIA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_CATEGORIA_SUBCATEGORIA(subcategoria, categoria)
                            SELECT DISTINCT id, categoria_id 
                            FROM FURIOUS_QUERYING.SUBCATEGORIA                       
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_BI_ENVIO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_ENVIO(fecha_programada, fecha_entrega, costo, estado_envio)
                            SELECT fecha_programada, fecha_entrega, costo, e2.estado
                            FROM FURIOUS_QUERYING.ENVIO e1 
                            JOIN FURIOUS_QUERYING.ESTADO_ENVIO e2 ON (e1.estado_envio_id=e2.id)                            
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_BI_TICKET
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_TICKET(numero_ticket, fecha_y_hora, tipo_comprobante_id, nombre_sucursal)
                            SELECT numero, fecha_y_hora,tipo_comprobante_id, sucursal_nombre
                            FROM FURIOUS_QUERYING.TICKET  
                                                       
END

CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_TIEMPO(@fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
DECLARE @resultado DECIMAL(18,0)
SELECT @resultado = id FROM FURIOUS_QUERYING.BI_TIEMPO WHERE anio=YEAR(fecha_y_hora), mes=MONTH(fecha_y_hora),cuatrimestre=CASE WHEN MONTH(fecha_y_hora) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(fecha_y_hora) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(fecha_y_hora) BETWEEN 9 AND 12 THEN 3 END
RETURN @resultado
END

CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_UBICACION(@sucursal_nombre VARCHAR)
RETURNS DECIMAL(18,0)
AS BEGIN
DECLARE @resultado 
SELpECT @resultado= id FURIOUS_QUERYING.BI_UBICACION WHERE localidad_id=(SELECT l.id from FURIOUS_QUERYING.SUCURSAL s join FURIOUS_QUERYING.LOCALIDAD l on s.localidad_id=l.id) AND provincia_id= (SELECT l.provincia_id from FURIOUS_QUERYING.SUCURSAL s join FURIOUS_QUERYING.LOCALIDAD l on s.localidad_id=l.id)
END

CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(@fecha_nacimiento DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
DECLARE @resultado DECIMAL(18,0)
DECLARE @edad INT;
    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE());
    SELECT @resultado = id FROM FURIOUS_QUERYING.BI_RANGO_ETARIO 
    WHERE rango LIKE (CASE 
                            WHEN @edad < 25 THEN  '< 25'
                            WHEN @edad BETWEEN 25 AND 34 THEN  '25 - 35'
                            WHEN @edad BETWEEN 35 AND 49 THEN  '35 - 50'
                            WHEN @edad >= 50 THEN '> 50')
RETURN @resultado
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(@fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS
BEGIN
    DECLARE @resultado DECIMAL(18,0);
    DECLARE @hora TIME;
    SET @hora = CAST(@fecha_y_hora AS TIME);
    SELECT @resultado = id 
    FROM FURIOUS_QUERYING.BI_TURNOS
    WHERE turno LIKE CASE 
                        WHEN @hora BETWEEN '08:00:00' AND '11:59:59' THEN '08:00 - 12:00'
                        WHEN @hora BETWEEN '12:00:00' AND '15:59:59' THEN '12:00 - 16:00'
                        WHEN @hora BETWEEN '16:00:00' AND '19:59:59' THEN '16:00 - 20:00'
                        ELSE 'Otros'
                     END;
    RETURN @resultado;
END

GO
CREATE FUNCTION FURIOUS_QUERYING.CANTIDAD_ITEMS(@ticket_id DECIMAL(18,0), @sucursal VARCHAR(255), 
                                                @tipo_comprobante DECIMAL(18,0), @fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS 
BEGIN
DECLARE @resultado DECIMAL(18,0)
SELECT @resultado= SUM(i.cantidad) FROM FURIOUS_QUERYING.ITEM i 
WHERE i.ticket_numero=@ticket_id AND i.sucursal_nombre=@sucursal AND i.tipo_comprobante=@tipo_comprobante AND fecha_y_hora=@fecha_y_hora 
RETURN @resultado;
END


CREATE FUNCTION FURIOUS_QUERYING.MIGRAR_TICKET(@ticket_id DECIMAL(18,0))
AS
BEGIN
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_VENTA
AS BEGIN
INSERT INTO BI_VENTA(
    tiempo_id ,
    ubicacion_id ,
    sucursal_id ,
    rango_etario_cliente_id,
    rango_etario_empleado_id ,
    turno_id,
    medio_de_pago_id,
    ticket_id,
    cantidad,
    total
) SELECT
FURIOUS_QUERYING.BI_SELECT_TIEMPO(t.fecha_y_hora),
FURIOUS_QUERYING.BI_SELECT_UBICACION(t.sucursal_id),
t.sucursal_id,
FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(c.fecha_nacimiento),
FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(e.fecha_nacimiento),
FURIOUS_QUERYING.BI_SELECT_TURNO(t.fecha_y_hora),
p.medio_de_pago_codigo
bt.id,
FURIOUS_QUERYING.CANTIDAD_ITEMS(t.sucursal_nombre,t.tipo_comprobante_id,t.fecha_y_hora),
t.total
     FROM FURIOUS_QUERYING.TICKET t
     JOIN FURIOUS_QUERYNG.EMPLEADO e on e.id=t.empleado_id
     JOIN FURIOUS_QUERYING.PAGO p on p.ticket_id= t.ide
     JOIN FURIOUS_QUERYING.DETALLE_PAGO dt on dt.id=p.detalle_pago_id
     JOIN FURIOUS_QUERYING.CLIENTE c on c.id=dt.cliente_id  
     JOIN FURIOUS_QUERYING.BI_TICKET bt ON  bt.numero_ticket = t.numero  
END
    

GO    
CREATE PROCEDURE MIGRAR_VENTA_X_CATEGORIA_SUBCATEGORIA AS

BEGIN
INSERT INTO VENTA_X_CATEGORIA_SUBCATEGORIA (venta_id,categoria_id,subcategoria_id)
                SELECT v.id,categoria_id,subcategoria_id
                FROM FURIOUS_QUERYING.BI_VENTA v 
                JOIN  


END











