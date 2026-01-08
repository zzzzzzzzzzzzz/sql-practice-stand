-- PostgreSQL schema and seed data for the SQL practice environment.

DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS location CASCADE;
DROP TABLE IF EXISTS job CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS sales_order CASCADE;
DROP TABLE IF EXISTS item CASCADE;
DROP TABLE IF EXISTS price CASCADE;
DROP TABLE IF EXISTS product CASCADE;

CREATE TABLE employee (
  employee_id SERIAL PRIMARY KEY,
  last_name VARCHAR(15),
  first_name VARCHAR(15),
  middle_initial VARCHAR(1),
  manager_id INTEGER,
  job_id INTEGER,
  hire_date TIMESTAMP WITHOUT TIME ZONE,
  salary NUMERIC(7, 2),
  commission NUMERIC(7, 2),
  department_id INTEGER
);

CREATE TABLE department (
  department_id SERIAL PRIMARY KEY,
  name VARCHAR(14),
  location_id INTEGER
);

CREATE TABLE location (
  location_id SERIAL PRIMARY KEY,
  regional_group VARCHAR(20)
);

CREATE TABLE job (
  job_id SERIAL PRIMARY KEY,
  function VARCHAR(30)
);

CREATE TABLE customer (
  customer_id SERIAL PRIMARY KEY,
  name VARCHAR(45),
  address VARCHAR(40),
  city VARCHAR(30),
  state VARCHAR(2),
  zip_code VARCHAR(9),
  area_code SMALLINT,
  phone_number INTEGER,
  salesperson_id INTEGER,
  credit_limit NUMERIC(9, 2),
  comments VARCHAR(500)
);

CREATE TABLE sales_order (
  order_id SERIAL PRIMARY KEY,
  order_date TIMESTAMP WITHOUT TIME ZONE,
  customer_id INTEGER,
  ship_date TIMESTAMP WITHOUT TIME ZONE,
  total NUMERIC(8, 2)
);

CREATE TABLE item (
  order_id INTEGER NOT NULL,
  item_id INTEGER NOT NULL,
  product_id INTEGER,
  actual_price NUMERIC(8, 2),
  quantity INTEGER,
  total NUMERIC(8, 2),
  PRIMARY KEY (order_id, item_id)
);

CREATE TABLE product (
  product_id SERIAL PRIMARY KEY,
  description VARCHAR(30)
);

CREATE TABLE price (
  product_id INTEGER NOT NULL,
  list_price NUMERIC(8, 2),
  min_price NUMERIC(8, 2),
  start_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
  end_date TIMESTAMP WITHOUT TIME ZONE,
  PRIMARY KEY (product_id, start_date)
);

INSERT INTO customer VALUES (100, 'jocksports', '345 viewridge', 'belmont', 'ca', '96711', 415, 5986609, 7844, 5000, 'very friendly people to work with -- sales rep likes to be called mike.');
INSERT INTO customer VALUES (101, 'tkb sport shop', '490 boli rd.', 'redwood city', 'ca', '94061', 415, 3681223, 7521, 10000, 'rep called 5/8 about change in order - contact shipping.');
INSERT INTO customer VALUES (102, 'vollyrite', '9722 hamilton', 'burlingame', 'ca', '95133', 415, 6443341, 7654, 7000, 'company doing heavy promotion beginning 10/89. prepare for large orders during w');
INSERT INTO customer VALUES (103, 'just tennis', 'hillview mall', 'burlingame', 'ca', '97544', 415, 6779312, 7521, 3000, 'contact rep about new line of tennis rackets.');
INSERT INTO customer VALUES (104, 'every mountain', '574 surry rd.', 'cupertino', 'ca', '93301', 408, 9962323, 7499, 10000, 'customer with high market share (23%) due to aggressive advertising.');
INSERT INTO customer VALUES (105, 'k + t sports', '3476 el paseo', 'santa clara', 'ca', '91003', 408, 3769966, 7844, 5000, 'tends to order large amounts of merchandise at once. accounting is considering r');
INSERT INTO customer VALUES (106, 'shape up', '908 sequoia', 'palo alto', 'ca', '94301', 415, 3649777, 7521, 6000, 'support intensive. orders small amounts (< 800) of merchandise at a time.');
INSERT INTO customer VALUES (107, 'womens sports', 'valco village', 'sunnyvale', 'ca', '93301', 408, 9674398, 7499, 10000, 'first sporting goods store geared exclusively towards women. unusual promotional');
INSERT INTO customer VALUES (108, 'north woods health and fitness supply center', '98 lone pine way', 'hibbing', 'mn', '55649', 612, 5669123, 7844, 8000, '');
INSERT INTO customer VALUES (201, 'stadium sports', '47 irving pl.', 'new york', 'ny', '10003', 212, 5555335, 7557, 10000, 'large general-purpose sports store with an affluent customer base.');
INSERT INTO customer VALUES (202, 'hoops', '2345 adams ave.', 'leicester', 'ma', '01524', 508, 5557542, 7820, 5000, 'specializes in basketball equipment.');
INSERT INTO customer VALUES (203, 'rebound sports', '2 e. 14th st.', 'new york', 'ny', '10009', 212, 5555989, 7557, 10000, 'follow up on the promotion proposal.');
INSERT INTO customer VALUES (204, 'the power forward', '1 knots landing', 'dallas', 'tx', '75248', 214, 5550505, 7560, 12000, 'large floorspace.  prefers maintaining large amounts of inventory on hand.');
INSERT INTO customer VALUES (205, 'point guard', '20 thurston st.', 'yonkers', 'ny', '10956', 914, 5554766, 7557, 3000, 'tremendous potential for an exclusive agreement.');
INSERT INTO customer VALUES (206, 'the coliseum', '5678 wilbur pl.', 'scarsdale', 'ny', '10583', 914, 5550217, 7557, 6000, 'contact rep. about new product lines.');
INSERT INTO customer VALUES (207, 'fast break', '1000 herbert ln.', 'concord', 'ma', '01742', 508, 5551298, 7820, 7000, 'customer requires written price quotes before making purchase requisitions.');
INSERT INTO customer VALUES (208, 'al and bob''s sports', '260 yorktown ct.', 'austin', 'tx', '78731', 512, 5557631, 7560, 4000, 'very personal purchasing agents -- sharon and scott.');
INSERT INTO customer VALUES (211, 'at bat', '234 beachem st.', 'brookline', 'ma', '02146', 617, 5557385, 7820, 8000, 'have an open purchase order for $3000.  ship immediately on request.');
INSERT INTO customer VALUES (212, 'all sport', '1000 38th st.', 'brooklyn', 'ny', '11210', 718, 5551739, 7600, 6000, 'pursue a contract -- possible candidate for volume purchasing agreements.');
INSERT INTO customer VALUES (213, 'good sport', '400 46th st.', 'sunnyside', 'ny', '11104', 718, 5553771, 7600, 5000, 'may be moving to a larger location.');
INSERT INTO customer VALUES (214, 'al''s pro shop', '45 spruce st.', 'spring', 'tx', '77388', 713, 5555172, 7564, 8000, 'target market is serious athletes.');
INSERT INTO customer VALUES (215, 'bob''s family sports', '400 e. 23rd', 'houston', 'tx', '77026', 713, 5558015, 7654, 8000, 'target market is casual and weekend athletes.  offers a large selection.');
INSERT INTO customer VALUES (216, 'the all american', '547 prentice rd.', 'chelsea', 'ma', '02150', 617, 5553047, 7820, 5000, 'customer prefers to be called between 10 and 12.');
INSERT INTO customer VALUES (217, 'hit, throw, and run', '333 wood court', 'grapevine', 'tx', '76051', 817, 5552352, 7564, 6000, 'general purpose sports store.');
INSERT INTO customer VALUES (218, 'the outfield', '346 garden blvd.', 'flushing', 'ny', '11355', 718, 5552131, 7820, 4000, 'store does not open until 11am and does not have an answering service.');
INSERT INTO customer VALUES (221, 'wheels and deals', '2 memorial drive', 'houston', 'tx', '77007', 713, 5554139, 7789, 10000, 'discount bicycle and sporting good store.');
INSERT INTO customer VALUES (222, 'just bikes', '4000 parkridge blvd.', 'dallas', 'tx', '75205', 214, 5558735, 7789, 4000, 'exclusive bicycle dealer.');
INSERT INTO customer VALUES (223, 'velo sports', '23 white st.', 'malden', 'ma', '02148', 617, 5554983, 7820, 5000, 'clerk answers all phone lines.  ask for mike.');
INSERT INTO customer VALUES (224, 'joe''s bike shop', '4500 fox court', 'grand prarie', 'tx', '75051', 214, 5559834, 7789, 6000, 'call joe to make sure last shipment was complete.');
INSERT INTO customer VALUES (225, 'bob''s swim, cycle, and run', '300 horsecreek circle', 'irving', 'tx', '75039', 214, 5558388, 7789, 7000, 'store catering to triathletes.');
INSERT INTO customer VALUES (226, 'century shop', '8 dagmar dr.', 'huntington', 'ny', '11743', 516, 5553006, 7555, 4000, 'customer in the midst of a cost-cutting program.');
INSERT INTO customer VALUES (227, 'the tour', '2500 gardner rd.', 'somerville', 'ma', '02144', 617, 5556673, 7820, 5000, 'customer referred to us by the all american.');
INSERT INTO customer VALUES (228, 'fitness first', '5000 85th st.', 'jackson heights', 'ny', '11372', 718, 5558710, 7555, 4000, 'recently acquired another sporting goods store.  expect higher volume in the future.');

INSERT INTO department VALUES (10, 'accounting', 122);
INSERT INTO department VALUES (20, 'research', 124);
INSERT INTO department VALUES (30, 'sales', 123);
INSERT INTO department VALUES (40, 'operations', 167);
INSERT INTO department VALUES (12, 'research', 122);
INSERT INTO department VALUES (13, 'sales', 122);
INSERT INTO department VALUES (14, 'operations', 122);
INSERT INTO department VALUES (23, 'sales', 124);
INSERT INTO department VALUES (24, 'operations', 124);
INSERT INTO department VALUES (34, 'operations', 123);
INSERT INTO department VALUES (43, 'sales', 167);

INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7369, 'smith', 'john', 'q', 667, 7902, '1984-12-17', 800, NULL, 20);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7499, 'allen', 'kevin', 'j', 7698, 670, '1985-02-20', 1600, 300, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7505, 'doyle', 'jean', 'k', 671, 7839, '1985-04-04', 2850, NULL, 13);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7506, 'dennis', 'lynn', 's', 671, 7839, '1985-05-15', 2750, NULL, 23);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7507, 'baker', 'leslie', 'd', 671, 7839, '1985-06-10', 2200, NULL, 14);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7521, 'ward', 'cynthia', 'd', 7698, 670, '1985-02-22', 1250, 500, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7555, 'peters', 'daniel', 't', 7505, 670, '1985-03-31', 1250, 300, 13);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7557, 'shaw', 'karen', 'p', 7505, 670, '1985-04-02', 1250, 1200, 13);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7560, 'duncan', 'sarah', 's', 670, 7506, '1985-05-31', 1250, NULL, 23);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7564, 'lange', 'gregory', 'j', 7506, 670, '1985-06-01', 1250, 300, 23);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7566, 'jones', 'terry', 'm', 671, 7839, '1985-04-02', 2975, NULL, 20);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7569, 'alberts', 'chris', 'l', 671, 7839, '1985-04-06', 3000, NULL, 12);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7600, 'porter', 'raymond', 'y', 7505, 670, '1985-04-15', 1250, 900, 13);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7609, 'lewis', 'richard', 'm', 668, 7507, '1985-04-16', 1800, NULL, 24);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7654, 'martin', 'kenneth', 'j', 7698, 670, '1985-09-28', 1250, 1400, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7676, 'sommers', 'denise', 'd', 668, 7507, '1985-04-19', 1850, NULL, 34);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7698, 'blake', 'marion', 's', 671, 7839, '1985-05-01', 2850, NULL, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7782, 'clark', 'carol', 'f', 671, 7839, '1985-06-09', 2450, NULL, 10);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7788, 'scott', 'donald', 't', 669, 7566, '1986-12-09', 3000, NULL, 20);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7789, 'west', 'livia', 'n', 7506, 670, '1985-04-04', 1500, 1000, 23);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7799, 'fisher', 'matthew', 'g', 669, 7569, '1986-12-12', 3000, NULL, 12);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7820, 'ross', 'paul', 's', 7505, 670, '1985-06-01', 1300, 800, 43);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7839, 'king', 'francis', 'a', 672, NULL, '1985-11-17', 5000, NULL, 10);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7844, 'turner', 'mary', 'a', 7698, 670, '1985-09-08', 1500, 0, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7876, 'adams', 'diane', 'g', 667, 7788, '1987-01-12', 1100, NULL, 20);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7900, 'james', 'fred', 's', 667, 7698, '1985-12-03', 950, NULL, 30);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7902, 'ford', 'jennifer', 'd', 669, 7566, '1985-12-03', 3000, NULL, 20);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7916, 'roberts', 'grace', 'm', 669, 7569, '1987-01-04', 2875, NULL, 12);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7919, 'douglas', 'michael', 'a', 667, 7799, '1987-01-04', 800, NULL, 12);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7934, 'miller', 'barbara', 'm', 667, 7782, '1986-01-23', 1300, NULL, 10);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7950, 'jensen', 'alice', 'b', 667, 7505, '1987-01-15', 750, NULL, 13);
INSERT INTO employee (employee_id, last_name, first_name, middle_initial, job_id, manager_id, hire_date, salary, commission, department_id) VALUES (7954, 'murray', 'james', 't', 667, 7506, '1987-01-16', 750, NULL, 23);

INSERT INTO item VALUES (600, 1, 100861, 42, 1, 42);
INSERT INTO item VALUES (610, 3, 100890, 58, 1, 58);
INSERT INTO item VALUES (611, 1, 100861, 45, 1, 45);
INSERT INTO item VALUES (612, 1, 100860, 30, 100, 3000);
INSERT INTO item VALUES (601, 1, 200376, 2.4, 12, 28.8);
INSERT INTO item VALUES (601, 2, 100860, 32, 1, 32);
INSERT INTO item VALUES (602, 1, 100870, 2.8, 20, 56);
INSERT INTO item VALUES (604, 1, 100890, 58, 3, 174);
INSERT INTO item VALUES (604, 2, 100861, 42, 2, 84);
INSERT INTO item VALUES (604, 3, 100860, 32, 12, 384);
INSERT INTO item VALUES (603, 1, 100860, 32, 7, 224);
INSERT INTO item VALUES (610, 1, 100860, 35, 1, 35);
INSERT INTO item VALUES (610, 2, 100870, 2.8, 3, 8.4);
INSERT INTO item VALUES (613, 4, 200376, 2.2, 200, 440);
INSERT INTO item VALUES (614, 1, 100860, 35, 444, 15540);
INSERT INTO item VALUES (614, 2, 100870, 2.8, 1000, 2800);
INSERT INTO item VALUES (612, 2, 100861, 40.5, 20, 810);
INSERT INTO item VALUES (612, 3, 101863, 10, 150, 1500);
INSERT INTO item VALUES (620, 1, 100860, 35, 10, 350);
INSERT INTO item VALUES (620, 2, 200376, 2.4, 1000, 2400);
INSERT INTO item VALUES (620, 3, 102130, 3.4, 500, 1700);
INSERT INTO item VALUES (613, 1, 100871, 5.6, 100, 560);
INSERT INTO item VALUES (613, 2, 101860, 24, 200, 4800);
INSERT INTO item VALUES (613, 3, 200380, 4, 150, 600);
INSERT INTO item VALUES (619, 3, 102130, 3.4, 100, 340);
INSERT INTO item VALUES (617, 1, 100860, 35, 50, 1750);
INSERT INTO item VALUES (617, 2, 100861, 45, 100, 4500);
INSERT INTO item VALUES (614, 3, 100871, 5.6, 1000, 5600);
INSERT INTO item VALUES (616, 1, 100861, 45, 10, 450);
INSERT INTO item VALUES (616, 2, 100870, 2.8, 50, 140);
INSERT INTO item VALUES (616, 3, 100890, 58, 2, 116);
INSERT INTO item VALUES (616, 4, 102130, 3.4, 10, 34);
INSERT INTO item VALUES (616, 5, 200376, 2.4, 10, 24);
INSERT INTO item VALUES (619, 1, 200380, 4, 100, 400);
INSERT INTO item VALUES (619, 2, 200376, 2.4, 100, 240);
INSERT INTO item VALUES (615, 1, 100861, 45, 4, 180);
INSERT INTO item VALUES (607, 1, 100871, 5.6, 1, 5.6);
INSERT INTO item VALUES (615, 2, 100870, 2.8, 100, 280);
INSERT INTO item VALUES (617, 3, 100870, 2.8, 500, 1400);
INSERT INTO item VALUES (617, 4, 100871, 5.6, 500, 2800);
INSERT INTO item VALUES (617, 5, 100890, 58, 500, 29000);
INSERT INTO item VALUES (617, 6, 101860, 24, 100, 2400);
INSERT INTO item VALUES (617, 7, 101863, 12.5, 200, 2500);
INSERT INTO item VALUES (617, 8, 102130, 3.4, 100, 340);
INSERT INTO item VALUES (617, 9, 200376, 2.4, 200, 480);
INSERT INTO item VALUES (617, 10, 200380, 4, 300, 1200);
INSERT INTO item VALUES (609, 2, 100870, 2.5, 5, 12.5);
INSERT INTO item VALUES (609, 3, 100890, 50, 1, 50);
INSERT INTO item VALUES (618, 1, 100860, 35, 23, 805);
INSERT INTO item VALUES (618, 2, 100861, 45, 50, 2250);
INSERT INTO item VALUES (618, 3, 100870, 2.8, 10, 28);
INSERT INTO item VALUES (621, 1, 100861, 45, 10, 450);
INSERT INTO item VALUES (621, 2, 100870, 2.8, 100, 280);
INSERT INTO item VALUES (615, 3, 100871, 5, 50, 250);
INSERT INTO item VALUES (608, 1, 101860, 24, 1, 24);
INSERT INTO item VALUES (608, 2, 100871, 5.6, 2, 11.2);
INSERT INTO item VALUES (609, 1, 100861, 40, 1, 40);
INSERT INTO item VALUES (606, 1, 102130, 3.4, 1, 3.4);
INSERT INTO item VALUES (605, 1, 100861, 45, 100, 4500);
INSERT INTO item VALUES (605, 2, 100870, 2.8, 500, 1400);
INSERT INTO item VALUES (605, 3, 100890, 58, 5, 290);
INSERT INTO item VALUES (605, 4, 101860, 24, 50, 1200);
INSERT INTO item VALUES (605, 5, 101863, 9.5, 100, 950);
INSERT INTO item VALUES (605, 6, 102130, 3.4, 10, 34);
INSERT INTO item VALUES (612, 4, 100871, 5.5, 100, 550);
INSERT INTO item VALUES (619, 4, 100871, 5.6, 50, 280);
INSERT INTO item VALUES (509, 1, 105123, 35, 30, 1050);
INSERT INTO item VALUES (509, 2, 105124, 9, 10, 90);
INSERT INTO item VALUES (509, 3, 102136, 3.4, 10, 34);
INSERT INTO item VALUES (523, 1, 102136, 3.4, 10, 34);
INSERT INTO item VALUES (523, 2, 105123, 37.7, 30, 1131);
INSERT INTO item VALUES (549, 1, 105123, 38, 5, 190);
INSERT INTO item VALUES (549, 2, 105127, 6, 30, 180);
INSERT INTO item VALUES (549, 3, 105125, 3, 200, 600);
INSERT INTO item VALUES (549, 4, 105124, 13, 50, 650);
INSERT INTO item VALUES (507, 1, 105123, 35.3, 20, 706);
INSERT INTO item VALUES (507, 2, 105124, 9, 20, 180);
INSERT INTO item VALUES (516, 1, 105124, 9, 60, 540);
INSERT INTO item VALUES (516, 2, 102136, 3.2, 250, 800);
INSERT INTO item VALUES (516, 3, 105125, 1.9, 250, 475);
INSERT INTO item VALUES (553, 1, 105127, 6, 500, 3000);
INSERT INTO item VALUES (553, 2, 200376, 1.75, 800, 1400);
INSERT INTO item VALUES (526, 1, 105123, 32, 100, 3200);
INSERT INTO item VALUES (526, 2, 105124, 9, 500, 4500);
INSERT INTO item VALUES (543, 1, 105123, 34, 100, 3400);
INSERT INTO item VALUES (543, 2, 105124, 10, 500, 5000);
INSERT INTO item VALUES (555, 1, 105123, 34, 100, 3400);
INSERT INTO item VALUES (555, 2, 105124, 10, 500, 5000);
INSERT INTO item VALUES (555, 3, 102136, 2.8, 50, 140);
INSERT INTO item VALUES (559, 1, 105123, 40, 5, 200);
INSERT INTO item VALUES (559, 2, 105124, 15, 5, 75);
INSERT INTO item VALUES (559, 3, 105127, 6, 5, 30);
INSERT INTO item VALUES (559, 4, 102136, 3.4, 3, 10.2);
INSERT INTO item VALUES (559, 5, 200376, 2.4, 30, 72);
INSERT INTO item VALUES (528, 1, 105123, 37.7, 100, 3770);
INSERT INTO item VALUES (531, 1, 105124, 11, 100, 1100);
INSERT INTO item VALUES (531, 2, 102136, 3, 100, 300);
INSERT INTO item VALUES (558, 1, 105124, 14, 100, 1400);
INSERT INTO item VALUES (558, 2, 102136, 3, 100, 300);
INSERT INTO item VALUES (525, 1, 105123, 37.7, 10, 377);
INSERT INTO item VALUES (552, 1, 105123, 40, 10, 400);
INSERT INTO item VALUES (552, 2, 105124, 15, 10, 150);
INSERT INTO item VALUES (552, 3, 102136, 3.4, 1, 3.4);
INSERT INTO item VALUES (552, 4, 200376, 2.4, 1, 2.4);
INSERT INTO item VALUES (556, 1, 102136, 3.4, 25, 85);
INSERT INTO item VALUES (560, 1, 200376, 2.4, 30, 72);
INSERT INTO item VALUES (565, 1, 105123, 37, 100, 3700);
INSERT INTO item VALUES (565, 2, 105124, 12, 100, 1200);
INSERT INTO item VALUES (574, 1, 104350, 41.8, 25, 1045);
INSERT INTO item VALUES (574, 2, 200380, 3.2, 200, 640);
INSERT INTO item VALUES (576, 1, 104350, 44, 10, 440);
INSERT INTO item VALUES (576, 2, 104351, 26, 10, 260);
INSERT INTO item VALUES (576, 3, 104362, 4.25, 170, 722.5);
INSERT INTO item VALUES (576, 4, 200376, 2.16, 90, 194.4);
INSERT INTO item VALUES (576, 5, 200380, 3.4, 130, 442);
INSERT INTO item VALUES (503, 1, 104350, 38, 30, 1140);
INSERT INTO item VALUES (503, 2, 104351, 23.6, 10, 236);
INSERT INTO item VALUES (503, 3, 104352, 50, 10, 500);
INSERT INTO item VALUES (518, 1, 104350, 38, 25, 950);
INSERT INTO item VALUES (518, 2, 104351, 23.6, 20, 472);
INSERT INTO item VALUES (518, 3, 104360, 36, 20, 720);
INSERT INTO item VALUES (518, 4, 104362, 4.25, 170, 722.5);
INSERT INTO item VALUES (518, 5, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (517, 1, 104352, 50, 15, 750);
INSERT INTO item VALUES (517, 2, 102134, 3.4, 10, 34);
INSERT INTO item VALUES (544, 1, 104350, 44, 15, 660);
INSERT INTO item VALUES (544, 2, 104351, 26, 15, 390);
INSERT INTO item VALUES (544, 3, 104352, 58.3, 10, 583);
INSERT INTO item VALUES (544, 4, 104361, 50, 10, 500);
INSERT INTO item VALUES (544, 5, 104362, 4.5, 50, 225);
INSERT INTO item VALUES (524, 1, 104350, 42, 10, 420);
INSERT INTO item VALUES (524, 2, 104351, 23.56, 35, 824.6);
INSERT INTO item VALUES (524, 3, 104362, 4.25, 150, 637.5);
INSERT INTO item VALUES (524, 4, 102134, 3.23, 30, 96.9);
INSERT INTO item VALUES (502, 1, 104352, 50, 10, 500);
INSERT INTO item VALUES (539, 1, 104351, 26, 20, 520);
INSERT INTO item VALUES (539, 2, 104360, 39, 20, 780);
INSERT INTO item VALUES (511, 1, 104351, 23.6, 15, 354);
INSERT INTO item VALUES (511, 2, 104362, 4.5, 50, 225);
INSERT INTO item VALUES (511, 3, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (512, 1, 104360, 36, 10, 360);
INSERT INTO item VALUES (512, 2, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (562, 1, 104351, 24.7, 25, 617.5);
INSERT INTO item VALUES (562, 2, 104352, 58.3, 15, 874.5);
INSERT INTO item VALUES (562, 3, 104362, 4.25, 130, 552.5);
INSERT INTO item VALUES (529, 1, 104350, 39.89, 30, 1196.7);
INSERT INTO item VALUES (529, 2, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (563, 1, 104352, 58.3, 10, 583);
INSERT INTO item VALUES (563, 2, 200376, 2.04, 150, 306);
INSERT INTO item VALUES (568, 1, 104351, 24.7, 30, 741);
INSERT INTO item VALUES (568, 2, 200376, 2.04, 110, 224.4);
INSERT INTO item VALUES (568, 3, 200380, 3.6, 70, 252);
INSERT INTO item VALUES (504, 1, 104350, 40, 10, 400);
INSERT INTO item VALUES (504, 2, 104351, 22.42, 35, 784.7);
INSERT INTO item VALUES (504, 3, 104352, 50, 5, 250);
INSERT INTO item VALUES (538, 1, 104351, 24.7, 30, 741);
INSERT INTO item VALUES (535, 1, 104352, 54, 15, 810);
INSERT INTO item VALUES (578, 1, 104350, 41.8, 40, 1672);
INSERT INTO item VALUES (578, 2, 200376, 2.04, 190, 387.6);
INSERT INTO item VALUES (578, 3, 200380, 3.6, 60, 216);
INSERT INTO item VALUES (534, 1, 104350, 42, 10, 420);
INSERT INTO item VALUES (536, 1, 104350, 39.89, 40, 1595.6);
INSERT INTO item VALUES (536, 2, 104352, 54, 10, 540);
INSERT INTO item VALUES (572, 1, 104351, 24.7, 25, 617.5);
INSERT INTO item VALUES (572, 2, 104352, 58.3, 10, 583);
INSERT INTO item VALUES (514, 1, 104350, 38, 30, 1140);
INSERT INTO item VALUES (521, 1, 104350, 40, 20, 800);
INSERT INTO item VALUES (521, 2, 102134, 3.23, 30, 96.9);
INSERT INTO item VALUES (551, 1, 104350, 44, 10, 440);
INSERT INTO item VALUES (551, 2, 104361, 50, 5, 250);
INSERT INTO item VALUES (551, 3, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (551, 4, 200376, 1.92, 200, 384);
INSERT INTO item VALUES (513, 1, 104350, 40, 15, 600);
INSERT INTO item VALUES (513, 2, 104351, 23.6, 20, 472);
INSERT INTO item VALUES (513, 3, 104362, 4.25, 100, 425);
INSERT INTO item VALUES (508, 1, 104360, 36, 20, 720);
INSERT INTO item VALUES (508, 2, 104362, 4.5, 80, 360);
INSERT INTO item VALUES (515, 1, 104350, 40, 20, 800);
INSERT INTO item VALUES (515, 2, 104351, 22.42, 25, 560.5);
INSERT INTO item VALUES (515, 3, 102134, 3.4, 20, 68);
INSERT INTO item VALUES (542, 1, 104350, 41.8, 25, 1045);
INSERT INTO item VALUES (542, 2, 104360, 39, 20, 780);
INSERT INTO item VALUES (542, 3, 104361, 50, 11, 550);
INSERT INTO item VALUES (542, 4, 102134, 3.4, 10, 34);
INSERT INTO item VALUES (573, 1, 103120, 22.5, 50, 1125);
INSERT INTO item VALUES (573, 2, 103131, 4.04, 50, 202);
INSERT INTO item VALUES (573, 3, 103141, 20, 15, 300);
INSERT INTO item VALUES (566, 1, 103120, 23.75, 40, 950);
INSERT INTO item VALUES (566, 2, 103121, 27, 50, 1350);
INSERT INTO item VALUES (566, 3, 103130, 3.77, 60, 226.2);
INSERT INTO item VALUES (566, 4, 103131, 3.9, 170, 663);
INSERT INTO item VALUES (566, 5, 103141, 20, 10, 200);
INSERT INTO item VALUES (520, 1, 103130, 4, 10, 40);
INSERT INTO item VALUES (520, 2, 103131, 3.77, 80, 301.6);
INSERT INTO item VALUES (519, 1, 103130, 3.5, 110, 385);
INSERT INTO item VALUES (519, 2, 103140, 19, 30, 570);
INSERT INTO item VALUES (575, 1, 103140, 19, 30, 570);
INSERT INTO item VALUES (575, 2, 200380, 3.8, 30, 114);
INSERT INTO item VALUES (547, 1, 103130, 3.77, 80, 301.6);
INSERT INTO item VALUES (547, 2, 103131, 4.04, 70, 282.8);
INSERT INTO item VALUES (547, 3, 103140, 20, 15, 300);
INSERT INTO item VALUES (547, 4, 103141, 20, 5, 100);
INSERT INTO item VALUES (540, 1, 103130, 3.98, 40, 159.2);
INSERT INTO item VALUES (540, 2, 103131, 3.9, 180, 702);
INSERT INTO item VALUES (567, 1, 103140, 20, 10, 200);
INSERT INTO item VALUES (570, 1, 103131, 4.04, 90, 363.6);
INSERT INTO item VALUES (570, 2, 103140, 20, 15, 300);
INSERT INTO item VALUES (571, 1, 103131, 4.04, 70, 282.8);
INSERT INTO item VALUES (571, 2, 103140, 19, 25, 475);
INSERT INTO item VALUES (571, 3, 102132, 3.4, 15, 51);
INSERT INTO item VALUES (571, 4, 200376, 2.16, 80, 172.8);
INSERT INTO item VALUES (571, 5, 200380, 3.8, 30, 114);
INSERT INTO item VALUES (541, 1, 103140, 20, 10, 200);
INSERT INTO item VALUES (541, 2, 103141, 20, 10, 200);
INSERT INTO item VALUES (532, 1, 103120, 21.59, 60, 1295.4);
INSERT INTO item VALUES (527, 1, 103120, 21.59, 60, 1295.4);
INSERT INTO item VALUES (527, 2, 103121, 27.35, 40, 1094);
INSERT INTO item VALUES (527, 3, 103140, 19, 35, 665);
INSERT INTO item VALUES (501, 1, 103130, 3.6, 60, 216);
INSERT INTO item VALUES (564, 1, 103130, 3.77, 80, 301.6);
INSERT INTO item VALUES (564, 2, 103131, 3.9, 120, 468);
INSERT INTO item VALUES (564, 3, 102132, 3.23, 40, 129.2);
INSERT INTO item VALUES (537, 1, 103130, 3.6, 160, 576);
INSERT INTO item VALUES (537, 2, 102132, 3.23, 30, 96.9);
INSERT INTO item VALUES (522, 1, 103120, 21.59, 80, 1727.2);
INSERT INTO item VALUES (522, 2, 103121, 28.8, 10, 288);
INSERT INTO item VALUES (522, 3, 103131, 4.04, 90, 363.6);
INSERT INTO item VALUES (522, 4, 103141, 20, 10, 200);
INSERT INTO item VALUES (554, 1, 103131, 4.04, 70, 282.8);
INSERT INTO item VALUES (569, 1, 103120, 22.5, 50, 1125);
INSERT INTO item VALUES (569, 2, 103130, 3.6, 180, 648);
INSERT INTO item VALUES (569, 3, 103141, 20, 15, 300);
INSERT INTO item VALUES (550, 1, 103120, 22.5, 60, 1350);
INSERT INTO item VALUES (550, 2, 103140, 19, 45, 855);
INSERT INTO item VALUES (550, 3, 103141, 20, 5, 100);
INSERT INTO item VALUES (550, 4, 102132, 3.4, 15, 51);
INSERT INTO item VALUES (548, 1, 103140, 19, 30, 570);
INSERT INTO item VALUES (548, 2, 102132, 3.23, 30, 96.9);
INSERT INTO item VALUES (505, 1, 103130, 3.5, 100, 350);
INSERT INTO item VALUES (505, 2, 103140, 20, 15, 300);
INSERT INTO item VALUES (577, 1, 103121, 30, 20, 600);
INSERT INTO item VALUES (577, 2, 103131, 3.9, 150, 585);
INSERT INTO item VALUES (577, 3, 102132, 3.23, 25, 80.75);
INSERT INTO item VALUES (533, 1, 103121, 27.35, 30, 820.5);
INSERT INTO item VALUES (533, 2, 103130, 3.77, 80, 301.6);
INSERT INTO item VALUES (561, 1, 103120, 22.5, 80, 1800);
INSERT INTO item VALUES (561, 2, 103130, 3.77, 70, 263.9);
INSERT INTO item VALUES (561, 3, 103141, 20, 15, 300);
INSERT INTO item VALUES (561, 4, 200376, 2.16, 90, 194.4);
INSERT INTO item VALUES (506, 1, 103120, 20.88, 80, 1670.4);
INSERT INTO item VALUES (506, 2, 103130, 3.5, 180, 630);
INSERT INTO item VALUES (506, 3, 103141, 20, 15, 300);
INSERT INTO item VALUES (530, 1, 103121, 25.91, 50, 1295.5);
INSERT INTO item VALUES (530, 2, 103130, 3.6, 200, 720);
INSERT INTO item VALUES (530, 3, 103140, 19, 40, 760);
INSERT INTO item VALUES (530, 4, 103141, 20, 10, 200);
INSERT INTO item VALUES (530, 5, 102132, 3.4, 15, 51);
INSERT INTO item VALUES (545, 1, 103140, 19, 25, 475);
INSERT INTO item VALUES (557, 1, 103120, 23.75, 40, 950);
INSERT INTO item VALUES (557, 2, 103121, 30, 10, 300);
INSERT INTO item VALUES (557, 3, 103140, 19, 35, 665);
INSERT INTO item VALUES (557, 4, 200376, 2.16, 80, 172.8);
INSERT INTO item VALUES (557, 5, 200380, 3.4, 110, 374);
INSERT INTO item VALUES (546, 1, 103120, 22.5, 50, 1125);
INSERT INTO item VALUES (546, 2, 103121, 30, 20, 600);
INSERT INTO item VALUES (546, 3, 103130, 3.6, 120, 432);
INSERT INTO item VALUES (546, 4, 103131, 3.9, 140, 546);
INSERT INTO item VALUES (546, 5, 103140, 19, 40, 760);
INSERT INTO item VALUES (546, 6, 103141, 20, 10, 200);
INSERT INTO item VALUES (510, 1, 103120, 20.88, 60, 1252.8);
INSERT INTO item VALUES (510, 2, 103131, 4.19, 20, 83.8);

INSERT INTO job VALUES (667, 'clerk');
INSERT INTO job VALUES (668, 'staff');
INSERT INTO job VALUES (669, 'analyst');
INSERT INTO job VALUES (670, 'salesperson');
INSERT INTO job VALUES (671, 'manager');
INSERT INTO job VALUES (672, 'president');

INSERT INTO location VALUES (122, 'new york');
INSERT INTO location VALUES (124, 'dallas');
INSERT INTO location VALUES (123, 'chicago');
INSERT INTO location VALUES (167, 'boston');

INSERT INTO price VALUES (100871, 4.8, 3.2, '1989-01-01', '1989-12-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (100890, 58, 46.4, '1989-01-01');
INSERT INTO price VALUES (100890, 54, 40.5, '1988-06-01', '1988-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (100860, 35, 28, '1990-06-01');
INSERT INTO price VALUES (100860, 32, 25.6, '1990-01-01', '1990-05-31');
INSERT INTO price VALUES (100860, 30, 24, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (100861, 45, 36, '1990-06-01');
INSERT INTO price VALUES (100861, 42, 33.6, '1990-01-01', '1990-05-31');
INSERT INTO price VALUES (100861, 39, 31.2, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (100870, 2.8, 2.4, '1990-01-01');
INSERT INTO price VALUES (100870, 2.4, 1.9, '1989-01-01', '1989-12-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (100871, 5.6, 4.8, '1990-01-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (101860, 24, 18, '1989-02-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (101863, 12.5, 9.4, '1989-02-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (102130, 3.4, 2.8, '1989-08-18');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (200376, 2.4, 1.75, '1990-11-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (200380, 4, 3.2, '1990-11-15');
INSERT INTO price VALUES (103120, 23.2, 18.6, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (103120, 24, 19.2, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103120, 25, 20, '1990-06-01');
INSERT INTO price VALUES (103121, 27.8, 22.3, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (103121, 28.8, 23, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103121, 30, 24, '1990-06-01');
INSERT INTO price VALUES (103130, 4, 3.5, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103130, 4.2, 3.6, '1990-01-01');
INSERT INTO price VALUES (103131, 4.2, 3.6, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103131, 4.5, 3.9, '1990-01-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103140, 20, 15, '1989-02-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (103141, 20, 15, '1989-02-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (102132, 3.4, 2.8, '1989-08-18');
INSERT INTO price VALUES (104350, 40, 32, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (104350, 42, 33.6, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104350, 44, 35.3, '1990-06-01');
INSERT INTO price VALUES (104351, 23.6, 18.9, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (104351, 24.8, 19.8, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104351, 26, 20.8, '1990-06-01');
INSERT INTO price VALUES (104352, 50, 35, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (104352, 54, 37.8, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104352, 58.3, 40.8, '1990-06-01');
INSERT INTO price VALUES (104360, 36, 29.5, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104360, 39, 32, '1990-01-01');
INSERT INTO price VALUES (104361, 47, 33, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104361, 50, 35, '1990-01-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (104362, 5, 4, '1989-02-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (102134, 3.4, 2.8, '1989-08-18');
INSERT INTO price VALUES (105123, 36.3, 29, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (105123, 37.7, 32, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105123, 40, 34, '1990-06-01');
INSERT INTO price VALUES (105124, 10, 7.6, '1989-01-01', '1989-12-31');
INSERT INTO price VALUES (105124, 12, 9, '1990-01-01', '1990-05-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105124, 15, 10, '1990-06-01');
INSERT INTO price VALUES (105125, 2, 1.7, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105125, 3, 2.6, '1990-01-01');
INSERT INTO price VALUES (105126, 5, 4.3, '1989-01-01', '1989-12-31');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105126, 6, 5, '1990-01-01');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105127, 6, 5, '1990-11-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (105128, 10, 8, '1990-11-15');
INSERT INTO price (product_id, list_price, min_price, start_date) VALUES (102136, 3.4, 2.8, '1989-08-18');

INSERT INTO product VALUES (100860, 'ace tennis racket i');
INSERT INTO product VALUES (100861, 'ace tennis racket ii');
INSERT INTO product VALUES (100870, 'ace tennis balls-3 pack');
INSERT INTO product VALUES (100871, 'ace tennis balls-6 pack');
INSERT INTO product VALUES (100890, 'ace tennis net');
INSERT INTO product VALUES (101860, 'sp tennis racket');
INSERT INTO product VALUES (101863, 'sp junior racket');
INSERT INTO product VALUES (102130, 'rh: "guide to tennis"');
INSERT INTO product VALUES (200376, 'sb energy bar-6 pack');
INSERT INTO product VALUES (200380, 'sb vita snack-6 pack');
INSERT INTO product VALUES (103120, 'wiff softball bat i');
INSERT INTO product VALUES (103121, 'wiff softball bat ii');
INSERT INTO product VALUES (103130, 'wiff softball, small');
INSERT INTO product VALUES (103131, 'wiff softball, large');
INSERT INTO product VALUES (103140, 'wiff softball mitt (lh)');
INSERT INTO product VALUES (103141, 'wiff softball mitt (rh)');
INSERT INTO product VALUES (102132, 'rh: "guide to softball"');
INSERT INTO product VALUES (104350, 'dunk basketball indoor');
INSERT INTO product VALUES (104351, 'dunk basketball outdoor');
INSERT INTO product VALUES (104352, 'dunk basketball professional');
INSERT INTO product VALUES (104360, 'dunk hoop');
INSERT INTO product VALUES (104361, 'dunk hoop w/fiberglass board');
INSERT INTO product VALUES (104362, 'dunk nets - rainbow');
INSERT INTO product VALUES (102134, 'rh: "guide to basketball"');
INSERT INTO product VALUES (105123, 'yellow jersey bicycle helmet');
INSERT INTO product VALUES (105124, 'yellow jersey bicycle gloves');
INSERT INTO product VALUES (105125, 'yellow jersey water bottle');
INSERT INTO product VALUES (105126, 'yellow jersey bottle cage');
INSERT INTO product VALUES (105127, 'yellow jersey frame pump');
INSERT INTO product VALUES (105128, 'yellow jersey saddle pack');
INSERT INTO product VALUES (102136, 'rh: "guide to cycling"');

INSERT INTO sales_order VALUES (610, '1991-01-07', 101, '1991-01-08', 101.4);
INSERT INTO sales_order VALUES (611, '1991-01-11', 102, '1991-01-11', 45);
INSERT INTO sales_order VALUES (612, '1991-01-15', 104, '1991-01-20', 5860);
INSERT INTO sales_order VALUES (601, '1990-05-01', 106, '1990-05-30', 60.8);
INSERT INTO sales_order VALUES (602, '1990-06-05', 102, '1990-06-20', 56);
INSERT INTO sales_order VALUES (600, '1990-05-01', 103, '1990-05-29', 42);
INSERT INTO sales_order VALUES (604, '1990-06-15', 106, '1990-06-30', 642);
INSERT INTO sales_order VALUES (605, '1990-07-14', 106, '1990-07-30', 8374);
INSERT INTO sales_order VALUES (606, '1990-07-14', 100, '1990-07-30', 3.4);
INSERT INTO sales_order VALUES (609, '1990-08-01', 100, '1990-08-15', 102.5);
INSERT INTO sales_order VALUES (607, '1990-07-18', 104, '1990-07-18', 5.6);
INSERT INTO sales_order VALUES (608, '1990-07-25', 104, '1990-07-25', 35.2);
INSERT INTO sales_order VALUES (603, '1990-06-05', 102, '1990-06-05', 224);
INSERT INTO sales_order VALUES (620, '1991-03-12', 100, '1991-03-12', 4450);
INSERT INTO sales_order VALUES (613, '1991-02-01', 108, '1991-02-01', 6400);
INSERT INTO sales_order VALUES (614, '1991-02-01', 102, '1991-02-05', 23940);
INSERT INTO sales_order VALUES (616, '1991-02-03', 103, '1991-02-10', 764);
INSERT INTO sales_order VALUES (619, '1991-02-22', 104, '1991-03-04', 1260);
INSERT INTO sales_order VALUES (617, '1991-02-05', 105, '1991-03-03', 46370);
INSERT INTO sales_order VALUES (615, '1991-02-01', 107, '1991-02-06', 710);
INSERT INTO sales_order VALUES (618, '1991-02-15', 102, '1991-03-06', 3083);
INSERT INTO sales_order VALUES (621, '1991-03-15', 100, '1991-04-01', 730);
INSERT INTO sales_order VALUES (509, '1989-06-04', 226, '1989-06-10', 1174);
INSERT INTO sales_order VALUES (523, '1990-02-13', 226, '1990-02-13', 1165);
INSERT INTO sales_order VALUES (549, '1990-12-27', 226, '1991-01-14', 1620);
INSERT INTO sales_order VALUES (507, '1989-05-26', 228, '1989-05-27', 886);
INSERT INTO sales_order VALUES (516, '1989-09-30', 228, '1989-10-03', 1815);
INSERT INTO sales_order VALUES (553, '1991-02-02', 228, '1991-02-13', 4400);
INSERT INTO sales_order VALUES (526, '1990-03-04', 221, '1990-03-07', 7700);
INSERT INTO sales_order VALUES (543, '1990-09-04', 221, '1990-09-07', 8400);
INSERT INTO sales_order VALUES (555, '1991-03-04', 221, '1991-03-07', 8540);
INSERT INTO sales_order VALUES (559, '1990-11-16', 222, '1991-04-23', 387.2);
INSERT INTO sales_order VALUES (528, '1990-03-24', 224, '1990-03-24', 3770);
INSERT INTO sales_order VALUES (531, '1990-03-31', 224, '1990-04-02', 1400);
INSERT INTO sales_order VALUES (558, '1991-03-31', 224, '1991-04-02', 1700);
INSERT INTO sales_order VALUES (525, '1990-02-28', 225, '1990-03-03', 377);
INSERT INTO sales_order VALUES (552, '1991-02-02', 223, '1991-02-07', 555.8);
INSERT INTO sales_order VALUES (556, '1991-03-10', 223, '1991-03-12', 85);
INSERT INTO sales_order VALUES (560, '1991-04-25', 223, '1991-04-25', 72);
INSERT INTO sales_order VALUES (565, '1991-06-01', 227, '1991-06-03', 4900);
INSERT INTO sales_order VALUES (574, '1991-10-10', 201, '1991-10-12', 1685);
INSERT INTO sales_order VALUES (576, '1991-10-13', 201, '1991-10-18', 2058.9);
INSERT INTO sales_order VALUES (503, '1989-03-25', 201, '1989-04-06', 1876);
INSERT INTO sales_order VALUES (518, '1989-10-20', 201, '1989-11-05', 2932.5);
INSERT INTO sales_order VALUES (517, '1989-10-23', 201, '1989-11-07', 784);
INSERT INTO sales_order VALUES (544, '1990-09-11', 202, '1990-09-15', 2358);
INSERT INTO sales_order VALUES (524, '1990-02-22', 202, '1990-03-04', 1979);
INSERT INTO sales_order VALUES (502, '1989-02-10', 202, '1989-02-23', 500);
INSERT INTO sales_order VALUES (539, '1990-06-26', 202, '1990-07-03', 1300);
INSERT INTO sales_order VALUES (511, '1989-08-17', 202, '1989-08-21', 647);
INSERT INTO sales_order VALUES (512, '1989-08-28', 203, '1989-09-13', 428);
INSERT INTO sales_order VALUES (562, '1991-05-04', 203, '1991-05-19', 2044.5);
INSERT INTO sales_order VALUES (529, '1990-04-02', 203, '1990-04-05', 1264.7);
INSERT INTO sales_order VALUES (563, '1991-05-25', 204, '1991-05-26', 889);
INSERT INTO sales_order VALUES (568, '1991-07-13', 204, '1991-07-21', 1217.4);
INSERT INTO sales_order VALUES (504, '1989-04-11', 204, '1989-04-12', 1434.7);
INSERT INTO sales_order VALUES (538, '1990-06-23', 204, '1990-06-26', 741);
INSERT INTO sales_order VALUES (535, '1990-05-28', 204, '1990-06-09', 810);
INSERT INTO sales_order VALUES (578, '1991-11-19', 204, '1991-12-04', 2275.6);
INSERT INTO sales_order VALUES (534, '1990-05-11', 206, '1990-05-15', 420);
INSERT INTO sales_order VALUES (536, '1990-05-21', 206, '1990-06-06', 2135.6);
INSERT INTO sales_order VALUES (572, '1991-08-19', 206, '1991-08-24', 1200.5);
INSERT INTO sales_order VALUES (514, '1989-09-05', 207, '1989-09-16', 1140);
INSERT INTO sales_order VALUES (521, '1989-11-20', 207, '1989-11-23', 896.9);
INSERT INTO sales_order VALUES (551, '1991-01-22', 208, '1991-02-06', 1142);
INSERT INTO sales_order VALUES (513, '1989-09-06', 208, '1989-09-14', 1497);
INSERT INTO sales_order VALUES (508, '1989-05-26', 208, '1989-06-08', 1080);
INSERT INTO sales_order VALUES (515, '1989-09-19', 208, '1989-09-26', 1428.5);
INSERT INTO sales_order VALUES (542, '1990-08-11', 208, '1990-08-23', 2409);
INSERT INTO sales_order VALUES (573, '1991-10-10', 201, '1991-10-12', 1627);
INSERT INTO sales_order VALUES (566, '1991-06-09', 201, '1991-06-12', 3389.2);
INSERT INTO sales_order VALUES (520, '1989-11-16', 201, '1989-11-19', 341.6);
INSERT INTO sales_order VALUES (519, '1989-10-20', 201, '1989-11-05', 955);
INSERT INTO sales_order VALUES (575, '1991-10-04', 201, '1991-10-17', 684);
INSERT INTO sales_order VALUES (547, '1990-10-16', 202, '1990-10-27', 984.4);
INSERT INTO sales_order VALUES (540, '1990-07-15', 202, '1990-07-17', 861.2);
INSERT INTO sales_order VALUES (567, '1991-07-05', 202, '1991-07-07', 200);
INSERT INTO sales_order VALUES (570, '1991-07-17', 202, '1991-07-24', 663.6);
INSERT INTO sales_order VALUES (571, '1991-08-02', 202, '1991-08-12', 1095.6);
INSERT INTO sales_order VALUES (541, '1990-08-08', 203, '1990-08-18', 400);
INSERT INTO sales_order VALUES (532, '1990-04-08', 203, '1990-04-21', 1295.4);
INSERT INTO sales_order VALUES (527, '1990-02-27', 204, '1990-03-14', 3054.4);
INSERT INTO sales_order VALUES (501, '1989-01-06', 204, '1989-01-11', 216);
INSERT INTO sales_order VALUES (564, '1991-05-25', 204, '1991-05-26', 898.8);
INSERT INTO sales_order VALUES (537, '1990-06-14', 204, '1990-06-26', 672.9);
INSERT INTO sales_order VALUES (522, '1990-01-07', 204, '1990-01-10', 2578.8);
INSERT INTO sales_order VALUES (554, '1991-02-18', 204, '1991-02-22', 282.8);
INSERT INTO sales_order VALUES (569, '1991-07-16', 205, '1991-07-23', 2073);
INSERT INTO sales_order VALUES (550, '1991-01-27', 205, '1991-02-07', 2356);
INSERT INTO sales_order VALUES (548, '1990-11-26', 205, '1990-12-12', 666.9);
INSERT INTO sales_order VALUES (505, '1989-04-07', 206, '1989-04-22', 650);
INSERT INTO sales_order VALUES (577, '1991-10-06', 206, '1991-10-20', 1265.75);
INSERT INTO sales_order VALUES (533, '1990-04-28', 206, '1990-05-02', 1122.1);
INSERT INTO sales_order VALUES (561, '1991-04-20', 207, '1991-05-07', 2558.3);
INSERT INTO sales_order VALUES (506, '1989-04-27', 208, '1989-05-10', 2600.4);
INSERT INTO sales_order VALUES (530, '1990-04-03', 208, '1990-04-07', 3026.5);
INSERT INTO sales_order VALUES (545, '1990-10-06', 208, '1990-10-13', 475);
INSERT INTO sales_order VALUES (557, '1991-03-08', 208, '1991-03-12', 2461.8);
INSERT INTO sales_order VALUES (546, '1990-10-17', 208, '1990-10-23', 3663);
INSERT INTO sales_order VALUES (510, '1989-07-18', 208, '1989-07-21', 1336.6);

ALTER TABLE price
  ADD FOREIGN KEY (product_id)
  REFERENCES product (product_id);

ALTER TABLE item
  ADD FOREIGN KEY (product_id)
  REFERENCES product (product_id);

ALTER TABLE item
  ADD FOREIGN KEY (order_id)
  REFERENCES sales_order (order_id);

ALTER TABLE sales_order
  ADD FOREIGN KEY (customer_id)
  REFERENCES customer (customer_id);

ALTER TABLE customer
  ADD FOREIGN KEY (salesperson_id)
  REFERENCES employee (employee_id);

ALTER TABLE employee
  ADD FOREIGN KEY (manager_id)
  REFERENCES employee (employee_id);

ALTER TABLE employee
  ADD FOREIGN KEY (job_id)
  REFERENCES job (job_id);

ALTER TABLE employee
  ADD FOREIGN KEY (department_id)
  REFERENCES department (department_id);

ALTER TABLE department
  ADD FOREIGN KEY (location_id)
  REFERENCES location (location_id);

SELECT setval(pg_get_serial_sequence('employee', 'employee_id'), (SELECT MAX(employee_id) FROM employee));
SELECT setval(pg_get_serial_sequence('department', 'department_id'), (SELECT MAX(department_id) FROM department));
SELECT setval(pg_get_serial_sequence('location', 'location_id'), (SELECT MAX(location_id) FROM location));
SELECT setval(pg_get_serial_sequence('job', 'job_id'), (SELECT MAX(job_id) FROM job));
SELECT setval(pg_get_serial_sequence('customer', 'customer_id'), (SELECT MAX(customer_id) FROM customer));
SELECT setval(pg_get_serial_sequence('sales_order', 'order_id'), (SELECT MAX(order_id) FROM sales_order));
SELECT setval(pg_get_serial_sequence('product', 'product_id'), (SELECT MAX(product_id) FROM product));
