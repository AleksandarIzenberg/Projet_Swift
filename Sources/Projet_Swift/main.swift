import Foundation

// Verifye un texte 
func lireTexte(_ message: String) -> String {
    while true {
        print(message, terminator: "")
        guard let saisie = readLine() else {
            print("\nFin de la saisie.")
            exit(0)
        }
        let texte = saisie.trimmingCharacters(in: .whitespaces)
        if !texte.isEmpty {
            return texte
        }
        print("Ce champ ne peut pas être vide.")
    }
}

// Verifier un nombre entier
func lireEntier(_ message: String) -> Int {
    while true {
        let texte = lireTexte(message)
        if let nombre = Int(texte) {
            return nombre
        }
        print("Veuillez entrer un nombre valide.")
    }
}

// Demande un nombre entier supérieur à 0
func lireEntierPositif(_ message: String) -> Int {
    var nombre = lireEntier(message)
    while nombre <= 0 {
        print("Le nombre doit être supérieur à 0.")
        nombre = lireEntier(message)
    }
    return nombre
}

// ---------- Actions du menu ----------

func afficherMenu() {
    print("\n===== MENU PRINCIPAL =====")
    print("1- Enregistrer des livres")
    print("2- Afficher le catalogue")
    print("3- Rechercher un livre")
    print("4- Créer un adhérent")
    print("5- Emprunter un livre")
    print("6- Retourner un livre")
    print("7- Afficher les emprunts")
    // print("8- Lancer les tests demandés")
    print("0- Quitter")
}

func enregistrerLivres(dans bibliotheque: Bibliotheque) {
    print("\n--- Enregistrement de livres ---")
    let nombre = lireEntierPositif("Combien de livres voulez-vous enregistrer ? ")

    for i in 1...nombre {
        print("\nLivre \(i)")
        let titre = lireTexte("Titre : ")
        let auteur = lireTexte("Auteur : ")

        print("Type de livre :")
        print("1- Livre papier")
        print("2- Livre numérique")
        var type = lireEntier("Votre choix : ")
        while type != 1 && type != 2 {
            type = lireEntier("Choix invalide, tapez 1 ou 2 : ")
        }

        if type == 1 {
            let pages = lireEntierPositif("Nombre de pages : ")
            bibliotheque.ajouterLivre(LivrePapier(titre: titre, auteur: auteur, nombrePages: pages))
        } else {
            let taille = lireEntierPositif("Taille du fichier en Mo : ")
            bibliotheque.ajouterLivre(LivreNumerique(titre: titre, auteur: auteur, tailleFichierMo: taille))
        }
    }
}

func rechercherUnLivre(dans bibliotheque: Bibliotheque) {
    let titre = lireTexte("Titre du livre : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        print("Livre trouvé :")
        livre.afficherInformations()
    } else {
        print("Aucun livre trouvé avec ce titre.")
    }
}

func emprunterUnLivre(_ adherent: Adherent, dans bibliotheque: Bibliotheque) {
    let titre = lireTexte("Titre du livre à emprunter : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        adherent.emprunterLivre(livre)
    } else {
        print("Aucun livre trouvé avec ce titre.")
    }
}

func retournerUnLivre(_ adherent: Adherent, dans bibliotheque: Bibliotheque) {
    let titre = lireTexte("Titre du livre à retourner : ")
    if let livre = bibliotheque.rechercherLivre(titre: titre) {
        adherent.retournerLivre(livre)
    } else {
        print("Aucun livre trouvé avec ce titre.")
    }
}

// --- Programme principal ---

let bibliotheque = Bibliotheque()
var adherent: Adherent? = nil
var continuer = true

while continuer {
    afficherMenu()
    let choix = lireEntier("Votre choix : ")

    switch choix {
    case 1:
        enregistrerLivres(dans: bibliotheque)
    case 2:
        bibliotheque.afficherCatalogue()
    case 3:
        rechercherUnLivre(dans: bibliotheque)
    case 4:
        adherent = Adherent(nom: lireTexte("Nom de l'adhérent : "))
        print("Adhérent créé : \(adherent!.nom)")
    case 5, 6, 7:
        if let courant = adherent {
            if choix == 5 {
                emprunterUnLivre(courant, dans: bibliotheque)
            } else if choix == 6 {
                retournerUnLivre(courant, dans: bibliotheque)
            } else {
                courant.afficherEmprunts()
            }
        } else {
            print("Créez d'abord un adhérent (option 4).")
        }
    case 0:
        continuer = false
        print("Fermeture du programme...")
    default:
        print("Choix invalide.")
    }
}
