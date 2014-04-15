--4) Listar la c�dula de identidad y nombre de los inspectores l�deres que haya sido designados por 
--   alguna agencia gubernamental para realizar inspecciones una �nica vez.

USE Prueba;

SELECT barCI, Nombre
FROM [Prueba].[dbo].[INSPECTOR] I
GROUP BY barCI, Nombre, CodInspector
HAVING 1 = (SELECT COUNT(*)
		    FROM [Prueba].[dbo].[INSPECCION_SOLICITADA] I2
			WHERE I.CodInspector = I2.fooCodInspector)

