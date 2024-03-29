Create Table MI_EMPRESA
    ( RUTMiEmpresa      NUMERIC(12)        NOT NULL,
      Nombre            VARCHAR(15)        NOT NULL,
      Direccion         VARCHAR(30),
      TelContacto       INT,        
      CantidadPersonal  INT, 
PRIMARY KEY (RUTMiEmpresa));

Create Table VALVULA 
    ( Serie             VARCHAR(30)        NOT NULL,
      Descripcion       VARCHAR(30),            
      Diametro_entrada  DECIMAL(3,1)       NOT NULL,
      Bool_disponible   BIT			       NOT NULL,
      fooRUTMiEmpresa   NUMERIC(12)        NOT NULL,
PRIMARY KEY (Serie),
FOREIGN KEY (fooRUTMiEmpresa) REFERENCES MI_EMPRESA(RUTMiEmpresa));

Create Table RETENCION
    ( CodigoRetencion   CHAR(6)         NOT NULL,
	  fooSerie			VARCHAR(30)  	NOT NULL,
PRIMARY KEY (CodigoRetencion),
FOREIGN KEY (fooSerie) REFERENCES VALVULA(Serie));

Create Table AGUJA
    ( CodigoAguja       CHAR(6)         NOT NULL,
	  barSerie			VARCHAR(30)		NOT NULL,
PRIMARY KEY (CodigoAguja),
FOREIGN KEY (barSerie) REFERENCES VALVULA(Serie));

Create Table EMPRESA_CLIENTE
    ( NombreCli         VARCHAR(15),        
      RUTCliente        NUMERIC(12)        NOT NULL,
      Telefono          INT,
      Direccion         VARCHAR(30),
PRIMARY KEY (RUTCliente));

Create Table AGENCIA_GUB 
    ( RUTGub            NUMERIC(12)        NOT NULL,
      NombreGub         VARCHAR(15),            
      Direccion         VARCHAR(30),
PRIMARY KEY (RUTGub));

Create Table INSPECCION
    ( ID                INT             NOT NULL,
      Descripcion       VARCHAR(30),       
PRIMARY KEY (ID));

Create Table EXTERNA
    ( CodExterna        VARCHAR(30)     NOT NULL,
      Fecha             DATE		    NOT NULL,
      TiempoMinimo      INT             NOT NULL,
      fooRut            NUMERIC(12)     NOT NULL,
	  fooID             INT             NOT NULL,
PRIMARY KEY (CodExterna),
FOREIGN KEY (fooID) REFERENCES INSPECCION(ID));

Create Table INTERNA
    ( CodInterna        VARCHAR(30)     NOT NULL,
      Itinerancia       DATE            NOT NULL,
	  barID             INT             NOT NULL, 
PRIMARY KEY (CodInterna),
FOREIGN KEY (barID) REFERENCES INSPECCION(ID));

Create Table PERSONA
    ( FechaNacimiento   DATE            NOT NULL,
      Cel               INT,                
      Edad              INT             NOT NULL,
      CI                INT             NOT NULL,  
PRIMARY KEY (CI));

Create Table PERSONAL
    ( Email             VARCHAR(20)     NOT NULL,
      NSS               CHAR(9)         NOT NULL,
      fooRutMiEmpresa   NUMERIC(12)     NOT NULL,      
	  fooCI             INT             NOT NULL,
PRIMARY KEY (NSS, fooRutMiEmpresa),
UNIQUE (Email),
FOREIGN KEY (fooRutMiEmpresa) REFERENCES MI_EMPRESA(RUTMiEmpresa),
FOREIGN KEY (fooCI) REFERENCES PERSONA(CI));

Create Table INSPECTOR
    ( CodInspector      VARCHAR(30)     NOT NULL,
      Especialidad      VARCHAR(30),          
	  barCI             INT             NOT NULL,
	  Nombre			VARCHAR(30),	
PRIMARY KEY (CodInspector),
FOREIGN KEY (barCI) REFERENCES PERSONA(CI));

Create Table SUCURSAL 
    ( NFS               CHAR(9)         NOT NULL,
      Direccion         VARCHAR(30),            
      BoolCasaCentral   BIT	            NOT NULL,
      fooRUTCliente     NUMERIC(12)        NOT NULL,
PRIMARY KEY (NFS, fooRUTCliente),
FOREIGN KEY (fooRUTCliente) REFERENCES MI_EMPRESA(RUTMiEmpresa));

Create Table ZONA 
    ( CodZona           CHAR(5)         NOT NULL,
      Descripcion       VARCHAR(30)     NOT NULL,
      fooSerie          VARCHAR(30),
      barNFS            CHAR(9)         NOT NULL,
      barRUTCliente     NUMERIC(12)     NOT NULL,
PRIMARY KEY (CodZona, barNFS, barRUTCliente),
FOREIGN KEY (barNFS, barRUTCliente) REFERENCES SUCURSAL(NFS, fooRUTCliente));

Create Table PAIS
    ( CodPais           CHAR(2)         NOT NULL,
      Nombre            VARCHAR(30),       
PRIMARY KEY (CodPais));

Create Table DEPARTAMENTO
    ( CodDep            CHAR(3)         NOT NULL,
      Nombre            VARCHAR(30),
      fooCodPais        CHAR(2)         NOT NULL,
PRIMARY KEY (CodDep),
FOREIGN KEY (fooCodPais) REFERENCES PAIS(CodPais));

Create Table CIUDAD
    ( CodPostal         VARCHAR(5)      NOT NULL,
      Nombre            VARCHAR(30),
      fooCodDep         CHAR(3)         NOT NULL,
PRIMARY KEY (CodPostal),
FOREIGN KEY (fooCodDep) REFERENCES DEPARTAMENTO(CodDep));

Create Table ARRIENDA
    ( NumFactura        INT             NOT NULL,
      FechaIni          DATE            NOT NULL,
      FechaDebe         DATE            NOT NULL,
      Importe           MONEY           NOT NULL,
      FechaDevuelta     DATE,           
      fooSerie          VARCHAR(30)     NOT NULL,
      fooRUTCliete      NUMERIC(12)     NOT NULL,
PRIMARY KEY (NumFactura),
FOREIGN KEY (fooSerie) REFERENCES VALVULA(Serie),
FOREIGN KEY (fooRUTCliete) REFERENCES EMPRESA_CLIENTE(RUTCliente));

Create Table INSPECCION_PERIODICA
    ( Estado            INT             NOT NULL,
      VidaEstimadaRestante DATE,
      FechaDeVisita     DATE            NOT NULL,
      fooNSS            CHAR(9)         NOT NULL,
      fooSerie          VARCHAR(30)     NOT NULL,           
      barCodInterna     VARCHAR(30)     NOT NULL,
	  barRutMiEmpresa   NUMERIC(12)     NOT NULL,
	  Descripcion		VARCHAR(30),
PRIMARY KEY (FechaDeVisita, barCodInterna),
FOREIGN KEY (barCodInterna) REFERENCES INTERNA(CodInterna),
FOREIGN KEY (fooNSS, barRutMiEmpresa) REFERENCES PERSONAL(NSS, fooRutMiEmpresa),
FOREIGN KEY (fooSerie) REFERENCES VALVULA(Serie));

Create Table CONTRATA 
    ( InicioDeContrato  DATE            NOT NULL,
      FinDeContrato     DATE            NOT NULL,
      barRUTMiEmpresa   NUMERIC(12)        NOT NULL,
      fooNSS            CHAR(9)         NOT NULL,
PRIMARY KEY (InicioDeContrato, FinDeContrato, fooNSS),
FOREIGN KEY (barRUTMiEmpresa) REFERENCES MI_EMPRESA(RUTMiEmpresa),
FOREIGN KEY (fooNSS, barRUTMiEmpresa) REFERENCES PERSONAL(NSS, fooRUTMiEmpresa));

Create Table COLOCADA_EN 
    ( fooSerie          VARCHAR(30)     NOT NULL,
      bazNFS            CHAR(9)         NOT NULL,
      bazRUTCliente     NUMERIC(12)     NOT NULL,
      fooCodZona        CHAR(5)         NOT NULL,
PRIMARY KEY (fooSerie, bazNFS, bazRUTCliente, fooCodZona),
FOREIGN KEY (fooSerie) REFERENCES VALVULA(Serie),
FOREIGN KEY (fooCodZona, bazNFS, bazRUTCliente) REFERENCES ZONA(CodZona, barNFS, barRUTCliente));

Create Table INSPECCION_SOLICITADA
    ( Descripcion       VARCHAR(30)     NOT NULL,
      FechaDeVisita     DATE            NOT NULL,
      BoolDenunciado    INT             NOT NULL,
      VidaEstimadaRestante DATE,
      fooCodInspector   VARCHAR(30)     NOT NULL,           
      fooSerie          VARCHAR(30)     NOT NULL,
      barCodExterna     VARCHAR(30)     NOT NULL,
PRIMARY KEY (FechaDeVisita, barCodExterna),
FOREIGN KEY (barCodExterna) REFERENCES EXTERNA(CodExterna),
FOREIGN KEY (fooCodInspector) REFERENCES INSPECTOR(CodInspector),
FOREIGN KEY (fooSerie) REFERENCES VALVULA(Serie));


--DATOS DE PRUEBA

INSERT INTO MI_EMPRESA VALUES (123456789123, 'LaEmpresa', '18 De Julio 2020',4026655, 4);

INSERT INTO VALVULA VALUES (12345, 'Descripcion1', 3.2, 0, 123456789123);
INSERT INTO VALVULA VALUES (123, 'Descripcion2', 3.6, 0, 123456789123);
INSERT INTO VALVULA VALUES (4321, 'Descripcion3', 3.2, 0, 123456789123);
INSERT INTO VALVULA VALUES (432, 'Descripcion4', 3.1, 0, 123456789123);
INSERT INTO VALVULA VALUES (555, 'Descripcion5', 3.8, 1, 123456789123);
INSERT INTO VALVULA VALUES (2121, 'Descripcion6', 3.7, 0, 123456789123);
INSERT INTO VALVULA VALUES (4123, 'Descripcion7', 3.3, 0, 123456789123);
INSERT INTO VALVULA VALUES (7854, 'Descripcion8', 3.0, 0, 123456789123);

INSERT INTO RETENCION VALUES ('RET123', 12345);
INSERT INTO RETENCION VALUES ('RET124', 123);
INSERT INTO RETENCION VALUES ('RET125', 2121);
INSERT INTO RETENCION VALUES ('RET126', 4123);

INSERT INTO AGUJA VALUES ('AGU123', 4321);
INSERT INTO AGUJA VALUES ('AGU124', 432);
INSERT INTO AGUJA VALUES ('AGU125', 7854);

INSERT INTO EMPRESA_CLIENTE VALUES ('Cliente1', 987654321987, 4065868, 'Pereira 854');
INSERT INTO EMPRESA_CLIENTE VALUES ('Cliente2', 654987321987, 4070858, 'Brazil 256');
INSERT INTO EMPRESA_CLIENTE VALUES ('Cliente3', 864965421982, 7021564, 'Rodo 1515');
INSERT INTO EMPRESA_CLIENTE VALUES ('Cliente4', 253966523562, 4050765, 'Varela 152');
INSERT INTO EMPRESA_CLIENTE VALUES ('Cliente5', 245386373213, 4020442, 'Rio Negro 214');

INSERT INTO AGENCIA_GUB VALUES (987654321456, 'Gub1', 'Mendoza 152');
INSERT INTO AGENCIA_GUB VALUES (123321123321, 'Gub2', 'San Martin 847');
INSERT INTO AGENCIA_GUB VALUES (543867124534, 'Gub3', 'Artigas 641');

INSERT INTO INSPECCION VALUES (1, 'IncspeccionInterna1');
INSERT INTO INSPECCION VALUES (2, 'IncspeccionInterna2');
INSERT INTO INSPECCION VALUES (3, 'IncspeccionInterna3');
INSERT INTO INSPECCION VALUES (4, 'IncspeccionInterna4');
INSERT INTO INSPECCION VALUES (5, 'IncspeccionInterna5');
INSERT INTO INSPECCION VALUES (6, 'IncspeccionInterna6');

INSERT INTO EXTERNA  VALUES ('EXT1', '2011-03-30', 5, 987654321456, 4);
INSERT INTO EXTERNA  VALUES ('EXT2', '2011-04-30', 6, 987654321456, 5);
INSERT INTO EXTERNA  VALUES ('EXT3', '2011-05-30', 7, 987654321456, 6);
INSERT INTO EXTERNA  VALUES ('EXT4', '2012-06-30', 4, 987654321456, 3);
INSERT INTO EXTERNA  VALUES ('EXT5', '2013-07-29', 3, 987654321456, 5);
INSERT INTO EXTERNA  VALUES ('EXT6', '2013-04-04', 2, 987654321456, 2);
INSERT INTO EXTERNA  VALUES ('EXT7', '2013-06-06', 2, 987654321456, 5);

INSERT INTO INTERNA VALUES ('INT1', '2012-03-29', 1);
INSERT INTO INTERNA VALUES ('INT2', '2012-04-29', 2);
INSERT INTO INTERNA VALUES ('INT3', '2012-05-29', 3);
INSERT INTO INTERNA VALUES ('INT4', '2012-06-29', 4);
INSERT INTO INTERNA VALUES ('INT5', '2012-07-29', 5);

INSERT INTO PERSONA VALUES ('1993-03-02', 099256521, 20, 15023251);
INSERT INTO PERSONA VALUES ('1992-05-04', 099356521, 21, 21022251);
INSERT INTO PERSONA VALUES ('1990-05-04', 099252421, 23, 11023351);
INSERT INTO PERSONA VALUES ('1992-08-04', 099366585, 21, 12023351);
INSERT INTO PERSONA VALUES ('1989-08-04', 099456582, 25, 11123322);
INSERT INTO PERSONA VALUES ('1988-08-04', 099268687, 26, 22123353);
INSERT INTO PERSONA VALUES ('1982-08-04', 099268687, 30, 18624538);
INSERT INTO PERSONA VALUES ('1992-08-04', 099268687, 21, 45378362);

INSERT INTO PERSONAL VALUES ('pepito@asd.com', 123456789, 123456789123, 15023251);
INSERT INTO PERSONAL VALUES ('juan@asd.com', 213456789, 123456789123, 21022251);
INSERT INTO PERSONAL VALUES ('vago@asd.com', 243316597, 123456789123, 18624538);

INSERT INTO INSPECTOR VALUES ('INSP1', 'Tuercas', 11023351, 'Juan');
INSERT INTO INSPECTOR VALUES ('INSP2', 'Canios', 12023351, 'Pablo');
INSERT INTO INSPECTOR VALUES ('INSP3', 'Aceros', 11123322, 'Pepe');
INSERT INTO INSPECTOR VALUES ('INSP4', 'Seguridad', 22123353, 'Julio');
INSERT INTO INSPECTOR VALUES ('INSP5', 'Motores', 45378362, 'Marta');

INSERT INTO ARRIENDA VALUES (1, '2012-07-19', '2012-08-19', 5000, NULL, 12345, 987654321987);
INSERT INTO ARRIENDA VALUES (2, '2012-05-19', '2012-06-19', 2000, NULL, 123, 987654321987);
INSERT INTO ARRIENDA VALUES (3, '2012-04-26', '2012-05-26', 3000, NULL, 4321, 654987321987);
INSERT INTO ARRIENDA VALUES (4, '2013-04-26', '2013-05-26', 3000, NULL, 4321, 654987321987);
INSERT INTO ARRIENDA VALUES (5, '2012-02-20', '2012-03-20', 4000, NULL, 432, 654987321987);
INSERT INTO ARRIENDA VALUES (6, '2013-02-20', '2013-03-20', 4000, NULL, 432, 654987321987);
INSERT INTO ARRIENDA VALUES (7, '2014-02-20', '2014-03-20', 4000, NULL, 432, 654987321987);
INSERT INTO ARRIENDA VALUES (8, '2012-01-01', '2013-01-01', 1500, NULL, 7854, 253966523562);

INSERT INTO INSPECCION_PERIODICA VALUES (5, '2015-02-12', '2013-02-04', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 5');
INSERT INTO INSPECCION_PERIODICA VALUES (3, '2016-02-12', '2013-03-03', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 3');
INSERT INTO INSPECCION_PERIODICA VALUES (8, '2012-05-12', '2013-04-02', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 8');
INSERT INTO INSPECCION_PERIODICA VALUES (6, '2014-02-12', '2013-03-23', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 6');
INSERT INTO INSPECCION_PERIODICA VALUES (2, '2014-03-21', '2013-05-08', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 2');
INSERT INTO INSPECCION_PERIODICA VALUES (4, '2016-04-12', '2013-04-12', 213456789, 4321, 'INT2', 123456789123, 'Descripcion para puntuacion 4');
INSERT INTO INSPECCION_PERIODICA VALUES (6, '2014-08-02', '2013-05-02', 213456789, 4321, 'INT2', 123456789123, 'Descripcion para puntuacion 6');
INSERT INTO INSPECCION_PERIODICA VALUES (6, '2014-08-02', '2010-04-08', 213456789, 4321, 'INT2', 123456789123, 'Descripcion para puntuacion 6');
INSERT INTO INSPECCION_PERIODICA VALUES (6, '2014-02-12', '2015-03-14', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 6');
INSERT INTO INSPECCION_PERIODICA VALUES (2, '2014-02-12', '2009-02-20', 123456789, 12345, 'INT1', 123456789123, 'Descripcion para puntuacion 2');
INSERT INTO INSPECCION_PERIODICA VALUES (3, '2013-02-02', '2012-08-08', 213456789, 4321, 'INT2', 123456789123, 'Descripcion para puntuacion 1');
INSERT INTO INSPECCION_PERIODICA VALUES (8, '2013-02-12', '2013-02-22', 123456789, 123, 'INT3', 123456789123, 'Descripcion para puntuacion 8');
INSERT INTO INSPECCION_PERIODICA VALUES (7, '2013-02-02', '2013-08-06', 213456789, 7854, 'INT4', 123456789123, 'Descripcion para puntuacion 7');

INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion1', '2012-03-30', 0, '2013-03-30', 'INSP1', 123, 'EXT1');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion2', '2012-05-10', 0, '2013-05-10', 'INSP2', 123, 'EXT2');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion3', '2012-06-05', 0, '2013-06-05', 'INSP2', 123, 'EXT3');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion4', '2012-07-03', 1, '2013-07-03', 'INSP3', 432, 'EXT4');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion5', '2013-05-03', 0, '2013-08-02', 'INSP3', 12345, 'EXT5');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion6', '2013-04-03', 0, '2013-06-06', 'INSP2', 12345, 'EXT6');
INSERT INTO INSPECCION_SOLICITADA VALUES ('Descripcion6', '2012-03-03', 0, '2013-06-06', 'INSP4', 4321, 'EXT7');