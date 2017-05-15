CREATE DATABASE cms;

CREATE SEQUENCE manufacturer_id_seq;

CREATE TABLE car_manufacturers(
		id int PRIMARY KEY DEFAULT NEXTVAL('manufacturer_id_seq'),
		manufacturer_name VARCHAR(30) NOT NULL
);

CREATE SEQUENCE type_id_seq;

CREATE TABLE car_types(
		id int PRIMARY KEY DEFAULT NEXTVAL('type_id_seq'),
		type_name VARCHAR(30) NOT NULL,
		manufacturer_id int REFERENCES car_manufacturers(id)
);

CREATE SEQUENCE engine_type_id_seq;

CREATE TABLE engine_types(
		id int PRIMARY KEY DEFAULT NEXTVAL('engine_type_id_seq'),
		engine_type VARCHAR(30)
);

CREATE SEQUENCE transmission_type_id_seq;

CREATE TABLE transmission_types(
		id int PRIMARY KEY DEFAULT NEXTVAL('transmission_type_id_seq'),
		transmission_type VARCHAR(30)
);

CREATE SEQUENCE colour_id_seq;

CREATE TABLE colours(
		id int PRIMARY KEY DEFAULT NEXTVAL('colour_id_seq'),
		colour VARCHAR(30)
);

CREATE SEQUENCE role_id_seq;

CREATE TABLE roles(
		id int PRIMARY KEY DEFAULT NEXTVAL('role_id_seq'),
		role_name VARCHAR(30)
);

CREATE SEQUENCE user_id_seq;

CREATE TABLE users(
		id int PRIMARY KEY DEFAULT NEXTVAL('user_id_seq'),
		first_name VARCHAR(30) NOT NULL,
		last_name VARCHAR(30) NOT NULL,
		email VARCHAR(50) NOT NULL,
		password VARCHAR(500) NOT NULL,
		enabled BOOLEAN,
		phone_number VARCHAR(30) NOT NULL
);

CREATE SEQUENCE user_role_id_seq;

CREATE TABLE user_role_relation(
		id int PRIMARY KEY DEFAULT NEXTVAL('user_role_id_seq'),
		role_id int REFERENCES roles(id),
		user_id int REFERENCES users(id)
);

CREATE SEQUENCE car_id_seq;

CREATE TABLE cars(
		id int PRIMARY KEY DEFAULT NEXTVAL('car_id_seq'),
		seller_id int REFERENCES users(id),
		manufacturer_id int REFERENCES car_manufacturers(id),
		type_id int REFERENCES car_types(id),
		price int NOT NULL,
		mileage int NOT NULL,
		registration_year int NOT NULL,
		extras VARCHAR(1000),
		engine_type_id int REFERENCES engine_types(id),
		transmission_type_id int REFERENCES transmission_types(id),
		colour_id int REFERENCES colours(id),
		picture_src VARCHAR(100),
		matriculation_status boolean
);

INSERT INTO car_manufacturers(manufacturer_name) values ('Audi'),
                                                        ('BMW'),
                                                        ('Citroen'),
                                                        ('Dacia'),
                                                        ('Fiat'),
                                                        ('Ford'),
                                                        ('Honda'),
                                                        ('Hyundai'),
                                                        ('Kia'),
                                                        ('Land Rover'),
                                                        ('Mazda'),
                                                        ('Mercedes-Benz'),
                                                        ('Mitsubishi'),
                                                        ('Nissan'),
                                                        ('Opel'),
                                                        ('Peugeot'),
                                                        ('Renault'),
                                                        ('Seat'),
                                                        ('Skoda'),
                                                        ('Toyota'),
                                                        ('Volkswagen'),
                                                        ('Volvo');

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('A3', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi')),
	('A4', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi')),
	('A5', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi')),
	('A6', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi')),
	('A7', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi')),
	('A8', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Audi'));

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('320', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW')),
	('330', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW')),
	('335', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW')),
	('420', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW')),
	('520', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW')),
	('525', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'BMW'));

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('C3', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Citroen')),
	('C4', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Citroen')),
	('C5', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Citroen')),
	('DS3', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Citroen')),
	('DS4', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Citroen'));

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('Amarok', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Volkswagen')),
	('Golf', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Volkswagen')),
	('Scirocco', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Volkswagen')),
	('Tiguan', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Volkswagen')),
	('Touareg', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Volkswagen'));

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('Amarok', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Skoda')),
	('Octavia', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Skoda')),
	('Rapid', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Skoda')),
	('Superb', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Skoda')),
	('Yeti', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Skoda'));

INSERT INTO car_types(type_name, manufacturer_id) VALUES
	('Escort', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford')),
	('Explorer', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford')),
	('F150', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford')),
	('Mondei', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford')),
	('Mustang', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford')),
	('Transit', (SELECT id FROM car_manufacturers WHERE manufacturer_name = 'Ford'));


INSERT INTO colours(colour) values('Black'),
                                  ('Blue'),
                                  ('Green'),
                                  ('Grey'),
                                  ('Orange'),
                                  ('Purple'),
                                  ('Red'),
                                  ('Silver'),
                                  ('White'),
                                  ('Yellow');

INSERT INTO engine_types(engine_type) values('PETROL'),('DIESEL'),('ELECTRIC'),('HYBRID');

INSERT INTO transmission_types(transmission_type) values('MANUAL'),('AUTOMATIC');

INSERT INTO roles(role_name) values('USER'),('ADMIN');



