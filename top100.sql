--desafio top 100
-- Crear base de datos llamada películas 
CREATE DATABASE peliculas;
--Revisar los archivos peliculas.csv y reparto.csv para crear las tablas correspondientes,
--determinando la relación entre ambas tablas
CREATE TABLE peliculas(id SERIAL PRIMARY KEY, pelicula VARCHAR(100) NOT NULL, año_estreno INT, director VARCHAR(100));
CREATE TABLE reparto(id_pelicula INT, actor VARCHAR(100) NOT NULL);
ALTER TABLE reparto ADD FOREIGN KEY(id_pelicula) REFERENCES peliculas(id);
--. Cargar ambos archivos a su tabla correspondiente 
\copy peliculas FROM '~/Escritorio/peliculas.csv' CSV HEADER
\copy reparto FROM '~/Escritorio/reparto.csv' CSV
-- Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,
--año de estreno, director y todo el reparto
SELECT pelicula, año_estreno, director, actor FROM peliculas p, reparto r WHERE p.pelicula='Titanic' AND r.id_pelicula=p.id;
--Listar los titulos de las películas donde actúe Harrison Ford.
SELECT pelicula  FROM peliculas p, reparto r WHERE r.actor='Harrison Ford' AND r.id_pelicula=p.id;
--. Listar los 10 directores mas populares, indicando su nombre y cuántas películas aparecen en el
--top 100
SELECT director, COUNT(*) AS numpeliculas FROM peliculas GROUP BY director ORDER BY numpeliculas DESC LIMIT(10);
-- Indicar cuantos actores distintos hay 
SELECT COUNT(DISTINCT actor) FROM reparto;
--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos) ordenadas por
--título de manera ascendente
SELECT pelicula FROM peliculas WHERE año_estreno BETWEEN 1990 AND 1999 ORDER BY pelicula;
-- Listar el reparto de las películas lanzadas el año 2001
SELECT DISTINCT actor FROM reparto r, peliculas p WHERE año_estreno=2001 AND r.id_pelicula=p.id;
-- Listar los actores de la película más nueva 
SELECT DISTINCT actor FROM reparto r, peliculas p WHERE p.año_estreno=(SELECT MAX(año_estreno) FROM peliculas) AND r.id_pelicula=p.id; 
