CREATE TABLE contacts (
  --contact_id INTEGER PRIMARY KEY,
  _id integer primary key autoincrement,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
  linkedin_url TEXT,
  workplace TEXT,
  work_email TEXT,
  personal_email TEXT,
  cell_phone TEXT,
  work_phone TEXT,
  last_updated datetime default current_timestamp,
  date_created datetime default current_timestamp,
  unique (fname, lname)
);


insert into contacts(fname, lname) VALUES('Jackie', 'Jenkins');
insert into contacts(fname, lname) VALUES('Karl', 'Riebs');
