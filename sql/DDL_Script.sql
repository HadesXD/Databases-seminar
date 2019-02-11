/*
Created		10/10/2018
Modified		20/12/2018
Project		Seminarska
Model			Postgresql 8.1
Company		StroleInc.
Author		Domen Stropnik
Version		1
Database		PostgreSQL 8.1 
*/


/* Create Domains */
Create domain gender Varchar(10) Check(UPPER (value) IN ('MALE', 'FEMALE'));



/* Create Tables */


Create table Films
(
	idFilm Serial NOT NULL,
	idFranchise Integer,
	name Varchar(100) NOT NULL,
	releaseDate Date NOT NULL,
	idCountry Integer NOT NULL,
	language Varchar(20),
	budget Numeric(30,6),
	description Text,
constraint pk_Films primary key (idFilm)
) Without Oids;


Create table Countries
(
	idCountry Serial NOT NULL,
	name Varchar(50) NOT NULL,
	acronym Char(10),
	description Text,
constraint pk_Countries primary key (idCountry)
) Without Oids;


Create table PostCodes
(
	idPostCode Serial NOT NULL,
	idCountry Integer NOT NULL,
	code Varchar(20) NOT NULL,
	city Varchar(80),
constraint pk_PostCodes primary key (idPostCode)
) Without Oids;


Create table People
(
	idPerson Serial NOT NULL,
	name Varchar(40) NOT NULL,
	surname Varchar(50) NOT NULL,
	idPostCode Integer,
	gender gender,
	telephone Varchar(20),
	email Varchar(80),
constraint pk_People primary key (idPerson)
) Without Oids;


Create table Roles
(
	idRole Serial NOT NULL,
	roleType Varchar(30) NOT NULL,
	description Text,
constraint pk_Roles primary key (idRole)
) Without Oids;


Create table CastAndProduction
(
	idCastAndProduct Serial NOT NULL,
	idFilm Integer NOT NULL,
	idPerson Integer NOT NULL,
	idRole Integer NOT NULL,
constraint pk_CastAndProduction primary key (idCastAndProduct)
) Without Oids;


Create table BusinessPartners
(
	idBusinessPartner Serial NOT NULL,
	type Varchar(40),
	description Text,
constraint pk_BusinessPartners primary key (idBusinessPartner)
) Without Oids;


Create table Reviews
(
	idReview Serial NOT NULL,
	score Smallint NOT NULL,
	description Text,
	idPerson Integer NOT NULL,
constraint pk_Reviews primary key (idReview)
) Without Oids;


Create table ProducitonCompanies
(
	idProductionCompany Serial NOT NULL,
	idPostCode Integer,
	name Varchar(50),
	idParentCompany Integer,
	description Varchar(20),
constraint pk_ProducitonCompanies primary key (idProductionCompany)
) Without Oids;


Create table FilmReviews
(
	idFilmReview Serial NOT NULL,
	idFilm Integer,
	idBusinessPartner Integer,
	idReview Integer,
constraint pk_FilmReviews primary key (idFilmReview)
) Without Oids;


Create table FilmCompany
(
	idFilmCompany Serial NOT NULL,
	idFilm Integer NOT NULL,
	idProductionCompany Integer NOT NULL,
constraint pk_FilmCompany primary key (idFilmCompany)
) Without Oids;


Create table Category
(
	idCategory Serial NOT NULL,
	name Varchar(30) NOT NULL,
	description Text,
constraint pk_Category primary key (idCategory)
) Without Oids;


Create table FilmsCategory
(
	idFilmCategory Serial NOT NULL,
	idCategory Integer NOT NULL,
	idFilm Integer NOT NULL,
	description Text,
constraint pk_FilmsCategory primary key (idFilmCategory)
) Without Oids;


Create table Franchises
(
	idFranchise Serial NOT NULL,
	franchise Varchar(50) NOT NULL,
	description Text,
constraint pk_Franchises primary key (idFranchise)
) Without Oids;



/* Create Tab 'Others' for Selected Tables */


/* Create Indexes */



/* Create Foreign Keys */
Create index IX_CastAndProduction___Films on CastAndProduction (idFilm);
Alter table CastAndProduction add Constraint CastAndProduction___Films foreign key (idFilm) references Films (idFilm) on update restrict on delete restrict;
Create index IX_Films___FilmReviews on FilmReviews (idFilm);
Alter table FilmReviews add Constraint Films___FilmReviews foreign key (idFilm) references Films (idFilm) on update restrict on delete restrict;
Create index IX_FilmCompany___Films on FilmCompany (idFilm);
Alter table FilmCompany add Constraint FilmCompany___Films foreign key (idFilm) references Films (idFilm) on update restrict on delete restrict;
Create index IX_FilmsCategory___Films on FilmsCategory (idFilm);
Alter table FilmsCategory add Constraint FilmsCategory___Films foreign key (idFilm) references Films (idFilm) on update restrict on delete restrict;
Create index IX_Countries_Postcode on PostCodes (idCountry);
Alter table PostCodes add Constraint Countries_Postcode foreign key (idCountry) references Countries (idCountry) on update restrict on delete restrict;
Create index IX_Countries___Films on Films (idCountry);
Alter table Films add Constraint Countries___Films foreign key (idCountry) references Countries (idCountry) on update restrict on delete restrict;
Create index IX_PostCodes___People on People (idPostCode);
Alter table People add Constraint PostCodes___People foreign key (idPostCode) references PostCodes (idPostCode) on update restrict on delete restrict;
Create index IX_PostCodes___ProductionCompanies on ProducitonCompanies (idPostCode);
Alter table ProducitonCompanies add Constraint PostCodes___ProductionCompanies foreign key (idPostCode) references PostCodes (idPostCode) on update restrict on delete restrict;
Create index IX_People___CastAndProduction on CastAndProduction (idPerson);
Alter table CastAndProduction add Constraint People___CastAndProduction foreign key (idPerson) references People (idPerson) on update restrict on delete restrict;
Create index IX_People___Reviews on Reviews (idPerson);
Alter table Reviews add Constraint People___Reviews foreign key (idPerson) references People (idPerson) on update restrict on delete restrict;
Create index IX_CastAndProduction___Roles on CastAndProduction (idRole);
Alter table CastAndProduction add Constraint CastAndProduction___Roles foreign key (idRole) references Roles (idRole) on update restrict on delete restrict;
Create index IX_BusinessPartners___FilmReviews on FilmReviews (idBusinessPartner);
Alter table FilmReviews add Constraint BusinessPartners___FilmReviews foreign key (idBusinessPartner) references BusinessPartners (idBusinessPartner) on update restrict on delete restrict;
Create index IX_Reviews___FilmReviews on FilmReviews (idReview);
Alter table FilmReviews add Constraint Reviews___FilmReviews foreign key (idReview) references Reviews (idReview) on update restrict on delete restrict;
Create index IX_ProductionCompanies___FilmCompanies on FilmCompany (idProductionCompany);
Alter table FilmCompany add Constraint ProductionCompanies___FilmCompanies foreign key (idProductionCompany) references ProducitonCompanies (idProductionCompany) on update restrict on delete restrict;
Create index IX_ on ProducitonCompanies (idParentCompany);
Alter table ProducitonCompanies add  foreign key (idParentCompany) references ProducitonCompanies (idProductionCompany) on update restrict on delete restrict;
Create index IX_FilmsCategory___Category on FilmsCategory (idCategory);
Alter table FilmsCategory add Constraint FilmsCategory___Category foreign key (idCategory) references Category (idCategory) on update restrict on delete restrict;
Create index IX_Franchises___Films on Films (idFranchise);
Alter table Films add Constraint Franchises___Films foreign key (idFranchise) references Franchises (idFranchise) on update restrict on delete restrict;





