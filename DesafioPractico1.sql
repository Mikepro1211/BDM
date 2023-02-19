/*Creacion de base de datos*/
CREATE DATABASE Museo_Metropolitano_de_arte
use Museo_Metropolitano_de_arte
/*Creacion de tablas en base de dato*/
CREATE TABLE Piezas (codigo varchar(5) primary key not null,Nombre varchar(50))
CREATE TABLE Pintores (Id_Pintor varchar (5) primary key not null , Nombre varchar(50))
CREATE TABLE Expocision (CODPIEZA varchar(5) primary key not null, IDPINTOR varchar(5) not null,  Precio decimal(7,2))
/*Alter en tablas de datos (Foreign key)*/
Alter Table Expocision  add constraint  fk_codigo_pieza foreign key (CODPIEZA) references Piezas(codigo)
Alter table Expocision  add constraint fk_codigo_pintor foreign key (IDPINTOR) references Pintores(Id_Pintor)
/*Insert into piezas*/
INSERT INTO Piezas (codigo,Nombre) values('PA001','La última Cena')
INSERT INTO Piezas (codigo,Nombre) values('PA002','La Gioconda')
INSERT INTO Piezas (codigo,Nombre) values('PA003','La noche estrellada')
INSERT INTO Piezas (codigo,Nombre) values('PA004','Las Tres Gracias')
INSERT INTO Piezas (codigo,Nombre) values('PA005','El Grito')
INSERT INTO Piezas (codigo,Nombre) values('PA006','El Guernica')
INSERT INTO Piezas (codigo,Nombre) values('PA007','La Creacion de Adán')
INSERT INTO Piezas (codigo,Nombre) values('PA008','Los Girasoles')
INSERT INTO Piezas (codigo,Nombre) values('PA009','La tentación de San Antonio')
INSERT INTO Piezas (codigo,Nombre) values('PA010','Los fusilamientos del 3 de mayo')
INSERT INTO Piezas (codigo,Nombre) values('PA011','El taller de BD')
select* From Piezas
/*Insert into Pintores */
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA001','Goya')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA002','Dalí')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA003','Van Gogh')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA004','Miguel Angel')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA005','Pablo Picasso')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA006','Rubens')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA007','Da Vinci')
INSERT INTO  Pintores (Id_Pintor,Nombre) values ('NA008','Kevin')

/*Promedio dos decimales*/
SELECT cast(AVG(Precio)as decimal(10,2)) AS [Promedio de valor] FROM Expocision
/*4*/
select p.Nombre,z.Nombre from Expocision e 
inner join Pintores p on e.IDPINTOR = p.Id_Pintor
inner join Piezas z on e.CODPIEZA = z.codigo where Z.Nombre='El grito'
/*5*/
select p.Nombre,z.Nombre from Expocision e 
inner join Pintores p on e.IDPINTOR = p.Id_Pintor
inner join Piezas z on e.CODPIEZA = z.codigo where p.Nombre='Van Gogh'
/*^6*/
select Nombre from (select z.Nombre ,ROW_NUMBER()over (order by e.Precio DESC)
AS RN FROM Expocision e inner join Piezas z on e.CODPIEZA = z.codigo) AS T where t.rn=1
/*Obtener el nombre de los 3 pintores que suministran las piezas más caras, indicando el
nombre de la pieza y el precio de la obra de arte.*/
select z.Nombre , e.Precio from Expocision e 
inner join Piezas z on e.CODPIEZA = z.codigo where e.Precio in (select DISTINCT TOP 3 Precio FROM Expocision ORDER BY Precio DESC)Order By e.Precio DESC

/*8.	Nombre de los pintores en exposición y su cantidad de cuadros respectivos.*/
SELECT p.Nombre,count(z.Nombre) as Cantidad_de_cuadro  from Expocision e inner join Pintores p on e.IDPINTOR=p.Id_Pintor
inner join Piezas z on e.CODPIEZA = z.codigo group by p.Nombre
/*Nombre de los cuadros de los pintores Van Gogh y Da Vinci.*/
select p.Nombre,z.Nombre from Expocision e 
inner join Pintores p on e.IDPINTOR = p.Id_Pintor
inner join Piezas z on e.CODPIEZA = z.codigo where p.Nombre='Van Gogh' or p.Nombre = 'Da Vinci'

/* Aumentar los precios de las piezas en una unidad.*/
Update Expocision set Precio = Precio+1 
select *from Pintores
/*Sustituir los datos del pintor Van Gogh por el nombre “Vincent Van Gogh”*/
update Pintores   set Nombre ='Vincent Van Gogh' where Nombre = 'Van Gogh'
/*Sustituir los datos del pintor Da Vinci por el nombre “Leonardo Da Vinci”.*/
update Pintores   set Nombre ='Leonardo Da Vinci' where Nombre = 'Da Vinci'
/*. Hacer constar en la base de datos que el artista Kevin ya no va a exponer ningún cuadro
en nuestro Museo. (Aunque el pintor en si va a seguir en nuestra base de datos)*/
select case when exists(select 1 from Expocision e inner join Pintores p on e.IDPINTOR = p.Nombre where p.Nombre ='Kevin' ) then 'El artista Kevin  
va exponer ningun cuadro en nuestro museo' else 'El artista Kevin ya no 
va exponer ningun cuadro en nuestro museo' END AS Mensaje

delete from Expocision where IDPINTOR ='NA002'
select * from Expocision

