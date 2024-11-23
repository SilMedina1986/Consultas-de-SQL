# Consultas-de-SQL
Proyecto: DataProject: Lógica. Consultas de SQL

Análisis y Consultas de Base de Datos - Proyecto de Alquiler de Películas
Este proyecto se enfoca en realizar consultas y análisis de una base de datos de alquiler de películas, utilizando un esquema relacional. A continuación, se describen los pasos realizados durante el desarrollo del proyecto, las consultas ejecutadas, y un análisis de los resultados obtenidos.

1. Descripción del Proyecto
El objetivo del proyecto fue analizar una base de datos de un sistema de alquiler de películas. Este sistema contiene información sobre clientes, empleados, películas, categorías, tiendas, y transacciones de alquiler. Utilizando SQL, se desarrollaron consultas para extraer información valiosa, optimizar el entendimiento del negocio y generar reportes útiles.
________________________________________
2. Esquema de la Base de Datos
El esquema relacional incluye las siguientes tablas principales:
•	Clientes (customer): Información de los clientes.
•	Películas (film): Detalles de las películas disponibles.
•	Categorías (category): Clasificación de las películas.
•	Alquileres (rental): Registro de los alquileres realizados.
•	Inventarios (inventory): Disponibilidad de películas por tienda.
•	Tiendas (store): Información de las sucursales.
•	Empleados (staff): Detalles de los trabajadores.
El esquema muestra las relaciones entre estas tablas, las claves primarias y foráneas, así como los campos relevantes.
________________________________________
3. Pasos Seguidos
Paso 1: Análisis del Esquema
•	Analizamos las tablas y sus relaciones para entender cómo conectar la información necesaria.
•	Identificamos las claves primarias y foráneas para realizar consultas correctamente.
Paso 2: Definición de Preguntas de Negocio
•	Planteamos preguntas clave que el análisis debía responder, como:
o	¿Qué categorías tienen más películas alquiladas?
o	¿Qué clientes son los más activos?
o	¿Cuántas películas se alquilaron en un año específico?
o	¿Cómo se relacionan los empleados con las tiendas?
Paso 3: Desarrollo de Consultas
Se diseñaron y ejecutaron consultas SQL para responder a las preguntas planteadas. Aquí se detallan algunas de las consultas implementadas:
•	15. ¿Cuánto dinero ha generado en total la empresa?

SELECT sum("amount") AS "ganancias totales"
FROM payment AS p 


•	26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT 
    ROUND(AVG("total_pagado"), 2) AS "Promedio",
    VAR_POP("total_pagado") AS "Varianza",
    STDDEV_POP("total_pagado") AS "Desviación"
FROM (
    SELECT 
        SUM("amount") AS "total_pagado"
    FROM payment
    GROUP BY customer_id ) AS "t"

•	52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.

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

•	57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días

SELECT "title" AS "Título_Película"
FROM "film" AS "f"
WHERE "f"."film_id" IN (
     SELECT "i"."film_id"
     FROM "inventory" AS "i"
     WHERE "i"."inventory_id" IN (
          SELECT "r"."inventory_id"
          FROM "rental" AS "r"
          WHERE DATE_PART('day', "r"."return_date" - "r"."rental_date") > 8))

•	63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

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


________________________________________
4. Resultados y Análisis
Hallazgos clave:
1.	Clientes más activos:
o	Identificamos los clientes que alquilan películas de manera constante. Esto puede ayudar a desarrollar programas de fidelización.
2.	Categorías más populares:
o	Las categorías con más alquileres permiten a la empresa optimizar la selección de películas y las estrategias de marketing.
3.	Relación empleados-tiendas:
o	La combinación de trabajadores y tiendas permitió analizar cómo distribuir mejor el personal.
Análisis:
El proyecto permitió extraer insights valiosos utilizando SQL y un diseño relacional bien estructurado. Además, se demostró cómo los datos pueden integrarse y cruzarse para responder preguntas complejas de negocio.
________________________________________
5. Conclusiones
•	Flexibilidad del modelo relacional: El esquema permitió realizar múltiples tipos de análisis gracias a las relaciones definidas entre las tablas.
•	Utilidad de SQL: Con las consultas, se extrajo información detallada y se generaron reportes relevantes para la toma de decisiones.
•	Recomendaciones futuras: Optimizar las consultas más complejas e implementar índices para mejorar el rendimiento en bases de datos grandes.
•	
