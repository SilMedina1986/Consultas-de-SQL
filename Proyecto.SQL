DataProject Silvina Medina: 

LógicaConsultasSQL
 1- Crea el esquema de la BBDD.
 2- Muestra los nombres de todas las películas con una clasificación por 
edades de ‘Rʼ

select "title" as "Título de película"
from film f 
where rating = 'R'

3- Encuentra los nombres de los actores que tengan un “actor_idˮ entre 30 
y 40--

select concat (first_name, ' ', last_name) 
from "actor"  
where actor_id between 30 and 40


4- Obtén las películas cuyo idioma coincide con el idioma original.

select "title"
from "film" 
where original_language_id = language_id

5- Ordena las películas por duración de forma ascendente

select "title"
from "film" 
order by length asc 

6- Encuentra el nombre y apellido de los actores que tengan ‘Allenʼ en su 
apellido.

select concat ("first_name",' ', "last_name")
from actor 
where last_name = 'ALLEN'

7- . Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y muestra la clasificación junto con el recuento
SELECT count ("film_id") AS "numero de peliculas", 
	   "rating" AS "Categoria"
FROM film AS f 
GROUP BY "rating"

8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.

SELECT "title", 
	   "length",
	   "rating" 
FROM film AS f 
WHERE "rating" = 'PG-13' 
OR "length" > 180 
ORDER BY "length"

9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT round(stddev("replacement_cost"),2)
FROM film AS f 

10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT round(stddev("replacement_cost"),2)
FROM film AS f 

11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT "payment_id", 
       "payment_date",
       "amount" 
FROM payment AS p 
ORDER BY "payment_date" desc 
LIMIT 1
OFFSET 3

12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

SELECT "title",
       "rating"
FROM "film"
WHERE "rating" ='PG'
AND "rating" ='PG-13'
AND "rating" ='R'

13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.

SELECT      "rating"                AS "Clasificación", 
            ROUND(AVG("length"),0)  AS "Duración_Promedio"
FROM        "film"
GROUP BY    "Clasificación"

14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos
SELECT "title" AS "título de película",
       "length" AS "duración"
FROM film AS f 
WHERE length > 180 

15. ¿Cuánto dinero ha generado en total la empresa?

SELECT sum("amount") AS "ganancias totales"
FROM payment AS p 

16. Muestra los 10 clientes con mayor valor de id.

SELECT concat( "first_name"), ("last_name") AS "nombre del cliente",
       "customer_id"
FROM customer AS c 
ORDER BY customer_id DESC 
LIMIT 10

17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’

SELECT CONCAT(first_name, ' ', last_name)
FROM actor AS a
WHERE actor_id IN (
      SELECT actor_id
      FROM film_actor AS fa 
      WHERE film_id IN (
             SELECT film_id
             FROM film AS f 
             WHERE title = 'Egg Igby'))


18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT "title" AS "nombres de peliculas unicos"
FROM film AS f 

19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.

SELECT f.title AS "titulo",
       f.length AS "duracion",
       c.name AS "nombre_categoría"
FROM category AS c 
INNER JOIN film_category AS fc 
ON c.category_id = fc.category_id 
INNER JOIN film AS f 
ON fc.film_id = f.film_id
WHERE c."name" = 'Comedy'
AND f.length >180


20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.

SELECT rating AS "clasificacion",
       round(avg("length"),0) AS "duracion promedio"
FROM film AS f 
GROUP BY "clasificacion" 

21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT round(avg(rental_duration),0) AS "media duracion de alquiler"
FROM film AS f 

22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT DISTINCT(concat("first_name",'', "last_name")) AS " nombre y apellido"
FROM actor AS a 

23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT CONCAT(EXTRACT(DAY FROM "payment_date"),'-',
EXTRACT(MONTH FROM "payment_date"),'-',
EXTRACT(YEAR FROM "payment_date")) AS "fecha_alquiler",
COUNT ("payment_id") AS "numeros_alquiler"
FROM "payment"
GROUP BY "payment_date"
ORDER BY "numeros_alquiler" DESC

24. Encuentra las películas con una duración superior al promedio.

SELECT "title" AS "peliculas",
       "length" AS "duracion superior al promedio"
FROM film AS f 
WHERE length >(
      SELECT avg ("length")
      FROM "film") 
ORDER BY length 

25. Averigua el número de alquileres registrados por mes.

SELECT EXTRACT (MONTH FROM "rental_date") AS "mes de alquiler",
count(rental_id) AS "alquileres"
FROM rental AS r 
GROUP BY "mes de alquiler"
ORDER BY "mes de alquiler"

26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT 
    ROUND(AVG("total_pagado"), 2) AS "Promedio",
    VAR_POP("total_pagado") AS "Varianza",
    STDDEV_POP("total_pagado") AS "Desviación"
FROM (
    SELECT 
        SUM("amount") AS "total_pagado"
    FROM payment
    GROUP BY customer_id  
) AS "t"

27. ¿Qué películas se alquilan por encima del precio medio?

SELECT "title" AS "titulo",
       "rental_rate" AS "precio alquiler"
FROM film AS f 
WHERE "rental_rate" >= (
      SELECT avg("rental_rate")
      FROM "film")
ORDER BY "rental_rate" DESC

28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT "actor_id"
FROM film_actor AS fa 
GROUP BY actor_id 
HAVING count (DISTINCT ("film_id")) >40

29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.

SELECT "f"."title" AS "nombres de peliculas",
COUNT ("i"."inventory_id") AS "cantidad de peliculas"
FROM film AS f 
LEFT JOIN inventory AS "i" 
ON "f"."film_id" = "i"."inventory_id" 
GROUP BY "nombres de peliculas"

30. Obtener los actores y el número de películas en las que ha actuado

SELECT concat ("a"."first_name",' ', "last_name") AS "nombre de actor",
count("fa"."film_id") AS "numero de peliculas actuadas"
FROM film_actor AS fa 
RIGHT JOIN actor AS a 
ON "fa"."actor_id" = "a"."actor_id"
GROUP BY "nombre de actor"


31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.

SELECT CONCAT("a"."first_name",' ',"a"."last_name") AS "nombre de actor",
       "f"."title" AS "nombre de la pelicula"
FROM film AS f 
LEFT JOIN film_actor AS fa 
ON "f"."film_id"= "fa"."film_id" 
INNER JOIN actor AS a 
ON "fa"."actor_id" = "a"."actor_id"
ORDER BY "nombre de actor"


32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película

SELECT concat ("first_name",' ',"last_name") AS "nombre de actores",
       "title" as "peliculas"
FROM film AS f 
INNER JOIN film_actor AS fa 
ON "f"."film_id"= "fa"."film_id"
RIGHT JOIN actor AS a 
ON "fa"."actor_id"= "a"."actor_id"
ORDER BY "nombre de actores"

33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT "title" AS "peliculas",
       "rental_date" AS "registros de alquiler"
FROM film AS f 
INNER JOIN inventory AS i 
ON "f"."film_id"= "i"."film_id" 
LEFT JOIN rental AS r 
ON "i"."inventory_id"= "r"."inventory_id"


34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT SUM("p"."amount") AS "Dinero_Gastado",
       CONCAT ("c"."first_name",' ',"c"."last_name") AS "clientes"
FROM "customer" AS "c"
INNER JOIN "payment" AS "p" 
    ON "c"."customer_id" = "p"."customer_id"
INNER JOIN "address" AS "a" 
    ON "c"."address_id" = "a"."address_id"
INNER JOIN "city" AS "ci" 
    ON "ci"."city_id" = "a"."city_id"
INNER JOIN "country" AS "co"
    ON "ci"."country_id" = "co"."country_id"
WHERE "co"."country" = 'Spain'  
GROUP BY "c"."first_name", "c"."last_name"
ORDER BY "Dinero_Gastado" DESC 
LIMIT 5


35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT "first_name" AS "primer nombre"
FROM actor AS a 
WHERE "first_name" = 'Johnny'


36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido

SELECT "first_name" AS "nombre",
       "last_name" AS "apellido"
FROM actor AS a 


37. Encuentra el ID del actor más bajo y más alto en la tabla actor

SELECT 
    MIN(actor_id) AS "ID mas Bajo",
    MAX(actor_id) AS "ID mas Alto"
FROM actor


38. Cuenta cuántos actores hay en la tabla “actor"

SELECT COUNT ("actor_id") AS "total actores"
FROM actor AS a

39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT CONCAT ("first_name",' ', "last_name") AS "nombres actores"
FROM actor AS a 
ORDER BY "last_name" ASC 

40. Selecciona las primeras 5 películas de la tabla “film"

SELECT "title" AS "peliculas"
FROM film AS f 
LIMIT 5



41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?

SELECT "first_name" AS "nombre actor",
        count (*) AS "mas repetido"
FROM "actor"
GROUP BY "first_name"
ORDER BY "mas repetido" DESC
LIMIT 1


42. Encuentra todos los alquileres y los nombres de los clientes que lo realizaron.

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS clientes,
    COUNT(r.inventory_id) AS peliculas_alquiladas
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id


43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.

   
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS cliente,
    r.rental_id
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
ORDER BY c.customer_id


44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT 
    f.film_id,
    f.title AS pelicula,
    c.category_id,
    c.name AS categoria
FROM film AS f
CROSS JOIN category AS c;

NO nos aporta REAL valor ya que el resultado del CROSS JOIN porque  incluirá combinaciones irrelevantes que no reflejan la realidad del negocio.
Impacto en rendimiento..
El CROSS JOIN NO se utiliza para relaciones entre datos sino en situaciones donde queremos todas las combinaciones posibles entre dos conjuntos de datos
Devuelve el producto cartesiano de dos tablas, esto significa que cada fila de la primera tabla se combina con cada fila de la segunda, sin ninguna condición que relacione las tablas


45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT DISTINCT 
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS actor
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Action'
ORDER BY actor;



46. Encuentra todos los actores que no han participado en películas

SELECT CONCAT(a.first_name, ' ', a.last_name) AS actor
FROM actor AS a
LEFT JOIN film_actor AS fa 
ON a.actor_id = fa.actor_id
WHERE fa.actor_id IS NULL
ORDER BY actor;


47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    COUNT(fa.film_id) AS peliculas_participadas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY peliculas_participadas DESC


48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS
SELECT 
    CONCAT(a.first_name, ' ', a.last_name) AS actor,
    COUNT(fa.film_id) AS peliculas_participadas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name


49. Calcula el número total de alquileres realizados por cada cliente

SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS "cliente",
    COUNT(r.rental_id) AS "total_alquileres"
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY "total_alquileres" DESC


50. Calcula la duración total de las películas en la categoría 'Action'

SELECT 
      sum(f.length) AS "duracion total"
FROM film AS f 
INNER JOIN film_category AS fc 
ON f.film_id = fc.film_id
INNER JOIN category AS c 
ON fc.category_id = c.category_id
WHERE c."name" = 'Action'


51. Crea una tabla temporal llamada “cliente_rentas_temporal”  para almacenar el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS cliente,
    COUNT(r.rental_id) AS total_alquileres
FROM customer AS c
LEFT JOIN rental AS r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name

52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT 
    f.film_id,
    f.title AS titulo,
    COUNT(r.rental_id) AS total_alquileres
FROM film AS f
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
HAVING COUNT(r.rental_id) >= 10

53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.

SELECT DISTINCT f.title AS titulo
FROM customer AS c
INNER JOIN rental AS r
ON c.customer_id = r.customer_id
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON i.film_id = f.film_id
WHERE CONCAT(c.first_name, ' ', c.last_name) = 'Tammy Sanders'
  AND r.return_date IS NULL
ORDER BY f.title


54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.

SELECT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Sci-Fi'
ORDER BY a.last_name, a.first_name


55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultado alfabéticamente por apellido

SELECT DISTINCT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
INNER JOIN film AS f
ON fa.film_id = f.film_id
INNER JOIN inventory AS i
ON f.film_id = i.film_id
INNER JOIN rental AS r
ON i.inventory_id = r.inventory_id
WHERE r.rental_date > (
    SELECT MIN(rental_date)
    FROM film AS f
    INNER JOIN inventory AS i
    ON f.film_id = i.film_id
    INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
    WHERE f.title = 'Spartacus Cheaper'
)
ORDER BY a.last_name, a.first_name;


56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’

SELECT DISTINCT a.first_name, a.last_name
FROM actor AS a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor AS fa
    INNER JOIN film AS f
    ON fa.film_id = f.film_id
    INNER JOIN film_category AS fc
    ON f.film_id = fc.film_id
    INNER JOIN category AS c
    ON fc.category_id = c.category_id
    WHERE c.name = 'Music')
ORDER BY a.last_name, a.first_name


57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días

SELECT "title" AS "Título_Película"
FROM "film" AS "f"
WHERE "f"."film_id" IN (
     SELECT "i"."film_id"
     FROM "inventory" AS "i"
     WHERE "i"."inventory_id" IN (
          SELECT "r"."inventory_id"
          FROM "rental" AS "r"
          WHERE DATE_PART('day', "r"."return_date" - "r"."rental_date") > 8))


58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’


SELECT DISTINCT f.title AS "Título_Película"
FROM film AS f
INNER JOIN film_category AS fc
ON f.film_id = fc.film_id
INNER JOIN category AS c
ON fc.category_id = c.category_id
WHERE c.name = 'Animation'
ORDER BY f.title;


59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultado
alfabéticamente por título de película.

SELECT "f"."title" AS "peliculas"
FROM film AS f 
WHERE "f"."length" =(
     SELECT "length"
     FROM film
     WHERE"title" = 'DANCING FEVER')
AND "f"."title" <>  'DANCING FEVER'   
ORDER BY "f"."title"


60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.

SELECT 
    c.first_name, 
    c.last_name
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
JOIN 
    inventory i ON r.inventory_id = i.inventory_id
JOIN 
    film f ON i.film_id = f.film_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
HAVING 
    COUNT(DISTINCT f.film_id) >= 7
ORDER BY 
    c.last_name ASC, c.first_name ASC



61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.

SELECT 
    cat.name AS category_name, 
    COUNT(r.rental_id) AS total_rentals
FROM 
    category cat
JOIN 
    film_category fc ON cat.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
JOIN 
    inventory i ON f.film_id = i.film_id
JOIN 
    rental r ON i.inventory_id = r.inventory_id
GROUP BY 
    cat.name
ORDER BY 
    total_rentals DESC


62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT 
    cat.name AS category_name, 
    COUNT(f.film_id) AS film_count
FROM 
    category cat
JOIN 
    film_category fc ON cat.category_id = fc.category_id
JOIN 
    film f ON fc.film_id = f.film_id
WHERE 
    f.release_year = 2006
GROUP BY 
    cat.name
ORDER BY 
    film_count DESC



63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT 
    s.first_name AS staff_first_name,
    s.last_name AS staff_last_name,
    st.store_id AS store_id
FROM 
    staff s
CROSS JOIN 
    store st
ORDER BY 
    s.last_name, s.first_name, st.store_id;


64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.

SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS total_rentals
FROM 
    customer c
JOIN 
    rental r ON c.customer_id = r.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_rentals DESC, c.last_name ASC, c.first_name ASC