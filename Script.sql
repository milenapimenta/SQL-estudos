-- create schema milena;

create table Users (
	id serial primary key,
	name varchar(255),
	lastname varchar(255),
	email varchar(255),
	cpf char(11),
	created_at timestamp default current_timestamp,
	updated_at timestamp
);

drop table Users;

select * from Users order by 1;

insert into Users (
	name,
	lastname,
	email,
	cpf
) values (
	'Cristiano',
	'Justino',
	'cris@server.com',
	'31545678985'
);

-- INSERT INTO milena.users (id, "name", lastname, email, cpf, created_at, updated_at) VALUES(7, 'duda', 'Lima', 'duda@server.com', '12345678905', '2024-07-04 12:30:16.772', NULL);

update users
	set name = 'Maria',
	lastname = 'Silva',
	email = 'sl@server.com',
	cpf = '12345678954',
	updated_at = current_timestamp
where id = 1;

delete from Users where id = 2;

select * from Users where name = 'Mile';
select lastname from Users where name = 'Mile';
select * from Users where id <= 2;
select * from Users where id != 1;

select lastname as "Sobrenome do Usuário" from Users;
select * from Users where name like 'Milen_';
select * from Users where name not like 'Milen_';
select * from Users where name like 'M%';
select * from Users where name like '%o';
select * from Users where lastname like '% %';
select * from Users where name like '%i%a%';

select * from Users where updated_at is null;
select * from Users where updated_at is not null;


select * from Users where id between 2 and 4;

select * from Users where name like 'M%' and updated_at is not null;

select * from Users where lastname like 'Junior' or lastname like 'Pimenta';

create table Categories (
	id integer primary key,
	name varchar(255) not null,
	created_at timestamp default current_timestamp,
	updated_at timestamp
);

select * from Categories order by 1;

insert into Categories (
	id,
	name
) values (
	2,
	'Amizades'
);

drop table Categories;

create table User_Category (
	user_id integer,
	category_id integer,
	
	primary key (user_id, category_id),
	
	foreign key (user_id) 
		references Users (id),
	foreign key (category_id)
		references Categories (id)
);

insert into User_Category (user_id, category_id) values (2,3);

--select Users.name as "User", Categories.name as Category" from Users 
	--join User_Category on User_category.user_id = Users.id
	--join Categories on Categories.id = User_Category.category_id;



create schema milena;

create table aluno (
	id serial primary key,
	name varchar(255)
);

create table curso (
	id serial primary key,
	name varchar(255),
	aluno_id integer,
	
	foreign key (aluno_id)
		references aluno (id)
);

insert into aluno (name) values ('Milena');
insert into aluno (name) values ('Eduarda');
insert into aluno (name) values ('Miguel');
insert into aluno (name) values ('Lucy');
insert into aluno (name) values ('Apollo');
insert into aluno (name) values ('Cristiano');

insert into curso (name, aluno_id) values ('HTML', 1);
insert into curso (name, aluno_id) values ('CSS', 2);
insert into curso (name, aluno_id) values ('JavaScript', 4);
insert into curso (name, aluno_id) values ('JavaScript', 5);
insert into curso (name, aluno_id) values ('CSS', 3);
insert into curso (name, aluno_id) values ('css', 6);

select
	a.name as alunoName, 
	c.name as cursoName
		from aluno as a 
		join curso as c
			on a.id  = c.aluno_id;
		
create table livro (
	id serial primary key,
	name varchar(255)
);

insert into livro (name) values ('Perdida');
insert into livro (name) values ('A Seleção');
insert into livro (name) values ('ACOTAR');
insert into livro (name) values ('Belo Desastre');

create table genero (
	id serial primary key,
	name varchar(255),
	livro_id integer,
	
	foreign key (livro_id)
		references livro (id)
);

insert into genero (name, livro_id) values ('Romance', 1);
insert into genero (name, livro_id) values ('Romance', 4);
insert into genero (name, livro_id) values ('Fantasia', 3);
insert into genero (name, livro_id) values ('Distopia', 2);

select 
	livro.id as id_livro,
	livro.name as nome_livro,
	genero.id as id_genero,
	genero.name as genero_livro
		from livro 
		join genero 
		on livro.id = genero.livro_id 
		where livro.name ilike 'a%';

create table products (
	id serial primary key,
	name varchar(255),
	price real
);

insert into products (name, price) values ('Bolsa', 100.00);
insert into products (name, price) values ('Perfume', 500.00);
insert into products (name, price) values ('Vestido', 150.00);
insert into products (name, price) values ('Brinco', 90.00);
insert into products (name, price) values ('Batom', 150.00);

create table categories (
	id serial primary key,
	name varchar(255)
);

insert into categories (name) values ('Acessórios');
insert into categories (name) values ('Roupas');
insert into categories (name) values ('Perfumaria');
insert into categories (name) values ('Maquiagem');

drop table category_product;

create table category_product (
	product_id integer,
	category_id integer,
	
	foreign key (product_id)
		references products (id)
		on delete cascade
		on update cascade,
		
	foreign key (category_id)
		references categories (id)
);

insert into category_product (product_id, category_id) values (1, 1);
insert into category_product (product_id, category_id) values (2, 3);
insert into category_product (product_id, category_id) values (3, 2);
insert into category_product (product_id, category_id) values (4, 1);
insert into category_product (product_id, category_id) values (5, 4);
insert into category_product (product_id, category_id) values (5, 3);


select * from category_product;



select 
p.id as product_id,
p.name as product_name,
p.price as product_price,
c.name as category_name
	from products as p
	right join category_product as cp
		on p.id = cp.product_id
	right join categories as c
		on c.id = cp.category_id
	order by p.name, c.name desc
--where c.name ilike 'ac%';
	
delete from products where id=1;

update products 
set id = 30
where id = 2;



select * from products 
order by name desc --asc
limit 2
offset 1;

select 
count(id),
sum(id),
max(id),
min(id),
round(avg(id), 2)
from products;


select distinct name, price from products
order by name;


select name, count(id) 
from products
group by name
order by name;

select products.name,
count(categories.id)
from products 
join category_product 
	on products.id = category_product.product_id
join categories 
	on categories.id = category_product.category_id
group by products.name
having count(categories.id) = 2
order by products.name desc;


select name, count(id) 
from products 
group by name
having count(id) > 1;

select name, count(id) 
from products 
group by name
having count(id) = 1;

