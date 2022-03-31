# SQL Mandatory Asignment based on movies database

#1. Write a SQL query to find the actors who were cast in the movie 'Annie Hall'. Return actor first name, last name and role.
SELECT actors.act_fname, actors.act_lname, movie_cast.role,movie.mov_title
FROM   actors  JOIN     movie_cast ON actors.act_id = movie_cast.act_id 
JOIN movie ON movie_cast.mov_id=movie.mov_id 
		  AND movie.mov_title='Annie Hall';

/*It is necessary to apply inner join on tables actors,movie and movie_cast for aceess interrelated columns.
  i displayed result of actors first name, last name and role  who were cast in the movie 'Annie Hall'.*/
          
#2.From the following tables, write a SQL query to find the director who directed a movie that casted a role for 'Eyes Wide Shut'.
# Return director first name, last name and movie title.

SELECT director.dir_fname, director.dir_lname,movie.mov_title
FROM   director  JOIN     movie_direction ON director.dir_id = movie_direction.dir_id 
JOIN movie ON movie_direction.mov_id=movie.mov_id 
AND movie.mov_title='Eyes Wide Shut';

/*It is necessary to apply inner join on tables director,movie_direction and movie for aceess interrelated columns.
  i displayed result of director first name, last name and movie title  who directed a movie that casted a role for 'Eyes Wide Shut' */

# 3.Write a SQL query to find who directed a movie that casted a role as ‘Sean Maguire’ director first name, last name and movie title.

SELECT director.dir_fname, director.dir_lname,movie.mov_title,movie_cast.role
FROM   director  JOIN     movie_direction ON director.dir_id = movie_direction.dir_id 
 JOIN movie ON movie_direction.mov_id=movie.mov_id 
 JOIN movie_cast ON movie.mov_id = movie_cast.mov_id
 AND movie_cast.role='Sean Maguire';

/*It is necessary to apply join tables director,movie_cast and movie for aceess interrelated columns.
I also used intermediate table movie which helps to join movie_direction and movie_cast.
I displayed result of director first name, last name and movie title  who directed a movie that casted a role for 'Sean Maguire' */
          
# 4.Write a SQL query to find the actors who have not acted in any movie between1990 and 2000 (Begin and end values are included.). 
#Return actor first name, last name, movie title and release year. 

SELECT actors.act_fname, actors.act_lname,movie.mov_title, movie.mov_year
FROM actors JOIN movie_cast 
ON actors.act_id=movie_cast.act_id
JOIN movie 
ON movie_cast.mov_id=movie.mov_id
WHERE mov_year not BETWEEN 1990 and 2000;

/*It is necessary to join tables actor,movie_cast and movie for aceess interrelated columns.
  I also used intermediate table movie__cast which helps to join movie and actors.
  I used where clause to compare movie year which not not BETWEEN 1990 and 2000 and displayed result of actor first name, last name,mov_year
  and movie title */


/* 5. Write a SQL query to find the directors with number of genres movies. Group the result set on director first name, last name
 and generic title. Sort the result-set in ascending order by director first name and last name. 
 Return director first name, last name and number of genres movies.*/

SELECT dir_fname,dir_lname, gen_title,count(gen_title) as "Count of Genres of movie"
FROM director
NATURAL JOIN movie_direction   
NATURAL JOIN movie_genres
NATURAL JOIN genres
GROUP BY dir_fname, dir_lname,gen_title
ORDER BY dir_fname,dir_lname;

/*Query explanation
I Used  natural join to find columns with the same name in joined tables and add one column in the result for each pair found. 
Group by clause to grouped dir_fname,dir_lname,gen_title wise movie generes count
order by to apply ascending order as dir_fname,dir_lname */

#6. Write a SQL query to find the movies with year and genres. Return movie title, movie year and generic title.

SELECT m.mov_title , m.mov_year, g.gen_title
FROM movie m , genres g , movie_genres mg
WHERE m.mov_id =mg.mov_id
AND g.gen_id =mg.gen_id;

/* it is need to  join movie,genres and movie_genres tables as  asked query return value columns are interlinked in tables
The output query will result as movie title, movie year and generic title.*/
 
#7.Write a SQL query to find all the movies with year, genres, and name of the director

SELECT m.mov_title , m.mov_year , g.gen_title ,concat(d.dir_fname ," ", d.dir_lname) as "Director Name"
FROM movie m , genres g , movie_genres mg , director d , movie_direction md
WHERE m.mov_id = mg.mov_id
AND g.gen_id = mg.gen_id
AND d.dir_id = md.dir_id
AND md.mov_id = m.mov_id;

/*With help of aliases and join tables based on common column between two tables,
I displayed all the movies with year, genres, and name of the director.*/

/* 8.Write a SQL query to find the movies released before 1st January 1989. 
Sort the result-set in descending order by date of release. 
Return movie title, release year, date of release, duration, and first and last name of the director. */

SELECT m.mov_title , m.mov_year , m.mov_dt_rel , concat(d.dir_fname ," ", d.dir_lname)as "Director Name"
FROM movie m , director d , movie_direction md
WHERE  m.mov_dt_rel <'1989-01-01'
AND d.dir_id = md.dir_id
AND md.mov_id = m.mov_id
ORDER BY m.mov_dt_rel DESC;

/*Query explanation
I used   join to find columns with the same name in joined tables  
order by to apply descending order as per mov_dt_rel date*/

