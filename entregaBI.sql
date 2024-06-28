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
	nombre_localidad VARCHAR(255),
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

CREATE TABLE FURIOUS_QUERYING.BI_TURNO(
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
    FOREIGN KEY (subcategoria,categoria) REFERENCES FURIOUS_QUERYING.SUBCATEGORIA(id,categoria_id),
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
    sucursal_nombre VARCHAR(255),
    tipo_caja VARCHAR(255)
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
	ticket_id DECIMAL(18,0),
    cantidad DECIMAL(18,0),
    total DECIMAL(18,2),
    FOREIGN KEY (tiempo_id) REFERENCES FURIOUS_QUERYING.BI_TIEMPO(id),
    FOREIGN KEY (ubicacion_id) REFERENCES FURIOUS_QUERYING.BI_UBICACION(id),
    FOREIGN KEY (sucursal_id) REFERENCES FURIOUS_QUERYING.BI_SUCURSAL(id),
    FOREIGN KEY (rango_etario_cliente_id) REFERENCES FURIOUS_QUERYING.BI_RANGO_ETARIO(id),
    FOREIGN KEY (rango_etario_empleado_id) REFERENCES FURIOUS_QUERYING.BI_RANGO_ETARIO(id),
    FOREIGN KEY (turno_id) REFERENCES FURIOUS_QUERYING.BI_TURNO(id),
    FOREIGN KEY (medio_de_pago_id) REFERENCES FURIOUS_QUERYING.BI_MEDIO_DE_PAGO(id), 
	FOREIGN KEY (ticket_id) REFERENCES FURIOUS_QUERYING.BI_TICKET(id),
    
);

CREATE TABLE FURIOUS_QUERYING.BI_VENTA_X_CATEGORIA_SUBCATEGORIA(
    venta_id DECIMAL(18,0),
    categoria_id VARCHAR(255),
    subcategoria_id VARCHAR(255),
    PRIMARY KEY (venta_id,categoria_id,subcategoria_id),
    FOREIGN KEY (subcategoria_id,categoria_id) REFERENCES FURIOUS_QUERYING.SUBCATEGORIA(id,categoria_id),
    FOREIGN KEY (venta_id) REFERENCES FURIOUS_QUERYING.BI_VENTA(id)
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
INSERT INTO FURIOUS_QUERYING.BI_UBICACION(provincia_id, localidad_id,nombre_localidad)
                            SELECT DISTINCT provincia_id, id,localidad
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
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_TURNO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_TURNO(turno) VALUES ('8:00 - 12:00')
INSERT INTO FURIOUS_QUERYING.BI_TURNO(turno) VALUES ('12:00 - 16:00')
INSERT INTO FURIOUS_QUERYING.BI_TURNO(turno) VALUES ('16:00 - 20:00 ')
INSERT INTO FURIOUS_QUERYING.BI_TURNO(turno) VALUES ('Otros')
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_MEDIO_DE_PAGO(descripcion, tipo_medio_de_pago_id)
                            SELECT DISTINCT descripcion, tipo_medio_de_pago_id 
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
AS 
BEGIN
INSERT INTO FURIOUS_QUERYING.BI_TICKET(numero_ticket, fecha_y_hora, tipo_comprobante_id, sucursal_nombre, tipo_caja)
                            SELECT t.numero, t.fecha_y_hora, t.tipo_comprobante_id, t.sucursal_nombre, tc.tipo
                            FROM FURIOUS_QUERYING.TICKET t
                            JOIN FURIOUS_QUERYING.CAJA c ON t.caja_numero =  c.numero AND c.sucursal_nombre = t.sucursal_nombre
                            JOIN FURIOUS_QUERYING.TIPO_CAJA tc ON tc.id = c.tipo_caja_id
                                                       
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_TIEMPO(@fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
DECLARE @resultado DECIMAL(18,0)
SELECT @resultado = id FROM FURIOUS_QUERYING.BI_TIEMPO t WHERE t.anio=YEAR(@fecha_y_hora) AND t.mes=MONTH(@fecha_y_hora) AND t.cuatrimestre=
CASE WHEN MONTH(@fecha_y_hora) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(@fecha_y_hora) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(@fecha_y_hora) BETWEEN 9 AND 12 THEN 3 END
RETURN @resultado
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_UBICACION(@sucursal_nombre VARCHAR)
RETURNS DECIMAL(18,0)
AS BEGIN
DECLARE @resultado DECIMAL(18,0)
SELECT @resultado = id FROM FURIOUS_QUERYING.BI_UBICACION WHERE localidad_id=(SELECT l.id from FURIOUS_QUERYING.SUCURSAL s join FURIOUS_QUERYING.LOCALIDAD l on s.localidad_id=l.id) AND provincia_id= (SELECT l.provincia_id from FURIOUS_QUERYING.SUCURSAL s join FURIOUS_QUERYING.LOCALIDAD l on s.localidad_id=l.id)
RETURN @resultado
END

GO
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
                            WHEN @edad >= 50 THEN '> 50'
							END)
RETURN @resultado
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_TURNO(@fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS
BEGIN
    DECLARE @resultado DECIMAL(18,0);
    DECLARE @hora TIME;
    SET @hora = CAST(@fecha_y_hora AS TIME);
    SELECT @resultado = id 
    FROM FURIOUS_QUERYING.BI_TURNO
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
WHERE i.ticket_numero=@ticket_id AND i.sucursal_nombre=@sucursal AND i.tipo_comprobante_id=@tipo_comprobante AND i.ticket_fecha_y_hora=@fecha_y_hora 
RETURN @resultado;
END


GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_VENTA
AS BEGIN
INSERT INTO FURIOUS_QUERYING.BI_VENTA(
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
FURIOUS_QUERYING.BI_SELECT_UBICACION(t.sucursal_nombre),
t.sucursal_nombre,
FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(c.fecha_nacimiento),
FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(e.fecha_nacimiento),
FURIOUS_QUERYING.BI_SELECT_TURNO(t.fecha_y_hora),
p.medio_de_pago_codigo,
bt.id,
FURIOUS_QUERYING.CANTIDAD_ITEMS(t.numero,t.sucursal_nombre,t.tipo_comprobante_id,t.fecha_y_hora),
t.total
     FROM FURIOUS_QUERYING.TICKET t
     JOIN FURIOUS_QUERYING.EMPLEADO e on e.id=t.empleado_id
     JOIN FURIOUS_QUERYING.PAGO p on p.ticket_numero = t.numero AND p.ticket_fecha_y_hora=t.fecha_y_hora AND p.tipo_comprobante_id=t.tipo_comprobante_id AND p.sucursal_nombre=t.sucursal_nombre
     JOIN FURIOUS_QUERYING.DETALLE_PAGO dt on dt.id=p.detalle_pago_id
     JOIN FURIOUS_QUERYING.CLIENTE c on c.id=dt.cliente_id  
     JOIN FURIOUS_QUERYING.BI_TICKET bt ON bt.numero_ticket = t.numero AND bt.fecha_y_hora=t.fecha_y_hora AND bt.tipo_comprobante_id=t.tipo_comprobante_id AND bt.sucursal_nombre=t.sucursal_nombre
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.MIGRAR_VENTA_X_CATEGORIA_SUBCATEGORIA 
AS 
BEGIN
INSERT INTO FURIOUS_QUERYING.BI_VENTA_X_CATEGORIA_SUBCATEGORIA (venta_id,categoria_id,subcategoria_id)
                SELECT v.id,p.categoria_id,p.subcategoria_id
                FROM FURIOUS_QUERYING.BI_VENTA v 
                JOIN FURIOUS_QUERYING.BI_TICKET bt ON bt.id=v.ticket_id
                JOIN FURIOUS_QUERYING.ITEM i ON i.ticket_numero=bt.numero_ticket AND i.sucursal_nombre=bt.sucursal_nombre AND i.ticket_fecha_y_hora=bt.fecha_y_hora AND i.tipo_comprobante_id=bt.tipo_comprobante_id
                JOIN FURIOUS_QUERYING.PRODUCTO p ON p.id=i.producto_id
END

--===================================================EXECS============================================================= 

EXEC FURIOUS_QUERYING.MIGRAR_TURNO
EXEC FURIOUS_QUERYING.MIGRAR_TIEMPO
EXEC FURIOUS_QUERYING.MIGRAR_UBICACION
EXEC FURIOUS_QUERYING.BI_MIGRAR_SUCURSAL
EXEC FURIOUS_QUERYING.MIGRAR_RANGO_ETARIO
EXEC FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO
EXEC FURIOUS_QUERYING.MIGRAR_CATEGORIA_SUBCATEGORIA
EXEC FURIOUS_QUERYING.MIGRAR_BI_ENVIO
EXEC FURIOUS_QUERYING.MIGRAR_BI_TICKET
EXEC FURIOUS_QUERYING.MIGRAR_VENTA
EXEC FURIOUS_QUERYING.MIGRAR_VENTA_X_CATEGORIA_SUBCATEGORIA

--===================================================VISTAS============================================================= 
--Ticket Promedio mensual. Valor promedio de las ventas (en $) según la
--localidad, año y mes. Se calcula en función de la sumatoria del importe de las
--ventas sobre el total de las mismas.

GO
CREATE VIEW FURIOUS_QUERYING.TICKET_PROMEDIO_MENSUAL AS
SELECT SUM(v.total) / COUNT(DISTINCT v.id) AS ValorPromedioVenta,u.nombre_localidad AS Localidad,t.anio AS Anio,t.mes AS Mes
FROM FURIOUS_QUERYING.BI_VENTA v JOIN FURIOUS_QUERYING.BI_UBICACION u ON (v.ubicacion_id = u.id) 
                                 JOIN FURIOUS_QUERYING.BI_TIEMPO t ON (v.tiempo_id = t.id) 
GROUP BY u.nombre_localidad,t.anio,t.mes

--Cantidad unidades promedio. Cantidad promedio de artículos que se venden
--en función de los tickets según el turno para cada cuatrimestre de cada año. Se
--obtiene sumando la cantidad de artículos de todos los tickets correspondientes
--sobre la cantidad de tickets. Si un producto tiene más de una unidad en un ticket,
--para el indicador se consideran todas las unidades.

GO
CREATE VIEW FURIOUS_QUERYING.CANTIDAD_UNIDADES_PROMEDIO AS 
SELECT AVG(v.cantidad) AS CantUnidadesPromedioArticulo,t.turno AS Turno
FROM FURIOUS_QUERYING.BI_VENTA v
JOIN FURIOUS_QUERYING.BI_TURNO t ON t.id=v.turno_id
GROUP BY t.turno

--Porcentaje anual de ventas registradas por rango etario del empleado según el
--tipo de caja para cada cuatrimestre. Se calcula tomando la cantidad de ventas
--correspondientes sobre el total de ventas anual.

GO
CREATE VIEW FURIOUS_QUERYING.PORCENTAJE_VENTAS_X_RANGO_ETARIO AS
SELECT COUNT(v.id)/(SELECT COUNT(v2.id) FROM FURIOUS_QUERYING.BI_VENTA v2) AS Porcentaje,r.rango AS RangoEtario,t.tipo_caja AS TipoDeCaja
FROM FURIOUS_QUERYING.BI_VENTA v 
JOIN FURIOUS_QUERYING.BI_RANGO_ETARIO r ON (v.rango_etario_empleado_id = r.id) 
JOIN FURIOUS_QUERYING.BI_TICKET t ON t.id=v.ticket_id
GROUP BY r.rango,t.tipo_caja