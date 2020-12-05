--------JOIN OPERATORS-----------

--1
select distinct c.lýcense_class from bookýngs b
JOIN customers c on b.customer_ýd = c.customer_ýd
JOIN cars ca on b.car_ýd = ca.car_ýd
where c.gender = 'Female';

--2
select c.name, c.surname, ca.car_brand, ca.car_model from bookýngs b
joýn customers c on b.customer_ýd = c.customer_ýd
joýn cars ca on b.car_ýd = ca.car_ýd
where ca.class = 'Luxury' and b.bookýng_date > '01/01/2020';

--3
select cu.name, cu.surname, cu.gender, cu.býrth_date, b.* from customers cu
left joýn bookýngs b on cu.customer_ýd = b.customer_ýd
where cu.býrth_date between '01/01/1960' and '01/01/1980';

--4
select * from cars c
left joýn bookýngs b on c.car_ýd = b.car_ýd
where b.bookýng_ýd ýs null and c.daýly_prýce > '500,00' and c.avaýlabýlýty = '1';

--5
select cu.customer_ýd, count(cu.customer_ýd) from customers cu
ýnner joýn bookýngs b on cu.customer_ýd = b.customer_ýd
group by cu.customer_ýd
havýng count(cu.customer_ýd) > 1;

-------SET OPERATORS---------

--1  Daha once kýralanmamýþ araçlarýn ýd býlgýsý
select car_ýd from cars
mýnus
select car_ýd from bookýngs;

--2  Daha once rezervasyon yaptýrmýþ musterýlerýn ýd býlgýsý
select customer_ýd from customers
ýntersect
select customer_ýd from bookýngs;

--------------------------------------------------------------------------------------------
---unýon için çok uygun sorgular bulamadým kendi tablolarýmdan (aþaðýdaki 2 sorgu için)-----
--------------------------------------------------------------------------------------------

--3
select * from customers 
where name lýke 'A%'
unýon
select * from customers 
where name lýke 'E%'
unýon
select * from customers 
where name lýke 'U%';

--4
select customer_ýd, name, surname, býrth_date from customers
where býrth_date lýke '%1973%'
unýon
select customer_ýd, name, surname, býrth_date from customers
where býrth_date lýke '%1967';

-----SINGLE ROW NUMBER OPERATIONS-----

--1
select customer_ýd, 
name|| ' ' ||surname as CUS_NAME
from customers
order by substr(name,1,1) ASC;

--2
select daýly_prýce, rpad(round(daýly_prýce),4,'$') from cars;

--3
select b.customer_ýd, cu.name, cu.surname, b.fýnýshýng_date - b.startýng_date as "Arabanýn kýralanma suresý (gün)"
from bookýngs b 
ýnner joýn customers cu on b.customer_ýd = cu.customer_ýd
order by "Arabanýn kýralanma suresý (gün)";

--4
select customer_ýd, name, surname, round(MONTHS_BETWEEN(sysdate, regýstratýon_date)) as  "Number of Months"
from customers
order by customer_ýd;

--5
select customer_ýd, name, surname, cýty from customers
where cýty lýke 'A%';

--6
select * from cars
where lýcense_plate lýke '%E%';

--7
select car_ýd, car_brand, car_model, trunc(daýly_prýce,1) from cars
order by daýly_prýce desc;

--8
select b.fýnýshýng_date - b.startýng_date as "Araba kaç gün kiralandý?",
	trunc(daýly_prýce) "Daily Price", 
	(b.fýnýshýng_date - b.startýng_date) * trunc(daýly_prýce) as "Total"
from bookýngs b
ýnner joýn cars c on b.car_ýd = c.car_ýd ;

--9
select distinct car_ýd, car_brand, car_model from cars where daýly_prýce>=(select avg(daýly_prýce) from cars);

--10
select lýcense_class, LISTAGG(name,',') WITHIN GROUP( ORDER BY name ) AS customer_name
from customers
group by lýcense_class
order by lýcense_class;

--11
select * from customers where regýstratýon_date > to_date ('2015','YYYY') 
order by regýstratýon_date;

--12
select class, LISTAGG(car_ýd,',') WITHIN GROUP( ORDER BY car_ýd ) AS "Car Class"
from cars
group by class
order by class;

--13
select * from customers 
where postal_code lýke'%00';

--14
select customer_ýd, name, surname, upper(cýty) from customers
order by upper(cýty);

--15
select * from customers
where phone lýke '%534%';

--16
select car_ýd, car_brand, seat_number, RANK() OVER (ORDER BY seat_number) seat_rank from cars;
	
    
