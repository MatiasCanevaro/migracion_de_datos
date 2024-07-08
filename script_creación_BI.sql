USE [GD1C2024]
GO
--===================================================TABLAS===================================================================
--================================================DIMENSIONES=================================================================
CREATE TABLE FURIOUS_QUERYING.BI_TIEMPO
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    anio DECIMAL(18,0),
    mes DECIMAL(18,0),
    cuatrimestre DECIMAL(18,0),
);

CREATE TABLE FURIOUS_QUERYING.BI_PROVINCIA
(
    id DECIMAL(18,0) PRIMARY KEY,
    provincia VARCHAR(255)
);

CREATE TABLE FURIOUS_QUERYING.BI_LOCALIDAD
(
    id DECIMAL(18,0) PRIMARY KEY ,
    localidad_nombre VARCHAR(255),
    provincia_id DECIMAL(18,0),
    FOREIGN KEY(provincia_id) REFERENCES FURIOUS_QUERYING.BI_PROVINCIA(id)
);


CREATE TABLE FURIOUS_QUERYING.BI_SUCURSAL
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    nombre VARCHAR(255),
);

CREATE TABLE FURIOUS_QUERYING.BI_RANGO_ETARIO
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    rango VARCHAR(20)
);

CREATE TABLE FURIOUS_QUERYING.BI_TURNO
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    turno VARCHAR(20)
);

CREATE TABLE FURIOUS_QUERYING.BI_TIPO_MEDIO_DE_PAGO
(
    id DECIMAL(18,0) PRIMARY KEY,
    tipo VARCHAR(255)
);

CREATE TABLE FURIOUS_QUERYING.BI_MEDIO_DE_PAGO
(
    id DECIMAL(18,0) PRIMARY KEY,
    descripcion VARCHAR(255),
);

CREATE TABLE FURIOUS_QUERYING.BI_CATEGORIA
(
    id VARCHAR(255) PRIMARY KEY
);

CREATE TABLE FURIOUS_QUERYING.BI_SUBCATEGORIA
(
    id VARCHAR(255),
    categoria_id VARCHAR(255),
    FOREIGN KEY (categoria_id) REFERENCES FURIOUS_QUERYING.BI_CATEGORIA(id),
    PRIMARY KEY (id,categoria_id)
);

CREATE TABLE FURIOUS_QUERYING.BI_TIPO_CAJA
(
    id DECIMAL(18,0) PRIMARY KEY,
    tipo VARCHAR(255)
);

--==================================================HECHOS============================================================= 
CREATE TABLE FURIOUS_QUERYING.BI_HECHOS_VENTA
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    turno_id DECIMAL(18,0),
    tiempo_id DECIMAL(18,0),
    localidad_sucursal_id DECIMAL(18,0),
    sucursal_id DECIMAL(18,0),
    rango_etario_empleado_id DECIMAL(18,0),
    tipo_caja_id DECIMAL(18,0),
    cantidad DECIMAL(18,0),
    descuento_aplicado_total DECIMAL(18,2),
    total DECIMAL(18,2),
    FOREIGN KEY (turno_id) REFERENCES FURIOUS_QUERYING.BI_TURNO(id),
    FOREIGN KEY (tiempo_id) REFERENCES FURIOUS_QUERYING.BI_TIEMPO(id),
    FOREIGN KEY (localidad_sucursal_id) REFERENCES FURIOUS_QUERYING.BI_LOCALIDAD(id),
    FOREIGN KEY (sucursal_id) REFERENCES FURIOUS_QUERYING.BI_SUCURSAL(id),
    FOREIGN KEY (rango_etario_empleado_id) REFERENCES FURIOUS_QUERYING.BI_RANGO_ETARIO(id),
    FOREIGN KEY (tipo_caja_id) REFERENCES FURIOUS_QUERYING.BI_TIPO_CAJA(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_HECHOS_ENVIO
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    sucursal_id DECIMAL(18,0),
    tiempo_id DECIMAL(18,0),
    rango_etario_cliente_id DECIMAL(18,0),
    localidad_cliente_id DECIMAL(18,0),
    costo_envio DECIMAL(18,2),
    enviado_a_tiempo BIT,
    FOREIGN KEY (sucursal_id) REFERENCES FURIOUS_QUERYING.BI_SUCURSAL(id),
    FOREIGN KEY (tiempo_id) REFERENCES FURIOUS_QUERYING.BI_TIEMPO(id),
    FOREIGN KEY (rango_etario_cliente_id) REFERENCES FURIOUS_QUERYING.BI_RANGO_ETARIO(id),
    FOREIGN KEY (localidad_cliente_id) REFERENCES FURIOUS_QUERYING.BI_LOCALIDAD(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_HECHOS_PAGO
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    sucursal_id DECIMAL(18,0),
    tiempo_id DECIMAL(18,0),
    rango_etario_cliente_id DECIMAL(18,0),
    medio_de_pago_id DECIMAL(18,0),
    tipo_medio_de_pago_id DECIMAL(18,0),
    descuento_aplicado DECIMAL(18,2),
    cuotas DECIMAL(18,0),
    importe DECIMAL(18,2),
    FOREIGN KEY (sucursal_id) REFERENCES FURIOUS_QUERYING.BI_SUCURSAL(id),
    FOREIGN KEY (tiempo_id) REFERENCES FURIOUS_QUERYING.BI_TIEMPO(id),
    FOREIGN KEY (rango_etario_cliente_id) REFERENCES FURIOUS_QUERYING.BI_RANGO_ETARIO(id),
    FOREIGN KEY (medio_de_pago_id) REFERENCES FURIOUS_QUERYING.BI_MEDIO_DE_PAGO(id),
    FOREIGN KEY (tipo_medio_de_pago_id) REFERENCES FURIOUS_QUERYING.BI_TIPO_MEDIO_DE_PAGO(id)
);

CREATE TABLE FURIOUS_QUERYING.BI_HECHOS_PROMOCIONES_APLICADAS
(
    id DECIMAL(18,0) PRIMARY KEY identity(1,1),
    tiempo_id DECIMAL(18,0),
    subcategoria_id VARCHAR(255),
    categoria_id VARCHAR(255),
    promo_aplicada_descuento DECIMAL(18,2),
    descripcion VARCHAR(255),
    FOREIGN KEY (tiempo_id) REFERENCES FURIOUS_QUERYING.BI_TIEMPO(id),
    FOREIGN KEY (subcategoria_id,categoria_id) REFERENCES FURIOUS_QUERYING.BI_SUBCATEGORIA(id,categoria_id)
);

--==================================================STORED PROCEDURES============================================================= 
GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_TIEMPO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_TIEMPO
        (anio,mes,cuatrimestre)
    SELECT DISTINCT YEAR(fecha_y_hora), MONTH(fecha_y_hora),
        CASE WHEN MONTH(fecha_y_hora) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(fecha_y_hora) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(fecha_y_hora) BETWEEN 9 AND 12 THEN 3 END
    FROM FURIOUS_QUERYING.TICKET
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_RANGO_ETARIO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO
        (rango)
    VALUES
        ('< 25')
    INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO
        (rango)
    VALUES
        ('25 - 35')
    INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO
        (rango)
    VALUES
        ('35 - 50')
    INSERT INTO FURIOUS_QUERYING.BI_RANGO_ETARIO
        (rango)
    VALUES
        ('> 50')
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_TURNO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_TURNO
        (turno)
    VALUES
        ('8:00 - 12:00')
    INSERT INTO FURIOUS_QUERYING.BI_TURNO
        (turno)
    VALUES
        ('12:00 - 16:00')
    INSERT INTO FURIOUS_QUERYING.BI_TURNO
        (turno)
    VALUES
        ('16:00 - 20:00 ')
    INSERT INTO FURIOUS_QUERYING.BI_TURNO
        (turno)
    VALUES
        ('Otros')
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_TIPO_MEDIO_DE_PAGO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_TIPO_MEDIO_DE_PAGO
        (id, tipo)
    SELECT DISTINCT id, tipo
    FROM FURIOUS_QUERYING.TIPO_MEDIO_DE_PAGO
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_MEDIO_DE_PAGO
        (id,descripcion)
    SELECT DISTINCT codigo,descripcion
    FROM FURIOUS_QUERYING.MEDIO_DE_PAGO 
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_SUBCATEGORIA
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_SUBCATEGORIA
        (id, categoria_id)
    SELECT DISTINCT id, categoria_id
    FROM FURIOUS_QUERYING.SUBCATEGORIA
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_CATEGORIA
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_CATEGORIA
        (id)
    SELECT DISTINCT id
    FROM FURIOUS_QUERYING.CATEGORIA
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_PROVINCIA
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_PROVINCIA
            (id, provincia)
    SELECT DISTINCT id, provincia
    FROM FURIOUS_QUERYING.PROVINCIA

END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_LOCALIDAD
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_LOCALIDAD
        (provincia_id, id, localidad_nombre)
    SELECT DISTINCT provincia_id, id, localidad
    FROM FURIOUS_QUERYING.LOCALIDAD
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_SUCURSAL
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_SUCURSAL
        (nombre)
    SELECT DISTINCT nombre
    FROM FURIOUS_QUERYING.SUCURSAL
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_TIPO_CAJA
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_TIPO_CAJA
        (id, tipo)
    SELECT DISTINCT id, tipo
    FROM FURIOUS_QUERYING.TIPO_CAJA
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_TIEMPO(@fecha_y_hora DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    SELECT @resultado = id
    FROM FURIOUS_QUERYING.BI_TIEMPO t
    WHERE t.anio=YEAR(@fecha_y_hora) AND t.mes=MONTH(@fecha_y_hora) AND t.cuatrimestre=
CASE WHEN MONTH(@fecha_y_hora) BETWEEN 1 AND 4 THEN 1
                 WHEN MONTH(@fecha_y_hora) BETWEEN 5 AND 8 THEN 2
                 WHEN MONTH(@fecha_y_hora) BETWEEN 9 AND 12 THEN 3 END
    RETURN @resultado
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_LOCALIDAD_CLIENTE(@cliente_id DECIMAL(18,0))
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    SELECT DISTINCT @resultado = id
    FROM FURIOUS_QUERYING.BI_LOCALIDAD u
    WHERE u.id=(SELECT DISTINCT l.id
			from FURIOUS_QUERYING.CLIENTE c JOIN FURIOUS_QUERYING.LOCALIDAD l ON c.localidad_id=l.id
			WHERE c.id = @cliente_id)
        AND u.provincia_id= (SELECT DISTINCT l.provincia_id
			from FURIOUS_QUERYING.CLIENTE c JOIN FURIOUS_QUERYING.LOCALIDAD l ON c.localidad_id=l.id
			WHERE c.id = @cliente_id)
    RETURN @resultado
END

GO
CREATE FUNCTION FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(@fecha_nacimiento DATETIME)
RETURNS DECIMAL(18,0)
AS BEGIN
    DECLARE @resultado DECIMAL(18,0)
    DECLARE @edad INT;
    SET @edad = DATEDIFF(YEAR, @fecha_nacimiento, GETDATE());
    SELECT @resultado = id
    FROM FURIOUS_QUERYING.BI_RANGO_ETARIO
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
                        WHEN @hora BETWEEN '08:00:00' AND '11:59:59' THEN '8:00 - 12:00'
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
    SELECT @resultado= SUM(i.cantidad)
    FROM FURIOUS_QUERYING.ITEM i
    WHERE i.ticket_numero=@ticket_id AND i.sucursal_nombre=@sucursal AND i.tipo_comprobante_id=@tipo_comprobante AND i.ticket_fecha_y_hora=@fecha_y_hora
    RETURN @resultado;
END
    
GO 
CREATE FUNCTION FURIOUS_QUERYING.ENVIADO_A_TIEMPO(@hora_inicio DECIMAL(18,0), @hora_fin DECIMAL(18,0), @fecha_programada DATETIME, @fecha_entrega DATETIME)
RETURNS BIT
AS BEGIN
    DECLARE @resultado BIT
    IF CAST(@fecha_programada AS DATE)  = CAST(@fecha_entrega AS DATE)
	BEGIN
        DECLARE @hora_entrega DECIMAL(18,0);
        SET @hora_entrega = DATEPART(HOUR, @fecha_entrega);
        IF @hora_entrega BETWEEN @hora_inicio AND @hora_fin
		BEGIN
		SET @resultado = 1;
		END;
	END;
    ELSE 
        SET @resultado = 0;
    RETURN @resultado;
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_HECHOS_VENTA
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_HECHOS_VENTA
        (
        turno_id,
        tiempo_id,
        localidad_sucursal_id,
        sucursal_id,
        rango_etario_empleado_id,
        tipo_caja_id,
        cantidad,
        descuento_aplicado_total,
        total
        )
    SELECT DISTINCT 
        FURIOUS_QUERYING.BI_SELECT_TURNO(t.fecha_y_hora),
        FURIOUS_QUERYING.BI_SELECT_TIEMPO(t.fecha_y_hora),
        s.localidad_id,
        s2.id,
        FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(e.fecha_nacimiento),
        c.tipo_caja_id,
        FURIOUS_QUERYING.CANTIDAD_ITEMS(t.numero,t.sucursal_nombre,t.tipo_comprobante_id,t.fecha_y_hora),
        t.descuento_medio_de_pago_total + t.descuento_promociones_total,
        t.total
    FROM FURIOUS_QUERYING.TICKET t
        JOIN FURIOUS_QUERYING.EMPLEADO e ON e.id = t.empleado_id
        JOIN FURIOUS_QUERYING.SUCURSAL s ON s.nombre = t.sucursal_nombre
		JOIN FURIOUS_QUERYING.BI_SUCURSAL s2 ON s.nombre = s2.nombre
        JOIN FURIOUS_QUERYING.CAJA c ON c.numero = t.caja_numero AND c.sucursal_nombre = t.sucursal_nombre
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_HECHOS_ENVIO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_HECHOS_ENVIO(
    sucursal_id,
    tiempo_id,
    rango_etario_cliente_id,
    localidad_cliente_id,
    costo_envio,
    enviado_a_tiempo
    )
    SELECT
        s.id,
        FURIOUS_QUERYING.BI_SELECT_TIEMPO(e.fecha_entrega),
        FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(c.fecha_nacimiento),
        FURIOUS_QUERYING.BI_SELECT_LOCALIDAD_CLIENTE(c.id),
        e.costo,
        FURIOUS_QUERYING.ENVIADO_A_TIEMPO(e.hora_inicio_programada, e.hora_fin_programada, e.fecha_programada,e.fecha_entrega)
    FROM FURIOUS_QUERYING.ENVIO e
    JOIN FURIOUS_QUERYING.CLIENTE c ON c.id = e.cliente_id
    JOIN FURIOUS_QUERYING.BI_SUCURSAL s ON s.nombre = e.sucursal_nombre 
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_HECHOS_PAGO
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_HECHOS_PAGO
    (
      sucursal_id,
      tiempo_id,
      rango_etario_cliente_id,
      medio_de_pago_id,
      tipo_medio_de_pago_id,
      descuento_aplicado,
      cuotas,
      importe  
    )
    SELECT 
        s2.id,
        FURIOUS_QUERYING.BI_SELECT_TIEMPO(p.fecha_y_hora),
        FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO(c.fecha_nacimiento),
        p.medio_de_pago_codigo,
        mp.tipo_medio_de_pago_id,
        p.descuento_aplicado,
        dp.cuotas,
        p.importe
    FROM FURIOUS_QUERYING.PAGO p
    JOIN FURIOUS_QUERYING.SUCURSAL s ON s.nombre = p.sucursal_nombre
	JOIN FURIOUS_QUERYING.BI_SUCURSAL s2 ON s.nombre = s2.nombre    
	JOIN FURIOUS_QUERYING.MEDIO_DE_PAGO mp ON mp.codigo = p.medio_de_pago_codigo
    LEFT JOIN FURIOUS_QUERYING.DETALLE_PAGO dp ON dp.id = p.detalle_pago_id
    LEFT JOIN FURIOUS_QUERYING.CLIENTE c ON c.id = dp.cliente_id
END

GO
CREATE PROCEDURE FURIOUS_QUERYING.BI_MIGRAR_HECHOS_PROMOCIONES_APLICADAS
AS
BEGIN
    INSERT INTO FURIOUS_QUERYING.BI_HECHOS_PROMOCIONES_APLICADAS
        (tiempo_id,subcategoria_id,categoria_id,promo_aplicada_descuento,descripcion)
    SELECT 
    FURIOUS_QUERYING.BI_SELECT_TIEMPO(t.fecha_y_hora),
    pr.subcategoria_id,
	pr.categoria_id,
	SUM(ixp.promo_aplicada_descuento),
    p.descripcion
    FROM FURIOUS_QUERYING.PROMOCION p
    JOIN FURIOUS_QUERYING.ITEM_X_PROMOCION ixp ON p.codigo = ixp.codigo_promocion
	JOIN FURIOUS_QUERYING.PRODUCTO pr ON pr.id = ixp.producto_id
    JOIN FURIOUS_QUERYING.TICKET t ON t.numero = ixp.ticket_numero 
	AND t.sucursal_nombre = ixp.sucursal_nombre 
	AND t.tipo_comprobante_id = ixp.tipo_comprobante_id 
	AND t.fecha_y_hora = ixp.ticket_fecha_y_hora
	GROUP BY t.fecha_y_hora,pr.subcategoria_id,pr.categoria_id,p.descripcion
END

--===================================================EXECS============================================================= 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_TIEMPO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_RANGO_ETARIO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_TURNO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_TIPO_MEDIO_DE_PAGO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_CATEGORIA 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_SUBCATEGORIA 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_PROVINCIA 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_LOCALIDAD

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_SUCURSAL 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_TIPO_CAJA 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_HECHOS_VENTA 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_HECHOS_ENVIO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_HECHOS_PAGO 

GO
EXEC FURIOUS_QUERYING.BI_MIGRAR_HECHOS_PROMOCIONES_APLICADAS 

--===================================================VISTAS============================================================= 
--1: Ticket Promedio mensual. Valor promedio de las ventas (en $) según la
--localidad, año y mes. Se calcula en función de la sumatoria del importe de las
--ventas sobre el total de las mismas.

GO
CREATE VIEW FURIOUS_QUERYING.TICKET_PROMEDIO_MENSUAL
AS
    SELECT SUM(v.total) / COUNT(DISTINCT v.id) AS ValorPromedioVenta, l.localidad_nombre AS Localidad, t.anio AS 'Año', t.mes AS Mes
    FROM FURIOUS_QUERYING.BI_HECHOS_VENTA v JOIN FURIOUS_QUERYING.BI_LOCALIDAD l ON (v.localidad_sucursal_id = l.id)
        JOIN FURIOUS_QUERYING.BI_TIEMPO t ON (v.tiempo_id = t.id)
    GROUP BY l.localidad_nombre,t.anio,t.mes

--2: Cantidad unidades promedio. Cantidad promedio de artículos que se venden
--en función de los tickets según el turno para cada cuatrimestre de cada año. Se
--obtiene sumando la cantidad de artículos de todos los tickets correspondientes
--sobre la cantidad de tickets. Si un producto tiene más de una unidad en un ticket,
--para el indicador se consideran todas las unidades.

GO
CREATE VIEW FURIOUS_QUERYING.CANTIDAD_UNIDADES_PROMEDIO
AS
    SELECT AVG(v.cantidad) 'Unidades promedio por ticket', tu.turno AS 'Turno', ti.cuatrimestre AS 'Cuatrimestre', ti.anio AS 'Año'
    FROM FURIOUS_QUERYING.BI_HECHOS_VENTA v
    JOIN FURIOUS_QUERYING.BI_TIEMPO ti ON v.tiempo_id = ti.id
    JOIN FURIOUS_QUERYING.BI_TURNO tu ON tu.id = v.turno_id
    GROUP BY ti.cuatrimestre,ti.anio,tu.turno
	
--3: Porcentaje anual de ventas registradas por rango etario del empleado según el
--tipo de caja para cada cuatrimestre. Se calcula tomando la cantidad de ventas
--correspondientes sobre el total de ventas anual.

GO
CREATE VIEW FURIOUS_QUERYING.PORCENTAJE_VENTAS_X_RANGO_ETARIO
AS
    SELECT SUM(v.total)/(SELECT SUM(total) FROM FURIOUS_QUERYING.BI_HECHOS_VENTA) * 100 AS 'Porcentaje de ventas',r.rango AS 'Rango',tc.tipo AS 'Tipo',ti.cuatrimestre AS 'Cuatrimestre',ti.anio AS 'Año'
    FROM FURIOUS_QUERYING.BI_HECHOS_VENTA v
    JOIN FURIOUS_QUERYING.BI_RANGO_ETARIO r ON r.id=v.rango_etario_empleado_id
    JOIN FURIOUS_QUERYING.BI_TIEMPO ti ON v.tiempo_id=ti.id
    JOIN FURIOUS_QUERYING.TIPO_CAJA tc ON tc.id=v.tipo_caja_id
    GROUP BY r.rango,tc.tipo,ti.cuatrimestre,ti.anio
  
--4: Cantidad  de  ventas  registradas  por  turno  para  cada  localidad  según  el  mes  de cada año. 

GO
CREATE VIEW FURIOUS_QUERYING.CANTIDAD_VENTAS_POR_TURNO
AS
	SELECT COUNT(v.id) AS 'Cantidad de ventas' , t.anio AS 'Año', t.mes AS 'Mes', tu.turno AS 'Turno'
	FROM FURIOUS_QUERYING.BI_HECHOS_VENTA v
	JOIN FURIOUS_QUERYING.BI_TIEMPO t ON (v.tiempo_id = t.id)
	JOIN FURIOUS_QUERYING.BI_TURNO tu ON (tu.id = v.turno_id)
	GROUP BY t.anio, t.mes, tu.turno

--5: Porcentaje de descuento aplicados en función del total de los tickets según el mes de cada año

GO
CREATE VIEW FURIOUS_QUERYING.PORCENTAJE_DESCUENTO
AS
    SELECT  SUM(v.descuento_aplicado_total) / SUM(v.total) *100 AS 'Porcentaje descuento aplicado', t.mes AS 'Mes', t.anio AS 'Año'
    FROM FURIOUS_QUERYING.BI_HECHOS_VENTA v
    JOIN FURIOUS_QUERYING.BI_TIEMPO t ON (v.tiempo_id = t.id)
    GROUP BY t.mes, t.anio
   
--6: Las tres categorías de productos con mayor descuento aplicado a partir de
--promociones para cada cuatrimestre de cada año.

GO
CREATE VIEW FURIOUS_QUERYING.CATEGORIAS_CON_MAYOR_DESCUENTO
AS
    SELECT categoria_id, anio AS 'Año', cuatrimestre AS 'Cuatrimestre', total_descuento AS 'Total descuento'
    FROM (
    SELECT p.categoria_id, ti.anio, ti.cuatrimestre,
            SUM(p.promo_aplicada_descuento) AS total_descuento,
            ROW_NUMBER() OVER (PARTITION BY ti.anio, ti.cuatrimestre ORDER BY SUM(p.promo_aplicada_descuento) DESC
        ) AS rn
        FROM FURIOUS_QUERYING.BI_HECHOS_PROMOCIONES_APLICADAS p
            JOIN FURIOUS_QUERYING.BI_TIEMPO ti ON ti.id = p.tiempo_id            
        GROUP BY p.categoria_id,ti.anio, ti.cuatrimestre
) AS RankedCategories
    WHERE rn <= 3;
    
--7: Porcentaje  de  cumplimiento  de  envíos  en  los  tiempos  programados  por sucursal por año/mes (desvío) 

GO
CREATE VIEW FURIOUS_QUERYING.PORCENTAJE_ENVIOS_CUMPLIDOS_A_TIEMPO
AS
    SELECT COUNT(CASE WHEN e.enviado_a_tiempo = 1 THEN 1 END) *100 / CAST(COUNT(e.id) AS decimal(18,2)) AS 'Porcentaje de cumplimiento', t.mes AS 'Mes', t.anio AS 'Año', s.nombre 'Nombre Sucursal'
    FROM FURIOUS_QUERYING.BI_HECHOS_ENVIO e
    JOIN FURIOUS_QUERYING.BI_TIEMPO t ON e.tiempo_id = t.id
	JOIN FURIOUS_QUERYING.BI_SUCURSAL s ON s.id = e.sucursal_id
    GROUP BY t.mes, t.anio, s.nombre

--8: Cantidad de envíos por rango etario de clientes para cada cuatrimestre de
--cada año

GO
CREATE VIEW FURIOUS_QUERYING.CANT_ENVIOS_RANGO_ETARIO_CLIENTES
AS
    SELECT COUNT(*) as 'Cantidad de Envios Por Rango Etario',
    r.rango AS 'Rango',
    t.cuatrimestre AS 'Cuatrimestre',
    t.anio AS 'Año'
    FROM FURIOUS_QUERYING.BI_HECHOS_ENVIO e 
    JOIN FURIOUS_QUERYING.BI_TIEMPO t ON e.tiempo_id = t.id
    JOIN FURIOUS_QUERYING.BI_RANGO_ETARIO r ON r.id = e.rango_etario_cliente_id
    GROUP BY r.rango,t.cuatrimestre,t.anio

--9: Las 5 localidades (tomando la localidad del cliente) con mayor costo de envío.

GO
CREATE VIEW FURIOUS_QUERYING.LOCALIDADES_MAYOR_COSTO_ENVIO
AS
    SELECT TOP 5 e.costo_envio AS 'Costo de envío', l.localidad_nombre AS 'Nombre de la localidad'
    FROM FURIOUS_QUERYING.BI_HECHOS_ENVIO e JOIN FURIOUS_QUERYING.BI_LOCALIDAD l ON e.localidad_cliente_id = l.id
	ORDER BY e.costo_envio DESC
	
--10: Las 3 sucursales con el mayor importe de pagos en cuotas, según el medio de
--pago, mes y año. Se calcula sumando los importes totales de todas las ventas en
--cuotas.

GO
CREATE VIEW FURIOUS_QUERYING.SUCURSALES_MAYOR_IMPORTE_EN_CUOTAS
AS
 SELECT 
        Importe, 
        nombre AS 'Nombre de la sucursal', 
        descripcion AS 'Descripción', 
        mes AS 'Mes', 
        anio AS 'Año'
    FROM (
        SELECT 
            SUM(p.importe) AS Importe, 
            s.nombre, 
            mp.descripcion, 
            t.mes, 
            t.anio,
            ROW_NUMBER() OVER (PARTITION BY mp.descripcion, t.mes, t.anio ORDER BY SUM(p.importe) DESC) AS rn
        FROM 
            FURIOUS_QUERYING.BI_HECHOS_PAGO p
        JOIN 
            FURIOUS_QUERYING.BI_TIEMPO t ON p.tiempo_id = t.id
        JOIN 
            FURIOUS_QUERYING.BI_SUCURSAL s ON s.id = p.sucursal_id
        JOIN 
            FURIOUS_QUERYING.BI_MEDIO_DE_PAGO mp ON mp.id = p.medio_de_pago_id
        GROUP BY 
            s.nombre, 
            mp.descripcion, 
            t.mes, 
            t.anio
    ) AS subquery
    WHERE rn <= 3;

--11: Promedio de importe de la cuota en función del rango etareo del cliente.

GO
CREATE VIEW FURIOUS_QUERYING.PROMEDIO_IMPORTE_CUOTA_POR_RANGO_ETARIO_DEL_CLIENTE
AS
    SELECT
	SUM(p.importe)/SUM(p.cuotas) AS 'Importe Promedio de la Cuota',
	r.rango AS 'Rango'
    FROM FURIOUS_QUERYING.BI_HECHOS_PAGO p
	JOIN FURIOUS_QUERYING.BI_RANGO_ETARIO r ON r.id = p.rango_etario_cliente_id
	GROUP BY r.rango

--12: Porcentaje de descuento aplicado por cada medio de pago en función del valor
--de total de pagos sin el descuento, por cuatrimestre. Es decir, total de descuentos
--sobre el total de pagos más el total de descuentos.

GO
CREATE VIEW FURIOUS_QUERYING.PORCENTAJE_DESCUENTO_POR_MEDIO_DE_PAGO
AS
    SELECT SUM(p.descuento_aplicado) / SUM(p.importe + p.descuento_aplicado)  * 100 AS 'Porcentaje de descuento', mp.descripcion AS 'Descripción', t.cuatrimestre AS 'Cuatrimestre'
    FROM FURIOUS_QUERYING.BI_HECHOS_PAGO p
    JOIN FURIOUS_QUERYING.BI_TIEMPO t ON t.id = p.tiempo_id
    JOIN FURIOUS_QUERYING.BI_MEDIO_DE_PAGO mp ON mp.id = p.medio_de_pago_id
    GROUP BY mp.descripcion, t.cuatrimestre
	