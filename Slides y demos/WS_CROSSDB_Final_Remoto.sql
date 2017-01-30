--=============================================================
-- Creamos en remoto la tabla que contiene los datos y añadimos unos pocos
-- =============================================================

CREATE USER PandaUser FROM LOGIN PandaLogin;

CREATE TABLE Cambios
  (ID int IDENTITY PRIMARY KEY,
   Nombre varchar(100)  NULL,
   Apellido varchar(100) NOT NULL,
   NrTlf varchar(12)  NULL,
   Email varchar(100)  NULL, 
   UserID int );


INSERT Cambios (Nombre, Apellido, NrTlf, Email, UserId) VALUES 
('Roberto', 'Torres', '91551234567', 'RTorres@contoso.com', 5),
('Juan', 'Galvin', '95551234568', 'JGalvin@contoso.com', 5),
('José', 'Garcia', '95551234569', 'Jgarcia@contoso.net',1);

GRANT select ON [Cambios] TO PandaUser;
