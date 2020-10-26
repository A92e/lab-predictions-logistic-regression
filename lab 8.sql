use sakila;

select f.film_id, count(r.rental_id) as num_rental, rental_duration, rental_rate, length, rating, replacement_cost,special_features, r.rental_date from film f
left join inventory i
on f.film_id=i.film_id
left join rental r
on i.inventory_id=r.inventory_id
group by f.film_id
having (r.rental_date >= '2005-05-15') and (r.rental_date <= '2005-05-30');



create or replace view activity_may as
select f.film_id, count(r.rental_id) as num_rental_may, r.rental_date as status_may from film f
left join inventory i
on f.film_id=i.film_id
left join rental r
on i.inventory_id=r.inventory_id

where (r.rental_date >= '2005-05-15') and (r.rental_date <= '2005-05-30')
group by f.film_id
order by f.film_id ;

select * from activity_may
order by film_id desc;




create or replace view activity_jun as

select f.film_id, count(r.rental_id) as num_rental_jun, f.release_year,r.rental_date as status_jun from film f
left join inventory i
on f.film_id=i.film_id
left join rental r
on i.inventory_id=r.inventory_id
where (r.rental_date >= '2005-06-15') and (r.rental_date <= '2005-06-30')
group by f.film_id
order by f.film_id ;



select f2.film_id, am.num_rental_may, c.name as categories ,f2.rental_duration,f2.length,f2.rating, f2.replacement_cost,f2.rental_rate, f2.special_features, am.status_may, aj.status_jun from activity_may am
right join film f
on f.film_id=am.film_id
left join activity_jun aj
on f.film_id=aj.film_id
right join film f2
on f2.film_id=aj.film_id
left join film_category fc
on f2.film_id=fc.film_id
join category c
on c.category_id= fc.category_id
limit 1000;








/*
select f.film_id,r.rental_date from film f
left join inventory i
on f.film_id=i.film_id
left join rental r
on i.inventory_id=r.inventory_id
join film f2
on f2.film_id=i.film_id
join language lng
on lng.language_id=f2.language_id
and (r.rental_date >= '2005-06-15') and (r.rental_date <= '2005-06-30')
group by f.film_id
order by f.film_id;



select c.name from category c
join film_category fc
on fc.category_id=c.category_id
join film f
on fc.film_id= f.film_id


select lng.name from language lng
join film f
on lng.language_id=f.language_id;

 select count(*) from film;
 */