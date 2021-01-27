--------JOIN OPERATORS-----------

--1
select distinct c.license_class from bookings b
JOIN customers c on b.customer_id = c.customer_id
JOIN cars ca on b.car_id = ca.car_id
where c.gender = 'Female';

--2
select c.name, c.surname, ca.car_brand, ca.car_model from bookings b
join customers c on b.customer_id = c.customer_id
join cars ca on b.car_id = ca.car_id
where ca.class = 'Luxury' and b.booking_date > '01/01/2020';

--3
select cu.name, cu.surname, cu.gender, cu.birth_date, b.* from customers cu
left join bookings b on cu.customer_id = b.customer_id
where cu.birth_date between '01/01/1960' and '01/01/1980';

--4
select * from cars c
left join bookings b on c.car_id = b.car_id
where b.booking_id is null and c.daily_price > '500,00' and c.availability = '1';

--5
select cu.customer_id, count(cu.customer_id) from customers cu
inner join bookings b on cu.customer_id = b.customer_id
group by cu.customer_id
having count(cu.customer_id) > 1;

-------SET OPERATORS---------

--1  Daha önce kiralanmamış araçların id bilgisi
select car_id from cars
minus
select car_id from bookings;

--2  Daha önce rezervasyon yaptırmış müşterilerin id bilgisi
select customer_id from customers
intersect
select customer_id from bookings;

------UNION------

--3
select * from customers 
where name like 'A%'
union
select * from customers 
where name like 'E%'
union
select * from customers 
where name like 'U%';

--4
select customer_id, name, surname, birth_date from customers
where birth_date like '%1973%'
union
select customer_id, name, surname, birth_date from customers
where birth_date like '%1967';

-----SINGLE ROW NUMBER OPERATIONS-----

--1
select customer_id, 
name|| ' ' ||surname as CUS_NAME
from customers
order by substr(name,1,1) ASC;

--2
select daily_price, rpad(round(daily_price),4,'$') from cars;

--3
select b.customer_id, cu.name, cu.surname, b.finishing_date - b.starting_date as "Arabanın kiralanma süresi (gün)"
from bookings b 
inner join customers cu on b.customer_id = cu.customer_id
order by "Arabanın kiralanma süresi (gün)";

--4
select customer_id, name, surname, round(MONTHS_BETWEEN(sysdate, registration_date)) as  "Number of Months"
from customers
order by customer_id;

--5
select customer_id, name, surname, city from customers
where city like 'A%';

--6
select * from cars
where license_plate like '%E%';

--7
select car_id, car_brand, car_model, trunc(daily_price,1) from cars
order by daily_price desc;

--8
select b.finishing_date - b.starting_date as "Araba kaç gün kiralandı?",
	trunc(daily_price) "Daily Price", 
	(b.finishing_date - b.starting_date) * trunc(daily_price) as "Total"
from bookings b
inner join cars c on b.car_id = c.car_id ;

--9
select distinct car_id, car_brand, car_model from cars where daily_price>=(select avg(daily_price) from cars);

--10
select license_class, LISTAGG(name,',') WITHIN GROUP( ORDER BY name ) AS customer_name
from customers
group by license_class
order by license_class;

--11
select * from customers where registration_date > to_date ('2015','YYYY') 
order by registration_date;

--12
select class, LISTAGG(car_id,',') WITHIN GROUP( ORDER BY car_id ) AS "Car Class"
from cars
group by class
order by class;

--13
select * from customers 
where postal_code like'%00';

--14
select customer_id, name, surname, upper(city) from customers
order by upper(city);

--15
select * from customers
where phone like '%534%';

--16
select car_id, car_brand, seat_number, RANK() OVER (ORDER BY seat_number) seat_rank from cars;
