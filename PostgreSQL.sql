--HACK 1
create table countries(
  id_country serial primary key,
  name varchar(50) not null  
);

create table users(
 id_users serial primary key,
 id_country integer not null,
 email varchar(100) not null,
 name varchar (50) not null,
 foreign key (id_country) references countries (id_country)   
);

--HACK 2
insert into countries (name) values ('argentina') , ('colombia'),('chile');
select * from countries;

insert into users (id_country, email, name) 
 values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;

delete from users where email = 'bar@bar.com';

update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;

select * from users inner join  countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name 
from users u inner join  countries c on u.id_country = c.id_country;

--HACK 3
create table priorities(
  id_priority serial primary key,
  type_name varchar(50) not null  
);

create table contact_request(
 id_email serial primary key,
 id_country integer not null,
 id_priority integer not null,
 name varchar (50) not null,
 detail varchar (100) not null,
 physical_address varchar (100) not null,
 foreign key (id_country) references countries (id_country),
 foreign key (id_priority) references priorities (id_priority)
);

--HACK 4
insert into countries (name) values ('venezuela') , ('corea del sur') , ('brasil') , ('uruguay') , ('paraguay');
select * from countries;

insert into priorities (type_name) values ('alta') , ('intermedio') , ('baja');
SELECT * FROM priorities;

insert into contact_request (id_country, id_priority, name, detail,physical_address) values (2,1,'gabriel','bogota', 'america');

insert into contact_request (id_country, id_priority, name, detail,physical_address) values (1,1,'neyleth','buenos aires', 'america');

insert into contact_request (id_country, id_priority, name, detail,physical_address) values (5,1,'neyleth','seul', 'asia');

insert into contact_request (id_country, id_priority, name, detail,physical_address) values (4,1,'luis','caracas', 'america');

insert into contact_request (id_country, id_priority, name, detail,physical_address) values (6,1,'fran','brasilia', 'america');
select * from contact_request;

delete from contact_request where id_email = 5;

update contact_request set name = 'gabo', detail = 'bogota' where id_email = 1;

--HACK 5
create table roles(
  id_role serial primary key,
  name varchar(50) not null  
);

create table taxes(
  id_tax serial primary key,
  percentage DECIMAL(5,2) DEFAULT 21.00
);

create table offers(
  id_offer serial primary key,
  status varchar(100) not null  
);

create table discounts(
  id_discount serial primary key,
  status varchar(100) not null,
  percentage DECIMAL(5,2) DEFAULT 21.00
);

create table payments(
  id_payment serial primary key,
  type varchar(50) not null  
);

create table customers(
 id_customer serial primary key,
 email varchar (50) NOT null,
 id_country integer not null,
 id_role integer not null,
 name varchar (50) not null,
 age varchar (10) not null,
 password varchar (50) not null,
 physical_address varchar (100) not null,
 foreign key (id_country) references countries (id_country),
 foreign key (id_role) references roles (id_role)
);

create table invoice_status(
  id_invoice_status serial primary key,
  status varchar(50) not null  
);

create table products(
 id_product serial primary key,
 id_discount integer not null,
 id_offer integer not null,
 id_tax integer not null,
 name varchar (50) not null,
 detail varchar (50) not null,
 minimum_stock varchar (50) not null,
 maximun_stock varchar (100) not null,
 current_stock varchar (100) not null,
 price varchar (50) not null,
 price_with_tax varchar (50) not null,
 foreign key (id_discount) references discounts (id_discount),
 foreign key (id_offer) references offers (id_offer),
 foreign key (id_tax) references taxes (id_tax)
);

create table products_customers(
  id_product integer not null,
  id_customer integer not null,
  foreign key (id_product) references products (id_product),
  foreign key (id_customer) references customers (id_customer)
);

create table invoices(
  id_invoice serial primary key,
  id_customer integer not null,
  id_payment integer not null,
  id_invoice_status integer not null,
  DATE varchar (50) not null,
  total_to_pay varchar (50) not null,
  foreign key (id_customer) references customers (id_customer),
  foreign key (id_payment) references payments (id_payment),
  foreign key (id_invoice_status) references invoice_status (id_invoice_status)
);

create table orders(
  id_order serial primary key,
  id_invoice integer not null,
  id_product integer not null,
  detail varchar (50) not null,
  amount integer not null,
  price integer not null,
  foreign key (id_invoice) references invoices (id_invoice),
  foreign key (id_product) references products (id_product)
);

--HACK 6
-- insert 3 record in all tables
-- table roles
insert into roles (name) values ('primario') , ('secundario') , ('terciario');
select * from roles;

-- table taxes
insert into taxes (percentage) values (100.00 * 0.21);
insert into taxes (percentage) values (200.00 * 0.21);
insert into taxes (percentage) values (300.00 * 0.21);
SELECT * FROM taxes;

-- table offers
insert into offers (status) values ('active'), ('in process'), ('inactive');
SELECT * FROM offers;

-- table discounts 
INSERT INTO discounts ( status , percentage ) VALUES ('active' , 15.00 );
INSERT INTO discounts ( status , percentage ) VALUES ('in process' , 20.00 );
INSERT INTO discounts ( status , percentage ) VALUES ('inactive' , 35.00 );
SELECT * FROM discounts;

-- table payments 
INSERT INTO payments (type) VALUES ('tarjeta de credito'),('tarjeta de debito'),('dinero en efectivo');
SELECT * FROM payments;

-- table customers
INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address) VALUES ('ney@gmail.com', 1, 1, 'neyleth', 27, 1234, 'av falsa 345');
INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address) VALUES ('luis@gmail.com', 4, 1, 'luis', 36, 5678, 'av falsa2 678');
INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address) VALUES ('gabriel@gmail.com', 2, 1, 'gabriel', 05, 9012, 'av falsa3 901');
SELECT * FROM customers;

-- table invoice_status 
insert into invoice_status (status) values ('paid'), ('in process'), ('denied');
SELECT * FROM invoice_status;

-- table products 
insert into products ( id_discount , id_offer , id_tax , name , details , minimum_stock , maximum_stock ,current_stock, price , price_with_tax ) values (2 , 3 , 2 , 'smartphone' , 'iphone 13pro' , 50 , 2000 , 600 , 1500.00 , 1815.00);
insert into products ( id_discount , id_offer , id_tax , name , details , minimum_stock , maximum_stock ,current_stock, price , price_with_tax ) values (1 , 1 , 3 , 'laptop' , 'macbook' , 50 , 2000 , 500 , 3500.00 , 5705.00);
insert into products ( id_discount , id_offer , id_tax , name , details , minimum_stock , maximum_stock ,current_stock, price , price_with_tax ) values (3 , 3 , 1 , 'tablet' , 'ipad mini' , 50 , 1000 , 300 , 2000.00 , 2420.00);
SELECT * FROM products;

-- table products_customers
INSERT INTO products_customers (id_product, id_customer) VALUES (1, 1);
INSERT INTO products_customers (id_product, id_customer) VALUES (3, 3);
INSERT INTO products_customers (id_product, id_customer) VALUES (2, 2);
SELECT * FROM products_customers;

-- table orders  
insert into orders (id_invoice, id_product, detail, amount, price) values ( 1, 1, 'iphone 13pro', 1, 1815.00);
insert into orders (id_invoice, id_product, detail, amount, price) values ( 2, 3, 'ipad mini', 1, 2420.00);
insert into orders (id_invoice, id_product, detail, amount, price) values ( 3, 2, 'macbook', 1, 5705.00);
SELECT * FROM orders;

-- table users 
insert into users (id_country, email, name) 
values (2, 'luney@gmail.com', 'luney'), (3, 'tech@gmail.com', 'tech'), (1, 'luna@gmail.com', 'luna');
select * from users;

-- create 3 invoices
insert into invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay) values (1, 2, 1, '2023-03-07 15:30:03', 1815.00);
insert into invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay) values (3, 1, 1, '2023-08-23 11:00:23', 2420.00); 
insert into invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay) values (2, 3, 1, '2024-03-06 12:30:15', 5705.00); 
SELECT * FROM invoices;

-- delete last first user:
delete from users where email = 'foo@foo.foo';
SELECT * from users;

-- update last user:
update users set email = 'moon@gmail.com', name = 'moon' where id_users = 5;
select * from users;

-- update all taxes:
update taxes set percentage = (100.00 * 0.31) where id_tax = 1;
update taxes set percentage = (200.00 * 0.31) where id_tax = 2;
update taxes set percentage = (300.00 * 0.31) where id_tax = 3;
SELECT * from taxes;

-- update all prices
update products set price = 1800.00, price_with_tax = 2358.00 where id_product = 1;
update products set price = 3800.00, price_with_tax = 4978.00 where id_product = 2;
update products set price = 2500.00, price_with_tax = 3275.00 where id_product = 3;
SELECT * from products;