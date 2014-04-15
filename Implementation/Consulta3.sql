--3) Listar los RUT, nombre y dirección de todas las petroquímicas que no hayan 
--   arrendado ninguna válvula en lo que va del año.

USE Prueba;

SELECT RUTCliente, NombreCli, Direccion
FROM [Prueba].[dbo].[EMPRESA_CLIENTE] E
GROUP BY RUTCliente, NombreCli, Direccion
HAVING 0 = (SELECT COUNT(*)
			FROM  [Prueba].[dbo].[ARRIENDA] A
			WHERE E.RUTCliente = A.fooRUTCliete)