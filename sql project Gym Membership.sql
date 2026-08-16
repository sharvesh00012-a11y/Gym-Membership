CREATE DATABASE gym_db;
USE gym_db;
drop database gym_db;
CREATE TABLE membership_plans (
    plan_id       INT PRIMARY KEY AUTO_INCREMENT,
    plan_name     VARCHAR(50)    NOT NULL,
    duration_days INT            NOT NULL,
    price         DECIMAL(8,2)   NOT NULL,
    description   VARCHAR(255)
);
CREATE TABLE trainers (
    trainer_id    INT PRIMARY KEY AUTO_INCREMENT,
    full_name     VARCHAR(100)   NOT NULL,
    specialization VARCHAR(100),
    phone         VARCHAR(15),
    salary        DECIMAL(10,2),
    hired_date    DATE
);
CREATE TABLE members (
    member_id     INT PRIMARY KEY AUTO_INCREMENT,
    full_name     VARCHAR(100)   NOT NULL,
    email         VARCHAR(100)   UNIQUE NOT NULL,
    phone         VARCHAR(15),
    dob           DATE,
    gender        ENUM('Male','Female','Other'),
    address       TEXT,
    joined_date   DATE           DEFAULT (CURDATE()),
    status        ENUM('Active','Inactive','Suspended') DEFAULT 'Active'
);
CREATE TABLE subscriptions (
    sub_id        INT PRIMARY KEY AUTO_INCREMENT,
    member_id     INT            NOT NULL,
    plan_id       INT            NOT NULL,
    start_date    DATE           NOT NULL,
    end_date      DATE           NOT NULL,
    status        ENUM('Active','Expired','Cancelled') DEFAULT 'Active',
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (plan_id)   REFERENCES membership_plans(plan_id)
);
CREATE TABLE payments (
    payment_id    INT PRIMARY KEY AUTO_INCREMENT,
    member_id     INT            NOT NULL,
    sub_id        INT            NOT NULL,
    amount        DECIMAL(8,2)   NOT NULL,
    payment_date  DATETIME       DEFAULT NOW(),
    method        ENUM('Cash','Card','UPI','Online'),
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (sub_id)    REFERENCES subscriptions(sub_id)
);

CREATE TABLE attendance (
    attend_id     INT PRIMARY KEY AUTO_INCREMENT,
    member_id     INT            NOT NULL,
    check_in      DATETIME       DEFAULT NOW(),
    check_out     DATETIME,
    FOREIGN KEY (member_id) REFERENCES members(member_id)
);

CREATE TABLE trainer_assignments (
    assign_id     INT PRIMARY KEY AUTO_INCREMENT,
    member_id     INT            NOT NULL,
    trainer_id    INT            NOT NULL,
    from_date     DATE,
    to_date       DATE,
    FOREIGN KEY (member_id)  REFERENCES members(member_id),
    FOREIGN KEY (trainer_id) REFERENCES trainers(trainer_id)
);


INSERT INTO membership_plans (plan_name, duration_days, price, description) VALUES
('Monthly',     30,   999.00, 'Basic 1-month access'),
('Quarterly',   90,  2499.00, '3-month discounted plan'),
('Half-Yearly', 180, 4499.00, '6-month plan with perks'),
('Annual',      365, 7999.00, 'Best value yearly plan');

INSERT INTO trainers (full_name, specialization, phone, salary, hired_date) VALUES
('Arjun Sharma',    'Weight Training',    '9876543210', 35000.00, '2020-01-15'),
('Priya Nair',      'Yoga & Flexibility', '9876543211', 32000.00, '2020-03-10'),
('Karthik Rajan',   'Cardio & HIIT',      '9876543212', 33000.00, '2019-07-01'),
('Meena Devi',      'Zumba & Dance',      '9876543213', 30000.00, '2021-02-20'),
('Suresh Kumar',    'CrossFit',           '9876543214', 36000.00, '2018-11-05'),
('Anitha Reddy',    'Pilates',            '9876543215', 31000.00, '2022-01-10'),
('Ramesh Babu',     'Nutrition & Diet',   '9876543216', 34000.00, '2020-06-15'),
('Divya Menon',     'Kickboxing',         '9876543217', 33500.00, '2021-09-01'),
('Vijay Prakash',   'Strength & Power',   '9876543218', 37000.00, '2019-04-20'),
('Lakshmi Priya',   'Aerobics',           '9876543219', 29000.00, '2022-05-05');

INSERT INTO members (full_name, email, phone, dob, gender, address, joined_date, status) VALUES
('Aarav Sharma',     'aarav.sharma@email.com',     '9800000001', '1995-04-12', 'Male',   'Chennai',    '2024-01-05', 'Active'),
('Aditi Nair',       'aditi.nair@email.com',       '9800000002', '1998-07-23', 'Female', 'Coimbatore', '2024-01-10', 'Active'),
('Arun Kumar',       'arun.kumar@email.com',       '9800000003', '1992-11-30', 'Male',   'Madurai',    '2024-01-15', 'Active'),
('Anjali Singh',     'anjali.singh@email.com',     '9800000004', '2000-02-14', 'Female', 'Salem',      '2024-01-20', 'Active'),
('Balaji Rajan',     'balaji.rajan@email.com',     '9800000005', '1997-09-05', 'Male',   'Trichy',     '2024-02-01', 'Active'),
('Bhavana Menon',    'bhavana.menon@email.com',    '9800000006', '1999-03-18', 'Female', 'Chennai',    '2024-02-05', 'Active'),
('Chetan Verma',     'chetan.verma@email.com',     '9800000007', '1993-06-25', 'Male',   'Erode',      '2024-02-10', 'Active'),
('Deepa Krishnan',   'deepa.krishnan@email.com',   '9800000008', '1996-12-01', 'Female', 'Vellore',    '2024-02-15', 'Active'),
('Dinesh Babu',      'dinesh.babu@email.com',      '9800000009', '1991-08-20', 'Male',   'Coimbatore', '2024-02-20', 'Active'),
('Divya Suresh',     'divya.suresh@email.com',     '9800000010', '2001-05-10', 'Female', 'Chennai',    '2024-03-01', 'Active'),
('Ganesh Iyer',      'ganesh.iyer@email.com',      '9800000011', '1990-01-28', 'Male',   'Madurai',    '2024-03-05', 'Active'),
('Geetha Ravi',      'geetha.ravi@email.com',      '9800000012', '1994-10-15', 'Female', 'Tirunelveli','2024-03-10', 'Active'),
('Hari Prasad',      'hari.prasad@email.com',      '9800000013', '1998-07-07', 'Male',   'Salem',      '2024-03-15', 'Active'),
('Harini Devi',      'harini.devi@email.com',      '9800000014', '2000-04-22', 'Female', 'Trichy',     '2024-03-20', 'Active'),
('Ishaan Reddy',     'ishaan.reddy@email.com',     '9800000015', '1996-11-11', 'Male',   'Chennai',    '2024-04-01', 'Active'),
('Janaki Priya',     'janaki.priya@email.com',     '9800000016', '1993-08-30', 'Female', 'Coimbatore', '2024-04-05', 'Active'),
('Karan Mehta',      'karan.mehta@email.com',      '9800000017', '1995-02-19', 'Male',   'Erode',      '2024-04-10', 'Active'),
('Kavitha Nair',     'kavitha.nair@email.com',     '9800000018', '1997-06-03', 'Female', 'Vellore',    '2024-04-15', 'Active'),
('Krishna Raj',      'krishna.raj@email.com',      '9800000019', '1992-09-14', 'Male',   'Chennai',    '2024-04-20', 'Active'),
('Lavanya Devi',     'lavanya.devi@email.com',     '9800000020', '1999-01-27', 'Female', 'Madurai',    '2024-05-01', 'Active'),
('Manoj Pillai',     'manoj.pillai@email.com',     '9800000021', '1990-12-09', 'Male',   'Chennai',    '2024-05-05', 'Active'),
('Meera Shankar',    'meera.shankar@email.com',    '9800000022', '1994-05-21', 'Female', 'Trichy',     '2024-05-10', 'Active'),
('Mohan Das',        'mohan.das@email.com',        '9800000023', '1988-03-17', 'Male',   'Salem',      '2024-05-15', 'Inactive'),
('Nandini Rao',      'nandini.rao@email.com',      '9800000024', '2002-10-08', 'Female', 'Coimbatore', '2024-05-20', 'Active'),
('Naveen Babu',      'naveen.babu@email.com',      '9800000025', '1991-07-31', 'Male',   'Chennai',    '2024-06-01', 'Active'),
('Nithya Priya',     'nithya.priya@email.com',     '9800000026', '1996-04-16', 'Female', 'Madurai',    '2024-06-05', 'Active'),
('Pavan Kumar',      'pavan.kumar@email.com',      '9800000027', '1993-11-25', 'Male',   'Erode',      '2024-06-10', 'Active'),
('Pooja Menon',      'pooja.menon@email.com',      '9800000028', '1998-02-04', 'Female', 'Vellore',    '2024-06-15', 'Active'),
('Prakash Rajan',    'prakash.rajan@email.com',    '9800000029', '1989-08-19', 'Male',   'Trichy',     '2024-06-20', 'Active'),
('Preethi Reddy',    'preethi.reddy@email.com',    '9800000030', '2001-06-12', 'Female', 'Chennai',    '2024-07-01', 'Active'),
('Rahul Singh',      'rahul.singh@email.com',      '9800000031', '1995-03-29', 'Male',   'Coimbatore', '2024-07-05', 'Active'),
('Raji Krishnan',    'raji.krishnan@email.com',    '9800000032', '1997-10-07', 'Female', 'Salem',      '2024-07-10', 'Active'),
('Rajiv Nair',       'rajiv.nair@email.com',       '9800000033', '1990-01-15', 'Male',   'Madurai',    '2024-07-15', 'Active'),
('Ramya Devi',       'ramya.devi@email.com',       '9800000034', '1999-08-28', 'Female', 'Chennai',    '2024-07-20', 'Active'),
('Ravi Varma',       'ravi.varma@email.com',       '9800000035', '1987-05-05', 'Male',   'Trichy',     '2024-08-01', 'Suspended'),
('Rekha Suresh',     'rekha.suresh@email.com',     '9800000036', '1994-12-20', 'Female', 'Erode',      '2024-08-05', 'Active'),
('Rohan Pillai',     'rohan.pillai@email.com',     '9800000037', '1996-09-11', 'Male',   'Vellore',    '2024-08-10', 'Active'),
('Sangeetha Rao',    'sangeetha.rao@email.com',    '9800000038', '2000-06-24', 'Female', 'Chennai',    '2024-08-15', 'Active'),
('Saravanan Raj',    'saravanan.raj@email.com',    '9800000039', '1992-04-03', 'Male',   'Coimbatore', '2024-08-20', 'Active'),
('Saritha Menon',    'saritha.menon@email.com',    '9800000040', '1995-01-16', 'Female', 'Madurai',    '2024-09-01', 'Active'),
('Senthil Kumar',    'senthil.kumar@email.com',    '9800000041', '1988-11-29', 'Male',   'Salem',      '2024-09-05', 'Active'),
('Shanthi Devi',     'shanthi.devi@email.com',     '9800000042', '1993-07-18', 'Female', 'Trichy',     '2024-09-10', 'Active'),
('Shiva Prakash',    'shiva.prakash@email.com',    '9800000043', '1997-03-07', 'Male',   'Chennai',    '2024-09-15', 'Active'),
('Sindhu Nair',      'sindhu.nair@email.com',      '9800000044', '2001-10-22', 'Female', 'Erode',      '2024-09-20', 'Active'),
('Suresh Babu',      'suresh.babu@email.com',      '9800000045', '1986-08-08', 'Male',   'Vellore',    '2024-10-01', 'Active'),
('Swetha Reddy',     'swetha.reddy@email.com',     '9800000046', '1999-05-31', 'Female', 'Chennai',    '2024-10-05', 'Active'),
('Uday Kumar',       'uday.kumar@email.com',       '9800000047', '1994-02-17', 'Male',   'Coimbatore', '2024-10-10', 'Inactive'),
('Uma Devi',         'uma.devi@email.com',          '9800000048', '1991-12-04', 'Female', 'Madurai',    '2024-10-15', 'Active'),
('Vinod Rajan',      'vinod.rajan@email.com',      '9800000049', '1996-09-27', 'Male',   'Salem',      '2024-10-20', 'Active'),
('Yamini Priya',     'yamini.priya@email.com',     '9800000050', '2003-07-14', 'Female', 'Trichy',     '2024-11-01', 'Active');


INSERT INTO subscriptions (member_id, plan_id, start_date, end_date, status) VALUES
(1,  1, '2024-01-05', '2025-01-04', 'Active'),
(2,  2, '2024-01-10', '2025-01-09', 'Active'),
(3,  3, '2024-01-15', '2025-01-14', 'Active'),
(4,  4, '2024-01-20', '2025-01-19', 'Active'),
(5,  1, '2024-02-01', '2025-01-31', 'Active'),
(6,  2, '2024-02-05', '2025-02-03', 'Active'),
(7,  3, '2024-02-10', '2025-02-09', 'Active'),
(8,  4, '2024-02-15', '2025-02-14', 'Active'),
(9,  1, '2024-02-20', '2025-02-19', 'Active'),
(10, 2, '2024-03-01', '2025-02-28', 'Active'),
(11, 3, '2024-03-05', '2025-03-04', 'Active'),
(12, 4, '2024-03-10', '2025-03-09', 'Active'),
(13, 1, '2024-03-15', '2025-03-14', 'Active'),
(14, 2, '2024-03-20', '2025-03-19', 'Active'),
(15, 3, '2024-04-01', '2025-03-31', 'Active'),
(16, 4, '2024-04-05', '2025-04-04', 'Active'),
(17, 1, '2024-04-10', '2025-04-09', 'Active'),
(18, 2, '2024-04-15', '2025-04-14', 'Active'),
(19, 3, '2024-04-20', '2025-04-19', 'Active'),
(20, 4, '2024-05-01', '2025-04-30', 'Active'),
(21, 1, '2024-05-05', '2025-05-04', 'Active'),
(22, 2, '2024-05-10', '2025-05-09', 'Active'),
(23, 1, '2024-05-15', '2024-06-14', 'Expired'),
(24, 3, '2024-05-20', '2025-05-19', 'Active'),
(25, 4, '2024-06-01', '2025-05-31', 'Active'),
(26, 1, '2024-06-05', '2025-06-04', 'Active'),
(27, 2, '2024-06-10', '2025-06-09', 'Active'),
(28, 3, '2024-06-15', '2025-06-14', 'Active'),
(29, 4, '2024-06-20', '2025-06-19', 'Active'),
(30, 1, '2024-07-01', '2025-06-30', 'Active'),
(31, 2, '2024-07-05', '2025-07-04', 'Active'),
(32, 3, '2024-07-10', '2025-07-09', 'Active'),
(33, 4, '2024-07-15', '2025-07-14', 'Active'),
(34, 1, '2024-07-20', '2025-07-19', 'Active'),
(35, 2, '2024-08-01', '2024-10-30', 'Cancelled'),
(36, 3, '2024-08-05', '2025-08-04', 'Active'),
(37, 4, '2024-08-10', '2025-08-09', 'Active'),
(38, 1, '2024-08-15', '2025-08-14', 'Active'),
(39, 2, '2024-08-20', '2025-08-19', 'Active'),
(40, 3, '2024-09-01', '2025-08-31', 'Active'),
(41, 4, '2024-09-05', '2025-09-04', 'Active'),
(42, 1, '2024-09-10', '2025-09-09', 'Active'),
(43, 2, '2024-09-15', '2025-09-14', 'Active'),
(44, 3, '2024-09-20', '2025-09-19', 'Active'),
(45, 4, '2024-10-01', '2025-09-30', 'Active'),
(46, 1, '2024-10-05', '2025-10-04', 'Active'),
(47, 2, '2024-10-10', '2024-11-09', 'Expired'),
(48, 3, '2024-10-15', '2025-10-14', 'Active'),
(49, 4, '2024-10-20', '2025-10-19', 'Active'),
(50, 1, '2024-11-01', '2025-10-31', 'Active');


INSERT INTO payments (member_id, sub_id, amount, payment_date, method) VALUES
(1,  1,  999.00, '2024-01-05 10:00:00', 'UPI'),
(2,  2, 2499.00, '2024-01-10 11:00:00', 'Card'),
(3,  3, 4499.00, '2024-01-15 09:30:00', 'Online'),
(4,  4, 7999.00, '2024-01-20 14:00:00', 'Cash'),
(5,  5,  999.00, '2024-02-01 10:15:00', 'UPI'),
(6,  6, 2499.00, '2024-02-05 12:00:00', 'Card'),
(7,  7, 4499.00, '2024-02-10 09:00:00', 'Online'),
(8,  8, 7999.00, '2024-02-15 15:30:00', 'Cash'),
(9,  9,  999.00, '2024-02-20 11:45:00', 'UPI'),
(10,10, 2499.00, '2024-03-01 10:00:00', 'Card'),
(11,11, 4499.00, '2024-03-05 09:30:00', 'Online'),
(12,12, 7999.00, '2024-03-10 14:00:00', 'Cash'),
(13,13,  999.00, '2024-03-15 11:00:00', 'UPI'),
(14,14, 2499.00, '2024-03-20 12:30:00', 'Card'),
(15,15, 4499.00, '2024-04-01 10:00:00', 'Online'),
(16,16, 7999.00, '2024-04-05 13:00:00', 'Cash'),
(17,17,  999.00, '2024-04-10 09:15:00', 'UPI'),
(18,18, 2499.00, '2024-04-15 10:30:00', 'Card'),
(19,19, 4499.00, '2024-04-20 11:00:00', 'Online'),
(20,20, 7999.00, '2024-05-01 14:30:00', 'Cash'),
(21,21,  999.00, '2024-05-05 10:00:00', 'UPI'),
(22,22, 2499.00, '2024-05-10 11:30:00', 'Card'),
(23,23,  999.00, '2024-05-15 09:00:00', 'Cash'),
(24,24, 4499.00, '2024-05-20 12:00:00', 'Online'),
(25,25, 7999.00, '2024-06-01 10:00:00', 'Card'),
(26,26,  999.00, '2024-06-05 11:15:00', 'UPI'),
(27,27, 2499.00, '2024-06-10 09:30:00', 'Card'),
(28,28, 4499.00, '2024-06-15 14:00:00', 'Online'),
(29,29, 7999.00, '2024-06-20 10:45:00', 'Cash'),
(30,30,  999.00, '2024-07-01 11:00:00', 'UPI'),
(31,31, 2499.00, '2024-07-05 09:00:00', 'Card'),
(32,32, 4499.00, '2024-07-10 12:30:00', 'Online'),
(33,33, 7999.00, '2024-07-15 10:00:00', 'Cash'),
(34,34,  999.00, '2024-07-20 11:30:00', 'UPI'),
(35,35, 2499.00, '2024-08-01 09:15:00', 'Card'),
(36,36, 4499.00, '2024-08-05 13:00:00', 'Online'),
(37,37, 7999.00, '2024-08-10 10:30:00', 'Cash'),
(38,38,  999.00, '2024-08-15 11:00:00', 'UPI'),
(39,39, 2499.00, '2024-08-20 09:30:00', 'Card'),
(40,40, 4499.00, '2024-09-01 12:00:00', 'Online'),
(41,41, 7999.00, '2024-09-05 10:00:00', 'Cash'),
(42,42,  999.00, '2024-09-10 11:15:00', 'UPI'),
(43,43, 2499.00, '2024-09-15 09:00:00', 'Card'),
(44,44, 4499.00, '2024-09-20 14:30:00', 'Online'),
(45,45, 7999.00, '2024-10-01 10:00:00', 'Cash'),
(46,46,  999.00, '2024-10-05 11:00:00', 'UPI'),
(47,47, 2499.00, '2024-10-10 09:15:00', 'Card'),
(48,48, 4499.00, '2024-10-15 12:00:00', 'Online'),
(49,49, 7999.00, '2024-10-20 10:30:00', 'Cash'),
(50,50,  999.00, '2024-11-01 11:00:00', 'UPI');

INSERT INTO attendance (member_id, check_in, check_out) VALUES
(1,  '2025-04-28 06:00:00', '2025-04-28 07:30:00'),
(2,  '2025-04-28 07:00:00', '2025-04-28 08:30:00'),
(3,  '2025-04-28 08:00:00', '2025-04-28 09:00:00'),
(4,  '2025-04-28 06:30:00', '2025-04-28 08:00:00'),
(5,  '2025-04-29 05:45:00', '2025-04-29 07:15:00'),
(6,  '2025-04-29 06:00:00', '2025-04-29 07:30:00'),
(7,  '2025-04-29 07:30:00', '2025-04-29 09:00:00'),
(8,  '2025-04-29 08:00:00', '2025-04-29 09:30:00'),
(9,  '2025-04-30 06:00:00', '2025-04-30 07:30:00'),
(10, '2025-04-30 07:00:00', '2025-04-30 08:30:00'),
(11, '2025-04-30 08:00:00', '2025-04-30 09:00:00'),
(12, '2025-04-30 06:30:00', '2025-04-30 08:00:00'),
(13, '2025-05-01 05:45:00', '2025-05-01 07:15:00'),
(14, '2025-05-01 06:00:00', '2025-05-01 07:45:00'),
(15, '2025-05-01 07:00:00', '2025-05-01 08:30:00'),
(16, '2025-05-01 08:00:00', '2025-05-01 09:00:00'),
(17, '2025-05-01 06:30:00', '2025-05-01 08:00:00'),
(18, '2025-05-01 07:30:00', '2025-05-01 09:00:00'),
(19, '2025-05-02 06:00:00', '2025-05-02 07:30:00'),
(20, '2025-05-02 07:00:00', '2025-05-02 08:30:00'),
(21, '2025-05-02 08:00:00', '2025-05-02 09:15:00'),
(22, '2025-05-02 06:30:00', '2025-05-02 08:00:00'),
(24, '2025-05-02 05:45:00', '2025-05-02 07:15:00'),
(25, '2025-05-02 07:30:00', '2025-05-02 09:00:00'),
(26, '2025-04-28 06:00:00', '2025-04-28 07:30:00'),
(27, '2025-04-28 07:00:00', '2025-04-28 08:30:00'),
(28, '2025-04-29 06:00:00', '2025-04-29 07:45:00'),
(29, '2025-04-29 08:00:00', '2025-04-29 09:30:00'),
(30, '2025-04-30 06:30:00', '2025-04-30 08:00:00'),
(31, '2025-04-30 07:00:00', '2025-04-30 08:30:00'),
(32, '2025-05-01 06:00:00', '2025-05-01 07:30:00'),
(33, '2025-05-01 07:30:00', '2025-05-01 09:00:00'),
(34, '2025-05-02 06:00:00', '2025-05-02 07:30:00'),
(36, '2025-05-02 07:00:00', '2025-05-02 08:30:00'),
(37, '2025-04-28 06:30:00', '2025-04-28 08:00:00'),
(38, '2025-04-29 07:00:00', '2025-04-29 08:30:00'),
(39, '2025-04-30 06:00:00', '2025-04-30 07:30:00'),
(40, '2025-04-30 08:00:00', '2025-04-30 09:15:00'),
(41, '2025-05-01 06:00:00', '2025-05-01 07:45:00'),
(42, '2025-05-01 07:00:00', '2025-05-01 08:30:00'),
(43, '2025-05-02 06:00:00', '2025-05-02 07:30:00'),
(44, '2025-05-02 07:30:00', '2025-05-02 09:00:00'),
(45, '2025-04-28 05:45:00', '2025-04-28 07:15:00'),
(46, '2025-04-29 06:00:00', '2025-04-29 07:30:00'),
(48, '2025-04-30 07:00:00', '2025-04-30 08:30:00'),
(49, '2025-05-01 06:30:00', '2025-05-01 08:00:00'),
(50, '2025-05-02 07:00:00', '2025-05-02 08:30:00'),
(1,  '2025-05-01 06:00:00', '2025-05-01 07:30:00'),
(3,  '2025-05-02 07:00:00', '2025-05-02 08:30:00'),
(5,  '2025-05-02 08:00:00', '2025-05-02 09:15:00');

INSERT INTO trainer_assignments (member_id, trainer_id, from_date, to_date) VALUES
(1,1,'2024-01-05','2025-01-04'),(2,2,'2024-01-10','2025-01-09'),
(3,3,'2024-01-15','2025-01-14'),(4,4,'2024-01-20','2025-01-19'),
(5,5,'2024-02-01','2025-01-31'),(6,6,'2024-02-05','2025-02-03'),
(7,7,'2024-02-10','2025-02-09'),(8,8,'2024-02-15','2025-02-14'),
(9,9,'2024-02-20','2025-02-19'),(10,10,'2024-03-01','2025-02-28'),
(11,1,'2024-03-05','2025-03-04'),(12,2,'2024-03-10','2025-03-09'),
(13,3,'2024-03-15','2025-03-14'),(14,4,'2024-03-20','2025-03-19'),
(15,5,'2024-04-01','2025-03-31'),(16,6,'2024-04-05','2025-04-04'),
(17,7,'2024-04-10','2025-04-09'),(18,8,'2024-04-15','2025-04-14'),
(19,9,'2024-04-20','2025-04-19'),(20,10,'2024-05-01','2025-04-30'),
(21,1,'2024-05-05','2025-05-04'),(22,2,'2024-05-10','2025-05-09'),
(23,3,'2024-05-15','2024-06-14'),(24,4,'2024-05-20','2025-05-19'),
(25,5,'2024-06-01','2025-05-31'),(26,6,'2024-06-05','2025-06-04'),
(27,7,'2024-06-10','2025-06-09'),(28,8,'2024-06-15','2025-06-14'),
(29,9,'2024-06-20','2025-06-19'),(30,10,'2024-07-01','2025-06-30'),
(31,1,'2024-07-05','2025-07-04'),(32,2,'2024-07-10','2025-07-09'),
(33,3,'2024-07-15','2025-07-14'),(34,4,'2024-07-20','2025-07-19'),
(35,5,'2024-08-01','2024-10-30'),(36,6,'2024-08-05','2025-08-04'),
(37,7,'2024-08-10','2025-08-09'),(38,8,'2024-08-15','2025-08-14'),
(39,9,'2024-08-20','2025-08-19'),(40,10,'2024-09-01','2025-08-31'),
(41,1,'2024-09-05','2025-09-04'),(42,2,'2024-09-10','2025-09-09'),
(43,3,'2024-09-15','2025-09-14'),(44,4,'2024-09-20','2025-09-19'),
(45,5,'2024-10-01','2025-09-30'),(46,6,'2024-10-05','2025-10-04'),
(47,7,'2024-10-10','2024-11-09'),(48,8,'2024-10-15','2025-10-14'),
(49,9,'2024-10-20','2025-10-19'),(50,10,'2024-11-01','2025-10-31');

-- All 50 members with their current plan & days remaining
SELECT
    m.member_id,
    m.full_name,
    m.email,
    m.gender,
    m.status                               AS member_status,
    mp.plan_name,
    mp.price                               AS plan_price,
    s.start_date,
    s.end_date,
    DATEDIFF(s.end_date, CURDATE())        AS days_remaining,
    s.status                               AS sub_status
FROM members m
LEFT JOIN subscriptions s  ON m.member_id = s.member_id
LEFT JOIN membership_plans mp ON s.plan_id = mp.plan_id
ORDER BY m.member_id;

-- Active members only (with active subscriptions)
SELECT
    m.member_id,
    m.full_name,
    m.phone,
    mp.plan_name,
    s.end_date,
    DATEDIFF(s.end_date, CURDATE()) AS days_left
FROM members m
JOIN subscriptions s  ON m.member_id = s.member_id AND s.status = 'Active'
JOIN membership_plans mp ON s.plan_id = mp.plan_id
WHERE m.status = 'Active'
ORDER BY days_left ASC;

-- Members with expired or cancelled subscriptions
SELECT
    m.full_name, m.email, m.phone,
    mp.plan_name, s.end_date, s.status AS sub_status
FROM members m
JOIN subscriptions s  ON m.member_id = s.member_id
JOIN membership_plans mp ON s.plan_id = mp.plan_id
WHERE s.status IN ('Expired','Cancelled')
ORDER BY s.end_date DESC;

-- Total revenue collected
SELECT
    SUM(amount)                            AS total_revenue,
    COUNT(*)                               AS total_payments,
    ROUND(AVG(amount), 2)                  AS avg_payment
FROM payments;

-- Revenue by plan type
SELECT
    mp.plan_name,
    COUNT(p.payment_id)                    AS total_subscriptions,
    SUM(p.amount)                          AS revenue,
    ROUND(AVG(p.amount), 2)               AS avg_amount
FROM payments p
JOIN subscriptions s  ON p.sub_id = s.sub_id
JOIN membership_plans mp ON s.plan_id = mp.plan_id
GROUP BY mp.plan_id, mp.plan_name
ORDER BY revenue DESC;

-- Revenue by payment method
SELECT
    method,
    COUNT(*)                               AS transactions,
    SUM(amount)                            AS total_collected
FROM payments
GROUP BY method
ORDER BY total_collected DESC;

--  Members with their trainer
SELECT
    m.full_name                            AS member_name,
    t.full_name                            AS trainer_name,
    t.specialization,
    ta.from_date, ta.to_date
FROM trainer_assignments ta
JOIN members  m ON ta.member_id  = m.member_id
JOIN trainers t ON ta.trainer_id = t.trainer_id
ORDER BY t.full_name, m.full_name;

-- Trainer workload (how many members each trainer has)
SELECT
    t.full_name                            AS trainer_name,
    t.specialization,
    COUNT(ta.member_id)                    AS total_members,
    t.salary
FROM trainers t
LEFT JOIN trainer_assignments ta ON t.trainer_id = ta.trainer_id
GROUP BY t.trainer_id, t.full_name, t.specialization, t.salary
ORDER BY total_members DESC;

-- Attendance log with duration
SELECT
    m.full_name,
    a.check_in,
    a.check_out,
    TIMEDIFF(a.check_out, a.check_in)      AS time_spent
FROM attendance a
JOIN members m ON a.member_id = m.member_id
ORDER BY a.check_in DESC;


-- Members who attended this week
SELECT
    m.full_name,
    COUNT(a.attend_id)                     AS visits_this_week,
    MAX(a.check_in)                        AS last_visit
FROM attendance a
JOIN members m ON a.member_id = m.member_id
WHERE a.check_in >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
GROUP BY m.member_id, m.full_name
ORDER BY visits_this_week DESC;

-- Members who have NEVER attended (zero visits)
SELECT
    m.member_id, m.full_name, m.email, m.phone, m.status
FROM members m
LEFT JOIN attendance a ON m.member_id = a.member_id
WHERE a.attend_id IS NULL;

-- Gender-wise member count & percentage
SELECT
    gender,
    COUNT(*)                               AS total,
    ROUND(COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM members), 2) AS percentage
FROM members
GROUP BY gender;

-- Plan popularity (most chosen plan)
SELECT
    mp.plan_name,
    COUNT(s.sub_id)                        AS members_enrolled,
    mp.price,
    mp.duration_days
FROM membership_plans mp
LEFT JOIN subscriptions s ON mp.plan_id = s.plan_id
GROUP BY mp.plan_id, mp.plan_name, mp.price, mp.duration_days
ORDER BY members_enrolled DESC;

-- City-wise member distribution
SELECT
    address                                AS city,
    COUNT(*)                               AS member_count
FROM members
GROUP BY address
ORDER BY member_count DESC;

-- Full dashboard summary (single query)
SELECT
    (SELECT COUNT(*) FROM members WHERE status = 'Active')           AS active_members,
    (SELECT COUNT(*) FROM members WHERE status = 'Inactive')         AS inactive_members,
    (SELECT COUNT(*) FROM members WHERE status = 'Suspended')        AS suspended_members,
    (SELECT COUNT(*) FROM subscriptions WHERE status = 'Active')     AS active_subs,
    (SELECT COUNT(*) FROM subscriptions WHERE status = 'Expired')    AS expired_subs,
    (SELECT COUNT(*) FROM subscriptions WHERE status = 'Cancelled')  AS cancelled_subs,
    (SELECT IFNULL(SUM(amount), 0) FROM payments)                    AS total_revenue,
    (SELECT COUNT(*) FROM attendance)                                AS total_checkins,
    (SELECT COUNT(*) FROM trainers)                                  AS total_trainers;
