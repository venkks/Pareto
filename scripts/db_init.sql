

CREATE TABLE auction (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  auction_date DATETIME NOT NULL,
  group_id int(11) NOT NULL,
  member_id int(11) NOT NULL,
  amount int(11) NOT NULL,
  dividend int(11) NOT NULL,
  deleted tinyint(1) NOT NULL,
  service_tax float DEFAULT NULL,
  upcoming_auction_date DATETIME DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE auction_details (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  auction_id int(11) NOT NULL REFERENCES auction(id),
  member_id int(11) NOT NULL REFERENCES members(id),
  bidding_amount int(11) NOT NULL,
  deleted tinyint(1) NOT NULL,
  narration varchar(45) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE branch (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  branch_name varchar(100) NOT NULL,
  street varchar(100) DEFAULT NULL,
  contact varchar(20) NOT NULL,
  company_id varchar(45) DEFAULT NULL REFERENCES company(id),
  address varchar(100) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE company (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  company_name varchar(100) UNIQUE NOT NULL,
  contact varchar(45) NOT NULL,
  remarks varchar(500) DEFAULT NULL,
  deleted tinyint(1) DEFAULT NULL,
  street varchar(150) DEFAULT NULL,
  place varchar(100) DEFAULT NULL,
  city varchar(100) DEFAULT NULL,
  state varchar(100) DEFAULT NULL,
  zip varchar(15) DEFAULT NULL,
  pan_no varchar(15) DEFAULT NULL,
  email_id varchar(50) DEFAULT NULL,
  country varchar(50) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE employee (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  user_id int(11) NOT NULL REFERENCES users(id),
  company_id int(11) NOT NULL REFERENCES company(id),
  branch_id int(11) NOT NULL REFERENCES branch(id),
  createdby varchar(45) DEFAULT NULL,
  deleted tinyint(1) NOT NULL,
  designation varchar(45) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY user_company (user_id,company_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE group_status(
  id int(2) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(50) UNIQUE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO group_status(name)
VALUES ('New'),('Active'),('Concluded'),('Cancelled');


CREATE TABLE groups (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  group_name varchar(45) NOT NULL,
  auction_date datetime NOT NULL,
  sms_option boolean NOT NULL,
  group_status_id tinyint(2) NOT NULL REFERENCES group_status(id),
  group_value int(11) NOT NULL,
  auction_frequency int(11) NOT NULL,
  company_id int(11) NOT NULL REFERENCES company(id),
  branch_id int(11) NOT NULL REFERENCES branch(id),
  member_count int(11) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY group_company_branch (group_name,company_id,branch_id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE members (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  deleted tinyint(1) NOT NULL,
  group_id int(11) NOT NULL REFERENCES groups(id),
  user_id int(11) NOT NULL REFERENCES users(id),
  createdby varchar(45) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE roles (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  role_name varchar(45) UNIQUE NOT NULL,
  deleted tinyint(1) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO roles (role_name,deleted)
VALUES ('Admin',0),('Head',0),('Staff',0),('Member',0);




CREATE TABLE transactions (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  member_id int(11) NOT NULL REFERENCES members(id),
  amount int(11) NOT NULL,
  transaction_type_id int(3) NOT NULL REFERENCES transaction_types(id),
  transaction_status_id int(3) NOT NULL REFERENCES transaction_status(id),
  transaction_mode_id int(3) NOT NULL REFERENCES transaction_modes(id),
  narration varchar(45) DEFAULT NULL,
  current_outstanding int(11) NOT NULL,
  created_by_user int(11) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


CREATE TABLE transaction_types (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(200) UNIQUE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO transaction_types (name)
VALUES ('Opening Balance entry'),('Admission fees entry'),('Next month’s installment Auto-debit entry'),
    ('Installment payment'),
    ('Auction - Prize money entry'),
    ('Auction - Service tax entry'),
    ('Auction - Commission Entry'),
    ('Auction - Dividend Entry'),
    ('Payment adjustment - Cheque bounced'),
    ('Collection adjustment - Wrong amount collected earlier');


CREATE TABLE transaction_status (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(50) UNIQUE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO transaction_status (name)
VALUES ('New'),('Pending'),('Successful'),('Unsuccessful'),('Deleted');


CREATE TABLE transaction_modes (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  name varchar(50) UNIQUE NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO transaction_modes (name)
VALUES ('Cash'),('Cheque'),('Online Payment'),('ECS'),('ACH'),('Others');


CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  title varchar(45) DEFAULT NULL,
  full_name varchar(45) NOT NULL,
  email_id varchar(45) UNIQUE DEFAULT NULL,
  password varchar(60) DEFAULT NULL,
  contact varchar(45) UNIQUE NOT NULL,
  deleted tinyint(1) DEFAULT NULL,
  role_id int(11) NOT NULL REFERENCES roles(id),
  street varchar(100) DEFAULT NULL,
  place varchar(45) DEFAULT NULL,
  city varchar(45) DEFAULT NULL,
  state varchar(45) DEFAULT NULL,
  zip varchar(10) DEFAULT NULL,
  dob datetime DEFAULT NULL,
  country varchar(45) DEFAULT NULL,
  aadhar_no varchar(15) DEFAULT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;



INSERT into users (title,full_name,email_id,password,contact,deleted,role_id,street,place,city,state,zip,dob,country,aadhar_no)
VALUES ("Mrs.","Priya Surya","priya.surya@gmail.com","12345",9004553241,0,1,"street","place","city","state",400076,"1993-04-18","India",1234567890);


