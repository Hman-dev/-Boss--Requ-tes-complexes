SELECT nom, COUNT(*) AS nbr_items
FROM `commande_ligne`
GROUP BY nom
HAVING nbr_items > 1
ORDER BY nbr_items DESC;

SELECT nom, COUNT(*) AS nbr_items, GROUP_CONCAT(commande_id) AS 'Liste commandes/id'
FROM commande_ligne 
GROUP BY nom
HAVING nbr_items > 1
ORDER BY nbr_items DESC;

UPDATE commande_ligne
SET prix_total = prix_unitaire * quantite;