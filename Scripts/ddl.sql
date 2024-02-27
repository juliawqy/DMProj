CREATE DATABASE G6T15;
USE G6T15;

CREATE TABLE User
	(AcctName VARCHAR(30) NOT NULL,
	Name VARCHAR(30),
	Password VARCHAR(15),
	PrimaryTel INT,
	PrimaryTelType VARCHAR(15),
	UserType CHAR(5),
	CONSTRAINT table_user_pk PRIMARY KEY (AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/user.txt' INTO TABLE user FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Extra_Contact
	(AcctName VARCHAR(30) NOT NULL,
	Tel INT NOT NULL,
	TelType VARCHAR(15),
	CONSTRAINT extra_contact_pk PRIMARY KEY (AcctName, Tel),
	CONSTRAINT extra_contact_fk FOREIGN KEY (AcctName) REFERENCES 
	User(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/extra_contact.txt' INTO TABLE extra_contact FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE SA
	(AcctName VARCHAR(30) NOT NULL,
	JobGrade VARCHAR(5),
	ExtraPwd VARCHAR(15),
	CONSTRAINT sa_pk PRIMARY KEY (AcctName),
	CONSTRAINT sa_fk FOREIGN KEY (AcctName) REFERENCES
	User(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/sa.txt' INTO TABLE sa FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE RU
	(AcctName VARCHAR(30) NOT NULL,
	HighestEdQual VARCHAR(20),
	CONSTRAINT ru_pk PRIMARY KEY (AcctName),
	CONSTRAINT ru_fk FOREIGN KEY (AcctName) REFERENCES
	User(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/ru.txt' INTO TABLE ru FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Interest
	(AcctName VARCHAR(30) NOT NULL,
	Category VARCHAR(20) NOT NULL,
	CONSTRAINT interest_pk PRIMARY KEY (AcctName, Category),
	CONSTRAINT interest_fk FOREIGN KEY (AcctName) REFERENCES
	RU(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/interest.txt' INTO TABLE interest FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE VOA
	(AcctName VARCHAR(30) NOT NULL,
	ApptTitle VARCHAR(30),
	TokenSNO BIGINT,
	VOID INT,
	CONSTRAINT voa_pk PRIMARY KEY (AcctName),
	CONSTRAINT voa_fk FOREIGN KEY (AcctName) REFERENCES
	User(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/voa.txt' INTO TABLE voa FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Course 
	(ID varchar(10) not null,
	NAME varchar(50),
	DESCRIPTION varchar(150),
	Constraint course_pk primary key (ID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/course.txt' INTO TABLE course FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Endorsement
	(Endorser VARCHAR(30) NOT NULL,
	ID VARCHAR(10) NOT NULL,
	Date DATE,
	UnEndorseDate DATE,
	Unendorser VARCHAR(30),
	CONSTRAINT endorsement_pk PRIMARY KEY (Endorser, ID),
	CONSTRAINT endorsement_fk1 FOREIGN KEY (Endorser) REFERENCES
	VOA(AcctName),
	CONSTRAINT endorsement_fk2 FOREIGN KEY (ID) REFERENCES
	Course(ID),
	CONSTRAINT endorsement_fk3 FOREIGN KEY (Unendorser) 
	REFERENCES VOA(AcctName));
    
LOAD DATA INFILE 'C:/<folder>/G6T15/Data/endorsement.txt' INTO TABLE endorsement FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Vo
	(VOID int not null,
	NAME varchar(40),	
	Constraint vo_pk primary key (VOID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/vo.txt' INTO TABLE vo FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Affiliation
	(VOID INT NOT NULL,
	AcctName VARCHAR(30) NOT NULL,
	DateOfAffiliation DATE,
	CONSTRAINT affiliation_pk PRIMARY KEY (VOID, AcctName),
	CONSTRAINT affiliation_fk1 FOREIGN KEY (VOID) REFERENCES
	VO(VOID),
	CONSTRAINT affiliation_fk2 FOREIGN KEY (AcctName) REFERENCES
	RU(AcctName));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/affiliation.txt' INTO TABLE affiliation FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Award 
	(VOID int not null,
	NAME varchar(30) not null,
	DATE date not null,
	TYPE varchar(15),
	Constraint award_pk primary key (VOID, NAME, DATE),
	Constraint award_fk foreign key (VOID) references Vo(VOID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/award.txt' INTO TABLE award FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Given
	(AcctName VARCHAR(30) NOT NULL,
	VOID INT NOT NULL,
	NAME VARCHAR(30) NOT NULL,
	Date DATE NOT NULL,
	CONSTRAINT given_pk PRIMARY KEY (AcctName, VOID, NAME, Date),
	CONSTRAINT given_fk1 FOREIGN KEY (AcctName) REFERENCES
	RU(AcctName),
	CONSTRAINT given_fk2 FOREIGN KEY (VOID,NAME,DATE) REFERENCES
	Award(VOID,NAME,DATE));
    
LOAD DATA INFILE 'C:/<folder>/G6T15/Data/given.txt' INTO TABLE given FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Activity
	(NAME varchar(100) not null,
	DATE date not null,
	MinReqEd varchar(20),
	Constraint activity_pk primary key (NAME,DATE));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/activity.txt' INTO TABLE activity FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

CREATE TABLE Register
	(VOID INT NOT NULL,
	AcctName VARCHAR(30) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Date DATE NOT NULL,
	Accepted TINYINT,
	Completed TINYINT,
	NumHrs INT,
	CONSTRAINT register_pk PRIMARY KEY (VOID, AcctName, Name, Date),
	CONSTRAINT register_fk1 FOREIGN KEY (VOID,AcctName) REFERENCES
	Affiliation(VOID,AcctName),
	CONSTRAINT register_fk2 FOREIGN KEY (Name,Date) REFERENCES
	Activity(Name,Date));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/register.txt' INTO TABLE register FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
 
Create table C_organize
	(ID varchar(10) not null,
	VOID int not null,
	Constraint pk_c_organize primary key (ID,VOID),
	Constraint fk1_c_organize foreign key(ID) references Course(ID),
	Constraint fk2_c_organize foreign key(VOID) references Vo(VOID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/c_organize.txt' INTO TABLE c_organize FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Vo_parent
	(PARENT int not null,
	CHILD int not null,
	Constraint pk_vo_parent primary key (PARENT,CHILD),
	Constraint fk1_vo_parent foreign key (PARENT) references Vo(VOID),
	Constraint fk2_vo_parent foreign key (CHILD) references Vo(VOID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/vo_parent.txt' INTO TABLE vo_parent FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Run 
	(ID varchar(10) not null,
	RunID varchar(10) not null,
	StartDate date,
	EndDate date,
	NoOfHours int,
	Constraint run_pk primary key (ID,RunID),
	Constraint run_fk1 foreign key (ID) references Course(ID));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/run.txt' INTO TABLE run FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
 
Create table Act_category
	(NAME varchar(100) not null,
	DATE date not null,
	CATEGORY varchar(30) not null,
	Constraint act_pk primary key (NAME,DATE,CATEGORY),
	Constraint act_fk1 foreign key (NAME,DATE) references Activity(NAME,DATE));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/act_category.txt' INTO TABLE act_category FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
 
Create table A_organize 
	(VOID int not null,
	NAME varchar(100) not null,
	DATE date not null,
	Constraint a_organize_pk primary key (VOID,NAME,DATE),
	Constraint a_organize_fk1 foreign key (VOID) references Vo(VOID),
	Constraint a_organize_fk2 foreign key (NAME,DATE) references Activity(NAME,DATE));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/a_organize.txt' INTO TABLE a_organize FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

Create table Post
	(VOID int not null,
	CreateDateTime datetime not null,
	STARTDATE date,
	ENDDATE date,
	MESSAGE varchar(100),
	IsPublic tinyint,
	NAME varchar(100),
	DATE date,
	Constraint post_pk primary key(VOID,CreateDateTime),
	Constraint post_fk1 foreign key (VOID) references Vo(VOID),
    Constraint post_fk2 foreign key (NAME, DATE) references Activity(NAME, DATE));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/post.txt' INTO TABLE post FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;
 
Create table Visible
	(VOID int not null,
	PostVOID int not null,
	CreateDateTime datetime not null,
	Constraint visible_pk primary key (VOID,PostVOID,CreateDateTime),
	Constraint visible_fk1 foreign key (PostVOID,CreateDateTime) references Post(VOID,CreateDateTime));

LOAD DATA INFILE 'C:/<folder>/G6T15/Data/visible.txt' INTO TABLE visible FIELDS 
TERMINATED BY '\t' LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

update Activity set minreqed = NULL where minreqed = 'NULL';
update course set description = NULL where description = 'NULL';
update RU set highestedqual= NULL where highestedqual = 'NULL';