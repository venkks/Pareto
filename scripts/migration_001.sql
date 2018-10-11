ALTER TABLE transactions MODIFY amount float(5) NOT NULL;

ALTER TABLE auction MODIFY amount float(5) NOT NULL;
ALTER TABLE auction MODIFY dividend float(5) NOT NULL;



CREATE TABLE sent_messages (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  message varchar(500) NOT NULL,
  reciever_user_id int(11) NOT NULL,
  response_message varchar(500),
  sender_id int(11) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


ALTER TABLE users ADD UNIQUE (full_name,contact);

-- Adding branch_id to members.
ALTER table members ADD branch_id int(11) default 0 not null;
update members m set branch_id=(select g.branch_id from groups g where m.group_id=g.id);
