//variables globals

let lastId = 0 // id derneir message affiché


//on attend le chargement du document 
window.onload = () => {
    //ecouteur d'evenment zone de texte
    let texte = document.querySelector("#texte");
    texte.addEventListener("keyup", verifEnter);

    //ecouteur sur le bouton valider
    let valide = document.querySelector("#valide");
    valide.addEventListener("click", ajoutMessage);

    //on charge les nouveaux message  tout les seconde
    setInterval(chargeMessage, 1000)

}
/**
 * charge les dernier message en Ajax et les insere dans la discussion
 */
function chargeMessage() {
    // on instancie XMLHttRequest
    let xmlhttp = new XMLHttpRequest()

    //on gere la response
    xmlhttp.onreadystatechange = function () {
        if (this.readyState == 4) {
            if (this.status == 200) {
                //on a une response
                //on converti les response en objet JS
                let messages = JSON.parse(this.response)

                //on retourne le tableau 
                messages.reverse()

                //on recupere la div #discussion
                let discussion = document.querySelector("#discussion")

                for (let message of messages) {
                    // on transforme la date message en JS
                    let dateMessage = new Date(message.created_at)

                    //on ajoute le contenu avant le contenu actuel de discussion
                    discussion.innerHTML = `<p>${message.pseudo} a ecrit le ${dateMessage.toLocaleString()} : ${message.message}</p>` +
                        discussion.innerHTML

                    //on met a jour le lastId
                    lastId = message.id
                }
            } else {
                //on gere les erreurs
                let erreur = JSON.parse(this.response)
                alert(erreur.message)
            }
        }
    }
    //on ouvre la requette 
    xmlhttp.open("GET", "ajax/chargeMessage.php?lastId="+lastId)

    //on envoi 
    xmlhttp.send()
}
//fonction qui verifier si on appuer sur la touche Enter
function verifEnter(e) {
    if (e.key == "Enter")
        ajoutMessage();
}
/**
 * cette fonction envoi le message en ajax a un fichier ajoutMessage.php
 */
function ajoutMessage() {
    // on recupere le message
    let message = document.querySelector("#texte").value
    //onverifie que le message n'est pas vide
    if (message) {
        //creation d'un objet js
        let data = {}
        data["message"] = message

        //on converti les data en json
        let dataJson = JSON.stringify(data)

        //on envoi les data en post en ajax
        //d'abord on instancie XMLHttpRequest
        let xmlhttp = new XMLHttpRequest()

        //on gere le response
        xmlhttp.onreadystatechange = function () {
            //on verifie si la requête est terminer
            if (this.readyState == 4) {
                // on verifie la response de server
                if (this.status == 201) {
                    //enrigestrement a fonctioné
                    //on efface le champ text
                    document.querySelector("#texte").value = "";
                } else {
                    //enregistrement a echoué
                    let reponse = JSON.parse(this.response)
                    alert(reponse.message)
                }
            }
        }
        xmlhttp.open("POST", "ajax/ajoutMessage.php")

        //on envoi les data via la requette
        xmlhttp.send(dataJson);
    }

}