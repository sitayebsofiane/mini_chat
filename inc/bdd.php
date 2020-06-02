<?php

/**
 * Connexion à la BDD ,je utilse postgresql
 */
try{
	$db = new PDO("pgsql:host=localhost;dbname=clientchat","postgres","as122014");
}catch(PDOException $e){
	die('Erreur : ' . $e->getMessage());
}
