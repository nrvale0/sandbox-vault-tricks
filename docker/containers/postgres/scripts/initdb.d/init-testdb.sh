#!/bin/bash

set -eux

PGUSER='postgres' PGPASSWORD='postgres' psql -h localhost -v VERBOSITY=verbose -v ON_ERROR_STOP=1 <<-EOSQL
     drop database testdb;
     create database testdb;
     \connect testdb;
     create table testdata (id serial PRIMARY KEY, sometext varchar(255));     
     insert into testdata values(1, 'test0');
     insert into testdata values(2, 'test1');
     insert into testdata values(3, 'test2');	
EOSQL
