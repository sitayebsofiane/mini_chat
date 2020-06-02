<?php

// ce fichier reçois les data en json et enregistre le message
session_start();

//on verifier la methode 
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    //on verifie si l'utlisateur est connecter 
    if (isset($_SESSION['user']['id'])) {
        // l'utilisateur est connecter
        // on recuper les data (message)
        $dataJson = file_get_contents('php://input');

        //on converti les donné en object php
        $donnees = json_decode($dataJson);

        //on verifie si on a un message
        if(isset($donnees->message) && !empty($donnees->message)){
            //on a un message
            //on le stock
            //on se connecte
            require_once('../inc/bdd.php');
            //on ecrit la requête
            $sql ='INSERT INTO messages(message,users_id) VALUES
            (:message,:user);';
            //je prepare la requette 
            $query = $db->prepare($sql);

            //on injecte les valeurs 
            $query->bindValue(':message',strip_tags($donnees->message),PDO::PARAM_STR);
            $query->bindValue(':user',$_SESSION['user']['id'],PDO::PARAM_INT);

            //on execute avec verification si ça fonctionne
            if($query->execute()){
                http_response_code(201);
                echo json_encode(['message'=>'Enregistrement effectué']);
            }else{
                http_response_code(400);
                echo json_encode(['message'=>'Une erreur est survenue']);
            }

        }else{
         // pas de message
         http_response_code(400);
         echo json_encode(['message'=>'le message est vide']);
        }
    } else {
        //l'utilisateur n'est pas connecter
        http_response_code(400);
        echo json_encode(['message' => 'vous devez vous connecter']);
    }
} else {
    // mauvaise methode 
    http_response_code(405);
    echo json_encode(['message' => 'mauvaise methode']);
}
