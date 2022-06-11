BEGIN TRANSACTION;

DROP TABLE IF EXISTS users, brewery, address_info, beverage, brewery_beverage, brewery_address_info, rating;
DROP SEQUENCE IF EXISTS seq_user_id;

CREATE SEQUENCE seq_user_id
  INCREMENT BY 1
  NO MAXVALUE
  NO MINVALUE
  CACHE 1;

CREATE TABLE users (
	user_id int DEFAULT nextval('seq_user_id'::regclass) NOT NULL,
	username varchar(50) NOT NULL,
	password_hash varchar(200) NOT NULL,
	role varchar(50) NOT NULL,
	CONSTRAINT PK_user PRIMARY KEY (user_id)
);

CREATE TABLE brewery (
    brewery_id serial,
    name varchar(75) NOT NULL,
    description varchar(300),
    outdoor_seating bool NOT NULL,
    pet_friendly bool NOT NULL,
    serves_food bool NOT NULL,
    on_site_brewing bool NOT NULL,
    brewer_id int,
    CONSTRAINT PK_brewery PRIMARY KEY (brewery_id),
    CONSTRAINT FK_brewery_brewer_id FOREIGN KEY (brewer_id) REFERENCES users(user_id)
);

--IMAGE URL FOR BREWERY







CREATE TABLE address_info (
  address_id serial,
  address varchar(300),
  phone_number varchar(20),
  latitude numeric(10,8),
  longitude numeric(10,8),
  CONSTRAINT PK_address_info PRIMARY KEY (address_id)
);

CREATE TABLE beverage (
    beverage_id serial,
    beverage_name varchar(30) NOT NULL,
    description varchar(250),
    image_url varchar(150),
    abv numeric(5,2) NOT NULL,
    beverage_type varchar(30) NOT NULL,
    ibu int,
    availability bool,
    CONSTRAINT PK_beverage PRIMARY KEY (beverage_id)
);

CREATE TABLE brewery_beverage (
    beverage_id int,
    brewery_id int,
    CONSTRAINT FK_brewery_beverage_brewery FOREIGN KEY (brewery_id) REFERENCES brewery(brewery_id),
    CONSTRAINT FK_brewery_beverage_beverage FOREIGN KEY (beverage_id) REFERENCES beverage(beverage_id)
);

CREATE TABLE brewery_address_info (
    brewery_id int,
    address_id int,
    CONSTRAINT FK_brewery_address_info_brewery FOREIGN KEY (brewery_id) REFERENCES brewery(brewery_id),
    CONSTRAINT FK_brewery_address_info_address FOREIGN KEY (address_id) REFERENCES address_info(address_id)
);

CREATE TABLE rating (
	rating_id serial,
	rating_text VarChar (500) NOT NULL,
	rating int NOT NULL CHECK (rating <=5),
	rating_date date,
	rating_type varchar(25),
	beverage_id int CONSTRAINT fk_beverage REFERENCES beverage(beverage_id),
	brewery_id int CONSTRAINT fk_brewery REFERENCES brewery(brewery_id),
    reviewer_id int CONSTRAINT fk_users REFERENCES users(user_id),
    CONSTRAINT PK_rating PRIMARY KEY (rating_id)
);




INSERT INTO users (username,password_hash,role) VALUES ('user','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_USER');
INSERT INTO users (username,password_hash,role) VALUES ('admin','$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC','ROLE_ADMIN');
INSERT INTO users (username, password_hash, role)
VALUES ('testBrewer', '$2a$08$UkVvwpULis18S19S5pZFn.YHPZt3oaqHZnDwqbCW9pft6uFtkXKDC', 'ROLE_BREWER');

INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES ('Antiques On High', 'As the sister brewery to Seventh Son Brewing, AoH focuses on the production of sour and wild beers as well as hazy hop-forward IPAs and pale ales.', true, false, true, false, 2);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES ('Barleys Brewing Company','Barleys Brewing Company is Columbus oldest operating Brewpub. Established in 1992, we offer a variety of award winning ales paired with elevated pub fare', false, false, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing,brewer_id)
VALUES('Brewdog Short North & Kennels', ' Our epic brewery in the USA is not only a brewery and taproom serving up cutting-edge brews, but also home to the world''s first craft beer hotel', true, true, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Columbus Brewing Co', 'Columbus Brewing Company is an independent craft brewery dedicated to exploring the flavors of American hops. Best known for Columbus IPA and Bodhi, we also enjoy the subtleties of German-style lagers, the intense characteristics of barrel aged beers and everything in between.', false, false, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Derive Brewing company', 'Located in Columbus, Ohio, Derive Brewing Company specializes in small batched hazy IPAs and saisons', true, false, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Elevator Brewery and Draught Haus', 'The Elevator Brewery & Draught Haus is a craft bar, micro-brewery, and chef driven restaurant that has been located in one of the most historic buildings, the Columbia building, in downtown Columbus for the last twenty years', false,false, true, false,3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Endeavor Brewing Company', 'In 2020 Endeavor became central Ohio’s first Brewstillery. Distilling and aging spirits on site, we released our clear spirits – Rum, Botanical Gin, Dry Gin, and Vodka – in 2020, and our first aged spirits – Cask Rum, Cask Gin, Malt Whisky, and Bourbon – in 2022.', true, false, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Hofbrauhaus Columbus', 'At Hofbräuhaus, we’re proud to have continued that tradition through the centuries – from the founding of our original brewery in Munich in 1589, to every Hofbräuhaus location around the world today', true, false, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Hoof Hearted Brewing', 'Relaxed brewery for house ales, stouts & elevated American pub fare in an airy, industrial venue.', true, true, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Knotty Pine Brewing', 'Casual brewpub serving American fare along with house-brewed beers & handcrafted cocktails',true, false, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Land-Grant Brewing Company', 'Production brewery & taproom located downtown in the historic Franklinton neighborhood of Columbus, featuring a sprawling outdoor beer garden and rotating food trucks.', true, true, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('North High Brewing', 'North High Brewing was founded in 2011 by a couple of guys who were passionate about great beer and fun times, and we opened our doors here in 2012 as just the 7th brewery in Central Ohio', true, false, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Pretentious Barrel House','Established in October of 2017, Pretentious is the first brewery in Columbus to specialize exclusively in barrel-aged sour ales.', true, true, false, true,3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Random Precision Brewing Company', 'An all wild and sour brewery with an open and inviting taproom', false, true, false, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Seventh Son Brewing Co', 'Seventh Son Brewing has been producing exceptional beers at the intersection of 4th & 4th in Columbus’ historic Italian Village since April of 2013.', true, false, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Sideswipe Brewing', 'After years of home brewing not yet famous Craig opened Sideswipe Brewing in 2013 to share his passion for brewing and naming this marvelous venture Sideswipe', true, true, false, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Smokehouse Brewing', 'Smokehouse Brewing Company is a community place where one feels at home, no matter where home happens to be.', true, false, true, true, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Spires Social Brewing Co.', 'Family owned craft brewery with on-site production, taproom, full bar, featuring craft beer and soda.', true, true, false, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES('Wolfs Ridge Brewing', 'Established in 2013, Wolf’s Ridge has grown into one of Columbus’ premier dining and drinking destinations, winning numerous local and national awards for their food and drink programs that have become synonymous with quality, inventiveness, and approachability.', true, false, true, false, 3);
INSERT INTO brewery (name, description, outdoor_seating, pet_friendly, serves_food, on_site_brewing, brewer_id)
VALUES ('Zaftig Brewing Co.', 'Established in 2013, Zaftig Brewing Company is Worthington''s only craft brewery, offering an extensive array of selections. Well-known in Columbus for our high-gravity, full-bodied ales, we aren''t afraid to push the boundaries of what great craft beer can be.', true, false, true, false, 3);


--ADDING HOURS AND IMAGES
ALTER TABLE brewery
ADD hours varchar(500);
UPDATE brewery SET hours = 'M: 4PM-11PM T: 4PM-11PM W: 4PM-11PM Th: 4PM-12AM F: 4PM-2AM SAT: 12PM-2AM SUN: 12PM-11PM'
WHERE brewery_id = 1;
UPDATE brewery SET hours = 'M: 11AM-10PM T: 11AM-10PM W: 11AM-10PM Th: 11AM-10PM F: 11AM-11PM SAT: 11AM-11PM SUN: 11AM-10PM'
WHERE brewery_id = 2;
UPDATE brewery SET hours = 'M: 4PM-10PM T: 4PM-10PM W: 4PM-10PM Th: 4PM-10PM F: 12PM-12AM SAT: 12PM-12AM SUN: 12PM-9PM'
WHERE brewery_id = 3;
UPDATE brewery SET hours = 'M: CLOSED T: 3PM-11PM W: 3PM-11PM Th: 3PM-11PM F: 1130AM-12AM SAT: 1130AM-12AM  SUN: 1130-10PM '
WHERE brewery_id = 4;
UPDATE brewery SET hours = 'M: 4PM-11PM T: 4PM-11PM W: 4PM-11PM Th: 4PM-12AM F: 2PM-12AM SAT: 12PM-12AM SUN: 12PM-9PM'
WHERE brewery_id = 5;
UPDATE brewery SET hours = 'M: CLOSED T: 1130AM-9PM W: 1130AM-9PM Th: 1130AM-9PM F: 1130AM-930PM SAT: 430PM-930PM SUN: CLOSED'
WHERE brewery_id = 6;
UPDATE brewery SET hours = 'M: 3PM-11PM T: 3PM-11PM W: 3PM-11PM Th: 3PM-11PM F: 3PM-1AM SAT: 12PM-1AM SUN: 11AM-9PM'
WHERE brewery_id = 7;
UPDATE brewery SET hours = 'M: 11AM-10PM T: 11AM-11PM W: 11AM-11PM Th: 11AM-11PM F: 11AM-11PM SAT: 11AM-12PM SUN: 11AM-10PM'
WHERE brewery_id = 8;
UPDATE brewery SET hours = 'M: CLOSED T: CLOSED W: CLOSED Th: CLOSED F: 4PM-10PM SAT: 12PM-10PM SUN: 12PM-7PM'
WHERE brewery_id = 9;
UPDATE brewery SET hours = 'M: 4PM-11PM T: 3PM-11PM W: 3PM-11PM Th: 3PM-12AM F: 3PM-1AM SAT: 10AM-1AM SUN: 10AM-10PM'
WHERE brewery_id = 10;
UPDATE brewery SET hours = 'M: 3PM-10PM T: 3PM-10PM  W: 3PM-10PM  Th: 11AM-12AM F: 11AM-1AM SAT: 11AM-1AM SUN: 11AM-10PM'
WHERE brewery_id = 11;
UPDATE brewery SET hours = 'M: 2PM-10PM T: 2PM-10PM W: 2PM-10PM Th: 2PM-10PM F: 12PM-12AM SAT: 12PM-12AM SUN: 12PM-10PM'
WHERE brewery_id = 12;
UPDATE brewery SET hours = 'M: CLOSED T: CLOSED W: CLOSED Th: CLOSED F: 5PM-10PM SAT: 1PM-10PM SUN: 1PM-6PM'
WHERE brewery_id = 13;
UPDATE brewery SET hours = 'M: CLOSED T: CLOSED W: 4PM-10PM Th: 4PM-10PM F: 4PM-11PM SAT: 12PM-11PM SUN: 1PM-7PM'
WHERE brewery_id = 14;
UPDATE brewery SET hours = 'M: 330PM-11PM T: 330PM-11PM W: 330PM-11PM Th: 330PM-12AM F: 11AM-2AM SAT: 11AM-2AM SUN: 11AM-11PM'
WHERE brewery_id = 15;
UPDATE brewery SET hours = 'M: CLOSED T: CLOSED W: 4PM-9PM Th: 4PM-9PM F: 4PM-10PM SAT: 1PM-10PM SUN: 1PM-7PM'
WHERE brewery_id = 16;
UPDATE brewery SET hours = 'M: CLOSED T: 11AM-8PM W: 11AM-8PM Th: 11AM-8PM F: 11AM-9PM SAT: 12PM-9PM SUN: 12PM-8PM'
WHERE brewery_id = 17;
UPDATE brewery SET hours = 'M: CLOSED T: 3PM-10PM W: 3PM-10PM Th: 3PM-10PM F: 3PM-11PM SAT: 12PM-11PM SUN: 12PM-8PM'
WHERE brewery_id = 18;
UPDATE brewery SET hours = 'M: CLOSED T: 3PM-11PM W: 1130AM-11PM Th: 1130AM-12AM F: 1130AM-12AM SAT: 10AM-12AM SUN: 10AM-10PM'
WHERE brewery_id = 19;
UPDATE brewery SET hours = 'M: 3PM-9PM T: 3PM-9PM W: 3PM-9PM Th: 3PM-9AM F: 3PM-10PM SAT: 11AM-10PM SUN: 1PM-7PM'
WHERE brewery_id = 20;
--IMAGES
ALTER TABLE brewery 
ADD image_url varchar(500);
UPDATE brewery SET image_url = 'https://614now.com/wp-content/uploads/2018/12/2018_AntiquesOnHigh_Kaiser-10-1024x683.jpg'
WHERE brewery_id = 1;
UPDATE brewery SET image_url = 'https://drinkupcolumbus.com/wp-content/uploads/2016/03/Barleys-Brewing-Company_01.jpg'
WHERE brewery_id = 2;
UPDATE brewery SET image_url = 'https://www.brewdog.com/public/files/DSC04924.jpg'
WHERE brewery_id = 3;
UPDATE brewery SET image_url ='https://media.bizj.us/view/img/12039158/20210616172927*750xx9248-5202-0-867.jpg'
WHERE brewery_id = 4;
UPDATE brewery SET image_url ='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSImMzpzMj4t2Vj3cw5vKRsN0kO5duLe7meIw&usqp=CAU'
WHERE brewery_id = 5;
UPDATE brewery SET image_url = 'https://media-cdn.tripadvisor.com/media/photo-s/17/fc/fc/00/original-handcrafted.jpg'
WHERE brewery_id = 6;
UPDATE brewery SET image_url = 'https://www.gannett-cdn.com/authoring/2019/12/06/NCOD/ghows-OH-1a459dc1-f17c-448b-9c5b-f07ef726d8d5-3e9160df.jpeg?width=660&height=434&fit=crop&format=pjpg&auto=webp'
WHERE brewery_id = 7;
UPDATE brewery SET image_url = 'https://ohio.org/static/uploads/068t0000002vJXeAAM.jpg'
WHERE brewery_id = 8;
UPDATE brewery SET image_url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_9sjR-zp5VOoJly1dm-AnJ7-qBOfi_wsk_g&usqp=CAU'
WHERE brewery_id = 9;
UPDATE brewery SET image_url = 'https://breakfastwithnick.com/wp-content/uploads/knotty-pine-brewing-6.jpeg'
WHERE brewery_id = 10;
UPDATE brewery SET image_url = 'https://media-exp1.licdn.com/dms/image/C4E1BAQHYYIcnEa2pIg/company-background_10000/0/1537889269236?e=1655226000&v=beta&t=GT6A-BDDju7TT4ZehGQie_O6HepYQESvkuKzr3veqo0'
WHERE brewery_id = 11;
UPDATE brewery SET image_url = 'https://images.squarespace-cdn.com/content/v1/5f2d61243d1dbf4e15a42fb7/1633527386623-OE2MC0LK3QX9NHUM4CCG/Short_North.jpg?format=1500w'
WHERE brewery_id = 12;
UPDATE brewery SET image_url = 'https://drinkupcolumbus.com/wp-content/uploads/2017/10/pretentious-barrel-house-mural.jpg'
WHERE brewery_id = 13;
UPDATE brewery SET image_url = 'https://images.squarespace-cdn.com/content/v1/5739eb3259827e68705e4267/1580095203961-FKELC0Z1P2JVUJRJXCV3/IMG_0755.jpg?format=300w'
WHERE brewery_id = 14;
UPDATE brewery SET image_url = 'https://ohiomagazine.imgix.net/sitefinity/images/default-source/articles/2018/02---february-2018/seventh-son_bar-space.jpg?sfvrsn=f06eac38_4&w=960&auto=compress%2cformat'
WHERE brewery_id = 15;
UPDATE brewery SET image_url = 'https://images.squarespace-cdn.com/content/v1/61376bef1c244a35f91d2d89/bf6feb0b-3a35-40aa-8bf7-89678cc99f4e/untitled-1859.jpg?format=750w'
WHERE brewery_id = 16;
UPDATE brewery SET image_url = 'https://fartleyfarms.com/wp-content/uploads/2019/07/IMG_7710.JPG-scaled.jpeg'
WHERE brewery_id = 17;
UPDATE brewery SET image_url = 'https://www.gannett-cdn.com/-mm-/27de1a8d150de430c721ef32458936d45459c04e/c=0-53-1024-629/local/-/media/2020/12/18/ColumbusAlive/ghows-OH-200929737-6953bbd9.jpg?width=660&height=372&fit=crop&format=pjpg&auto=webp'
WHERE brewery_id = 18;
UPDATE brewery SET image_url = 'https://media-cdn.tripadvisor.com/media/photo-s/15/73/f2/88/storefront.jpg'
WHERE brewery_id = 19;
UPDATE brewery SET image_url = 'https://media.bizj.us/view/img/11539170/20191121100152*1024xx4032-2268-0-378.jpg'
WHERE brewery_id = 20;



INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('714 S High St', '614-725-2070', 39.9476, -82.99774);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('467 N High St', '614-228-2537', 39.9719408, -83.0027669);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('1175 N High S', '614-908-3053', 39.98637, -83.00579);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('2555 Harrison Rd', '614-224-3626', 39.9675898, -83.0692897);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('2808 N. High St', '614-732-4186', 40.01939, -83.01185);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('161 N High St', '614-228-0500', 39.9656697, -83.0017892);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('909 W 5th Ave', '614-456-7074', 39.988002, -83.030429);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('800 Goodale Blvd', '614-294-2437', 39.974313, -83.025737);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('850 N 4th St', '614-104-4033', 39.9803665, -83.0002482);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('1765 W 3rd Ave', '614-817-1515', 39.9852813, -83.0529324);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('424 W Town St', '216-956-2634', 39.95787195, -83.01150763);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('1125 Cleveland Ave', '614-226-3244', 39.992787, -82.982658);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('745 Taylor Ave', '614-887-7687', 39.981855, -82.960769);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('2365 W Dublin Granville Rd', '614-389-3864', 40.090144, -83.05232);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('1101 N 4th St', '614-817-1515', 39.985351, -83.0019404);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('2419 Scioto Harper Dr', '614-719-9654', 39.96723751, -83.06626767);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('1130 Dublin Rd', '614-485-0227', 39.973715, -83.047935);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('8757 Sancus Blvd', '614-485-0227', 40.1473396, -83.004836);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('215 N 4th St', '614-429-3936', 39.9577586, -82.99517953);
INSERT INTO address_info (address, phone_number, latitude, longitude)
VALUES('7020 Huntley Rd Ste A', '614-636-2537', 40.1063329, -83.0003532);

INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(1,1);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(2,2);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(3,3);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(4,4);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(5,5);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(6,6);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(7,7);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(8,8);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(9,9);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(10,10);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(11,11);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(12,12);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(13,13);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(14,14);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(15,15);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(16,16);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(17,17);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(18,18);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(19,19);
INSERT INTO brewery_address_info (brewery_id, address_id)
VALUES(20,20);

--RUN THIS BEFORE ADDING BEVERAGES--
ALTER TABLE beverage
ALTER COLUMN description TYPE varchar(500);
ALTER TABLE beverage
ALTER COLUMN image_url TYPE varchar(500);
ALTER TABLE beverage
ALTER COLUMN beverage_type TYPE varchar(75);
ALTER TABLE beverage
ALTER COLUMN beverage_name TYPE varchar(75);


--THIS IS THE BEVERAGE LIST--
--IPA--
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Sobayu', 'Sour Ale brewed w/ buckwheat. Moderately sour.', 'https://untappd.akamaized.net/photos/2022_05_29/fd3eaf9e82e5e0c5e8b07ea3422e35d9_raw.jpg', 6.70, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Coepacetic', 'Sour Blonde Ale. Moderately sour.', 'https://untappd.akamaized.net/photos/2022_05_20/a1da1883133fe99c943f7ecd248f87d9_raw.jpg', 6.50, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Wax Poetic', 'Sour Blond Ale. Moderately sour', 'https://untappd.akamaized.net/photos/2022_05_26/616323d812336a986e1d1c214a8325f4_raw.jpg', 7.50, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Penny in the morning', 'Sour Blond Ale. Moderately sour', 'https://untappd.akamaized.net/photos/2022_05_26/616323d812336a986e1d1c214a8325f4_raw.jpg', 7.50, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Hoop Diver', 'A blend of sour red ale aged in several oak wine barrels from six to 36 months', 'https://untappd.akamaized.net/photos/2021_07_30/225b80607d37f886531706013390845d_raw.jpg', 6.70, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Dang!', 'Sour Blond Ale. Moderately sour', 'https://untappd.akamaized.net/photos/2022_05_26/616323d812336a986e1d1c214a8325f4_raw.jpg', 7.50, 'IPA', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Mallrat', 'Simcoe, sultana, El Dorado', 'https://untappd.akamaized.net/photos/2020_02_01/2ef50b2bea438f9ff0a4d73232c31af7_raw.jpg', 8.00, 'IPA', 40, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Blood Thirst Wheel', 'Winner of our 14th annual Homebrew Competition in 2009.', 'https://untappd.akamaized.net/photos/2022_05_26/d5bb1c1a1bf36b4e916bd167533113f2_raw.jpg', 5.00, 'IPA', 3, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Blurry Pike', 'This IPA is brewed exclusively with Columbus hops for a citrus note that resonates clean and cris', 'https://untappd.akamaized.net/photos/2021_03_28/2d9bf0e2a28d141963c70c388c1186ad_raw.jpg', 5.80, 'IPA', 79, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Russian Imperial Stout', 'Roasty, smooth and a nice finish.', 'https://untappd.akamaized.net/photos/2022_04_16/128ba527de3e8b1768a29f98d18f7802_raw.jpg', 7.60, 'IPA', 51, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Barleywine', 'Lightbody brown ale brewed with deeper roots coffee.', 'https://untappd.akamaized.net/photos/2019_07_06/f624b4565426e920b39e6fdf62460c5d_raw.jpg', 7.60, 'IPA', 51, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Pilsner', 'A great introduction to craft brewed beer, since there is enough malt and hop flavor in our Pilsner to keep even the most sophisticated beer drinkers coming back for more', 'https://untappd.akamaized.net/photos/2022_04_16/c7fe2eb25e549c5f5b47fb226f9b985b_640x640.jpg', 4.80, 'IPA', 15, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Christmas Ale', 'When it came time to brew Barleys Christmas Ale though, we drop everything were doing, grab some chairs (and beers!) and sit around zesting oranges while we chat.', 'https://untappd.akamaized.net/photos/2021_12_29/b434061fac0e138c78d83d903c35a5b1_raw.jpg', 7.00, 'IPA', 45, true);
--Ale
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Ulysses Imperial Red Ale', 'Toasty, fruity, and toasty! Imperial ale with a hint of butterscotch.', 'https://untappd.akamaized.net/photo/2017_06_16/8a66787863592aab3cbbf476e0d5a76f_320x320.jpeg', 7.50, 'Ale', 35, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Citrajectory Saison', 'Citrusy notes and a bitter finish', 'https://untappd.akamaized.net/photos/2018_04_16/7ce91800053dafedc5ad5d42fba11063_raw.jpg', 5.00, 'Ale', 23, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Frambwha?!', 'This wheat-heavy barley wine (wheat wine) is equal in strength to out Barleys Barleywine! We add only enough hops to keep them from being missed', 'https://untappd.akamaized.net/photo/2016_05_01/4de641bce321d2d34012b805e3aaa72d_raw.jpg', 11.50, 'Ale', 13, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('MacLennys Scottish Ale', 'You want to do WHAT? When we first brewed this beer we didnt know what would happen when we turned our brew kettle on while it was empty, in order to scorch the malt.', 'https://untappd.akamaized.net/photo/2022_06_01/07fe77317cfe0b86d5fe2262136526d3_c_1164461428_raw.jpg', 6.60, 'Ale', 14, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Pale Ale', 'Pale ale was the first beer we brewed in our brewery and continues to be one of our flagship ales.', 'https://untappd.akamaized.net/photos/2022_05_24/8598ba0d04e8bbf91e9065eeffea4195_640x640.jpg', 5.60, 'Ale', 27, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Cerveza de Mercado', 'Mexican Style Salty Lime Blonde Ale with fresh lime zest and sea salt', 'https://untappd.akamaized.net/photo/2022_05_29/9c79c1014550331906f9133e4fb60f04_c_1163506571_raw.jpg', 4.80, 'Ale', 15, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Punk IPA', 'This light, golden classic has been subverted with new world hops to create an explosion of flavour.', 'https://untappd.akamaized.net/photos/2022_06_03/2528e4f048fc05a51829b8a01dc98c5f_raw.jpg', 6.50, 'Ale', 40, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Elvis Juice', 'An American IPA with a bitter edge that will push your citrus tolerance to the brink and back; Elvis Juice is loaded with tart pithy grapefruit peel.', 'https://untappd.akamaized.net/photos/2022_06_03/6c5a0da1586a14e3604926c43a5a465b_640x640.jpg', 8.00, 'Ale', 40, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Dead Pony Club', 'Get ready to gun it down the Pacific Coast Highway through a hop-heavy west-coast wonderland.', 'https://untappd.akamaized.net/photos/2022_06_03/7856f0c0beca56e618026251b40eb445_640x640.jpg', 3.80, 'Ale', 35, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Clockwork', 'Tangerine session IPA', 'https://untappd.akamaized.net/photos/2022_06_03/009cafea48af8ee30bb426fd7265ef5e_640x640.jpg', 4.50, 'Ale', 30, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('5AM Saint', 'Jump in and you’ll find berry bouncing off marmalade clashing with caramel cosying up to chocolate buzzing off spice sizzling with toast laced with lychee and colliding with biscuit.', 'https://untappd.akamaized.net/photos/2022_06_02/8179d82517677e22915a7f6be89946d6_640x640.jpg', 5.00, 'Ale', 35, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Yakima Fresh', 'Our annual wet-hopped American IPA features hops that were shipped directly from the farm to our brewery and used within 24 hours after being picked in the field.', 'https://untappd.akamaized.net/photos/2022_06_03/8b3235f8bb8e4b887a320ab5558960dd_640x640.jpg', 7.50, 'Ale', 70, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Insane Wanderer Vol 1', 'Hops that you crave, balance that you need This deep golden session ale is brewed with balance in mind.', 'https://untappd.akamaized.net/photos/2022_05_26/1c15460e791c6823c03d5887a67a7724_640x640.jpg', 7.40, 'Ale', 75, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Endless Haze', 'Endless Haze is a smooth, easy-going hazy IPA. It’s your patio pal, grilling sidekick and wilderness companion', 'https://untappd.akamaized.net/photos/2022_06_03/1b390e8d657f0f4f16e4acdb09eaf2c0_640x640.jpg', 6.10, 'Ale', 30, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Pallet Island', 'Bourbon barrel aged Imperial Stout, w toasted coconut.', 'https://untappd.akamaized.net/photos/2020_05_07/a84bf0c6e6588b6f69525b8666b0d58c_640x640.jpg', 12.00, 'Ale', 20, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Friends Out West', 'Friends Out West (7.5%) is a Double Dry-hopped New England IPA brewed with a base of pilsner malts and a copious amounts of malted spelt and flaked oats', 'https://untappd.akamaized.net/photo/2022_06_03/a6616859ab52c9eaea90532344133c35_c_1164878021_640x640.jpg', 7.50, 'Ale', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Lofty Aspirations', 'Lofty Aspirations: An 8% hazy DIPA brewed with a fluffy and THICCC base of pilsner malts, flaked oats, malted oats, spelt and milk sugar', 'https://untappd.akamaized.net/photo/2022_05_23/fd6d173c6c604a93f48d5bafa47b22ec_c_1161550442_640x640.jpg', 8.00, 'Ale', 40, true);
--Pilsner
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Double Hazy', 'East Coasts collide and crank it up for this new New England IPA retuned in Scotland', 'https://untappd.akamaized.net/photos/2022_06_03/172dd707f2f2903305df691b538d3542_640x640.jpg', 7.20, 'Pilsner', 30, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Jack Hammer', 'Press the button, go ahead. What are you waiting for? Your mama’s not coming this time. Don’t slow down. Hammer it', 'https://untappd.akamaized.net/photos/2022_06_03/084d1818e0f95ca63ea602c5e62f8427_640x640.jpg', 7.20, 'Pilsner', 250, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Lost Lager', 'Our new recipe Lost is here. This planet first German-style Pilsner is a 4.5% lager brewed using wind power, a third less water, and would-be waste bread in the malt bill.', 'https://untappd.akamaized.net/photos/2022_06_03/2af46ac83602eec5e173d2572361451d_640x640.jpg', 4.50, 'Pilsner', 37, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Vagabond', 'A kick-ass, hop-forward pale ale, that just so happens to be gluten free.', 'https://untappd.akamaized.net/photos/2022_06_03/99b53db747f49f30686d3f09f6862ce5_640x640.jpg', 4.50, 'Pilsner', 55, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Bodhi', 'Award-winning double IPA featuring Citra® hops with a pale golden color.', 'https://untappd.akamaized.net/photos/2022_06_02/878bd105e619d90ab0e63b6ed4833954_640x640.jpg', 8.30, 'Pilsner', 80, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Creeper', 'Our Gold medal winning Imperial IPA, brewed with Mosaic, Citra®, and Idaho 7.', 'https://untappd.akamaized.net/photos/2022_06_01/7f9462d5725b39d00bfa93fde0a64741_640x640.jpg', 10.00, 'Pilsner', 100, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Thunderlips', 'Modern American Pale brewed with Mosaic and Idaho hops', 'https://untappd.akamaized.net/photos/2021_06_26/90d75bb7761cb18d4f3a27a0b62fdcd7_640x640.jpg', 5.30, 'Pilsner', 0, true);
--Lager
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Thunderkiss Morning Froth', 'Cream ale with Thunderkiss Coffees Ethiopia Sidama Natural Bourbon Finished', 'https://untappd.akamaized.net/photos/2022_04_10/4fb7d38e9a224a03c53221e068ac32ee_640x640.jpg', 5.50, 'Lager', 25, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Glad Hands', 'Hazy Pale Ale- Malt: Pilsner, Oats, Spelt. Hops: Citra, Mosaic, El Dorado, Simcoe', 'https://untappd.akamaized.net/photos/2022_06_02/2b4ae61c04e40a1aa4b9031fdfea9687_640x640.jpg', 5.50, 'Lager', 51, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Canary Diamonds', 'Canary Diamonds is a 7.2% New England IPA brewed with pilsner malt, spelt and flaked oats', 'https://untappd.akamaized.net/photos/2021_12_13/02b97a3ee18d55985b426c727199abf5_640x640.jpg', 7.20, 'Lager', 52, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('OG Pale', 'Derive OG Pale Ale: A 5.6% ABV nostalgic look at 2016 in a glass.', 'https://untappd.akamaized.net/photos/2021_11_15/aaa0a960b680ee3657907d1d9fb98ab9_640x640.jpg', 5.60, 'Lager', 45, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('We Dont Know A Stranger', 'SBrewed with our house base of Pilsner Malts, Spelt and Flaked Oats', 'https://untappd.akamaized.net/photos/2021_11_03/a05002925b5162289e7c7546fd05e6ba_640x640.jpg', 7.50, 'Lager', 40, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Cheers To 1 Year', 'Imperial Molasses cookie Pastry Stout', 'https://untappd.akamaized.net/photos/2021_12_29/e443d12466cfc8888330b67a9d918aa7_640x640.jpg', 12.00, 'Lager', 55, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Shaka', 'Select hops from three separate continents provide an accentuated aroma of tropical fruit, while keeping bitterness, alcohol content, and malt base balanced.', 'https://untappd.akamaized.net/photos/2022_05_14/fbcbe0140c7199cc44b4d8ac1b4f7b0f_640x640.jpg', 6.50, 'Lager', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Altura', 'Patagonian malt. Lime hops.', 'https://untappd.akamaized.net/photos/2022_05_24/8be7e2f386762bd2e6212d6529c4aca7_640x640.jpg', 4.70, 'Lager', 25, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Icelandic Saga', 'Icelandic-style Ale. This brew is made with some wheat and features notes of Sage and Icelandic Anise Star.', 'https://untappd.akamaized.net/photo/2022_05_22/9c272909431952e6e901ed45c43d31c0_c_1161191343_640x640.jpg', 4.70, 'Lager', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Campfire S’mores', 'Infuswd with cocoa, vanilla beans, and milk sugar', 'https://untappd.akamaized.net/photos/2022_06_02/3e0ad40b1cc71fa863e51e40a28e64b1_640x640.jpg', 6.70, 'Lager', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Tripel', 'Flavors of spice, stone fruit, clover and bubblegum', 'https://untappd.akamaized.net/photos/2019_03_14/b6c791331964ca0a05d0ef76cc57a603_640x640.jpg', 9.00, 'Lager', 30, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Sybarite W/ Raspberries', 'The raspberry flavor and aroma are not subtle. This beer is the equivalent of cramming fresh raspberries into your mouth.', 'https://untappd.akamaized.net/photos/2022_05_29/725b17f3894cb3ba03fe735e068e98c9_640x640.jpg', 4.80, 'Lager', 40, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Indolence', 'The dichotomy of sweet and sour unite to create something unlike any beer we have ever tried. ', 'https://untappd.akamaized.net/photos/2022_05_28/b3812c61bea91107f5ea862c9f9d681b_640x640.jpg', 5, 'Lager', 10, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Derisive', 'A blend of red and dark sour ale aged in wine barrels.', 'https://untappd.akamaized.net/photos/2020_04_17/93e7c9f74c21f6dd4a96336930c27887_640x640.jpeg', 5.30, 'Lager', 0, true);
--Cider
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Grape Stomp', 'Row after row of plump, purple grapes. Plucked fresh from the vine, jam-packed into a barrel, and ready for a good stomp.', 'https://untappd.akamaized.net/photos/2022_05_30/bc09f6daf188f7713ce367e54328b1ab_640x640.jpg', 5.00, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Golden Empire of York', 'We created Golden Empire of York from 100% Virginia-grown Golden Delicious, Empire, and York apples.', 'https://untappd.akamaized.net/photos/2022_02_14/0dbbf8915318b0956a6bb2b4611860eb_640x640.jpg', 6.90, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Toasted Pumpkin', 'Dry Hazy Cider; packed full warming spices & pumpkin pie.', 'https://untappd.akamaized.net/photos/2022_04_12/8e2c4553bcdb48284eb5faf5ed181a44_640x640.jpg', 5.00, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Hazy Apple', 'Unfiltered apple juice makes this home-style cider an all-time classic.', 'https://untappd.akamaized.net/photos/2022_01_16/638dd8cb43cc627f0d625d90c14dea6a_640x640.jpg', 7.00, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Agave Dreamwave', 'Sharp and light with a lemon grassy finish, not at all what I was expecting to a pleasant surprise', 'https://untappd.akamaized.net/photos/2022_06_02/da3275399f293029ae71ba53ad32a00e_640x640.jpg', 6.90, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Black Oak', 'Apples with black current wine aged in American Oak brandy barrels for 9 months', 'https://untappd.akamaized.net/photos/2022_01_22/dd4147756d5d30ceb628cf2539c6ae5a_640x640.jpg', 9.50, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Cider Donut', 'Warm up as the weather cools down with 16 ounces of fall flavors found in a cider donut. Soul warmingly good, made for the adventurer in you', 'https://untappd.akamaized.net/photos/2022_02_13/9323224b0cca8303541911b6aa8843e4_640x640.jpg', 5, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Bluegrass Russet', 'Off-dry. This cider showcases the Golden Russet apple. Custom fermentation and bottling using the Charmat method.', 'https://untappd.akamaized.net/photos/2021_12_25/229173956aa45fce5bbac4b35632ba58_640x640.jpg', 7.40, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Book of Nomad | Dragons Lair', 'Black Currant Blueberry Honey Cider.', 'https://untappd.akamaized.net/photos/2019_03_25/01d033e8e6e348bbf8967df5446d15cc_640x640.jpg', 6.90, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Desert Diamonds', 'Gose Cider / Bright and fruity tamarind and ginger tart salted cider.', 'https://untappd.akamaized.net/photos/2022_04_14/d00c8dd4e5016969816d9b7794eceb27_640x640.jpg', 6.90, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Sonata', 'Spontaneously fermented with 250g/L cherries + pits. Zero residual sugar.', 'https://untappd.akamaized.net/photos/2022_04_30/a034284e78d4ce3e4fe86ba2ed1f865a_640x640.jpg', 6.50, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Feels Like Home', 'Feels Like Home is a fruity and unfiltered cider with hints of rum and oak, made for unwinding.', 'https://untappd.akamaized.net/photos/2022_05_26/2ad6e56713ed0115b5025ffda2aabe7f_640x640.jpg', 5.40, 'Cider', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Jona And Ida Are A Pear', 'Pressed from a blend of Jona Gold, Ida Red, Greening, and Golden Delicious apples grown in Virginia.', 'https://untappd.akamaized.net/photos/2021_11_29/3d8146e7688514dda783b47063fa233a_640x640.jpg', 6.90, 'Cider', 40, true);
--Stouts
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Melk Stout', 'Melk Stout brings a rich, complex malt profile of dark chocolate, coffee, and roasted barley', 'https://untappd.akamaized.net/photos/2022_02_26/14117908057fa2cb23e658b941d26371_640x640.jpg', 5.60, 'Stout', 22, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Eros', 'Greek god of love and desire. He is a decadent imperial stout with note of chocolate and cream conditioned on Oreos', 'https://untappd.akamaized.net/photos/2022_06_01/a5ffb584eb359c0861da26e503a75720_640x640.jpg', 11.00, 'Stout', 14, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('A Stout Has No Name', 'Chocolate, Peanut Butter & Coffee Stout', 'https://untappd.akamaized.net/photos/2022_05_21/15ceaee20b539b7670285ca65081d000_640x640.jpg', 8.20, 'Stout', 55, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Background Radiation', 'Imperial Sweet Stout aged and fermented in a Buffalo Trace Lot E barrel.', 'https://untappd.akamaized.net/photos/2022_04_12/0699a40e0eadc54208eb417e0eaac080_640x640.jpg', 11.85, 'Stout', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Two Tone Footer Stout', 'Chocolatey', 'https://untappd.akamaized.net/photos/2022_04_08/dac93356ba7584bf86973c1edd019748_640x640.jpg', 6.40, 'Stout', 21, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Big Cinder Toffee Stout', ' A beautifully smooth, jet black stout with delicious blow-torched honeycomb added to the mix for that tasty New Bristol twist.', 'https://untappd.akamaized.net/photos/2022_06_02/32b12afcf7c11362b14e7dd9e07b8d6a_640x640.jpg', 6.50, 'Stout', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Hold the Pancakes', 'Multiple vintages of imperial brown ales and imperial stouts aged from 15 to 24 months in bourbon, rye and maple syrup-filled whiskey casks come together in this complex, sticky, boozy behemoth of a beer, showcasing the barrel shepherding and blending skills of our brilliant brewers.', 'https://untappd.akamaized.net/photos/2022_05_26/c09f7abf6c382441abc5630f29a8e9c1_640x640.jpg', 13.90, 'Stout', 13, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('El Hombre', 'Horchata stout - brewed with Almond tea, cinnamon sticks and Madagascar vanilla beans.', 'https://untappd.akamaized.net/photos/2022_03_27/3c2d13233abf4eec3d85f2d46f857a31_640x640.jpg', 7.00, 'Stout', 50, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Skillet Donut Stout', 'Peanut butter tones', 'https://untappd.akamaized.net/photos/2021_01_14/17d55d091979fdd3db31d80a72e34dfe_640x640.jpg', 8.00, 'Stout', 60, true);

--Non Alchoholic--
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('U R AWSM!', 'Extra Quadro Fruited Non-Alcoholic Sour Ale', 'https://untappd.akamaized.net/photos/2022_04_02/b74abcba0e702caecf5fe4716dce23f6_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Closer By the Mile', 'A pale IPA with grapefruit and pineapple aromas and a lean malt profile.', 'https://untappd.akamaized.net/photos/2022_03_11/4a55a98afc93b51399b26d8c4e1a1831_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Parallel: Raspberry Passion Fruit', 'Fruited Sour Ale brewed with lactose, and massive amounts of passion fruit and raspberry purees.', 'https://untappd.akamaized.net/photos/2022_05_31/bcc8666ecc30796a205d9b5c11d47120_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Free Gelato: Berries & Cream', 'Non-ABV Ice Cream Pastry Sour w. raspberries, blackcurrant, marshmallow & vanilla.', 'https://untappd.akamaized.net/photos/2022_06_03/feb7ee7cf9ab096765b7048450d4be58_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Soul Sour', 'Soul Sour is a tribute to and celebration of the beauty and history of black culture', 'https://untappd.akamaized.net/photos/2022_05_30/0f5493438eb021900317587a47193780_640x640.jpg', 0.00, 'Non-Alchoholic', 10, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Passion Pool Shallow', 'Who says the shallow pool has to be boring? Shallow Pool is our brand new non-alcoholic Passion Fruit Gose, that works like an excellent alternative to Passion Pool.', 'https://untappd.akamaized.net/photos/2022_06_03/9978c6af17c2d5ba0a0c99dfc4aa5455_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Daves American Dark Malt', 'Inspired by robust American Porters this is a substantial dark and malty brew', 'https://untappd.akamaized.net/photos/2022_03_28/e8c2192b440feab58d0a656e92b61fd1_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);
INSERT INTO beverage (beverage_name, description, image_url, abv, beverage_type, ibu, availability) VALUES ('Trailblazer', 'A liquid legend in the land of lager. It follows a crisp peach nose through cairns of citrus and florals, peaking at a whole new elevation of hops.', 'https://untappd.akamaized.net/photos/2022_05_30/e18d6ad1d5419b3a16f4dfaf6da96bee_640x640.jpg', 0.00, 'Non-Alchoholic', 0, true);

--Inserting Drinks into breweries
--Antiques ON high
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (1, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (2, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (3, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (4, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (5, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (6, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (8, 1);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (79, 1);
--Barley brewing
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (80, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (64, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (22, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (29, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (15, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (10, 2);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (9, 2);
--BrewDog
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (74, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (51, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (23, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (15, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (8, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (16, 3);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (21, 3);
--Columbus
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (22, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (23, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (24, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (78, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (14, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (13, 4);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (19, 4);
--Derive
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (8, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (12, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (19, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (18, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (45, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (48, 5);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (62, 5);
--Elevator
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (12, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (31, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (34, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (35, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (55, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (61, 6);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (81, 6);
--Endeavor
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (11, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (13, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (14, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (15, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (16, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (17, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (18, 7);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (19, 7);
--Hofbrauhus
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (20, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (21, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (22, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (23, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (24, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (25, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (26, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (27, 8);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (28, 8);
--hoof hearted
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (29, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (30, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (31, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (32, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (33, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (34, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (35, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (36, 9);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (37, 9);
--knottyPine
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (38, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (40, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (39, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (41, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (42, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (43, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (44, 10);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (45, 10);
--Land Grant
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (46, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (47, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (48, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (49, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (50, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (51, 11);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (52, 11);
--North High
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (53, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (54, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (55, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (56, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (57, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (58, 12);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (59, 12);
--Pretentios
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (62, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (23, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (65, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (18, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (78, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (35, 13);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (46, 13);
--Random Precision
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (64, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (21, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (26, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (43, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (33, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (27, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (37, 14);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (63, 14);
--Seventh SOn
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (67, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (35, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (41, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (51, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (24, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (17, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (7, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (9, 15);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (68, 15);
--SideSwipe
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (70, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (31, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (62, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (29, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (30, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (69, 16);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (28, 16);
--Smokehouse
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (21, 17);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (79, 17);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (13, 17);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (6, 17);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (8, 17);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (1, 17);
--Spires Social
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (73, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (74, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (28, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (26, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (24, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (75, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (18, 18);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (45, 18);
--Wolfs Ridge
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (77, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (78, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (21, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (41, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (45, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (58, 19);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (57, 19);
--Zaftig
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (24, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (33, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (48, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (75, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (41, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (55, 20);
INSERT INTO brewery_beverage (beverage_id, brewery_id) VALUES (31, 20);
--Run before adding ratings

--Rating for each beverage
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-04', 'beverage', 1, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Pretty Decent OK', 3, '2022-06-05', 'beverage', 2, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 3, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 4, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 5, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 6, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 7, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 8, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 9, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 10, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-04', 'beverage', 11, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-03', 'beverage', 12, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Pretty Decent OK', 3, '2022-06-05', 'beverage', 13, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 14, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 15, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 16, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 17, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 18, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 19, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 20, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 21, 2);

VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 22, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 23, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 24, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 25, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 26, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 27, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 28, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 29, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 30, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 31, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 32, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 33, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-01', 'beverage', 34, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-02', 'beverage', 35, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Pretty Decent OK', 3, '2022-06-05', 'beverage', 36, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 37, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-04', 'beverage', 38, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Pretty Decent OK', 3, '2022-06-05', 'beverage', 39, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage',40, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 41, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 42, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 43, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 44, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 45, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 46, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 47, 2);

VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 45, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 49, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 50, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 51, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 52, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 53, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 54, 2);

VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 55, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 56, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 57, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 58, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 59, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 60, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 61, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had, it tastes great too', 5, '2022-06-05', 'beverage', 62, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 63, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 64, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 65, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 66, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 67, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 68, 2);

INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Best Beer', 5, '2022-06-07', 'beverage', 69, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Pretty Decent OK', 3, '2022-06-05', 'beverage', 70, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This beer is awesome!', 5, '2022-06-05', 'beverage', 71, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('This is one of the most unique beers I have had it tastes great too', 5, '2022-06-05', 'beverage', 4, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Mediocre beer...', 3, '2022-06-05', 'beverage', 73, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 74, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 75, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 76, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Great can, but clowns are terrible, not as terrible as this beer though', 1, '2022-06-05', 'beverage', 77, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Buy This! Excellent Brew', 3, '2022-06-05', 'beverage', 78, 2);
VALUES ('Great can, terrible beer though', 1, '2022-06-05', 'beverage', 79, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Excellent Brew', 4, '2022-06-05', 'beverage', 80, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, beverage_id, reviewer_id)
VALUES ('Average Not my style', 3, '2022-06-05', 'beverage', 81, 2);
--1 Rating for each Brewery
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Awesome Vibe', 5, '2022-05-05', 'brewery', 1, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Great Setting', 4, '2022-05-28', 'brewery', 2, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Worst Bartender ever', 2, '2022-04-15', 'brewery', 3, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Great Location!', 4, '2022-03-20', 'brewery', 4, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Great selection of beers', 4, '2022-02-14', 'brewery', 5, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Service is impeccable', 5, '2022-04-05', 'brewery', 6, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Seen a rat', 1, '2022-03-25', 'brewery', 7, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Horrible food', 1, '2022-02-26', 'brewery', 8, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Not much to say about this place', 3, '2022-01-05', 'brewery', 9, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Couldve been a bit better service', 3, '2022-04-05', 'brewery', 10, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Always crowded with no seating', 3, '2021-08-05', 'brewery', 11, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Fantastic service', 4, '2021-12-05', 'brewery', 12, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('The bartender was drunk', 2, '2021-12-31', 'brewery', 13, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Awesome late night stop', 5, '2022-02-15', 'brewery', 14, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Mediocre at best', 3, '2022-06-05', 'brewery', 15, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Cool place to hangout', 4, '2022-04-21', 'brewery', 16, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Very interesting place', 3, '2022-03-14', 'brewery', 17, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('This place does it right', 5, '2022-02-18', 'brewery', 18, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('Kinda maybe sorta okay', 3, '2022-01-14', 'brewery', 19, 2);
INSERT INTO rating (rating_text, rating, rating_date, rating_type, brewery_id, reviewer_id)
VALUES ('This place is a joke', 1, '2022-05-22', 'brewery', 20, 2);



COMMIT TRANSACTION;
