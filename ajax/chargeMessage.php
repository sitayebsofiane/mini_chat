<?php

// on verifie la methode utiliser 

if($_SERVER['REQUEST_METHOD'] =='GET'){
    // on est en methode GET
    // on verifie si on a reçu un id
    if(isset($_GET['lastId'])){
        //on recupere l'id et le  nettoie
        $lastId = (int)strip_tags($_GET['lastId']);
        //on donne la valeur au filtre
        $filtre = $lastId>0?"where m.id>$lastId":"";

        //on se connecte a la base 
        require_once('../inc/bdd.php');
        //on ecrit la requête 
        $sql='SELECT m.id, m.message, m.created_at, u.pseudo
        FROM public.messages as m left join users as u on m.users_id=u.id'.$filtre.' ORDER BY m.id ;';

        //on execture la requête 
        $query = $db->query($sql);

        //on recupere les donnees
        $messages = $query->fetchAll();

        //on encode en JSON
        $messagesJson = json_encode($messages);

        //on envoi 
        echo $messagesJson;
    }
}else{
    //mauvaise methode
    http_response_code(405);
    echo json_encode(['message'=>'Mauvaise méthodes']);
}