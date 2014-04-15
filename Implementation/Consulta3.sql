--3) Listar los RUT, nombre y direcci�n de todas las petroqu�micas que no hayan 
--   arrendado ninguna v�lvula en lo que va del a�o.

USE Prueba;

SELECT RUTCliente, NombreCli, Direccion
FROM [Prueba].[dbo].[EMPRESA_CLIENTE] E
GROUP BY RUTCliente, NombreCli, Direccion
HAVING 0 = (SELECT COUNT(*)
			FROM  [Prueba].[dbo].[ARRIENDA] A
			WHERE E.RUTCliente = A.fooRUTCliete)