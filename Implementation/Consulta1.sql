--1) Listar ordenado por n�mero de v�lvula descendente y fecha ascendente los siguientes atributos: 
--	 n�mero de v�lvula, n�mero de inspecci�n, fecha en la que se realiz� y la (breve) descripci�n de cada una de 
--	 las inspecciones peri�dicas que se hicieron a las v�lvulas n�mero 12345 y 4321.

USE Prueba;

SELECT fooSerie, barCodInterna, FechaDeVisita, Descripcion
FROM [Prueba].[dbo].[INSPECCION_PERIODICA] 
WHERE (fooSerie = 12345
OR fooSerie = 4321)
AND DATEPART(YEAR, FechaDeVisita) = DATEPART(YEAR, GETDATE())
ORDER BY fooSerie DESC, FechaDeVisita ASC