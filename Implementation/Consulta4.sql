--4) Listar la cédula de identidad y nombre de los inspectores líderes que haya sido designados por 
--   alguna agencia gubernamental para realizar inspecciones una única vez.

USE Prueba;

SELECT barCI, Nombre
FROM [Prueba].[dbo].[INSPECTOR] I
GROUP BY barCI, Nombre, CodInspector
HAVING 1 = (SELECT COUNT(*)
		    FROM [Prueba].[dbo].[INSPECCION_SOLICITADA] I2
			WHERE I.CodInspector = I2.fooCodInspector)

