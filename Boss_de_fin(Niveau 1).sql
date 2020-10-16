-- 1) Obtenir l’utilisateur ayant le prénom "Muriel" et le mot de passe (en clair) "test11", sachant que l’encodage du mot de passe est effectué avec l’algorithme Sha1.
-- Indice :
SELECT *
FROM client
WHERE prenom = ...
AND password = SHA1(...)

SELECT *
FROM client
WHERE prenom = 'Muriel'
AND password = SHA1('test11');


-- 2) Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes.
--Indice :
/*SELECT nom, COUNT(*) AS nbr_items
FROM `commande_ligne`
GROUP BY ...
HAVING .... > 1
ORDER BY nbr_items DESC*/

SELECT nom, COUNT(*) AS nbr_items
FROM commande_ligne
GROUP BY nom
HAVING nbr_items > 1
ORDER BY nbr_items DESC;


-- 3) Obtenir la liste de tous les produits qui sont présent sur plusieurs commandes et y ajouter une colonne qui liste les identifiants des commandes associées.

SELECT nom, COUNT(*) AS nbr_items, GROUP_CONCAT(commande_id)
FROM commande_ligne 
GROUP BY nom
HAVING nbr_items > 1
ORDER BY nbr_items DESC;

-- 4) Enregistrer le prix total à l’intérieur de chaque ligne des commandes, en fonction du prix unitaire et de la quantité

UPDATE commande_ligne
SET prix_total = prix_unitaire * quantite;

-- 5) Obtenir le montant total pour chaque commande et y voir facilement la date associée à cette commande ainsi que le prénom et nom du client associé

SELECT client.prenom, client.nom , commande.date_achat , commande_id,
SUM(prix_total) AS 'prix_commande'
FROM commande_ligne
LEFT JOIN commande ON commande.id = commande_ligne.commande_id
LEFT JOIN CLIENT ON CLIENT.id = commande.client_id
GROUP BY commande_id;

-- 6)(Attention - question difficile) Enregistrer le montant total de chaque commande dans le champ
-- intitulé “cache_prix_total”




-- 7) Obtenir le montant global de toutes les commandes, pour chaque mois
SELECT YEAR(`date_achat`), MONTH(`date_achat`), SUM(`cache_prix_total`) 
FROM `commande` 
GROUP BY YEAR(`date_achat`), MONTH(`date_achat`)
ORDER BY YEAR(`date_achat`), MONTH(`date_achat`);