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