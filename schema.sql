CREATE TABLE list (
    id serial PRIMARY KEY, 
    name varchar(50) UNIQUE NOT NULL
);

CREATE TABLE todos (
  id serial PRIMARY KEY, 
  name varchar(50) NOT NULL, 
  list_id integer NOT NULL REFERENCES list(id), 
  completed boolean DEFAULT false NOT NULL
);
