CREATE TABLE tech_bucket_list (
  _id integer primary key autoincrement,
  description TEXT NOT NULL UNIQUE,
  difficulty INT NOT NULL,
  effort INT NOT NULL,
  complete datetime,
  last_updated datetime default current_timestamp,
  date_created datetime default current_timestamp
);
