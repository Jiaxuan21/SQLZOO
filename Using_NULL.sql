// 2 table
teacher
id	dept	name	phone	mobile
101	1	Shrivell	2753	07986 555 1234
102	1	Throd	        2754   07122 555 1920
103	1	Splint  	2293	
104		Spiregrain	3287	
105	2	Cutflower	3212	07996 555 6574
106		Deadyawn	3345	
...
dept
id	name
1	Computing
2	Design
3	Engineering
...

/* 1.
List the teachers who have NULL for their department.
You might think that the phrase dept=NULL would work here but it doesn't - you can use the phrase dept IS NULL
*/
select name from teacher
where dept is null


