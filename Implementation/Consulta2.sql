--2) Listar para cada válvula la cantidad de veces que fueron arrendadas 
--	 siempre que hayan sido arrendadas mas de 1 vez (por la misma petroquímica u otra).

USE Prueba;

SELECT fooSerie, COUNT(fooSerie) AS CantidadVeces
FROM [Prueba].[dbo].[ARRIENDA]
GROUP BY fooSerie 
HAVING COUNT(fooSerie) > 1