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