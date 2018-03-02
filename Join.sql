//table
game
id	    mdate	         stadium	        team1 team2
1001	8 June 2012	National Stadium, Warsaw	POL	GRE
1002	8 June 2012	Stadion Miejski (Wroclaw)	RUS	CZE
1003	12 June 2012	Stadion Miejski (Wroclaw)	GRE	CZE
1004	12 June 2012	National Stadium, Warsaw	POL	RUS
...

goal
matchid	teamid	 player	      gtime
1001	  POL	 Robert Lewandowski	17
1001	  GRE	 Dimitris Salpingidis	51
1002	  RUS	 Alan Dzagoev	15
1002	  RUS	 Roman Pavlyuchenko	82
...

eteam
id	teamname	coach
POL	Poland	Franciszek Smuda
RUS	Russia	Dick Advocaat
CZE	Czech Republic	Michal Bilek
GRE	Greece	Fernando Santos
...

/* 1.
The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
show the matchid and player name for all goals scored by Germany.
*/
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
/* 2.
Show id, stadium, team1, team2 for just game 1012
*/
SELECT id,stadium,team1,team2
  FROM game
  WHERE id = 1012

/* 3.
Modify it to show the player, teamid, stadium and mdate for every German goal.
*/
SELECT player,teamid,stadium,mdate
  FROM game JOIN goal ON (id=matchid)
  where teamid='Ger'
  
/* 4.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'
*/
select team1,team2,player 
from game join goal on (id=matchid)
where player like 'Mario%'

/* 5.
The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10
*/
SELECT player, teamid, coach, gtime
  FROM goal join eteam on (teamid=id)
 WHERE gtime<=10

/* 6.
To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.
*/
select mdate,teamname
from game join eteam on (team1=eteam.id)
where coach='Fernando Santos'

/* 7.
List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'
*/
select player 
from game join goal on (id=matchid)
where stadium='National Stadium, Warsaw'

/* 8.
show the name of all players who scored a goal against Germany.
*/
SELECT distinct player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' or team2='GER') and teamid != 'GER'

/* 9.
Show teamname and the total number of goals scored.
*/
SELECT teamname, count(*)
  FROM eteam JOIN goal ON id=teamid
 group BY teamname

/* 10.
Show the stadium and the number of goals scored in each stadium.
*/
select stadium, count(*)
from game join goal on id=matchid
group by stadium

/* 11.
For every match involving 'POL', show the matchid, date and the number of goals scored
*/
