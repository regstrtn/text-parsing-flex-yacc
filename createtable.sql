drop table info;
drop table projects; 
drop table students;
drop table publications;
drop table awards;

CREATE TABLE IF NOT EXISTS info (
  fac_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(256),
  email VARCHAR(256),
  phone VARCHAR(256), 
  responsibility VARCHAR(256),
  website VARCHAR(256),
  designation VARCHAR(256),
  research_statement VARCHAR(2000),
  PRIMARY KEY (fac_id)
);

CREATE TABLE IF NOT EXISTS publications (
  pub_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) references info(name),
  year INT,
  title VARCHAR(2000),
  PRIMARY KEY (pub_id)
);

CREATE TABLE IF NOT EXISTS projects (
  project_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) references info(name),
  title VARCHAR(2000),
  PRIMARY KEY (project_id)
);

CREATE TABLE IF NOT EXISTS students (
  student_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) references info(name),
  student_name VARCHAR(2000),
  student_type VARCHAR(256),
  student_research_area VARCHAR(2000),
  PRIMARY KEY (student_id)
);

CREATE TABLE IF NOT EXISTS awards (
  award_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(256) references info(name),
  award VARCHAR(2000),
  PRIMARY KEY (award_id)
);
