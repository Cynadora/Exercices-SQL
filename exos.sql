--1  Afficher la liste des hôtels / Le résultat doit faire apparaître le nom de l’hôtel et la ville
SELECT hot_nom, hot_ville 
FROM hotel;

-- 2 Afficher la ville de résidence de Me White/Le résultat doit faire apparaître le nom, le prénom, et l'adresse du client/
-- réponse / White Jack Détroit

SELECT cli_nom, cli_prenom, cli_adresse, cli_ville 
FROM client 
WHERE cli_nom = 'white';

-- 3 Affichez la liste des stations dont l'altitude < 1000 / le résultat doit faire apparaître le nom de la station et l'altitude
-- réponse / Le Sud 200 / La plage 10
SELECT sta_nom, sta_altitude
FROM station
WHERE sta_altitude < 1000;

-- 4 Affichez la liste des chambres ayant une capacité > 1 /Le résultat doit faire apparaître le numéro de la chambre ainsi que la capacité 
SELECT cha_capacite, cha_numero
FROM chambre
WHERE cha_capacite > 1;

-- 5 Affichez les clients habitant à Londres/Le résultat doit faire apparaître le nom du client et la ville
SELECT cli_ville, cli_nom
FROM client
WHERE cli_ville = 'Londres'; 

-- 5 Affichez les clients n'habitant pas à Londres/Le résultat doit faire apparaître le nom du client et la ville
SELECT cli_ville, cli_nom
FROM client
WHERE cli_ville != 'Londres';

-- 6 Affichez la liste des hôtels située sur la ville de bretou et possédant une catégorie > 3 / Le résultat doit faire apparaître le nom de l'hôtel,ville et la catégorie
SELECT hot_ville, hot_nom, hot_categorie
FROM hotel
WHERE hot_ville = 'Bretou';

-- Lot 2 JOIN  /7 Affichez la liste des hôtels avec leur station / Le résultat doit faire apparaître le nom de la station, le nom de l'hôtel, la catégorie, la ville 

SELECT sta_nom, hot_nom, hot_categorie, hot_ville
FROM station
JOIN hotel ON sta_id = hot_sta_id;

-- 7 Afficher la liste des hôtels avec leur station
SELECT sta_nom, hot_nom, hot_categorie, hot_ville
FROM hotel
JOIN station ON sta_id = hot_sta_id;

-- 8 Afficher la liste des chambres et leur hôtel
SELECT hot_nom, hot_categorie, hot_ville, cha_numero
FROM chambre
JOIN hotel ON hot_id = cha_hot_id;

-- 9 Afficher la liste des chambres de plus d'une place dans des hôtel situés sur la ville de Bretou
SELECT hot_nom, hot_categorie, hot_ville, cha_numero, cha_capacite
FROM chambre
JOIN hotel ON hot_id = cha_hot_id
WHERE cha_capacite > 1
AND hot_ville = 'Bretou';

-- 10 Afficher la liste des réservations avec le nom des clients
SELECT cli_nom, hot_nom, res_date
FROM client
JOIN reservation ON cli_id = res_cli_id
JOIN chambre ON res_cha_id = cha_id
JOIN hotel ON hot_id = cha_hot_id;

-- 11 Afficher la liste des chambres avec le nom de l'hôtel et le nom de la station
SELECT sta_nom, hot_nom, cha_numero, cha_capacite
FROM chambre
JOIN hotel ON cha_hot_id = hot_id
JOIN station ON sta_id = hot_sta_id;

-- 12 Afficher les réservation avec le nom du client et le nom de l'hôtel avec datediff
SELECT cli_nom, hot_nom, res_date_debut, DATEDIFF(res_date_fin, res_date_debut)
FROM client
JOIN reservation ON cli_id = res_cli_id
JOIN chambre ON res_cha_id = cha_id
JOIN hotel ON cha_hot_id = hot_id;

-- 13 Compter le nombre d'hôtel par station
SELECT sta_nom, COUNT(hot_id)
FROM hotel
JOIN station ON hot_sta_id = sta_id
GROUP BY sta_nom;

-- 14 Compter le nombre de chambres par station --
SELECT sta_nom,  COUNT(hot_sta_id)
FROM station
JOIN hotel ON hot_sta_id = sta_id
JOIN chambre ON cha_hot_id = hot_id
GROUP BY sta_nom;

-- 15 Compter le nombre de chambres par station ayant une capacité > 1 --
SELECT sta_nom,  COUNT(cha_id)
FROM station
JOIN hotel ON hot_sta_id = sta_id
JOIN chambre ON cha_hot_id = hot_id 
WHERE cha_capacite > 1
GROUP BY sta_nom;

-- 16 Afficher la liste des hôtels pour lesquels Mr Squire a effectué une réservation --
SELECT hot_nom, res_date, cli_nom
FROM reservation
JOIN client ON cli_id = res_cli_id
JOIN chambre ON res_cha_id = cha_id
JOIN hotel ON cha_hot_id = hot_id
WHERE cli_nom = 'Squire';

-- 17 Afficher la durée moyenne des réservations par station --
SELECT sta_nom, (AVG(DATEDIFF(res_date_fin, res_date_debut))) 'duree_moyenne_des_reservations'
FROM reservation
JOIN client ON cli_id = res_cli_id
JOIN chambre ON cha_id = res_cha_id
JOIN hotel ON hot_id = cha_hot_id
JOIN station ON sta_id = hot_sta_id
GROUP BY sta_nom;

SELECT hot_sta_id, (AVG(DATEDIFF(res_date_fin, res_date_debut))) 'duree_moyenne_des_reservations'
FROM reservation, hotel, chambre
WHERE res_cha_id = cha_id AND cha_hot_id = hot_id
GROUP BY hot_sta_id;

-- 1 Quelles sont les commandes du fournisseur n°9120 ?
SELECT numfou, numcom
FROM entcom
WHERE numfou = 9120;

-- 2 Afficher le code des fournisseurs pour lesquels des commandes ont été passées.
-- Affiche le code des fournisseurs/depuis la table entcom
SELECT numfou
FROM entcom;

-- 3 Afficher le nombre de commandes fournisseurs passées, et le nombre de fournisseur concernés.
SELECT COUNT(numfou) AS FsseurConcernee,
COUNT(*) AS CdePassees,
FROM fournis;

-- 4 Extraire les produits ayant un stock inférieur ou égal au stock d'alerte, et dont la quantité annuelle est inférieure à 1000. / Informations à fournir : n° produit, libellé produit, stock actuel, stock d'alerte, quantité annuelle)
-- Sélection des colonnes dont on a besoin / WHERE filtre les produits qui ont un stock actuel <= au stock 'd'alerte  et dont la qté annuelle est < 1000

SELECT stkale, qteann, stkphy, libart, codart
FROM produit
WHERE stkphy <= stkale AND qteann < 1000; 

SELECT produit.codart, produit.libart, produit.stkphy, produit.stkale, produit.qteann
FROM produit
WHERE produit.stkphy <= produit.stkale AND produit.qteann < 1000;

-- 5 Quels sont les fournisseurs situés dans les départements 75, 78, 92, 77 ? / L’affichage (département, nom fournisseur) sera effectué par département décroissant, puis par ordre alphabétique.
-- Sélection du nom et du CP des fournisseurs dans la table fournis/ WHERE filtre les fournisseurs situés dans les départements 75, 78, 92 et 77/ LIKE recherche toutes les lignes qui
-- correspondent aux départements recherchés / ORDER BY met les départements par ordre décroissant et le nom des fournisseurs par ordre croissant

SELECT nomfou, posfou
FROM fournis
WHERE posfou LIKE '75%' OR posfou LIKE '78%' OR posfou LIKE '92%' OR posfou LIKE '77%' 
ORDER BY posfou DESC, nomfou ASC;

-- 6 Quelles sont les commandes passées en mars et en avril ?
SELECT *
FROM entcom
WHERE MONTH (datcom) = '03' OR MONTH (datcom) = '04';

-- 7 Quelles sont les commandes du jour qui ont des observations particulières ? / Afficher numéro de commande et date de commande
SELECT numcom, datcom, obscom
FROM entcom
WHERE obscom IS NOT NULL AND obscom <> ''; 

-- 8 Lister le total de chaque commande par total décroissant. / Afficher numéro de commande et total
-- SELECT colonne numcom et qtecde de la table ligcom / ORDER BY (trie le total décroissant (DESC) de chaque commande)
SELECT numcom, qtecde
FROM ligcom
ORDER BY numcom DESC;

-- 9 Lister les commandes dont le total est supérieur à 10000€ ; on exclura dans le calcul du total les articles commandés en quantité supérieure ou égale à 1000./ Afficher numéro de commande et total
SELECT qtecde, numcom
FROM ligcom
WHERE qtecde > 10000 AND qtecde >= 1000;

-- 10 - Lister les commandes par nom de fournisseur. / Afficher nom du fournisseur, numéro de commande et date
Sélectionner les colonnes nomfou, numfou dans la table fournis puis datcom
dans la table entcom/ Utiliser JOIN pour relier la table entcom à la table
fournis on relie numfou de la table fournis = numfou de la table entcom

SELECT nomfou, numcom, datcom
 FROM entcom
 JOIN fournis ON fournis.numfou = entcom.numfou

SELECT nomfou, numcom, datcom
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou;

-- 11 Sortir les produits des commandes ayant le mot "urgent' en observation. / Afficher numéro de commande, nom du fournisseur, libellé du produit et sous total (= quantité commandée * prix unitaire)
Sélectionner toutes les colonnes de la table entcom (numcom, obscom, datcom et numfou) Faire le jointure entre les tables
WHERE on recherche dans la colonne obscom le mot 'urgent'

SELECT entcom.numcom, fournis.nomfou, produit.libart, obscom, qtecde* priuni AS sous_total
 FROM entcom
 JOIN fournis ON fournis.numfou = entcom.numfou
 JOIN vente ON vente.numfou = fournis.numfou
 JOIN produit ON produit.codart = vente.codart
 JOIN ligcom ON ligcom.codart = produit.codart
 WHERE obscom LIKE '%urgent%';

-- 12 Coder de 2 manières différentes la requête suivante : Lister le nom des fournisseurs susceptibles de livrer au moins un article.
-- Sélectionner colonnes nomfou et numcom de la table fournis/ On joint entcom en reliant entcom.numfou à fournis.numcom grouper par nom de fournisseurs

SELECT fournis.nomfou, entcom.numcom 
FROM fournis
JOIN entcom ON entcom.numfou = fournis.numfou; 

SELECT fournis.nomfou, entcom.numcom 
FROM fournis
JOIN entcom ON entcom.numfou = fournis.numfou 
GROUP BY nomfou

 -- 13 Coder de 2 manières différentes la requête suivante : Lister les commandes dont le fournisseur est celui de la commande n°70210./ Afficher numéro de commande et date
SELECT fournis.nomfou, entcom.datcom, entcom.numcom 
FROM entcom
JOIN fournis ON fournis.numfou = entcom.numfou
JOIN vente ON vente.numfou = fournis.numfou
JOIN produit ON produit.codart = vente.codart
JOIN ligcom ON ligcom.codart = produit.codart
WHERE numcom = 70210;

SELECT fournis.nomfou, entcom.datcom, entcom.numcom 
FROM entcom
JOIN fournis ON fournis.numfou = entcom.numfou
JOIN vente ON vente.numfou = fournis.numfou
JOIN produit ON produit.codart = vente.codart
JOIN ligcom ON ligcom.codart = produit.codart
WHERE entcom.numcom = 70210
GROUP BY nomfou;

-- 14 Dans les articles susceptibles d’être vendus, lister les articles moins chers (basés sur Prix1)
--  que le moins cher des rubans (article dont le premier caractère commence par R).Afficher libellé de l’article et prix1
-- Sélection du code article, du numéro du fsseur et le prix1 pour tous les articles dont le prix1 est inférieur au prix1 du ruban le moins cher 
-- (par le 1er caractère de R) on utilise une sous-requête pour trouver le prix1 du ruban le moins cher.
SELECT codart, numfou, prix1
FROM vente
WHERE prix1 < (SELECT MIN(prix1)
FROM vente
WHERE codart LIKE 'R%');

-- 15  Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte. / La liste sera triée par produit puis fournisseur
SELECT fournis.nomfou, produit.stkphy, produit.stkale, produit.libart
FRom fournis
JOIN vente ON  vente.numfou = fournis.numfou 
JOIN produit ON produit.codart = vente.codart
WHERE produit.stkphy <= produit.stkale * 1.5; 
ORDER BY produit.libart, fournis.nomfou;

-- 16 Sortir la liste des fournisseurs susceptibles de livrer les produits dont le stock est inférieur ou égal à 150 % du stock d'alerte, et un délai de livraison d'au maximum 30 jours./ La liste sera triée par fournisseur puis produit
SELECT fournis.nomfou, produit.stkphy
FRom fournis
JOIN vente ON  vente.numfou = fournis.numfou 
JOIN produit ON produit.codart = vente.codart
WHERE produit.stkphy <= produit.stkale * 1.5 AND delliv <= 30
ORDER BY produit.libart, fournis.nomfou;

-- 17 Avec le même type de sélection que ci-dessus, sortir un total des stocks par fournisseur, triés par total décroissant.
SELECT fournis.nomfou, SUM(produit.stkphy)
FRom fournis
JOIN vente ON  vente.numfou = fournis.numfou 
JOIN produit ON produit.codart = vente.codart
GROUP BY nomfou 
ORDER BY stkphy DESC;

-- 18 En fin d'année, sortir la liste des produits dont la quantité réellement commandée dépasse 90% de la quantité annuelle prévue.
SELECT*
FROM produit
JOIN ligcom ON ligcom.codart = produit.codart
WHERE produit.stkphy  AND qteann >= 0.9;

-- 19 Calculer le chiffre d'affaire par fournisseur pour l'année 2018, sachant que les prix indiqués sont hors taxes et que le taux de TVA est 20%.
-- La jointure lie les tables ligcom, entcom et fournis / WHERE filtre les résultats pour 2018 / La requête calcule le chiffre d'affaire par fournisseur pour l'année
-- 2018 en prenant compte de la TVA.

SELECT nomfou, SUM(qtecde*priuni) AS 'totalht', SUM(qtecde*priuni)*1.20 
FROM fournis
JOIN entcom ON fournis.numfou = entcom.numfou
JOIN ligcom ON entcom.numcom = ligcom.numcom
WHERE YEAR (derliv) = '2018'; 

-- MISE A JOUR
-- 1 Appliquer une augmentation de tarif de 4% pour le prix 1 et de 2% pour le prix2, pour le fournisseur 9180.
-- Mettre à jour les enregistrements dans la table 'vente'.Le prix 1 doit être * PAR 1.04 (augmentation de 4%) et le prix2 doit être * par 1.02 (augmentation de 2%) WHERE filtre les augmentations pour le fsseur 9180
UPDATE vente
SET prix1 = prix1 * 1.04, prix2 = prix2 * 1.02
WHERE numfou = '9180';

-- 2 Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est nul, en affectant la valeur du prix1.
-- Mettre à jour les enregistrements dans la table 'vente'. La clause SET spécifie que le prix2 doit être mis à jour avec la valeur du prix1. WHERE filtre pour que le prix2
-- est égal à 0.
UPDATE vente
SET prix2 = prix1
WHERE prix2 = 0;

-- 3 Mettre à jour le champ obscom, en renseignant ***** pour toutes les commandes dont le fournisseur a un indice de satisfaction inférieur à 5.
-- La clause SET spfécifie que le champ 'obscom' doit être mis à jour avec la valeur "" 
-- on utilise une sous-requête qui sélectionne les numéros des fournisseurs dans la table 'fournis' qui ont un indice de satisfaction inférieur à 5.Puis aller voir
-- dans la table entcom la colonne obscom 
UPDATE entcom
SET obscom = '*****'
WHERE numfou IN (SELECT numfou FROM fournis WHERE satisf < 5);

-- 4 Supprimer le produit "I110".
-- WHERE filtre les lignes à supprimer basé sur le code de l'article / La suppression d'une ligne est définitive et ne peut être annuler.
DELETE FROM produit
WHERE produit.codart = 'I110';





