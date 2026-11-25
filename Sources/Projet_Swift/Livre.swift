// Classe de base : un livre de la bibliothèque
class Livre {
    let titre: String
    let auteur: String
    private(set) var estDisponible: Bool

    init(titre: String, auteur: String) {
        self.titre = titre
        self.auteur = auteur
        self.estDisponible = true
    }

    func afficherInformations() {
        let etat = estDisponible ? "Disponible" : "Emprunté"
        print("Titre : \(titre) | Auteur : \(auteur) | État : \(etat)")
    }

    // Retourne true si l'emprunt a réussi, false si le livre est déjà emprunté
    func emprunter() -> Bool {
        if estDisponible {
            estDisponible = false
            return true
        }
        return false
    }

    func retourner() {
        estDisponible = true
    }
}
