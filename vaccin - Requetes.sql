-- nombre de médecin par spécialités
select spe_nom, count(pos_medecin) nb
from specialite, possede
where spe_id=pos_specialite
group by spe_id;
-- nombre de médecin par centre médicaux
-- nombre de médecin par école et par année
-- nombre de médecin par école toutes années confondues
-- nombre de vaccinations reçues par enfant
-- nombre de vaccinations réalisées par médecin
-- nombre de vaccinations réalisées par médecin et par année
-- médecin ayant fait le plus de vaccination pour une année donnée
create view NbVaccination as
select year(tra_date) annee, med_nom, count(tra_vaccin) nb
from traiter, medecin
where tra_medecin=med_id
group by annee, med_id;

create view vuemax as
select annee, max(nb) zmax
from NbVaccination
group by annee;

select NbVaccination.annee, med_nom, zmax
from NbVaccination, vuemax
where NbVaccination.annee=vuemax.annee and zmax=nb;

-- médecin ayant fait le plus de vaccination toutes années confondues

