var continuer = true
let bibliotheque = Bibliotheque()
while continuer {
    print("\n===== MENU PRINCIPAL =====")
    print("1- Menu Livre")
    print("0- Quitter")
    print("Votre choix : ", terminator: "")

    if let input = readLine(), let choix = Int(input) {
        switch choix {
            
        case 1:
        var menuLivre = true
        while menuLivre {
                
            print("\n--- MENU Bibliothèque ---")
            print("1- Enregistrer un livre")
            print("2- Afficher les livres")
            print("3- Rechercher un livre")
            print("0- Retour au menu principal")
            print("Votre choix : ", terminator: "")

            if let input = readLine(), let choixLivre = Int(input) {
                switch choixLivre {
                case 1:
                    EnregistrerLivre()

                case 2:
                    bibliotheque.afficherCatalogue()
                
                case 3:
                    print("Tapez le titre du livre : ")
                    if let titre = readLine() {
                        bibliotheque.rechercherLivre(titre: titre)
                    }
                case 0:
                    print("Retour au menu principal...")
                    menuLivre = false

                default:
                    print("Choix invalide")
                }
            }
            }

        case 0:
            continuer = false
            print("Fermeture du programme...")

        default:
            print("Choix invalide")
        }
    } else {
        print("Veuillez entrer un nombre valide.")
    }
}