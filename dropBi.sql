DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_TIEMPO
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_UBICACION
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_SUCURSAL
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_RANGO_ETARIO
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_TURNO
DROP TABLE IF EXISTS BI_TURNO
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_MEDIO_DE_PAGO
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_CATEGORIA_SUBCATEGORIA
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_ENVIO
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_TICKET
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_VENTA
DROP TABLE IF EXISTS FURIOUS_QUERYING.BI_VENTA_X_ITEM

DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_TIEMPO
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_UBICACION
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.BI_MIGRAR_SUCURSAL
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_RANGO_ETARIO
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_TURNOS
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.BI_MIGRAR_MEDIO_DE_PAGO
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_VENTA_X_ITEM
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_CATEGORIA_SUBCATEGORIA
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_BI_ENVIO
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_BI_TICKET
DROP PROCEDURE IF EXISTS FURIOUS_QUERYING.MIGRAR_VENTA

DROP FUNCTION IF EXISTS FURIOUS_QUERYING.BI_SELECT_TIEMPO
DROP FUNCTION IF EXISTS FURIOUS_QUERYING.BI_SELECT_UBICACION
DROP FUNCTION IF EXISTS FURIOUS_QUERYING.BI_SELECT_RANGO_ETARIO
DROP FUNCTION IF EXISTS FURIOUS_QUERYING.BI_SELECT_TURNO
DROP FUNCTION IF EXISTS FURIOUS_QUERYING.CANTIDAD_ITEMS
DROP FUNCTION IF EXISTS FURIOUS_QUERYING.BI_SELECT_UBICACION_CLIENTE

DROP VIEW IF EXISTS FURIOUS_QUERYING.TICKET_PROMEDIO_MENSUAL
DROP VIEW IF EXISTS FURIOUS_QUERYING.CANTIDAD_UNIDADES_PROMEDIO
DROP VIEW IF EXISTS FURIOUS_QUERYING.PORCENTAJE_VENTAS_X_RANGO_ETARIO
DROP VIEW IF EXISTS FURIOUS_QUERYING.CANTIDAD_VENTAS_POR_TURNO
DROP VIEW IF EXISTS FURIOUS_QUERYING.PORCENTAJE_ENVIOS_CUMPLIDOS_A_TIEMPO
DROP VIEW IF EXISTS FURIOUS_QUERYING.CATEGORIAS_CON_MAYOR_DESCUENTO
DROP VIEW IF EXISTS FURIOUS_QUERYING.PORCENTAJE_DESCUENTO
DROP VIEW IF EXISTS FURIOUS_QUERYING.CANT_ENVIOS_RANGO_ETARIO_CLIENTES
DROP VIEW IF EXISTS FURIOUS_QUERYING.LOCALIDADES_MAYOR_COSTO_ENVIO

