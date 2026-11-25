// La bibliothèque garde la liste de tous les livres
class Bibliotheque {
    private var livres: [Livre] = []

    func ajouterLivre(_ livre: Livre) {
        livres.append(livre)
        print("Livre ajouté : \"\(livre.titre)\".")
    }

    func afficherCatalogue() {
        print("--- CATALOGUE ---")
        if livres.isEmpty {
            print("Aucun livre enregistré.")
            return
        }
        for livre in livres {
            livre.afficherInformations()
            print("-------------------")
        }
    }

    // Retourne le livre trouvé, ou nil si le titre n'existe pas
    func rechercherLivre(titre: String) -> Livre? {
        for livre in livres {
            if livre.titre.lowercased() == titre.lowercased() {
                return livre
            }
        }
        return nil
    }
}
