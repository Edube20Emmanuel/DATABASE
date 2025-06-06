create database players;

create table players.cricketers(playerid int, name varchar(255));

insert into players.cricketers(playerid, name) values(1, "Edube Emma");
insert into players.cricketers(playerid, name) values(2, "Mukama Joseph");
insert into players.cricketers(playerid, name) values(3, "Oscar Odonkara");

select * from players.cricketers;

select name from players.cricketers where playerid = 2;
select * from players.cricketers where playerid = 3;
select * from players.cricketers where playerid >= 2;