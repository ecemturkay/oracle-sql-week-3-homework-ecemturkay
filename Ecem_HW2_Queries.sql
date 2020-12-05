--------JOIN OPERATORS-----------

--1
select distinct c.l�cense_class from book�ngs b
JOIN customers c on b.customer_�d = c.customer_�d
JOIN cars ca on b.car_�d = ca.car_�d
where c.gender = 'Female';

--2
select c.name, c.surname, ca.car_brand, ca.car_model from book�ngs b
jo�n customers c on b.customer_�d = c.customer_�d
jo�n cars ca on b.car_�d = ca.car_�d
where ca.class = 'Luxury' and b.book�ng_date > '01/01/2020';

--3
select cu.name, cu.surname, cu.gender, cu.b�rth_date, b.* from customers cu
left jo�n book�ngs b on cu.customer_�d = b.customer_�d
where cu.b�rth_date between '01/01/1960' and '01/01/1980';

--4
select * from cars c
left jo�n book�ngs b on c.car_�d = b.car_�d
where b.book�ng_�d �s null and c.da�ly_pr�ce > '500,00' and c.ava�lab�l�ty = '1';

--5
select cu.customer_�d, count(cu.customer_�d) from customers cu
�nner jo�n book�ngs b on cu.customer_�d = b.customer_�d
group by cu.customer_�d
hav�ng count(cu.customer_�d) > 1;

-------SET OPERATORS---------

--1  Daha once k�ralanmam�� ara�lar�n �d b�lg�s�
select car_�d from cars
m�nus
select car_�d from book�ngs;

--2  Daha once rezervasyon yapt�rm�� muster�ler�n �d b�lg�s�
select customer_�d from customers
�ntersect
select customer_�d from book�ngs;

--------------------------------------------------------------------------------------------
---un�on i�in �ok uygun sorgular bulamad�m kendi tablolar�mdan (a�a��daki 2 sorgu i�in)-----
--------------------------------------------------------------------------------------------

--3
select * from customers 
where name l�ke 'A%'
un�on
select * from customers 
where name l�ke 'E%'
un�on
select * from customers 
where name l�ke 'U%';

--4
select customer_�d, name, surname, b�rth_date from customers
where b�rth_date l�ke '%1973%'
un�on
select customer_�d, name, surname, b�rth_date from customers
where b�rth_date l�ke '%1967';

-----SINGLE ROW NUMBER OPERATIONS-----

--1
select customer_�d, 
name|| ' ' ||surname as CUS_NAME
from customers
order by substr(name,1,1) ASC;

--2
select da�ly_pr�ce, rpad(round(da�ly_pr�ce),4,'$') from cars;

--3
select b.customer_�d, cu.name, cu.surname, b.f�n�sh�ng_date - b.start�ng_date as "Araban�n k�ralanma sures� (g�n)"
from book�ngs b 
�nner jo�n customers cu on b.customer_�d = cu.customer_�d
order by "Araban�n k�ralanma sures� (g�n)";

--4
select customer_�d, name, surname, round(MONTHS_BETWEEN(sysdate, reg�strat�on_date)) as  "Number of Months"
from customers
order by customer_�d;

--5
select customer_�d, name, surname, c�ty from customers
where c�ty l�ke 'A%';

--6
select * from cars
where l�cense_plate l�ke '%E%';

--7
select car_�d, car_brand, car_model, trunc(da�ly_pr�ce,1) from cars
order by da�ly_pr�ce desc;

--8
select b.f�n�sh�ng_date - b.start�ng_date as "Araba ka� g�n kiraland�?",
	trunc(da�ly_pr�ce) "Daily Price", 
	(b.f�n�sh�ng_date - b.start�ng_date) * trunc(da�ly_pr�ce) as "Total"
from book�ngs b
�nner jo�n cars c on b.car_�d = c.car_�d ;

--9
select distinct car_�d, car_brand, car_model from cars where da�ly_pr�ce>=(select avg(da�ly_pr�ce) from cars);

--10
select l�cense_class, LISTAGG(name,',') WITHIN GROUP( ORDER BY name ) AS customer_name
from customers
group by l�cense_class
order by l�cense_class;

--11
select * from customers where reg�strat�on_date > to_date ('2015','YYYY') 
order by reg�strat�on_date;

--12
select class, LISTAGG(car_�d,',') WITHIN GROUP( ORDER BY car_�d ) AS "Car Class"
from cars
group by class
order by class;

--13
select * from customers 
where postal_code l�ke'%00';

--14
select customer_�d, name, surname, upper(c�ty) from customers
order by upper(c�ty);

--15
select * from customers
where phone l�ke '%534%';

--16
select car_�d, car_brand, seat_number, RANK() OVER (ORDER BY seat_number) seat_rank from cars;
	
    
