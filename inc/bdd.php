<?php
$host = "localhost";
$db_name = "clientchat";
$username = "postgres";
$password = "as122014";
/**
 * Connexion à la BDD ,je utilse postgresql
 */
try{
	$db = new PDO("pgsql:host=".$host.";dbname=".$db_name,$username,$password);
}catch(PDOException $e){
	die('Erreur : ' . $e->getMessage());
}