

CREATE TABLE bid_details (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  group_id int(11) NOT NULL,
  bid_cycle int(3) NOT NULL,
  member_id int(11) NOT NULL,
  bidding_amount int(11) NOT NULL,
  deleted tinyint(1) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
