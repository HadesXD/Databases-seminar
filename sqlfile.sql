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