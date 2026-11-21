class Bibliotheque {
    private var livres: [Livre] = []

    func ajouterLivre(_ livre: Livre) {
        livres.append(livre)
        print("Livre ajouté avec succès !")
    }

    func afficherCatalogue() {
        if livres.isEmpty {
            print("Aucun livre enregistré.")
            return
        }

        print("--- CATALOGUE ---")

        for livre in livres {
            livre.afficherInformations()
            print("-------------------")
        }
    }

    func rechercherLivre(titre: String) {
    for livre in livres {
        if livre.getTitre() == titre {
            print("Livre trouvé !")
            livre.afficherInformations()
            return
        }
    }

    print("Aucun livre trouvé avec ce titre.")
}
}