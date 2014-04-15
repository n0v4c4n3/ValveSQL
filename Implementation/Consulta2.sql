--2) Listar para cada v�lvula la cantidad de veces que fueron arrendadas 
--	 siempre que hayan sido arrendadas mas de 1 vez (por la misma petroqu�mica u otra).

USE Prueba;

SELECT fooSerie, COUNT(fooSerie) AS CantidadVeces
FROM [Prueba].[dbo].[ARRIENDA]
GROUP BY fooSerie 
HAVING COUNT(fooSerie) > 1