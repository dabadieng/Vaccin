--
-- base de donn�es: 'baseavion'
--
create database if not exists basevaccin default character set utf8 collate utf8_general_ci;
use basevaccin;
-- --------------------------------------------------------
-- creation des tables

set foreign_key_checks =0;

-- table medecin
drop table if exists medecin;
create table medecin (
	med_id int not null auto_increment primary key,
	med_nom varchar(50) not null,
	med_centre int
)engine=innodb;

-- table enfants
drop table if exists enfants;
create table enfants (
	enf_id int not null auto_increment primary key,
	enf_nom varchar(20) not null
)engine=innodb;


-- table centre
drop table if exists centre;
create table centre (
	cen_id int not null auto_increment primary key,
	cen_nom varchar(20) not null
)engine=innodb;

-- table specialite
drop table if exists specialite;
create table specialite (
	spe_id int not null auto_increment primary key,
	spe_nom varchar(50) not null
)engine=innodb;

-- table ecole
drop table if exists ecole;
create table ecole (
	eco_id int not null auto_increment primary key,
	eco_nom varchar(20) not null
)engine=innodb;

-- table vaccin
drop table if exists vaccin;
create table vaccin (
	vac_id int not null auto_increment primary key,
	vac_nom varchar(20) not null
)engine=innodb;

-- table possede
drop table if exists possede;
create table possede (
	pos_id int not null auto_increment primary key,
	pos_medecin int not null,
	pos_specialite int not null,
	unique key med_specialite (pos_medecin, pos_specialite)
)engine=innodb;


-- table affecter
drop table if exists affecter;
create table affecter (
	aff_id int not null auto_increment primary key,
	aff_medecin int,
	aff_ecole int not null,
	aff_annee int not null,
	unique key aff_med_annee (aff_medecin,aff_ecole, aff_annee)
)engine=innodb; 

-- table traiter
drop table if exists traiter;
create table traiter (
	tra_id int not null auto_increment primary key,
	tra_vaccin int,
	tra_date date,
	tra_medecin int,
	tra_enfant int,
	unique key traitement (tra_vaccin, tra_enfant, tra_medecin, tra_date)
)engine=innodb; 


-- contraintes
alter table medecin add constraint cs1 foreign key (med_centre) references centre(cen_id);
alter table possede add constraint cs2 foreign key (pos_specialite) references specialite(spe_id);
alter table possede add constraint cs3 foreign key (pos_medecin) references medecin(med_id);
alter table affecter add constraint cs4 foreign key (aff_medecin) references medecin(med_id);
alter table affecter add constraint cs5 foreign key (aff_ecole) references ecole(eco_id);
alter table traiter add constraint cs8 foreign key (tra_vaccin) references vaccin(vac_id);
alter table traiter add constraint cs9 foreign key (tra_medecin) references medecin(med_id);
alter table traiter add constraint cs10 foreign key (tra_enfant) references enfants(enf_id);

set foreign_key_checks = 1;

-- jeu de données
