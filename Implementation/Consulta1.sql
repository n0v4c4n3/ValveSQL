--1) Listar ordenado por número de válvula descendente y fecha ascendente los siguientes atributos: 
--	 número de válvula, número de inspección, fecha en la que se realizó y la (breve) descripción de cada una de 
--	 las inspecciones periódicas que se hicieron a las válvulas número 12345 y 4321.

USE Prueba;

SELECT fooSerie, barCodInterna, FechaDeVisita, Descripcion
FROM [Prueba].[dbo].[INSPECCION_PERIODICA] 
WHERE (fooSerie = 12345
OR fooSerie = 4321)
AND DATEPART(YEAR, FechaDeVisita) = DATEPART(YEAR, GETDATE())
ORDER BY fooSerie DESC, FechaDeVisita ASC