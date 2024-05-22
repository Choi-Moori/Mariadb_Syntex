create table author (
	id int not null auto_increment primary key,
    name varchar(255) not null,
    email varchar(255) not null unique,
    password varchar(255) not null,
    created_time datetime default current_timestamp()
);

--------------------------------------------------------------------------------------

create table post(
	id int not null auto_increment primary key,
    title varchar(255) not null,
    contents varchar(255) not null
);

--------------------------------------------------------------------------------------

create table author_post(
	id int not null auto_increment primary key,
    author_id int not null,
    post_id int not null,
    modified_time datetime default current_timestamp,
    foreign key author_post(author_id) references author(id) on delete cascade,
    foreign key post(post_id) references post(id) on delete cascade
);

--------------------------------------------------------------------------------------

create table author_address(
	id int not null auto_increment primary key,
    city varchar(255) not null,
    street varchar(255) not null,
    author_id int unique not null ,
    foreign key author_address(author_id) references author(id) on delete cascade
);

--------------------------------------------------------------------------------------    

select * from author;

insert into author(name, email, password) values ('kim','kim@naver.com',1234);
insert into author(name, email, password) values ('lee','lee@naver.com',1234);
insert into author(name, email, password) values ('park','park@naver.com',1234);
insert into author(name, email, password) values ('choi','choi@naver.com',1234);
insert into author(name, email, password) values ('min','min@naver.com',1234);
insert into author(name, email, password) values ('bang','bang@naver.com',1234);

select * from author;

--------------------------------------------------------------------------------------
select * from post;

insert into post (title, contents) values ('lee', 'leelee');
insert into post (title, contents) values ('park', 'parkpark');
insert into post (title, contents) values ('choi', 'choichoi');
insert into post (title, contents) values ('min', 'minmin');
insert into post (title, contents) values ('bang', 'bangbang');

select * from post;

--------------------------------------------------------------------------------------

select * from author_address;

insert into author_address( city, street, author_id) values ('Seoul', 'kangnamero', 1);
insert into author_address( city, street, author_id) values ('Busan', 'seomyeonro', 2);
insert into author_address( city, street, author_id) values ('ChunCheon', 'ChunCheonro', 3);
insert into author_address( city, street, author_id) values ('InCheon', 'InCheonro', 4);
insert into author_address( city, street, author_id) values ('DaeGu', 'DongSeongro', 5);
insert into author_address( city, street, author_id) values ('DaeJeon', 'DaeJeonro', 6);

select * from author_address;

--------------------------------------------------------------------------------------

select * from author_post;

insert into author_post(author_id, post_id) values (1,1);
insert into author_post(author_id, post_id) values (1,2);
insert into author_post(author_id, post_id) values (2,1);
insert into author_post(author_id, post_id) values (2,2);
insert into author_post(author_id, post_id) values (2,3);
insert into author_post(author_id, post_id) values (3,4);
insert into author_post(author_id, post_id) values (4,5);
insert into author_post(author_id, post_id) values (5,6);
insert into author_post(author_id, post_id) values (6,5);
insert into author_post(author_id, post_id) values (6,4);

select * from author_post;