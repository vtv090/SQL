How many actresses are there?
select count(distinct name)
from actress;


Output all producers that have no associated entries in the film table (sorted by producer name)! Each producer should be output only once.

select distinct id, name
from producer p1
where NOT EXISTS (select *
						from movie m join producer p2 on p2.movie_id = m.mid
						where p1.id = p2.id)
order by name desc;

Output the titles of all film pairs in which at least one common actor plays! Sort the result by the title of the second movie.

SELECT distinct m1.title as first_movie, m2.title as second_movie
FROM movie m1 join actor a1 on (m1.mid = a1.movie_id),
	 movie m2 join actor a2 on (m2.mid = a2.movie_id)
WHERE a1.name = a2.name and a1.movie_id != a2.movie_id and m1.title != m2.title
order by m2.title asc;



Create a top-3 list of movies with the most actors and actresses! Sort accordingly. Note: Research the LIMIT clause for this. 

SELECT mv.m_id, sum(mv.cnt)
from(
	select movie_id as m_id, count(*) cnt
	from actor a1
	group by movie_id
	union all
	select movie_id as m_id, count(*) cnt
	from actress a2
	group by movie_id
)mv
group by mv.m_id
order by sum(mv.cnt) desc
limit 3;