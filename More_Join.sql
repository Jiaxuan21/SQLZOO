// 3 table
movie
id	title	yr	director	budget	gross 

actor
id	name 

casting
movieid	actorid	ord

/* 1.
List the films where the yr is 1962 [Show id, title]
*/
SELECT id, title
 FROM movie
 WHERE yr=1962
 
/* 2.
Give year of 'Citizen Kane'.
*/
select yr from movie
where title = 'Citizen Kane'

/* 3.
List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
*/
select id,title,yr 
from movie
where title like '%Star Trek%'
order by yr

/* 4.
What id number does the actor 'Glenn Close' have?
*/
select id from actor
where name = 'Glenn Close'

/* 5.
What is the id of the film 'Casablanca'
*/
select id from movie
where title = 'Casablanca'

/* 6.
Obtain the cast list for 'Casablanca'.
(The cast list is the names of the actors who were in the movie.)
Use movieid=11768, (or whatever value you got from the previous question)
*/
select name
from actor join casting on id=actorid
where movieid = 11768

/* 7.
Obtain the cast list for the film 'Alien'
*/
select name
from actor join casting on actor.id=actorid join movie on movieid=movie.id
where title = 'Alien'
//or
SELECT name
FROM actor
  JOIN casting ON (id=actorid AND movieid = (SELECT id FROM movie WHERE title = 'Alien'))

/* 8.
List the films in which 'Harrison Ford' has appeared
*/
select title 
from movie join casting on movie.id=movieid join actor on actorid=actor.id
where name = 'Harrison Ford'

/* 9.
List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
*/
select title
from movie join casting on movie.id=movieid join actor on actor.id=actorid
where name = 'Harrison Ford'
and ord != 1

/* 10.
List the films together with the leading star for all 1962 films.
*/
select title, name
from movie join casting on movie.id=movieid join actor on actor.id=actorid
where yr = 1962
and ord = 1

/* 11.
Which were the busiest years for 'John Travolta', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
*/
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title)=(SELECT MAX(c) FROM
(SELECT yr,COUNT(title) AS c FROM
   movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
 where name='John Travolta'
 GROUP BY yr) AS t
)
//or
SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
         JOIN actor   ON actorid=actor.id
where name='John Travolta'
GROUP BY yr
HAVING COUNT(title) > 2

/* 12
List the film title and the leading actor for all of the films 'Julie Andrews' played in.
Did you get "Little Miss Marker twice"? Julie Andrews starred in the 1980 remake of Little Miss Marker and not the original(1934).
Title is not a unique field, create a table of IDs in your subquery
*/
select distinct title,name
from movie JOIN casting ON movie.id=movieid JOIN actor ON actorid=actor.id
WHERE movieid in (select movieid from casting 
                  where actorid in (
                  select id from actor
                  where name='Julie Andrews'))
and ord = 1

/* 13.
Obtain a list, in alphabetical order, of actors who've had at least 30 starring roles.
*/
select name
from actor join casting on id=actorid
where ord=1
group by name
having count(*) >= 30
order by name

/* 14.
List the films released in the year 1978 ordered by the number of actors in the cast, then by title.
*/


