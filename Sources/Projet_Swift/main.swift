import Foundation

// ---------- Fonctions de saisie ----------

// Demande un texte et recommence tant que la réponse est vide
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

// Demande un nombre entier et recommence tant que la réponse n'est pas un nombre
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
    print("8- Lancer les tests demandés")
    print("0- Quitter")
}

func enregistrerLivres(dans bibliotheque: Bibliotheque) {
    print("\n--- Enregistrement de livres ---")
    let nombre = lireEntierPositif("Combien de livres voulez-vous enregistrer ? ")

    for i in 1...nombre {
        print("\nLivre \(i) :")
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

// ---------- Les tests demandés dans le sujet ----------

func lancerLesTests() {
    print("\n===== 1. Création de la bibliothèque =====")
    let biblio = Bibliotheque()
    print("Bibliothèque créée.")

    print("\n===== 2. Ajout de trois livres =====")
    let livre1 = LivrePapier(titre: "Gouverneurs de la rosée", auteur: "Jacques Roumain", nombrePages: 220)
    let livre2 = LivreNumerique(titre: "Swift pour débutants", auteur: "Jean Pierre", tailleFichierMo: 12)
    let livre3 = LivrePapier(titre: "Compère Général Soleil", auteur: "Jacques Stephen Alexis", nombrePages: 400)
    biblio.ajouterLivre(livre1)
    biblio.ajouterLivre(livre2)
    biblio.ajouterLivre(livre3)

    print("\n===== 3. Création d'un adhérent =====")
    let adherent = Adherent(nom: "Lorvensky")
    print("Adhérent créé : \(adherent.nom)")

    print("\n===== 4. Affichage du catalogue =====")
    biblio.afficherCatalogue()

    print("\n===== 5. Emprunt d'un livre =====")
    adherent.emprunterLivre(livre2)

    print("\n===== 6. Emprunt d'un livre déjà emprunté =====")
    adherent.emprunterLivre(livre2)

    print("\n===== 7. Retour d'un livre =====")
    adherent.retournerLivre(livre2)

    print("\n===== 8. Livres empruntés par l'adhérent =====")
    adherent.emprunterLivre(livre1)
    adherent.afficherEmprunts()

    print("\n===== Test bonus : limite de 3 livres =====")
    let livre4 = LivreNumerique(titre: "Introduction à la cybersécurité", auteur: "Marie Louis", tailleFichierMo: 8)
    biblio.ajouterLivre(livre4)
    adherent.emprunterLivre(livre2)
    adherent.emprunterLivre(livre3)
    adherent.emprunterLivre(livre4)
    adherent.afficherEmprunts()
}

// ---------- Programme principal ----------

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
    case 8:
        lancerLesTests()
    case 0:
        continuer = false
        print("Fermeture du programme...")
    default:
        print("Choix invalide.")
    }
}
